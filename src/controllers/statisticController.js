import * as statisticsService from '../services/statisticService.js';

export const getTopProducts = async (req, res) => {
    try {
        const { startDate, endDate } = req.body;
        const result = await statisticsService.getTopProducts(startDate, endDate);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy top sản phẩm' });
    }
};

export const getTotalRevenue = async (req, res) => {
    try {
        const { startDate, endDate } = req.body;
        const result = await statisticsService.getTotalRevenue(startDate, endDate);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy tổng doanh thu:' });
    }
};

export const getOrderToday = async (req, res) => {
    try {
        const result = await statisticsService.getOrderToday();
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy tổng số sản phẩm đã bán' });
    }
};

export const getNewUserCount = async (req, res) => {
    try {
        const { startDate, endDate } = req.body;
        const result = await statisticsService.getNewUserCount(startDate, endDate);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: 'Lỗi khi lấy số tài khoản mới' });
    }
};
