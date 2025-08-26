import { Router } from "express";
import {crearTarea, listarTareas, eliminarTarea, asignarTarea, cambiarEstado, generarReporte, editarTarea} from "../controllers/task.controller.js";
import { authMiddleware, soloAdmin } from "../middlewares/auth.js";

const router = Router();

// CRUD tareas
router.post("/", authMiddleware, crearTarea);
router.get("/", authMiddleware, listarTareas);
router.put("/:id", authMiddleware, editarTarea);
router.delete("/:id", authMiddleware, eliminarTarea);

// Extra
router.put("/:id/asignar", authMiddleware, asignarTarea);
router.put("/:id/estado", authMiddleware, cambiarEstado);
router.get("/reportes", authMiddleware, soloAdmin, generarReporte);

export default router;
