import express from 'express';
import * as promotion from '../controllers/promotionController.js';
const promotion_route = express.Router();

promotion_route.get('/', promotion.getPromotion);
promotion_route.post('/', promotion.createPromotion);
promotion_route.put('/:id', promotion.updatePromotion);
// promotion_route.delete('/:id', promotion.deletePromotion);

export default promotion_route;