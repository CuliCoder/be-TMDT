import * as addressService from '../services/addressService.js';

// Lấy danh sách địa chỉ của một khách hàng
export const getAddressesByCustomer = async (req, res) => {
    try {
        const { id } = req.params;
        const addresses = await addressService.getAddressesByCustomer(id);
        res.status(200).json(addresses);
    } catch (error) {
        console.error("Lỗi getAddressesByCustomer:", error);
        res.status(500).json({ success: false, message: "Lỗi server!" });
    }
};

// Thêm địa chỉ mới
export const addAddress = async (req, res) => {
    try {
        const { iduser, phonenumber, address, name, setDefault } = req.body;

        // Kiểm tra xem các dữ liệu cần thiết có đầy đủ không
        if (!iduser || !address || !phonenumber || !name) {
            return res.status(400).json({ success: false, message: "Thiếu dữ liệu cần thiết!" });
        }

        // Nếu setDefault là 1, đảm bảo chỉ có một địa chỉ mặc định
        if (setDefault === 1) {
            // Cập nhật tất cả các địa chỉ của người dùng thành không mặc định
            await addressService.setAllAddressesNonDefault(iduser);
        }

        // Gọi service để thêm địa chỉ
        const newAddress = await addressService.addAddress(iduser, phonenumber, address, name, setDefault);

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
        const { name, phonenumber, address } = req.body;

        // Kiểm tra dữ liệu đầu vào
        if (!id || !name || !phonenumber || !address) {
            return res.status(400).json({ success: false, message: "Thiếu thông tin cập nhật!" });
        }

        // Gọi Service để cập nhật
        const updatedAddress = await addressService.updateAddress(id, name, phonenumber, address);

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

export const getDefaultAddress = async (req, res) => {
    try {
        const { id } = req.params;
        const address = await addressService.getDefaultAddress(id);
        return res.status(200).json(address);
    } catch (error) {
        console.error("Lỗi getDefaultAddress:", error);
        return res.status(500).json({ success: false, message: "Lỗi server!" });
    }
}