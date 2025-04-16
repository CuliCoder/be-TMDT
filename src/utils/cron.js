import axios from "axios";
import connection from "../database/database.js";

const fetchTransactionsFromSheet = async () => {
  try {
    const response = await axios.get(
      "https://script.google.com/macros/s/AKfycbylftMXXkXNEXSozIRqpvE4tk16aMl0_xYne39FTpyP5gDo7sWt3d2BXkhMnksxDoE/exec"
    );
    const transactions = response.data.data;
    return transactions;
  } catch (error) {
    console.error("Error fetching transactions:", error);
    return null;
  }
};

// export const checkPaymentFromTransactions = () =>
//   new Promise(async (resolve, reject) => {
//     let client;
//     try {
//       client = await connection.getConnection();
//       await client.beginTransaction();

//       const transactions = await fetchTransactionsFromSheet();
//       if (!transactions || transactions.length === 0) {
//         return resolve({
//           error: 0,
//           message: "No transactions found.",
//         });
//       }

//       for (const transaction of transactions) {
//         const description = transaction["Mô tả"];
//         const amount = transaction["Giá trị"];
//         const idOrder = description.match(/DH(\d+)/);
//         if (!idOrder) continue;

//         const id = parseInt(idOrder[1]);

//         // Khóa đơn hàng để tránh xung đột
//         const [order] = await client.query(
//           "SELECT * FROM orders WHERE OrderID = ? AND payment_status = 'Chưa thanh toán' FOR UPDATE",
//           [id]
//         );

//         if (order.length === 0) continue;

//         if (amount < order[0].TotalAmount) {
//           console.error(`Order ${id} has not been paid yet.`);
//           continue;
//         }

//         // Cập nhật trạng thái đơn hàng
//         const [result] = await client.query(
//           "UPDATE orders SET status = 'Chuẩn bị hàng', payment_status = 'Đã thanh toán' WHERE OrderID = ?",
//           [id]
//         );

//         if (result.affectedRows === 0) {
//           console.error(`Failed to update order with ID ${id}`);
//           await client.rollback();
//           return reject({
//             error: 1,
//             message: `Failed to update order with ID ${id}`,
//           });
//         }

//         // Lấy chi tiết đơn hàng
//         const [orderDetail] = await client.query(
//           "SELECT * FROM orderdetails WHERE OrderID = ?",
//           [id]
//         );

//         if (orderDetail.length === 0) {
//           console.error(`No order detail found for order ID ${id}`);
//           continue;
//         }

//         const productIDs = orderDetail.map((item) => item.Product_Item_ID);
//         const quantities = orderDetail.map((item) => item.Quantity);

//         // Khóa sản phẩm để tránh xung đột
//         const [products] = await client.query(
//           "SELECT * FROM product_item WHERE id IN (?) FOR UPDATE",
//           [productIDs]
//         );

//         if (products.length === 0) {
//           console.error(`No products found for order ID ${id}`);
//           await client.rollback();
//           return reject({
//             error: 1,
//             message: `No products found for order ID ${id}`,
//           });
//         }

//         for (let i = 0; i < products.length; i++) {
//           const product = products[i];
//           const quantity = quantities[i];
//           const newQuantity = product.qty_in_stock - quantity;
//           const reservedStock = product.reserved_stock - quantity;

//           if (newQuantity < 0) {
//             console.error(`Not enough stock for product ID ${product.id}`);
//             await client.rollback();
//             return reject({
//               error: 1,
//               message: `Not enough stock for product ID ${product.id}`,
//             });
//           }

//           // Cập nhật số lượng sản phẩm
//           const [update_product_item] = await client.query(
//             "UPDATE product_item SET qty_in_stock = ?, reserved_stock = ? WHERE id = ?",
//             [newQuantity, reservedStock, product.id]
//           );

//           if (update_product_item.affectedRows === 0) {
//             console.error(`Failed to update product item with ID ${product.id}`);
//             await client.rollback();
//             return reject({
//               error: 1,
//               message: `Failed to update product item with ID ${product.id}`,
//             });
//           }
//         }

//         // Cập nhật trạng thái đơn hàng
//         const [update_status] = await client.query(
//           "INSERT INTO order_status (idorder, status) VALUES (?, 'Chuẩn bị hàng')",
//           [id]
//         );

