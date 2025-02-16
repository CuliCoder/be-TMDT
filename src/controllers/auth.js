import * as auth from '../services/auth.js';
export const register = async (req, res) => {
    try {
        const { fullname, username, email, phonenumber, password } = req.body;
        if (!fullname || !username || !email || !phonenumber || !password) {
            return res.status(400).json({
                error: 1,
                message: "Thiếu thông tin đăng ký",
            });
        }
        const result = await auth.register(fullname, username, email, phonenumber, password);
        return res.status(200).json(result);
    } catch (error) {
        console.log(error);
        return res.status(500).json(error);
    }
}
export const login = async (req, res) => {
    try {
        const { username, password } = req.body;
        if (!username || !password) {
            return res.status(400).json({
                error: 1,
                message: "Thiếu tên đăng nhập hoặc mật khẩu",
            });
        }
        const user = await auth.login(username, password);
        return res.status(200).json(user);
    } catch (error) {
        console.log(error);
        return res.status(500).json(error);
    }
}