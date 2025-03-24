import express from 'express';
import * as promotion from '../controllers/promotionController.js';
const promotion_route = express.Router();

promotion_route.get('/', promotion.getPromotion);
promotion_route.post('/', promotion.createPromotion);
promotion_route.put('/:id', promotion.updatePromotion);
promotion_route.get('/:id/products', promotion.getProductWithPromotion);
promotion_route.post('/:id/apply', promotion.applyPromotion);
export default promotion_route;