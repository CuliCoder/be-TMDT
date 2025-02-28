import express from "express";
import * as image from "../controllers/imageController.js";

const image_route = express.Router();

image_route.get("/", image.getImages);
image_route.get("/:id", image.getImage);
image_route.post("/", image.createImage);
export default image_route;