import express from "express";
import path from "path";
import connection from "./database/database.js";
import { fileURLToPath } from "url";
import auth_route from "./routes/auth.js";
import router from "./routes/api.js";
import "dotenv/config";
import cors from "cors";
import customer_route from "./routes/customerRoute.js";
import od_Route from "./routes/ordersRoute.js";
import orderdetail_route from "./routes/orderDetailRoute.js";
import pr_Route from "./routes/productRoute.js";
import image_route from "./routes/imageRoute.js";
import supplier_route from "./routes/supplierRoute.js";
import promotion_route from "./routes/promotionRoute.js";
import brand_route from "./routes/brandRoute.js";
import catagory_route from "./routes/catagoryRoute.js";
import address_route from "./routes/addressRoute.js";
import cart_router from "./routes/cartRouter.js";
import cron from "node-cron";
import { cancelLateOrders } from "./services/cart.js";
import { checkPaymentFromTransactions } from "./utils/cron.js";
const app = express();
const PORT = process.env.PORT || 3000;
app.use(
  cors({
    origin: "*", // Nếu vẫn lỗi, đổi thành "*" để chấp nhận tất cả
    credentials: true,
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

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
app.use("/orders", od_Route);
app.use("/orderdetail", orderdetail_route);
app.use("/api", router);
app.get("/", (req, res) => res.send("Server hoạt động!"));
app.use("/api/customers", customer_route);
app.use("/customers", customer_route);
app.use("/product", pr_Route);
app.use("/products", pr_Route);
app.use("/images", image_route);
app.use("/brands", brand_route);
app.use("/api/suppliers", supplier_route);
app.use("/api/promotions", promotion_route);
app.use("/categories", catagory_route);
app.use("/api/addressCustomer", address_route);
app.use("/cart", cart_router);
cron.schedule("*/1 * * * *", async () => {
  try {
    console.log(await checkPaymentFromTransactions());
    console.log(await cancelLateOrders());
  } catch (error) {
    console.error("Lỗi khi kiểm tra đơn hàng thanh toán:", error);
  }
});
app.listen(3000, () => {
  console.log("Server đang chạy tại http://localhost:3000");
});
