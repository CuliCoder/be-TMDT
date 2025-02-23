import express from "express";
import * as pr from "../controllers/productController.js";

const pr_Route = express.Router();

pr_Route.get("/", pr.getProducts);
pr_Route.get("/:id", pr.getProduct);
pr_Route.post("/", pr.createProduct);
pr_Route.put("/:id", pr.updateProduct);
pr_Route.delete("/:id", pr.deleteProduct);

export default pr_Route;
