import * as od from '../services/ordersService.js';
import * as oddt from '../services/orderDetailService.js';
import * as product from '../services/productService.js';

export const addOrder = async (req, res) => 
{
    try {
        const userid = req.body.UserID;
        const totalAmount = req.body.TotalAmount;
        const OrderDetail = req.body.detailOrder;
        if (!userid || !totalAmount || !Array.isArray(OrderDetail)) {
            return res.status(400).json({ message: 'Thiếu dữ liệu cần thiết hoặc dữ liệu không hợp lệ' });
        }
        const addOD = await od.addOrder(userid, totalAmount)
        for (const item of OrderDetail){
            await oddt.addOrderDetail(addOD, item.ProductID, item.Quantity, item.Price);
            const productUpdate = await product.getProductById(item.ProductID);
            console.log(productUpdate);
            const dataProduct = {
                StockQuantity: productUpdate.StockQuantity - item.Quantity
            }
            await product.updateProduct(item.ProductID, dataProduct);
        }
        return res.status(200).json({ message: 'Thêm hóa đơn thành công' });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Thêm hóa đơn thất bại' });
    }
}
export const getOrders = async (req, res) => 
{
    try {
        const result = await od.getOrders();
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Lấy Orders thất bại' });
    }
}
export const getOrderByID = async (req, res) => {
    try {
        const OrderID = req.params.id;
        const result = await od.getOrderByID(OrderID);
        console.log(result);
        return res.status(200).json(result)
    } catch (error) {
        return res.status(500).json({ message: 'Lấy Orders theo ID thất bại'})
    }
}
export const getOrderByUserID = async (req, res) => {
    try {
        const UserID = req.params.id;
        const result = await od.getOrderByUserID(UserID);
        return res.status(200).json(result)
    } catch (error) {
        return res.status(500).json({ message: 'Lấy Orders theo UserID thất bại'})
    }
}
export const updateOrderStatus = async (req, res) => {
    try {
        const {OrderID, Status} = req.body;
        const result = await od.updateOrderStatus(OrderID, Status);
        return res.status(200).json(result);
    } catch (error) {
        return res.status(500).json({ message: 'Cập nhật trạng thái đơn hàng thất bại'})
    }
}