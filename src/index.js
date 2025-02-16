import express from "express";
import path from "path";
import connection from "./database/database.js";
import { fileURLToPath } from "url";
import auth_route from "./routes/auth.js";
import "dotenv/config";
import cors from "cors";
const app = express();
app.use(cors(
  {
    origin:process.env.URL_CLIENT,
    credentials:true,
    methods:['GET','POST','PUT','DELETE']
  }
));
// Phục vụ các tệp tĩnh từ thư mục 'public'
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
app.use(express.static(path.join(__dirname, "../public")));
app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ limit: "50mb", extended: true }));
// Kết nối với cơ sở dữ liệu
connection.getConnection((err) => {
  if (err) {
    console.error("Lỗi kết nối cơ sở dữ liệu: " + err.message);
    return;
  }
  console.log("Kết nối cơ sở dữ liệu thành công!");
});
app.use("/auth", auth_route);

app.listen(3000, () => {
  console.log("Server đang chạy tại http://localhost:3000");
});
