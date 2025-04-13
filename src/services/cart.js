import connection from "../database/database.js";
export const getCart = (userID) =>
  new Promise(async (resolve, reject) => {
    try {
      const query = `
      SELECT pi.id , p.ProductName, pi.price, c.Quantity, pi.product_image, pr.DiscountRate
      FROM cart as c join product_item as pi on c.Product_Item_ID = pi.id join products as p on pi.product_id = p.ProductID
      left join productpromotions as pp on p.ProductID = pp.ProductID
      left join promotions as pr on pp.PromotionID = pr.PromotionID
      where c.UserID = ?
      order by c.AddedDate desc;
      `;
      const [carts, fields] = await connection.execute(query, [userID]);
      resolve(carts);
    } catch (error) {
      console.log(error);
      reject(error);
    }
  });
export const addToCart = (userID, Product_Item_ID, quantity) =>
  new Promise(async (resolve, reject) => {
    try {
      const existingProduct = await connection.execute(
        `SELECT * FROM cart WHERE UserID = ? AND Product_Item_ID = ?`,
        [userID, Product_Item_ID]
      );
      if (existingProduct[0].length === 0) {
        await connection.execute(
          `INSERT INTO cart (UserID, Product_Item_ID, Quantity) VALUES (?, ?, ?)`,
          [userID, Product_Item_ID, quantity]
        );
      } else {
        await connection.execute(
          `UPDATE cart SET Quantity = Quantity + ? WHERE UserID = ? AND Product_Item_ID = ?`,
          [quantity, userID, Product_Item_ID]
        );
      }
      resolve({
        error: 0,
        message: "Thêm sản phẩm vào giỏ hàng thành công",
      });
    } catch (error) {
      reject(error);
    }
  });
export const updateCart = (userID, productID, quantity) =>
  new Promise(async (resolve, reject) => {
    try {
      await connection.execute(
        `UPDATE cart SET Quantity = ? WHERE UserID = ? AND Product_item_ID = ?`,
        [quantity, userID, productID]
      );
      // const [updatedCart] = await connection.execute(
      //   `SELECT Quantity FROM cart WHERE UserID = ? AND ProductID = ?`,
      //   [userID, productID]
      // );
      resolve({
        error: 0,
        message: "Cập nhật giỏ hàng thành công",
        // quantity: updatedCart[0].Quantity
      });
    } catch (error) {
      reject(error);
    }
  });
export const removeFromCart = (userID, product_item_ID) =>
  new Promise(async (resolve, reject) => {
    try {
      await connection.execute(
        `DELETE FROM cart WHERE UserID = ? AND Product_Item_ID = ?`,
        [userID, product_item_ID]
      );
      resolve({
        error: 0,
        message: "Xóa sản phẩm khỏi giỏ hàng thành công",
      });
    } catch (error) {
      reject(error);
    }
  });
export const clearCart = (userID) =>
  new Promise(async (resolve, reject) => {
    try {
      await connection.execute(`DELETE FROM cart WHERE UserID = ?`, [userID]);
      resolve({
        error: 0,
        message: "Xóa giỏ hàng thành công",
      });
    } catch (error) {
      reject(error);
    }
  });

