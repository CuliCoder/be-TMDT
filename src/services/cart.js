import connection from "../database/database.js";
export const getCart = (userID) =>
  new Promise(async (resolve, reject) => {
    try {
      const query = `
      SELECT pi.id , p.ProductName, pi.price, c.Quantity, pi.product_image, CASE 
         WHEN pr.StartDate <= NOW() AND pr.EndDate >= NOW() THEN pr.DiscountRate
         ELSE NULL
       END AS DiscountRate
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
        const [insert] = await connection.execute(
          `INSERT INTO cart (UserID, Product_Item_ID, Quantity) VALUES (?, ?, ?)`,
          [userID, Product_Item_ID, quantity]
        );
        if (insert.affectedRows === 0) {
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình thêm sản phẩm vào giỏ hàng",
          });
        }
      } else {
        const [update] = await connection.execute(
          `UPDATE cart SET Quantity = Quantity + ? WHERE UserID = ? AND Product_Item_ID = ?`,
          [quantity, userID, Product_Item_ID]
        );
        if (update.affectedRows === 0) {
          return resolve({
            error: 1,
            message: "Có lỗi xảy ra trong quá trình thêm sản phẩm vào giỏ hàng",
          });
        }
      }
      return resolve({
        error: 0,
        message: "Thêm sản phẩm vào giỏ hàng thành công",
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Có lỗi xảy ra trong quá trình thêm sản phẩm vào giỏ hàng",
      });
    }
  });
export const updateCart = (userID, productID, quantity) =>
  new Promise(async (resolve, reject) => {
    try {
      const [update] = await connection.execute(
        `UPDATE cart SET Quantity = ? WHERE UserID = ? AND Product_item_ID = ?`,
        [quantity, userID, productID]
      );
      // const [updatedCart] = await connection.execute(
      //   `SELECT Quantity FROM cart WHERE UserID = ? AND ProductID = ?`,
      //   [userID, productID]
      // );
      return resolve({
        error: update.affectedRows === 0 ? 1 : 0,
        message:
          update.affectedRows === 0
            ? "Có lỗi xảy ra trong quá trình cập nhật giỏ hàng"
            : "Cập nhật giỏ hàng thành công",
        // quantity: updatedCart[0].Quantity
      });
    } catch (error) {
      reject({
        error: 1,
        message: "Có lỗi xảy ra trong quá trình cập nhật giỏ hàng",
      });
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
        console.log(reserved_stock);
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
      for (const product of orderDetails) {
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
      }
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

      // Lấy danh sách các đơn hàng quá hạn
      const [orders] = await client.execute(
        `SELECT * FROM orders 
           WHERE payment_method = 'bank' 
             AND payment_status = 'Chưa thanh toán' 
             AND Status <> 'Quá hạn thanh toán' 
             AND OrderDate < NOW() - INTERVAL 30 MINUTE`
      );

      if (orders.length === 0) {
        return resolve({
          error: 1,
          message: "Không có đơn hàng quá hạn",
        });
      }

      for (const order of orders) {
        // Lấy chi tiết đơn hàng
        const [orderDetails] = await client.execute(
          `SELECT * FROM orderdetails WHERE OrderID = ?`,
          [order.OrderID]
        );

        if (orderDetails.length === 0) {
          console.error(
            `Không tìm thấy chi tiết đơn hàng cho OrderID: ${order.OrderID}`
          );
          continue; // Bỏ qua đơn hàng này và tiếp tục xử lý các đơn hàng khác
        }

        // Cập nhật reserved_stock cho từng sản phẩm
        for (const product of orderDetails) {
          const [updateReservedStock] = await client.execute(
            `UPDATE product_item 
               SET reserved_stock = reserved_stock - ? 
               WHERE id = ?`,
            [product.Quantity, product.Product_Item_ID]
          );

          if (updateReservedStock.affectedRows === 0) {
            console.error(
              `Không thể cập nhật reserved_stock cho Product_Item_ID: ${product.Product_Item_ID}`
            );
            continue; // Bỏ qua sản phẩm này và tiếp tục xử lý các sản phẩm khác
          }
        }

        // Cập nhật trạng thái đơn hàng
        const [updateOrder] = await client.execute(
          `UPDATE orders 
             SET Status = 'Quá hạn thanh toán' 
             WHERE OrderID = ?`,
          [order.OrderID]
        );

        if (updateOrder.affectedRows === 0) {
          console.error(
            `Không thể cập nhật trạng thái cho OrderID: ${order.OrderID}`
          );
          continue; // Bỏ qua đơn hàng này và tiếp tục xử lý các đơn hàng khác
        }

        // Thêm trạng thái vào bảng order_status
        const [insertOrderStatus] = await client.execute(
          `INSERT INTO order_status (idorder, status) 
             VALUES (?, 'Quá hạn thanh toán')`,
          [order.OrderID]
        );

        if (insertOrderStatus.affectedRows === 0) {
          console.error(
            `Không thể thêm trạng thái vào order_status cho OrderID: ${order.OrderID}`
          );
          continue; // Bỏ qua đơn hàng này và tiếp tục xử lý các đơn hàng khác
        }

        console.log(
          `Đơn hàng ${order.OrderID} đã được cập nhật thành 'Quá hạn thanh toán'`
        );
      }

      resolve({
        error: 0,
        message: "Hủy đơn hàng quá hạn thành công",
      });
    } catch (error) {
      console.error("Lỗi khi hủy đơn hàng quá hạn:", error);
      reject({
        error: 1,
        message: "Lỗi khi hủy đơn hàng quá hạn",
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });
// export const cancelLateOrders = () =>
//   new Promise(async (resolve, reject) => {
//     let client;
//     try {
//       client = await connection.getConnection();
//       await client.beginTransaction();

//       // Lấy danh sách các đơn hàng quá hạn
//       const [orders] = await client.execute(
//         `SELECT * FROM orders
//          WHERE payment_method = 'bank'
//            AND payment_status = 'Chưa thanh toán'
//            AND Status <> 'Quá hạn thanh toán'
//            AND OrderDate < NOW() - INTERVAL 30 MINUTE`
//       );

//       if (orders.length === 0) {
//         return resolve({
//           error: 1,
//           message: "Không có đơn hàng quá hạn",
//         });
//       }

//       for (const order of orders) {
//         // Lấy chi tiết đơn hàng
//         const [orderDetails] = await client.execute(
//           `SELECT * FROM orderdetails WHERE OrderID = ?`,
//           [order.OrderID]
//         );

//         if (orderDetails.length === 0) {
//           console.error(`Không tìm thấy chi tiết đơn hàng cho OrderID: ${order.OrderID}`);
//           await client.rollback();
//           return reject({
//             error: 1,
//             message: `Không tìm thấy chi tiết đơn hàng cho OrderID: ${order.OrderID}`,
//           });
//         }

//         // Cập nhật reserved_stock cho từng sản phẩm
//         for (const product of orderDetails) {
//           const [updateReservedStock] = await client.execute(
//             `UPDATE product_item
//              SET reserved_stock = reserved_stock - ?
//              WHERE id = ?`,
//             [product.Quantity, product.Product_Item_ID]
//           );

//           if (updateReservedStock.affectedRows === 0) {
//             console.error(`Không thể cập nhật reserved_stock cho Product_Item_ID: ${product.Product_Item_ID}`);
//             await client.rollback();
//             return reject({
//               error: 1,
//               message: `Không thể cập nhật reserved_stock cho Product_Item_ID: ${product.Product_Item_ID}`,
//             });
//           }
//         }

//         // Cập nhật trạng thái đơn hàng
//         const [updateOrder] = await client.execute(
//           `UPDATE orders
//            SET Status = 'Quá hạn thanh toán'
//            WHERE OrderID = ?`,
//           [order.OrderID]
//         );

//         if (updateOrder.affectedRows === 0) {
//           console.error(`Không thể cập nhật trạng thái cho OrderID: ${order.OrderID}`);
//           await client.rollback();
//           return reject({
//             error: 1,
//             message: `Không thể cập nhật trạng thái cho OrderID: ${order.OrderID}`,
//           });
//         }

//         // Thêm trạng thái vào bảng order_status
//         const [insertOrderStatus] = await client.execute(
//           `INSERT INTO order_status (idorder, status)
//            VALUES (?, 'Quá hạn thanh toán')`,
//           [order.OrderID]
//         );

//         if (insertOrderStatus.affectedRows === 0) {
//           console.error(`Không thể thêm trạng thái vào order_status cho OrderID: ${order.OrderID}`);
//           await client.rollback();
//           return reject({
//             error: 1,
//             message: `Không thể thêm trạng thái vào order_status cho OrderID: ${order.OrderID}`,
//           });
//         }

//         console.log(`Đơn hàng ${order.OrderID} đã được cập nhật thành 'Quá hạn thanh toán'`);
//       }

//       // Commit giao dịch sau khi hoàn tất
//       await client.commit();
//       resolve({
//         error: 0,
//         message: "Hủy đơn hàng quá hạn thành công",
//       });
//     } catch (error) {
//       console.error("Lỗi khi hủy đơn hàng quá hạn:", error);
//       if (client) {
//         await client.rollback();
//       }
//       reject({
//         error: 1,
//         message: "Lỗi khi hủy đơn hàng quá hạn",
//       });
//     } finally {
//       if (client) {
//         client.release();
//       }
//     }
//   });
