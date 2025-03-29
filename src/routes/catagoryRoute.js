import express from 'express';
import * as catagory from '../controllers/catagoryController.js';
const catagory_route = express.Router();

catagory_route.get('/', catagory.getCatagory);
catagory_route.post('/', catagory.createCatagory);
catagory_route.put('/:id', catagory.updateCatagory);
catagory_route.delete('/:id', catagory.deleteCatagory);

export default catagory_route;