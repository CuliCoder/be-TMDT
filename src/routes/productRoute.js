import express from "express";
import * as pr from "../controllers/productController.js";
import database from "../database/database.js";
import multer from "multer";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const pr_Route = express.Router();
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, '../../public/products'));
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage });
pr_Route.get("/products", pr.getProducts);
pr_Route.get("/product_item_by_productID/:id", pr.get_product_item_by_productID);
pr_Route.get("/product_item_by_ID/:id", pr.get_product_item_by_ID);
pr_Route.get("/product_item_all", pr.get_product_item_all);
pr_Route.post("/add_product_item", upload.single('image'), pr.add_product_item);
pr_Route.put("/update_product_item", upload.single('image'), pr.update_product_item);
pr_Route.post("/add_product", upload.single('image'), pr.add_product);
pr_Route.put("/update_product", upload.single('image'), pr.update_product);
pr_Route.get("/get_product_by_productID/:id", pr.get_product_by_productID);
pr_Route.delete("/delete_product_item/:id", pr.delete_product_item);
pr_Route.delete("/delete_product/:id", pr.delete_product);
pr_Route.get("/categoryByProductID/:id", async (req, res) => {
  try {
    const [categories] = await database.execute(`SELECT CategoryID from categories as ca 
      join products as pr on ca.CategoryID = pr.category_id 
      where pr.ProductID = ?`, [req.params.id]);
    return res.status(200).json({ success: true, data: categories[0] });
  } catch (error) {
    console.log(error);
  }
});
pr_Route.get("/attributes/:id", async (req, res) => {
  try {
    const [attributes] = await database.execute(
      "SELECT * FROM variation where CategoryID = ?",
      [req.params.id]
    );
    return res.status(200).json({ success: true, data: attributes });
  } catch (error) {
    console.log(error);
  }
});
pr_Route.get("/brands", async (req, res) => {
  try {
    const [brands] = await database.execute("SELECT * FROM brand");
    return res.status(200).json({ success: true, data: brands });
  } catch (error) {
    console.log(error);
  }
});
pr_Route.get("/categories", async (req, res) => {
  try {
    const [categories] = await database.execute("SELECT * FROM categories");
    return res.status(200).json({ success: true, data: categories });
  } catch (error) {
    console.log(error);
  }
});
pr_Route.post("/add_attribute", pr.add_attribute);
export default pr_Route;
