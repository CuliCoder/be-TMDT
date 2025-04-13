import express from 'express';
import * as staticstic from '../controllers/statisticController.js';
const staticstic_route = express.Router();

staticstic_route.get('/top-products', staticstic.getTopProducts);
staticstic_route.get('/total-revenue', staticstic.getTotalRevenue);
staticstic_route.get('/order-today', staticstic.getOrderToday);
staticstic_route.get('/new-users', staticstic.getNewUserCount);

export default staticstic_route;
