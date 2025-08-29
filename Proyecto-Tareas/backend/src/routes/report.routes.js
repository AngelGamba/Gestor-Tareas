import { Router } from "express";
import { generarReporte } from "../controllers/task.controller.js";
import { authMiddleware, soloAdmin } from "../middlewares/auth.js";

const router = Router();

// ✅ Reporte de tareas completadas
router.get("/tareas", authMiddleware, soloAdmin, generarReporte);

export default router;
