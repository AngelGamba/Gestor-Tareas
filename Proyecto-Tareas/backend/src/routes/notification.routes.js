import { Router } from "express";
import { getNotificaciones, marcarLeida } from "../controllers/notification.controller.js";
import { authMiddleware } from "../middlewares/auth.js";

const router = Router();

router.get("/", authMiddleware, getNotificaciones);
router.put("/:id/leida", authMiddleware, marcarLeida);

export default router;
