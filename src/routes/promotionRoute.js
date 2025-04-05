import express from 'express';
import * as promotion from '../controllers/promotionController.js';
const promotion_route = express.Router();

promotion_route.get('/', promotion.getPromotion);
promotion_route.post('/', promotion.createPromotion);
promotion_route.put('/:id', promotion.updatePromotion);
promotion_route.delete('/:id', promotion.deletePromotion);
promotion_route.get('/:id/products', promotion.getProductWithPromotion);
promotion_route.post('/:id/apply', promotion.applyPromotion);
promotion_route.get('/:id/percent', promotion.getpercent_by_product_item_ID);
export default promotion_route;
