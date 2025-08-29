import { DataTypes } from "sequelize";
import { sequelize } from "../config/database.js";
import { User } from "./User.js";

export const Task = sequelize.define("Task", {
  id_tarea: { 
    type: DataTypes.INTEGER, 
    autoIncrement: true, 
    primaryKey: true 
  },
  titulo: { 
    type: DataTypes.STRING(200), 
    allowNull: false 
  },
  descripcion: { 
    type: DataTypes.TEXT, 
    allowNull: false 
  },
  estado: { 
    type: DataTypes.ENUM("pendiente", "en progreso", "completada"), 
    defaultValue: "pendiente" 
  },
  fecha_creacion: { 
    type: DataTypes.DATE, 
    defaultValue: DataTypes.NOW 
  },
  fecha_vencimiento: { 
    type: DataTypes.DATE, 
    allowNull: true 
  },
  // ✅ Nueva columna para reportes
  fecha_completada: { 
    type: DataTypes.DATE, 
    allowNull: true 
  }
});

// Relaciones
User.hasMany(Task, { foreignKey: "id_usuario_creador" });
Task.belongsTo(User, { as: "creador", foreignKey: "id_usuario_creador" });

User.hasMany(Task, { foreignKey: "id_usuario_asignado" });
Task.belongsTo(User, { as: "asignado", foreignKey: "id_usuario_asignado" });
