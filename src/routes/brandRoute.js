import express from 'express';
import * as brand from '../controllers/brandController.js';
const brand_route = express.Router();

brand_route.get('/', brand.getBrands);
brand_route.post('/', brand.createBrand);
brand_route.put('/:id', brand.updateBrand);
brand_route.delete('/:id', brand.deleteBrand);

export default brand_route;