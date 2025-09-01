/**
 * @swagger
 * tags:
 *   name: Notificaciones
 *   description: Endpoints para gestión de notificaciones de usuario
 */

import { Router } from "express";
import { getNotificaciones, marcarLeida } from "../controllers/notification.controller.js";
import { authMiddleware } from "../middlewares/auth.js";

const router = Router();

/**
 * @swagger
 * /notificaciones:
 *   get:
 *     summary: Listar notificaciones del usuario
 *     tags: [Notificaciones]
 *     security:
 *       - bearerAuth: []
 */
router.get("/", authMiddleware, getNotificaciones);

/**
 * @swagger
 * /notificaciones/{id}/leida:
 *   put:
 *     summary: Marcar notificación como leída
 *     tags: [Notificaciones]
 *     security:
 *       - bearerAuth: []
 */
router.put("/:id/leida", authMiddleware, marcarLeida);

export default router;
