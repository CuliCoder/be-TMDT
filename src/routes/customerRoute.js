import express from 'express';
import * as customer from '../controllers/customerController.js';
console.log("customer:", customer);
console.log("customer.updateCustomer:", customer.updateCustomer);

const customer_route = express.Router();

customer_route.get('/',customer.getCustomer);
customer_route.get('/:id',customer.getCustomerById);
// customer_route.post('/',customer.addCustomer);
customer_route.put('/:id',customer.updateCustomer);
customer_route.delete('/:id',customer.deleteCustomer);
export default customer_route;