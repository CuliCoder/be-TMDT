import * as od from '../services/ordersService.js';
import * as oddt from '../services/orderDetailService.js';

export const addOrder = async (req, res) => 
{
    try {
        const {userid, totalAmount, OrderDetail} = req.body;
        const addOD = await od.addOrder(userid, totalAmount);
        for (const item of OrderDetail){
            const addODDetail = 
            await oddt.addOrderDetail(addOD.dataValues.OrderID, item.ProductID, item.Quantity, item.Price);
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
        const OrderID = req.params;
        const result = await od.getOrderByID(OrderID);
        return res.status(200).json(result)
    } catch (error) {
        return res.status(500).json({ message: 'Lấy Orders theo ID thất bại'})
    }
}