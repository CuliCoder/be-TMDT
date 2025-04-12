import express from "express";
import { register, login } from "../controllers/auth.js";
import { loginAdm } from "../controllers/auth.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/loginAdmin", loginAdm);
export default router;
