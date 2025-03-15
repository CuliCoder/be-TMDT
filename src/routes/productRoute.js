import express from "express";
import * as pr from "../controllers/productController.js";
import database from "../database/database.js";

const pr_Route = express.Router();

pr_Route.get("/products", pr.getProducts);
// pr_Route.get("/:id", pr.getProduct);
// pr_Route.post("/", pr.createProduct);
// pr_Route.put("/:id", pr.updateProduct);
// pr_Route.delete("/:id", pr.deleteProduct);
pr_Route.get("/product_item/:id", pr.get_product_item);
pr_Route.get("/product_item_all", pr.get_product_item_all);
pr_Route.get("/categories", async (req, res) => {
  try {
    const [categories] = await database.execute("SELECT * FROM categories");
    return res.status(200).json({ success: true, data: categories });
  } catch (error) {
    console.log(error);
  }
});
pr_Route.get("/attributes/:id", async (req, res) => {
  try {
    const [attributes] = await database.execute("SELECT * FROM variation where CategoryID = ?", [req.params.id]);
    return res.status(200).json({ success: true, data: attributes });
  } catch (error) {
    console.log(error);
  }
});
export default pr_Route;
