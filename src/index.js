import express from "express";
import path from "path";
import connection from "./database/database.js";
import { fileURLToPath } from "url";
import auth_route from "./routes/auth.js";
import router from "./routes/api.js";
import "dotenv/config";
import cors from "cors";
import pr_Route from "./routes/productRoute.js"; 
import customer_route from "./routes/customerRoute.js";
<<<<<<< HEAD
<<<<<<< HEAD
import od_Route from "./routes/ordersRoute.js";
import orderdetail_route from "./routes/orderDetailRoute.js";
=======
import pr_Route from "./routes/productRoute.js"; 
>>>>>>> b60f829 (Lưu thay đổi của tôi trong src/index.js)
=======
import image_route from "./routes/imageRoute.js";
>>>>>>> 4595a84 (Cập nhật thêm backend Images)
const app = express();
const PORT = process.env.PORT || 3000;
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
<<<<<<< HEAD
app.use("/orders", od_Route);
app.use("/orderdetail", orderdetail_route);
app.use("/api", router);
app.get("/", (req, res) => res.send("Server hoạt động!"));


app.use("/api/customers",customer_route);

=======
app.use("/customers",customer_route);
<<<<<<< HEAD
app.get("/", (req, res) => res.send("Server hoạt động!"));

>>>>>>> b60f829 (Lưu thay đổi của tôi trong src/index.js)
=======
app.use("/products", pr_Route);
app.use("/images", image_route);
>>>>>>> 4595a84 (Cập nhật thêm backend Images)
app.listen(3000, () => {
  console.log("Server đang chạy tại http://localhost:3000");
});
