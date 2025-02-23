import connection from "../database/database.js";
export const getCart = (userID) =>
  new Promise(async (resolve, reject) => {
    try {
      const query = `SELECT * FROM cart WHERE UserID = ?`;
      const [carts, fields] = await connection.execute(query, [userID]);
      resolve(carts);
    } catch (error) {
      reject(error);
    }
  });
export const addToCart = (userID, productID, quantity) =>
  new Promise(async (resolve, reject) => {
    try {
      const existingProduct = await connection.execute(
        `SELECT * FROM cart WHERE UserID = ? AND ProductID = ?`,
        [userID, productID]
      );
      if (existingProduct[0].length === 0) {
        await connection.execute(
          `INSERT INTO cart (UserID, ProductID, Quantity) VALUES (?, ?, ?)`,
          [userID, productID, quantity]
        );
      } else {
        await connection.execute(
          `UPDATE cart SET Quantity = Quantity + ? WHERE UserID = ? AND ProductID = ?`,
          [quantity, userID, productID]
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
        `UPDATE cart SET Quantity = ? WHERE UserID = ? AND ProductID = ?`,
        [quantity, userID, productID]
      );
      resolve({
        error: 0,
        message: "Cập nhật giỏ hàng thành công",
      });
    } catch (error) {
      reject(error);
    }
  });
export const removeFromCart = (userID, productID) =>
  new Promise(async (resolve, reject) => {
    try {
      await connection.execute(
        `DELETE FROM cart WHERE UserID = ? AND ProductID = ?`,
        [userID, productID]
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
