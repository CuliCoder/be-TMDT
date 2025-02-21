import * as oddt from '../services/orderDetailService';

export const getOrderDetail = async (req, res) => {
    try {
        const OrderID = req.params;
        const result = await oddt.getOrderDetail(OrderID);
        return res.status(200).json(result)
    } catch (error) {
        return res.status(500).json({ message: 'Lấy OrderDetail theo OrderID thất bại'})
    }
}

// export const addOrderDetail = async (req, res) => 
//     {
//         try {
//             const {OrderID, ProductID, Quantity, Price} = req.body;
//             const result = await oddt.addOrderDetail(OrderID, ProductID, Quantity, Price);
//             return res.status(200).json(result);
//         } catch (error) {
//             console.log(error);
//             return res.status(500).json({ message: 'Thêm chi tiết hóa đơn thất bại' });
//         }
//     }