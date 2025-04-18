import { registerUser, loginUser, loginAdmin } from "../services/auth.js";

export const register = async (req, res) => {
  try {
    const { FullName, Email, PhoneNumber, Password, ConfirmPassword } =
      req.body;
    const result = await registerUser(
      FullName,
      Email,
      PhoneNumber,
      Password,
      ConfirmPassword
    );

    res.status(200).json(result);
  } catch (error) {
    res.status(400).json(error);
  }
};

export const login = async (req, res) => {
  try {
    console.log("Dữ liệu nhận từ frontend:", req.body); // Log request body

    const { Email, PhoneNumber, Password } = req.body;

    if ((!Email && !PhoneNumber) || !Password) {
      return res
        .status(400)
        .json({ error: 1, message: "Thiếu thông tin đăng nhập" });
    }

    const loginIdentifier = Email || PhoneNumber;
    const result = await loginUser(loginIdentifier, Password);

    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({
      error: 1,
      message: "Tài khoản và mật khẩu không đúng. Vui lòng thử lại ",
      details: error.message,
    });
  }
};

export const loginAdm = async (req, res) => {
  try {
    const loginIdentifier = req.body.loginIdentifier;
    const password = req.body.password;

    if (!loginIdentifier || !password) {
      return res
        .status(400)
        .json({ error: 1, message: "Thiếu thông tin đăng nhập" });
    }
    const result = await loginAdmin(loginIdentifier, password);
    return res.status(200).json(result);
  } catch (error) {
    console.error("Lỗi trong loginAdmin:", error);
    return res.status(500).json({ error: 1, message: error.message });
  }
};
