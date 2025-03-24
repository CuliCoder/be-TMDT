import express from 'express';
import * as supplier from '../controllers/supplierController.js';

const supplier_route = express.Router();

supplier_route.get('/', supplier.getSuppliers);
supplier_route.get('/:id', supplier.getSupplierById);
supplier_route.post('/', supplier.addSupplier);  // Thêm nhà cung cấp
supplier_route.put('/:id', supplier.updateSupplier);
supplier_route.delete('/:id', supplier.deleteSupplier);
supplier_route.put('/status/:id', supplier.statusSupplier);

export default supplier_route;
