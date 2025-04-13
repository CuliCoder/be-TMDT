import connection from '../database/database.js';

// Lấy top 3 sản phẩm bán chạy nhất
export const getTopProducts = async () => {
    try {
        const query = `
            SELECT p.ProductName, SUM(od.Quantity) AS totalSold
            FROM orderdetails od
            JOIN product_item pi ON od.Product_Item_ID = pi.id  -- Liên kết với bảng product_item
            JOIN products p ON pi.product_id = p.ProductID  -- Liên kết với bảng products
            GROUP BY p.ProductName
            ORDER BY totalSold DESC
            LIMIT 1;
        `;
        const [rows] = await connection.execute(query);
        return rows;
    } catch (error) {
        console.error(" SQL error:", error.message);
        throw error;
    }
};


// Lấy tổng doanh thu
export const getTotalRevenue = async (startDate, endDate) => {
    try {
        const query = `
            SELECT SUM(TotalAmount) AS totalRevenue
            FROM orders
            WHERE OrderDate BETWEEN ? AND ?
        `;
        const [rows] = await connection.execute(query, [startDate, endDate]);
        return rows[0];
    } catch (error) {
        console.error("Error fetching total revenue:", error);
        throw error;
    }
};

export const getTotalRevenueToday = async () => {
    try {
        const query = `
            SELECT SUM(TotalAmount) AS totalRevenue
            FROM orders
            WHERE DATE(OrderDate) = CURDATE()
        `;
        const [rows] = await connection.execute(query);
        return rows[0];
    } catch (error) {
        console.error("Error fetching total revenue today:", error);
        throw error;
    }
};


// Lấy đơn hàng trong hôm nay
export const getOrderToday = async () => {
    try {
        const query = `
            SELECT OrderID, OrderDate, TotalAmount, name, phonenumber, payment_method
            FROM orders
            WHERE DATE(OrderDate) = CURDATE()
        `;
        const [rows] = await connection.execute(query);
        return rows;
    } catch (error) {
        console.error("Error fetching today's orders:", error);
        throw error;
    }
};


// Lấy số người dùng mới
export const getNewUserCount = async () => {
    try {
        const query = `
            SELECT COUNT(*) AS newUsers
            FROM users u
            WHERE u.role = 'customer'
            AND DATE(u.CreatedAt) = CURDATE()
            AND EXISTS (
                SELECT 1
                FROM orders o
                WHERE o.UserID = u.UserID
                AND DATE(o.OrderDate) = CURDATE()
                AND (
                    SELECT MIN(OrderDate)
                    FROM orders
                    WHERE UserID = u.UserID
                ) = o.OrderDate
            )
        `;
        const [rows] = await connection.execute(query);
        return rows[0];
    } catch (error) {
        console.error("Lỗi khi lấy khách hàng mới trong ngày:", error);
        throw error;
    }
};


