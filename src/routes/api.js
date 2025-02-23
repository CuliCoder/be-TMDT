import * as cartController from '../controllers/cart.js';
import express from 'express';
const router = express.Router();
//cart
router.post('/addToCart', cartController.addToCart);
router.get('/getCart', cartController.getCart);
router.post('/updateCart', cartController.updateCart);
router.post('/removeFromCart', cartController.removeFromCart);
export default router;