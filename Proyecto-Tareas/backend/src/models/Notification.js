import { DataTypes } from "sequelize";
import { sequelize } from "../config/database.js";
import { User } from "./User.js";

export const Notification = sequelize.define("Notification", {
  id_notificacion: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  
  id_tarea: {
  type: DataTypes.INTEGER,
  allowNull: true,
  references: {
    model: "Tasks",
    key: "id_tarea",
  },
  onUpdate: "CASCADE",
  onDelete: "SET NULL",
  },

  mensaje: {
    type: DataTypes.STRING(255),
    allowNull: false,
  },
  fecha: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
  leida: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
  },
  id_usuario_destino: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  tableName: "notifications", // 👈 nombre real de tu tabla
  timestamps: false,           // 👈 ya tienes columna fecha, no usar createdAt/updatedAt
});

// Relación con User
User.hasMany(Notification, { foreignKey: "id_usuario_destino" });
Notification.belongsTo(User, { foreignKey: "id_usuario_destino" });
