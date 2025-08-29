import { Router } from "express";
import { register, login, getUsuarios, updateRol } from "../controllers/user.controller.js";
import { authMiddleware, soloAdmin } from "../middlewares/auth.js";

const router = Router();

router.post("/registro", register);
router.post("/login", login);

// ✅ Listar usuarios (solo admin)
router.get("/", authMiddleware, soloAdmin, getUsuarios);

// ✅ Cambiar rol (solo admin)
router.put("/:id/rol", authMiddleware, soloAdmin, updateRol);

export default router;
