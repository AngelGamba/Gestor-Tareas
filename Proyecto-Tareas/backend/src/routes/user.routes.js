import { Router } from "express";
import { register, login } from "../controllers/user.controller.js";

const router = Router();

router.post("/registro", register);
router.post("/login", login);

export default router;
