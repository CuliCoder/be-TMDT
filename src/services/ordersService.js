import database from "../database/database.js";

export const addOrder = async (userid, totalAmount) => {
  try {
    const query = `INSERT INTO orders (UserID, OrderDate, TotalAmount, Status) VALUES (?, ?, ?, ?)`;
    const currentTime = new Date().toISOString().slice(0, 19).replace("T", " "); // Chuyển sang định dạng MySQL DATETIME
    const [result] = await database.execute(query, [
      userid,
      currentTime,
      totalAmount,
      1,
    ]);
    return result.insertId;
  } catch (error) {
    console.error("Error adding order:", error);
    throw error;
  }
};

export const getOrders = async () => {
  try {
    const query = `SELECT * FROM orders order by OrderDate DESC`;
    const [result] = await database.execute(query);
    return result;
  } catch (error) {
    console.error("Error fetching orders:", error);
    throw error;
  }
};

export const getOrderByID = async (OrderID) => {
  try {
    const query = `SELECT * FROM orders WHERE OrderID = ?`;
    const [result] = await database.execute(query, [OrderID]);
    return result;
  } catch (error) {
    console.error("Error fetching order by ID:", error);
    throw error;
  }
};

export const getOrderByUserID = async (UserID) => {
  try {
    const query = `SELECT * FROM orders WHERE UserID = ? order by OrderDate DESC`;
    UserID = Number(UserID);
    const [result] = await database.execute(query, [UserID]);
    return result;
  } catch (error) {
    console.error("Error fetching order by UserID:", error);
    throw error;
  }
};

export const getOrderByDate = async (startDate, endDate) => {
  try {
    // Định dạng ngày thành `YYYY-MM-DD HH:MM:SS` (chuẩn MySQL DATETIME)
    const formattedStartDate = new Date(startDate)
      .toISOString()
      .slice(0, 19)
      .replace("T", " ");
    const formattedEndDate = new Date(endDate)
      .toISOString()
      .slice(0, 19)
      .replace("T", " ");

    const query = `SELECT * FROM orders WHERE OrderDate BETWEEN ? AND ?`;
    const [result] = await database.execute(query, [
      formattedStartDate,
      formattedEndDate,
    ]);
    return result;
  } catch (error) {
    console.error("Error fetching orders by date range:", error);
    throw error;
  }
};

export const updateOrderStatus = async (OrderID, status) => {
  let client;
  try {
    client = await database.getConnection();
    await client.beginTransaction();
    const query = `UPDATE orders SET Status = ? WHERE OrderID = ?`;
    const [result] = await client.execute(query, [status, OrderID]);
    if (result.affectedRows === 0) {
      await client.rollback();
      return {
        error: 1,
        message: "Cập nhật trạng thái đơn hàng thất bại",
      };
    }
    const [update_status] = await client.execute(
      `insert into order_status (idorder,status) VALUES (?, ?)`,
      [OrderID, status]
    );
    if (update_status.affectedRows === 0) {
      await client.rollback();
      return {
        error: 1,
        message: "Cập nhật trạng thái đơn hàng thất bại",
      };
    }
    await client.commit();
    return {
      error: 0,
      message: "Cập nhật trạng thái đơn hàng thành công",
    };
  } catch (error) {
    await client.rollback();
    console.error("Error updating order status:", error);
    throw error;
  } finally {
    if (client) {
      client.release();
    }
  }
};

export const checkOrderStatus = (OrderID) =>
  new Promise(async (resolve, reject) => {
    try {
      const query = `SELECT * FROM orders WHERE OrderID = ?`;
      const [result] = await database.execute(query, [OrderID]);
      if (result.length === 0) {
        return resolve(null); // Không tìm thấy đơn hàng
      }
      const order = result[0];
      return resolve(order);
    } catch (error) {
      console.error("Error checking order status:", error);
      return reject({
        error: 1,
        message: "Lỗi server",
      });
    }
  });
export const getStatus = (OrderID) =>
  new Promise(async (resolve, reject) => {
    try {
      const query = `SELECT * FROM order_status WHERE idorder = ? ORDER BY UpdatedAt DESC`;
      const [result] = await database.execute(query, [OrderID]);
      if (result.length === 0) {
        return resolve(null); // Không tìm thấy đơn hàng
      }
      const order = result;
      return resolve(order);
    } catch (error) {
      console.error("Error checking order status:", error);
      return reject({
        error: 1,
        message: "Lỗi server",
      });
    }
  });
