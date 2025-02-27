import express from 'express';
import * as customer from '../controllers/customerController.js';
const customer_route = express.Router();

customer_route.get('/',customer.getCustomer);
customer_route.get('/:id',customer.getCustomerById);
customer_route.put('/:id',customer.updateCustomer);
customer_route.delete('/:id',customer.deleteCustomer);
customer_route.put('/status/:id',customer.statusCustomer);
export default customer_route;