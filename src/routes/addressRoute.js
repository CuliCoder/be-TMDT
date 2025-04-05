import express from 'express';
import * as addressController from '../controllers/addressController.js'

const address_route = express.Router();

// Lấy danh sách địa chỉ của một khách hàng
address_route.get('/:id', addressController.getAddressesByCustomer);

// Thêm địa chỉ mới cho khách hàng
address_route.post('/', addressController.addAddress);

// Cập nhật địa chỉ
address_route.put('/:id', addressController.updateAddress);

// Xóa địa chỉ
address_route.delete('/:id', addressController.deleteAddress);

address_route.put('/set_default/:id', addressController.setDefaultAddress)
export default address_route;
