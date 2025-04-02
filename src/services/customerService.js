import connection from "../database/database.js";
import bcrypt from "bcrypt";

function hashPassword(password) {
    if (!password) {
        throw new Error("Password không được để trống!");
    }
    return bcrypt.hashSync(password, 10); 
}

export const getCustomers = async() => {
    try {
        const query = "select * from users where role = 'customer'";
        const [result] = await connection.execute(query);
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
}
export const getCustomerById = async(id) => {
    try {
        const query ="select * from users where role = 'customer' and UserID = ?";
        const [result] = await connection.execute(query, [id]);
        return result[0];
    } catch (error) {
        console.error(error);
        throw error;
    }
}
export const updateCustomer = async (id, email, fullname, phonenumber) => {
    try {
        const query = `
            UPDATE users 
            SET   email = ?, fullname = ?, phonenumber = ?
            WHERE UserID = ?
        `;
        const [result] = await connection.execute(query, [  email, fullname, phonenumber, id]);
    } catch (error) {
        console.error("Lỗi updateCustomer:", error);
        throw error;
    }
};
export const deleteCustomer = async (id) => {
    try {
        const query = "DELETE FROM users WHERE UserID = ?";
        const [result] = await connection.execute(query, [id]);
    } catch (error) {
        console.error("Lỗi deleteCustomer:", error);
        throw error;
    }
};
export const statusCustomer = async (id,status) => {
    try {
        const st = String(status);
        const query = "UPDATE users SET status = ? WHERE UserID = ?";
        const [result] = await connection.execute(query, [st, id]);
    } catch (error) {
        console.error("Lỗi statusCustomer:", error);
        throw error;
    }
}

export const changePasswords = async (id, oldPassword, newPassword) => {
    try {
        // 1. Lấy thông tin user từ database
        const queryGetUser = "SELECT * FROM users WHERE UserID = ?";
        const [users] = await connection.execute(queryGetUser, [id]);

        // 2. Kiểm tra nếu user không tồn tại
        if (users.length === 0) {
            throw new Error("Người dùng không tồn tại!");
        }

        const hashedPassword = users[0].PasswordHash; // Password đã mã hóa trong DB

        // 3. So sánh password cũ với hashed password trong DB
        const isMatch = bcrypt.compareSync(oldPassword, hashedPassword);
        if (!isMatch) {
            return {message: "Mật khẩu cũ không chính xác"}
        }

        // 4. Mã hóa mật khẩu mới
        const newHashedPassword = bcrypt.hashSync(newPassword, 10);

        // 5. Cập nhật mật khẩu mới vào database
        const queryUpdatePassword = "UPDATE users SET PasswordHash = ? WHERE UserID = ?";
        await connection.execute(queryUpdatePassword, [newHashedPassword, id]);

        return { message: "Đổi mật khẩu thành công!" };
    } catch (error) {
        console.error("Lỗi changePasswords:", error);
        throw error;
    }
};
