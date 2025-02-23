import express from 'express'
import * as od from "../controllers/ordersController";

const od_Route = express.Router()
od_Route.get("/", od.getOrders)
od_Route.get("/:id", od.getOrderByID)
od_Route.post("/", od.addOrder)
export default od_Route;