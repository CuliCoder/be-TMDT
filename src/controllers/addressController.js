import * as addressService from '../services/addressService.js';

// Lấy danh sách địa chỉ của một khách hàng
export const getAddressesByCustomer = async (req, res) => {
    try {
        const { id } = req.params;
        const addresses = await addressService.getAddressesByCustomer(id);
        res.status(200).json(addresses );
    } catch (error) {
        console.error("Lỗi getAddressesByCustomer:", error);
        res.status(500).json({ success: false, message: "Lỗi server!" });
    }
};



// Thêm địa chỉ mới
export const addAddress = async (req, res) => {
    try {
        const { iduser, address } = req.body;
        if (!iduser || !address) {
            return res.status(400).json({ success: false, message: "Thiếu dữ liệu cần thiết!" });
        }
        const newAddress = await addressService.addAddress(iduser, address);
        res.status(201).json({ success: true, message: "Thêm địa chỉ thành công!", data: newAddress });
    } catch (error) {
        console.error("Lỗi addAddress:", error);
        res.status(500).json({ success: false, message: "Lỗi server!" });
    }
};

// Cập nhật địa chỉ
export const updateAddress = async (req, res) => {
    try {
        const { id } = req.params;
        const { address } = req.body;
        const updatedAddress = await addressService.updateAddress(id, address);
        res.json({ success: true, message: "Cập nhật địa chỉ thành công!", data: updatedAddress });
    } catch (error) {
        console.error("Lỗi updateAddress:", error);
        res.status(500).json({ success: false, message: "Lỗi server!" });
    }
};

// Xóa địa chỉ
export const deleteAddress = async (req, res) => {
    try {
        const { id } = req.params;
        await addressService.deleteAddress(id);
        res.json({ success: true, message: "Xóa địa chỉ thành công!" });
    } catch (error) {
        console.error("Lỗi deleteAddress:", error);
        res.status(500).json({ success: false, message: "Lỗi server!" });
    }
};

// Đặt địa chỉ làm mặc định
export const setDefaultAddress = async (req, res) => {
    try {
        console.log("req.params:", req.params);
        console.log("req.body:", req.body);

        const { id } = req.params;
        const { iduser } = req.body;

        if (!id || !iduser) {
            return res.status(400).json({ success: false, message: "Thiếu iduser hoặc iduser_address!" });
        }

        await addressService.setDefaultAddress(id, iduser);
        res.json({ success: true, message: "Đặt địa chỉ mặc định thành công!" });
    } catch (error) {
        console.error("Lỗi setDefaultAddress:", error);
        res.status(500).json({ success: false, message: "Lỗi server!" });
    }
};
