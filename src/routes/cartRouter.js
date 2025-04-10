import express from 'express';
import * as cartController from '../controllers/cart.js';

const cartRouter = express.Router();
cartRouter.get('/', cartController.getCart);
cartRouter.post('/', cartController.addToCart);
cartRouter.delete('/:id/:userid', cartController.removeFromCart);
cartRouter.put('/', cartController.updateCart);
cartRouter.post('/placeOrder/:userid', cartController.placeOrder);
export default cartRouter;