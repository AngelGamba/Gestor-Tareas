import { DataTypes } from "sequelize";
import { sequelize } from "../config/database.js";

export const User = sequelize.define("User", {
  id_usuario: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
  nombre: { type: DataTypes.STRING(100), allowNull: false },
  correo: { type: DataTypes.STRING(150), allowNull: false, unique: {name: "unique_correo"} },
  contraseña: { type: DataTypes.STRING(255), allowNull: false },
  rol: { type: DataTypes.ENUM("admin", "usuario"), defaultValue: "usuario" }
});
