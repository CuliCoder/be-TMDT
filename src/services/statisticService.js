import connection from '../database/database.js';

// Lấy top sản phẩm bán chạy
export const getTopProducts = async (startDate, endDate) => {
    try {
        const query = `
            SELECT 
                p.ProductID, p.ProductName,
                SUM(od.Quantity) AS totalSold
            FROM 
                orderdetails od
            JOIN 
                product_item pi ON od.Product_Item_ID = pi.id
            JOIN 
                products p ON pi.product_id = p.ProductID
            JOIN 
                orders o ON od.OrderID = o.OrderID
            WHERE 
                o.OrderDate BETWEEN ? AND ?
            GROUP BY 
                p.ProductID, p.ProductName
            ORDER BY 
                totalSold DESC
            LIMIT 10
        `;
        const [rows] = await connection.execute(query, [startDate, endDate]);
        return rows;
    } catch (error) {
        console.error("Error fetching top products:", error);
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

// Lấy đơn hàng trong hôm nay
export const getOrderToday = async () => {
    try {
        const query = `
            SELECT * FROM orders
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
export const getNewUserCount = async (startDate, endDate) => {
    try {
        const query = `
            SELECT COUNT(*) AS newUsers
            FROM users
            WHERE role = 'customer' and CreatedAt BETWEEN ? AND ?
        `;
        const [rows] = await connection.execute(query, [startDate, endDate]);
        return rows[0];
    } catch (error) {
        console.error("Error fetching new user count:", error);
        throw error;
    }
};