export const placeOrder = (userID, name, phonenumber, address, method) =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await connection.getConnection();
      await client.beginTransaction();
      const [cart] = await client.execute(
        `SELECT * FROM cart WHERE UserID = ?`,
        [userID]
      );
      if (cart.length === 0) {
        return resolve({
          error: 1,
          message: "Giỏ hàng trống",
        });
      }

      const [result] = await connection.execute(
        `SELECT 1
FROM cart c
WHERE c.UserID = ?
GROUP BY c.UserID
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM cart c2
    JOIN product_item pr ON c2.Product_Item_ID = pr.id
    WHERE c2.UserID = ? AND pr.qty_in_stock - pr.reserved_stock >= c2.Quantity
);`,
        [userID, userID]
      );
      if (result.length === 0) {
        return resolve({
          error: 1,
          message: "Có sản phẩm không đủ số lượng",
        });
      }
      const [products] = await client.execute(
        `SELECT pi.id , p.ProductName, pi.price, pi.reserved_stock, c.Quantity, pi.product_image, pr.DiscountRate
      FROM cart as c join product_item as pi on c.Product_Item_ID = pi.id join products as p on pi.product_id = p.ProductID
      left join productpromotions as pp on p.ProductID = pp.ProductID
      left join promotions as pr on pp.PromotionID = pr.PromotionID
      where c.UserID = ?`,
        [userID]
      );
      let totalPrice = 0;
      products.forEach((product) => {
        totalPrice += !product.DiscountRate
          ? product.price * product.Quantity
          : (product.price - (product.price * product.DiscountRate) / 100) *
            product.Quantity;
      });
      const [addOrder] = await client.execute(
        `INSERT INTO orders (UserID, TotalAmount, name, phonenumber, address, payment_method) VALUES (?, ?, ?, ?, ?, ?)`,
        [userID, totalPrice, name, phonenumber, address, method]
      );
      if (addOrder.affectedRows === 0) {
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình thanh toán",
        });
      }
      const orderID = addOrder.insertId;
      const [update_status_order] = await client.execute(
        `insert into order_status (idorder,status) VALUES (?, 'Chờ duyệt')`,
        [orderID]
      );
      if (update_status_order.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình thanh toán",
        });
      }
      const values = [];
      const placeholders_addOrderDetails = products
        .map((product) => {
          const price = !product.DiscountRate
            ? product.price * product.Quantity
            : (product.price - (product.price * product.DiscountRate) / 100) *
              product.Quantity;
          values.push(orderID, product.id, product.Quantity, price);
          return `(?, ?, ?, ?)`;
        })
        .join(", ");
      const [addOrderDetails] = await client.execute(
        `INSERT INTO orderdetails (OrderID, Product_Item_ID, Quantity, Price) VALUES ${placeholders_addOrderDetails}`,
        values
      );
      if (addOrderDetails.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình đặt hàng",
        });
      }
      products.forEach(async (product) => {
        const reserved_stock = product.reserved_stock + product.Quantity;
        console.log(reserved_stock)
        const [update_reserved_stock] = await client.execute(
          `update product_item set reserved_stock = ? where id = ?`,
          [reserved_stock, product.id]
        );
        if (update_reserved_stock.affectedRows === 0) {
          await client.rollback();
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình đặt hàng",
          });
        }
      });
      await client.commit();
      resolve({
        error: addOrder.affectedRows === 0 ? 1 : 0,
        message:
          addOrder.affectedRows === 0
            ? "Có lỗi xảy ra trong quá trình đặt hàng"
            : "Tiến hành đặt hàng",
        data: {
          orderID: addOrder.insertId,
          totalPrice,
        },
      });
    } catch (error) {
      console.error(error);
      if (client) {
        await client.rollback();
      }
      reject({
        error: 1,
        message: error,
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });

export const cancelOrder = (orderID) =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await connection.getConnection();
      await client.beginTransaction();
      const [checkOrder] = await client.execute(
        `SELECT * FROM orders WHERE OrderID = ? and payment_status = 'Chưa thanh toán' and Status = 'Chờ duyệt'`,
        [orderID]
      );
      if (checkOrder.length === 0) {
        return resolve({
          error: 1,
          message: "Đơn hàng không tồn tại hoặc đã thanh toán",
        });
      }
      const [orderDetails] = await client.execute(
        `SELECT * FROM orderdetails WHERE OrderID = ?`,
        [orderID]
      );
      if (orderDetails.length === 0) {
        return resolve({
          error: 1,
          message: "Đơn hàng không tồn tại",
        });
      }
      orderDetails.forEach(async (product) => {
        const [update_reserved_stock] = await client.execute(
          `update product_item set reserved_stock = reserved_stock - ? where id = ?`,
          [parseInt(product.Quantity), product.Product_Item_ID]
        );
        if (update_reserved_stock.affectedRows === 0) {
          await client.rollback();
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
          });
        }
      });
      const [updateOrder] = await client.execute(
        `UPDATE orders SET Status = 'Hủy' WHERE OrderID = ?`,
        [orderID]
      );
      if (updateOrder.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
        });
      }
      const [update_status_order] = await client.execute(
        `insert into order_status (idorder,status) VALUES (?, 'Hủy')`,
        [orderID]
      );
      if (update_status_order.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
        });
      }
      await client.commit();
      resolve({
        error: 0,
        message: "Hủy đơn hàng thành công",
      });
    } catch (error) {
      console.error(error);
      if (client) {
        await client.rollback();
      }
      reject({
        error: 1,
        message: error,
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });
export const cancelOrderByAd = (orderID) =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await connection.getConnection();
      await client.beginTransaction();
      const [checkOrder] = await client.execute(
        `SELECT * FROM orders WHERE OrderID = ? and payment_status = 'Chưa thanh toán'`,
        [orderID]
      );
      if (checkOrder.length === 0) {
        return resolve({
          error: 1,
          message: "Đơn hàng không tồn tại hoặc đã thanh toán",
        });
      }
      const [orderDetails] = await client.execute(
        `SELECT * FROM orderdetails WHERE OrderID = ?`,
        [orderID]
      );
      if (orderDetails.length === 0) {
        return resolve({
          error: 1,
          message: "Đơn hàng không tồn tại",
        });
      }
      orderDetails.forEach(async (product) => {
        const [update_reserved_stock] = await client.execute(
          `update product_item set reserved_stock = reserved_stock - ? where id = ?`,
          [parseInt(product.Quantity), product.Product_Item_ID]
        );
        if (update_reserved_stock.affectedRows === 0) {
          await client.rollback();
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
          });
        }
      });
      const [updateOrder] = await client.execute(
        `UPDATE orders SET Status = 'Hủy' WHERE OrderID = ?`,
        [orderID]
      );
      if (updateOrder.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
        });
      }
      const [update_status_order] = await client.execute(
        `insert into order_status (idorder,status) VALUES (?, 'Hủy')`,
        [orderID]
      );
      if (update_status_order.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
        });
      }
      await client.commit();
      resolve({
        error: 0,
        message: "Hủy đơn hàng thành công",
      });
    } catch (error) {
      console.error(error);
      if (client) {
        await client.rollback();
      }
      reject({
        error: 1,
        message: error,
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });
export const confirmPayment = (orderID) =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await connection.getConnection();
      await client.beginTransaction();
      const [orderDetails] = await client.execute(
        `SELECT * FROM orderdetails WHERE OrderID = ?`,
        [orderID]
      );
      if (orderDetails.length === 0) {
        return resolve({
          error: 1,
          message: "Đơn hàng không tồn tại",
        });
      }
      orderDetails.forEach(async (product) => {
        const [update_reserved_stock] = await client.execute(
          `update product_item set reserved_stock = reserved_stock - ?, qty_in_stock = qty_in_stock - ? where id = ?`,
          [
            parseInt(product.Quantity),
            parseInt(product.Quantity),
            product.Product_Item_ID,
          ]
        );
        if (update_reserved_stock.affectedRows === 0) {
          await client.rollback();
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình xác nhận thanh toán",
          });
        }
      });
      const [order] = await client.execute(
        `SELECT * FROM orders WHERE OrderID = ?`,
        [orderID]
      );
      if (order.length === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình xác nhận thanh toán",
        });
      }
      const [updateOrder] = await client.execute(
        `UPDATE orders SET payment_status = 'Đã thanh toán', Status = 'Đã giao' WHERE OrderID = ?`,
        [orderID]
      );
      if (updateOrder.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình xác nhận thanh toán",
        });
      }
      const [update_status_order] = await client.execute(
        `insert into order_status (idorder,status) VALUES (?, 'Đã giao')`,
        [orderID]
      );
      if (update_status_order.affectedRows === 0) {
        await client.rollback();
        return resolve({
          error: 1,
          message: "Có lỗi xảy ra trong quá trình xác nhận thanh toán",
        });
      }
      await client.commit();
      resolve({
        error: 0,
        message: "Xác nhận thanh toán thành công",
      });
    } catch (error) {
      console.error(error);
      if (client) {
        await client.rollback();
      }
      reject({
        error: 1,
        message: error,
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });
export const cancelLateOrders = () =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await connection.getConnection();
      await client.beginTransaction();
      const [order] = await client.execute(
        `SELECT * FROM orders WHERE payment_method = 'bank' and payment_status = 'Chưa thanh toán' and Status <> 'Quá hạn thanh toán' and OrderDate < NOW() - INTERVAL 30 MINUTE`
      );
      if (order.length === 0) {
        return resolve({
          error: 1,
          message: "Đơn hàng không tồn tại",
        });
      }
      for (let i = 0; i < order.length; i++) {
        const [orderDetails] = await client.execute(
          `SELECT * FROM orderdetails WHERE OrderID = ?`,
          [order[i].OrderID]
        );
        if (orderDetails.length === 0) {
          return resolve({
            error: 1,
            message: "Đơn hàng không tồn tại",
          });
        }
        orderDetails.forEach(async (product) => {
          const [update_reserved_stock] = await client.execute(
            `update product_item set reserved_stock = reserved_stock - ? where id = ?`,
            [product.Quantity, product.Product_Item_ID]
          );
          if (update_reserved_stock.affectedRows === 0) {
            await client.rollback();
            return resolve({
              error: 1,
              message: "Hủy đơn hàng không thành công",
            });
          }
        });
        const [updateOrder] = await client.execute(
          `UPDATE orders SET Status = 'Quá hạn thanh toán' WHERE OrderID = ?`,
          [order[i].OrderID]
        );
        if (updateOrder.affectedRows === 0) {
          await client.rollback();
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
          });
        }
        const [update_status_order] = await client.execute(
          `insert into order_status (idorder,status) VALUES (?, 'Quá hạn thanh toán')`,
          [order[i].OrderID]
        );
        if (update_status_order.affectedRows === 0) {
          await client.rollback();
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình hủy đơn hàng",
          });
        }
      }
      await client.commit();
      resolve({
        error: 0,
        message: "Hủy đơn hàng thành công " ,
      });
    } catch (error) {
      console.error(error);
      if (client) {
        await client.rollback();
      }
      reject({
        error: 1,
        message: error,
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });
