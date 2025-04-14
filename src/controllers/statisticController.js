import * as statisticsService from '../services/statisticService.js';

export const getTopProducts = async (req, res) => {
    try {
        const result = await statisticsService.getTopProducts();
        res.json({ topProducts: result });
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy top sản phẩm' });
    }
};

export const getTotalRevenue = async (req, res) => {
    try {
        const { startDate, endDate } = req.body;
        const result = await statisticsService.getTotalRevenue(startDate, endDate);
        res.json({ totalRevenue: result.totalRevenue }); // Đảm bảo trả về đúng dữ liệu
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy tổng doanh thu' });
    }
};

// Trả về tổng doanh thu trong ngày hôm nay
export const getTotalRevenueToday = async (req, res) => {
    try {
        const result = await statisticsService.getTotalRevenueToday();
        res.json({ totalRevenue: result.totalRevenue }); // Đảm bảo trả về đúng dữ liệu
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy tổng doanh thu hôm nay' });
    }
};


// Trả về đơn hàng hôm nay
export const getOrderToday = async (req, res) => {
    try {
        const result = await statisticsService.getOrderToday();
        res.json({ orders: result });
    } catch (err) {
        console.error("Error in controller getOrderToday:", err);
        res.status(500).json({ error: 'Lỗi khi lấy đơn hàng hôm nay' });
    }
};

export const getNewUserCount = async (req, res) => {
    try {
        const result = await statisticsService.getNewUserCount();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy số khách hàng mới trong ngày' });
    }
};

