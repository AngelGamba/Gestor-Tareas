import app from "./src/app.js";
import { sequelize } from "./src/config/database.js";
import { Notification } from "./src/models/Notification.js";

const PORT = process.env.PORT || 8080;

async function start() {
  try {
    await sequelize.authenticate();
    console.log("Conexión a BD exitosa");
    await sequelize.sync({ alter: true }); // crea/actualiza tablas
    app.listen(PORT, () => console.log(`Servidor en http://localhost:${PORT}`));
  } catch (error) {
    console.error("Error al conectar BD:", error);
  }
}

start();
