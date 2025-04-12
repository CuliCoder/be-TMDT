import database from "../database/database.js";
import bcrypt from "bcrypt";
const saltRounds = 10;

const hashPassword = (password) => {
  return bcrypt.hashSync(password, saltRounds);
};

export const registerUser = async (
  fullname,
  email,
  phonenumber,
  password,
  confirmPassword
) => {
  if (password !== confirmPassword) {
    throw { error: 1, message: "Mật khẩu nhập lại không khớp" };
  }

  // Kiểm tra email hợp lệ
  if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
    throw { error: 1, message: "Email không hợp lệ" };
  }

  // Kiểm tra số điện thoại hợp lệ (bắt đầu bằng 0, có 10-11 số)
  if (!/^0\d{9,10}$/.test(phonenumber)) {
    throw { error: 1, message: "Số điện thoại không hợp lệ" };
  }

  const checkQuery = `SELECT * FROM users WHERE Email = ? OR PhoneNumber = ?`;
  const [existingUsers] = await database.execute(checkQuery, [
    email,
    phonenumber,
  ]);

  if (existingUsers.length > 0) {
    throw { error: 1, message: "Email hoặc số điện thoại đã tồn tại" };
  }

  const hashedPassword = hashPassword(password);

  const query = `INSERT INTO users (FullName, Email, PhoneNumber, PasswordHash, Role, status) VALUES (?, ?, ?, ?, ?, ?)`;
  await database.execute(query, [
    fullname,
    email,
    phonenumber,
    hashedPassword,
    "customer",
    1,
  ]);

  return { error: 0, message: "Đăng ký thành công" };
};

export const loginUser = async (identifier, password) => {
  const query = `SELECT * FROM users WHERE (Email = ? OR PhoneNumber = ?) AND Status = 1 and Role = 'customer'`;
  const [users] = await database.execute(query, [identifier, identifier]);

  if (users.length === 0) {
    throw { error: 1, message: "Tài khoản không tồn tại hoặc đã bị khóa" };
  }

  const user = users[0];
  if (!bcrypt.compareSync(password, user.PasswordHash)) {
    throw { error: 1, message: "Tài khoản hoặc mật khẩu không chính xác" };
  }

  return {
    error: 0,
    message: "Đăng nhập thành công",
    data: {
      id: user.UserID,
      fullname: user.FullName,
      email: user.Email,
      phonenumber: user.PhoneNumber,
      role: user.Role,
    },
  };
};

export const loginAdmin = async (identifier, password) => {
  try {
    const query = `SELECT * FROM users WHERE (Email = ? OR PhoneNumber = ?) AND Status = 1 and Role = 'admin'`;
    const [users] = await database.execute(query, [identifier, identifier]);
    if (users.length === 0) {
      return { error: 1, message: "Tài khoản không tồn tại hoặc đã bị khóa" };
    }

    const user = users[0];
    if (!bcrypt.compareSync(password, user.PasswordHash)) {
      return { error: 1, message: "Tài khoản hoặc mật khẩu không chính xác" };
    }
    return {
      error: 0,
      message: "Đăng nhập thành công",
      data: {
        id: user.UserID,
        fullname: user.FullName,
        email: user.Email,
        phonenumber: user.PhoneNumber,
        role: user.Role,
      },
    };
  } catch (error) {
    console.error("Lỗi trong loginAdmin:", error);
    return { error: 1, message: "Đã xảy ra lỗi trong quá trình đăng nhập" };
  }
};
