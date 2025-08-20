import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import userRoutes from "./routes/user.routes.js";
import taskRoutes from "./routes/task.routes.js";

dotenv.config();
const app = express();

app.use(cors());
app.use(express.json());

// Rutas
app.get("/", (req, res) => {
    res.send("API Gestor de Tareas funcionando");
});
app.use("/api/usuarios", userRoutes);
app.use("/api/tareas", taskRoutes);

export default app;
