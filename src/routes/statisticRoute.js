import express from 'express';
import * as staticstic from '../controllers/statisticController.js';
const staticstic_route = express.Router();

// Sửa toàn bộ sang POST
staticstic_route.post('/top-products', staticstic.getTopProducts);
staticstic_route.post('/total-revenue', staticstic.getTotalRevenue);
staticstic_route.post('/total-revenue-today', staticstic.getTotalRevenueToday);
staticstic_route.post('/order-today', staticstic.getOrderToday);
staticstic_route.post('/new-users', staticstic.getNewUserCount);

export default staticstic_route;
