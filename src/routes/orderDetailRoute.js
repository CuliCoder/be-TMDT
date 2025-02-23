import express from 'express'
import * as oddt from "../controllers/orderDetailController";

const oddt_Route = express.Router()
oddt_Route.get("/", oddt.getOrderDetail)
// oddt_Route.post("/", oddt.addOrderDetail)
export default oddt_Route;