import connection from '../database/database.js';

// Lấy danh sách địa chỉ của khách hàng
export const getAddressesByCustomer = async (iduser) => {
    try {
        const query = "SELECT * FROM user_address WHERE iduser = ?";
        const [addresses] = await connection.execute(query, [iduser]);
        return addresses;
    } catch (error) {
        console.error(error);
        throw error
    }
};



// Thêm địa chỉ mới
export const addAddress = async (iduser, phonenumber, address, name, setDefault) => {
    try {
        const query = "INSERT INTO user_address (iduser, phonenumber, name, address, setDefault) VALUES (?, ?, ?, ?, ?)";
        const [result] = await connection.execute(query, [iduser, phonenumber, name, address, setDefault]);

        // Trả về kết quả khi thêm địa chỉ
        return result;
    } catch (error) {
        console.error("Lỗi khi thêm địa chỉ:", error);
        throw error;
    }
};

// Đặt tất cả địa chỉ của người dùng thành không mặc định
export const setAllAddressesNonDefault = async (iduser) => {
    try {
        const query = "UPDATE user_address SET setDefault = 0 WHERE iduser = ?";
        await connection.execute(query, [iduser]);
    } catch (error) {
        console.error("Lỗi khi đặt tất cả địa chỉ thành không mặc định:", error);
        throw error;
    }
};


// Cập nhật địa chỉ
export const updateAddress = async (id, name, phonenumber, address) => {
    try {
        const query = "UPDATE user_address SET name = ?, phonenumber = ?, address = ? WHERE iduser_address = ?";
        const [result] = await connection.execute(query, [name, phonenumber, address, id]);

        if (result.affectedRows === 0) {
            throw new Error("Không tìm thấy địa chỉ để cập nhật!");
        }

        return { id, name, phonenumber, address }; // Trả về dữ liệu đã cập nhật
    } catch (error) {
        console.error("Lỗi updateAddress:", error);
        throw error;
    }
};


// Xóa địa chỉ
export const deleteAddress = async (id) => {
    try {
        const query = "DELETE FROM user_address WHERE iduser_address = ?";
        await connection.execute(query, [id]);    
    } catch (error) {
        console.log(error)
        throw error;
    }
};

// Đặt một địa chỉ làm mặc định
export const setDefaultAddress = async (iduser_address, iduser) => {
    try {
        // Bỏ mặc định các địa chỉ khác
        await connection.execute("UPDATE user_address SET setDefault = 0 WHERE iduser = ?", [iduser]);
        // Đặt địa chỉ được chọn làm mặc định
        await connection.execute("UPDATE user_address SET setDefault = 1 WHERE iduser_address = ?", [iduser_address]);
    } catch (error) {
        console.error(error);
        throw error;   
    }
};
