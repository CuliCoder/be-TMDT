import * as cus from '../services/customerService.js';

export const getCustomer = async (req, res) => {
    try {
        const result = await cus.getCustomers();
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Lấy Customers thất bại' ,error:error.message});
    }
}

export const getCustomerById = async (req, res) => {
    try {
        const {id} =req.params;
        const result = await cus.getCustomerById(id);
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Lấy danh sách khách hànghàng thất bại' , error:error.message});
    }
}
export const updateCustomer= async (req,res) => {
    try {
        const {id} = req.params;
        const {fullname, username, email, phonenumber, password} = req.body;
        const result = await cus.updateCustomer(id,username, password, email,fullname, phonenumber);
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Cập nhật khách hàng thất bại' , error:error.message});
    }
}
export const deleteCustomer = async (req, res) => {
    try {
        const {id} = req.params;
        const result = await cus.deleteCustomer(id);
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: 'Xóa khách hàng thất bại' , error:error.message});
    }
}