import { Router } from "express";
import {
    crearTarea,
    listarTareas,
    actualizarTarea,
    eliminarTarea,
    asignarTarea,
    cambiarEstado,
    generarReporte
} from "../controllers/task.controller.js";
import { authMiddleware } from "../middlewares/auth.js";

const router = Router();

// CRUD tareas
router.post("/", authMiddleware, crearTarea);
router.get("/", authMiddleware, listarTareas);
router.put("/:id", authMiddleware, actualizarTarea);
router.delete("/:id", authMiddleware, eliminarTarea);

// Extra
router.put("/:id/asignar", authMiddleware, asignarTarea);
router.put("/:id/estado", authMiddleware, cambiarEstado);
router.get("/reportes", authMiddleware, generarReporte);

export default router;
