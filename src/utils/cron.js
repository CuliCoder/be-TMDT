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
    throw error;
  }
};

export const checkPaymentFromTransactions = async () => {
  let client;
  try {
    const transactions = await fetchTransactionsFromSheet();
    console.log("Fetched transactions:", transactions);
    client = await connection.getConnection();
    await client.beginTransaction();
    if (!transactions || transactions.length === 0) {
      console.log("No transactions found.");
      return;
    }
    for (const transaction of transactions) {
      const description = transaction["Mô tả"];
      const amount = transaction["Giá trị"];
      const idOrder = description.match(/DH(\d+)/);
      if (!idOrder) continue;
      const id = parseInt(idOrder[1]);
      const [order] = await client.query(
        "SELECT * FROM orders WHERE OrderID = ? and payment_status = 'Chưa thanh toán'",
        [id]
      );
      if (order.length === 0) continue;
      if (amount < order[0].TotalAmount) {
        console.error(`Order ${id} has not been paid yet.`);
        continue;
      }
      const [result] = await client.query(
        "UPDATE orders SET status = 'Chuẩn bị hàng', payment_status = 'Đã thanh toán' WHERE OrderID = ?",
        [id]
      );
      if (result.affectedRows == 0) {
        console.error(`Failed to update order with ID ${id}`);
        await client.rollback();
        return;
      }
      const [ orderDetail] = await client.query(
        "SELECT * FROM orderdetails WHERE OrderID = ?",
        [id]
      );
      if (orderDetail.length === 0) {
        console.error(`No order detail found for order ID ${id}`);
        continue;
      }
      const productIDs = orderDetail.map((item) => item.Product_Item_ID);
      const quantities = orderDetail.map((item) => item.Quantity);
      const [products] = await client.query(
        "SELECT * FROM product_item WHERE id IN (?)",
        [productIDs]
      );
      if (products.length === 0) {
        console.error(`No products found for order ID ${id}`);
        await client.rollback();
        return;
      }
      for (let i = 0; i < products.length; i++) {
        const product = products[i];
        const quantity = quantities[i];
        const newQuantity = product.qty_in_stock - quantity;
        const reservedStock = product.reserved_stock - quantity;
        console.log(
          `Product ID: ${product.id}, Quantity: ${quantity}, New Quantity: ${newQuantity}`
        );
        if (newQuantity < 0) {
          console.error(`Not enough stock for product ID ${product.id}`);
          continue;
        }
        console.log(
          `Updating product item with ID ${product.id}: New quantity = ${newQuantity}`
        );
        const [update_product_item] = await client.query(
          "UPDATE product_item SET qty_in_stock = ?, reserved_stock = ? WHERE id = ?",
          [newQuantity, reservedStock, product.id]
        );
        if (update_product_item.affectedRows == 0) {
          console.error(`Failed to update product item with ID ${product.id}`);
          await client.rollback();
          return;
        }
      }
      const [update_status] = await client.query(
        "insert into order_status (idorder,status) values (?,'Chuẩn bị hàng')",
        [id]
      );
      if (update_status.affectedRows == 0) {
        console.error(`Failed to insert order status for order ID ${id}`);
        await client.rollback();
        return;
      }
      await client.commit();
      console.log(`Order ${id} has been updated to 'Chuẩn bị hàng'`);
    }
  } catch (error) {
    console.error("Error inserting transactions:", error);
    if (client) {
      await client.rollback();
    }
  } finally {
    if (client) {
      client.release();
    }
    console.log("Transaction completed.");
  }
};
