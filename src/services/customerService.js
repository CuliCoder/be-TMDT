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
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
}
export const updateCustomer = async (id, username, password, email, fullname, phonenumber) => {
    try {
        const hashPass = hashPassword(password);
        const query = `
            UPDATE users 
            SET username = ?, passwordhash = ?, email = ?, fullname = ?, phonenumber = ?
            WHERE UserID = ?
        `;
        const [result] = await connection.execute(query, [username, hashPass, email, fullname, phonenumber, id]);
    } catch (error) {
        console.error("Lỗi updateCustomer:", error);
        throw error;
    }
};


export const deleteCustomer = async(id) =>{
    try {
        const query ="update users set status = ?  where userID = ?";
        const [result] = await connection.execute(query,['0',id]);
        return result;
    } catch (error) {
        console.error(error);
        throw error;
    }
}