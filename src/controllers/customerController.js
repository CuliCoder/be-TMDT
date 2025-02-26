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
export const updateCustomer = async (req, res) => { 
    try {
        const id = req.params.id;
        const { username, password, fullname, email, phonenumber } = req.body;

        if (!id) {
            return res.status(400).json({ message: "Thiếu ID khách hàng!" });
        }

        const result = await cus.updateCustomer(id, username, password, email, fullname, phonenumber);
        return res.json({ message: "Cập nhật thành công!", result });
    } catch (error) {
        console.error("Lỗi updateCustomer:", error);
        return res.status(500).json({ message: "Lỗi server!" });
    }
};
export const deleteCustomer = async (req, res) => {
    try {
        const id = req.params.id;
        if (!id) {
            return res.status(400).json({ message: "Thiếu ID khách hàng!" });
        }
        const result = await cus.deleteCustomer(id);
        return res.json({ message: "Xóa thành công!", result });
    } catch (error) {
        console.error("Lỗi deleteCustomer:", error);
        return res.status(500).json({ message: "Lỗi server!" });
    }
}
export const statusCustomer = async (req, res) => {
    try {
        const id = req.params.id;
        const status = req.body.status;
        if (!id) {
            return res.status(400).json({ message: "Thiếu ID khách hàng!" });
        }
        const result = await cus.statusCustomer(id, status);
        return res.json({ message: "Cập nhật trạng thái thành công!", result });
    } catch (error) {
        console.error("Lỗi statusCustomer:", error);
        return res.status(500).json({ message: "Lỗi server!" });
    }
}