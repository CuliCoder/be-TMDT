import database from "../database/database.js";
import bcrypt from "bcrypt";
const saltRounds = 10;
const hashPassword = (password) => {
  return bcrypt.hashSync(password, saltRounds);
};
export const register = (fullname, username, email, phonenumber, password) =>
  new Promise(async (resolve, reject) => {
    try {
      const hashedPassword = hashPassword(password);
      const query = `INSERT INTO users (fullname, username, email, phonenumber, passwordhash, role) VALUES (?, ?, ?, ?, ?,'customer')`;
      const [result, fields] = await database.execute(query, [
        fullname,
        username,
        email,
        phonenumber,
        hashedPassword,
      ]);
      resolve(result);
    } catch (error) {
      reject(error);
    }
  });
export const login = (username, password) =>
  new Promise(async (resolve, reject) => {
    try {
      const query = `SELECT * FROM users WHERE username = ?`;
      const [users, fields] = await database.execute(query, [username]);
      if (users.length === 0) {
        reject({
          error: 1,
          message: "Tài khoản không tồn tại",
        });
        return;
      }
      const user = users[0];
      if (!bcrypt.compareSync(password, user.PasswordHash)) {
        reject({
          error: 1,
          message: "Mật khẩu không chính xác",
        });
        return;
      }
      resolve({
        error: 0,
        message: "Đăng nhập thành công",
        data: {
          id: user.UserID,
          fullname: user.FullName,
          username: user.Username,
          email: user.Email,
          phonenumber: user.PhoneNumber,
          role: user.Role,
        },
      });
    } catch (error) {
      reject(error);
    }
  });
