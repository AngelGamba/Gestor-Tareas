import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import userRoutes from "./routes/user.routes.js";
import taskRoutes from "./routes/task.routes.js";
import notificationRoutes from "./routes/notification.routes.js";
import reportRoutes from "./routes/report.routes.js";
import { swaggerSpec, swaggerUiMiddleware } from "./swagger.js";

dotenv.config();
const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/usuarios", userRoutes);
app.use("/api/tareas", taskRoutes);
app.use("/api/notificaciones", notificationRoutes);
app.use("/api/reportes", reportRoutes);

// Ruta para documentación
app.use("/api-docs", swaggerUiMiddleware.serve, swaggerUiMiddleware.setup(swaggerSpec));

export default app;
