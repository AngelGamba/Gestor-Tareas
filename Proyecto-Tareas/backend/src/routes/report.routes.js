/**
 * @swagger
 * tags:
 *   name: Reportes
 *   description: Generación de reportes de tareas completadas
 */

import { Router } from "express";
import { generarReporte } from "../controllers/task.controller.js";
import { authMiddleware, soloAdmin } from "../middlewares/auth.js";

const router = Router();

/**
 * @swagger
 * /reportes/tareas:
 *   get:
 *     summary: Generar reporte de tareas completadas en un rango de fechas
 *     tags: [Reportes]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: desde
 *         required: true
 *         schema:
 *           type: string
 *           format: date
 *       - in: query
 *         name: hasta
 *         required: true
 *         schema:
 *           type: string
 *           format: date
 *       - in: query
 *         name: formato
 *         schema:
 *           type: string
 *           enum: [json, csv, pdf]
 *     responses:
 *       200:
 *         description: Reporte generado
 */
router.get("/tareas", authMiddleware, soloAdmin, generarReporte);

export default router;