//         if (update_status.affectedRows === 0) {
//           console.error(`Failed to insert order status for order ID ${id}`);
//           await client.rollback();
//           return reject({
//             error: 1,
//             message: `Failed to insert order status for order ID ${id}`,
//           });
//         }

//         console.log(`Order ${id} has been updated to 'Chuẩn bị hàng'`);
//       }

//       // Commit giao dịch sau khi hoàn tất
//       await client.commit();
//       return resolve({
//         error: 0,
//         message: "Orders have been updated successfully.",
//       });
//     } catch (error) {
//       console.error("Error inserting transactions:", error);
//       if (client) {
//         await client.rollback();
//       }
//       return reject({
//         error: 1,
//         message: "Error inserting transactions",
//       });
//     } finally {
//       if (client) {
//         client.release();
//       }
//       console.log("Transaction completed.");
//     }
//   });
export const checkPaymentFromTransactions = () =>
  new Promise(async (resolve, reject) => {
    let client;
    try {
      client = await connection.getConnection();

      const transactions = await fetchTransactionsFromSheet();
      if (!transactions || transactions.length === 0) {
        return resolve({
          error: 0,
          message: "No transactions found.",
        });
      }

      for (const transaction of transactions) {
        const description = transaction["Mô tả"];
        const amount = transaction["Giá trị"];
        const idOrder = description.match(/DH(\d+)/);
        if (!idOrder) continue;

        const id = parseInt(idOrder[1]);

        // Kiểm tra đơn hàng
        const [order] = await client.query(
          "SELECT * FROM orders WHERE OrderID = ? AND payment_status = 'Chưa thanh toán'",
          [id]
        );

        if (order.length === 0) continue;

        if (amount < order[0].TotalAmount) {
          console.error(`Order ${id} has not been paid yet.`);
          continue;
        }

        // Cập nhật trạng thái đơn hàng
        const [result] = await client.query(
          "UPDATE orders SET status = 'Chuẩn bị hàng', payment_status = 'Đã thanh toán' WHERE OrderID = ?",
          [id]
        );

        if (result.affectedRows === 0) {
          console.error(`Failed to update order with ID ${id}`);
          continue;
        }

        // Lấy chi tiết đơn hàng
        const [orderDetail] = await client.query(
          "SELECT * FROM orderdetails WHERE OrderID = ?",
          [id]
        );

        if (orderDetail.length === 0) {
          console.error(`No order detail found for order ID ${id}`);
          continue;
        }

        const productIDs = orderDetail.map((item) => item.Product_Item_ID);
        const quantities = orderDetail.map((item) => item.Quantity);

        // Kiểm tra và cập nhật sản phẩm
        const [products] = await client.query(
          "SELECT * FROM product_item WHERE id IN (?)",
          [productIDs]
        );

        if (products.length === 0) {
          console.error(`No products found for order ID ${id}`);
          continue;
        }

        for (let i = 0; i < products.length; i++) {
          const product = products[i];
          const quantity = quantities[i];
          const newQuantity = product.qty_in_stock - quantity;
          const reservedStock = product.reserved_stock - quantity;

          if (newQuantity < 0) {
            console.error(`Not enough stock for product ID ${product.id}`);
            continue;
          }

          // Cập nhật số lượng sản phẩm
          const [update_product_item] = await client.query(
            "UPDATE product_item SET qty_in_stock = ?, reserved_stock = ? WHERE id = ?",
            [newQuantity, reservedStock, product.id]
          );

          if (update_product_item.affectedRows === 0) {
            console.error(`Failed to update product item with ID ${product.id}`);
            continue;
          }
        }

        // Thêm trạng thái vào bảng order_status
        const [update_status] = await client.query(
          "INSERT INTO order_status (idorder, status) VALUES (?, 'Chuẩn bị hàng')",
          [id]
        );

        if (update_status.affectedRows === 0) {
          console.error(`Failed to insert order status for order ID ${id}`);
          continue;
        }

        console.log(`Order ${id} has been updated to 'Chuẩn bị hàng'`);
      }

      return resolve({
        error: 0,
        message: "Orders have been updated successfully.",
      });
    } catch (error) {
      console.error("Error processing transactions:", error);
      return reject({
        error: 1,
        message: "Error processing transactions",
      });
    } finally {
      if (client) {
        client.release();
      }
    }
  });