import express from 'express'
import * as od from "../controllers/ordersController.js";

const od_Route = express.Router()
od_Route.get("/", od.getOrders)
od_Route.get("/:id", od.getOrderByID)
od_Route.get("/user/:id", od.getOrderByUserID)
od_Route.post("/", od.addOrder)
od_Route.put("/", od.updateOrderStatus)
od_Route.get("/status/:id", od.checkOrderStatus)
export default od_Route;