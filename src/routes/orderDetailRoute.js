import express from 'express'
import * as oddt from "../controllers/orderDetailController.js";

const oddt_Route = express.Router()
oddt_Route.get("/:id", oddt.getOrderDetail)
// oddt_Route.post("/", oddt.addOrderDetail)
export default oddt_Route;