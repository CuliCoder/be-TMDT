import database from "../database/database.js";

export const addOrder = async (userid, totalAmount) => {
    try {
        const query = `INSERT INTO orders (UserID, OrderDate, TotalAmount, Status) VALUES (?, ?, ?, ?)`;
        const currentTime = new Date().toISOString().slice(0, 19).replace("T", " "); // Chuyển sang định dạng MySQL DATETIME
        const [result] = await database.execute(query, [userid, currentTime, totalAmount, 1]);
        return result.insertId;
    } catch (error) {
        console.error("Error adding order:", error);
        throw error;
    }
};

export const getOrders = async () => {
    try {
        const query = `SELECT * FROM orders`;
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
        const query = `SELECT * FROM orders WHERE UserID = ?`;
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
        const formattedStartDate = new Date(startDate).toISOString().slice(0, 19).replace("T", " ");
        const formattedEndDate = new Date(endDate).toISOString().slice(0, 19).replace("T", " ");

        const query = `SELECT * FROM orders WHERE OrderDate BETWEEN ? AND ?`;
        const [result] = await database.execute(query, [formattedStartDate, formattedEndDate]);
        return result;
    } catch (error) {
        console.error("Error fetching orders by date range:", error);
        throw error;
    }
};
export const updateOrderStatus = async (OrderID, status) => {
    try {
        const query = `UPDATE orders SET Status = ? WHERE OrderID = ?`;
        const [result] = await database.execute(query, [status, OrderID]);
        return result.affectedRows;
    } catch (error) {
        console.error("Error updating order status:", error);
        throw error;
    }
}
