import express from 'express';
import * as customer from '../controllers/customerController.js';
const customer_route = express.Router();

customer_route.get('/',customer.getCustomer);
customer_route.get('/:id',customer.getCustomerById);
customer_route.put('/:id',customer.updateCustomer);
customer_route.delete('/:id',customer.deleteCustomer);
export default customer_route;