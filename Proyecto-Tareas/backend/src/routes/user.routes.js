import { Router } from "express";
import { register, login, getUsuarios } from "../controllers/user.controller.js";

const router = Router();

router.post("/registro", register);
router.post("/login", login);

// ✅ Nueva ruta para listar usuarios
router.get("/", getUsuarios);

export default router;
