"use strict";

module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable("Notifications", {
      id_notificacion: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        allowNull: false,
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
        type: Sequelize.STRING(255),
        allowNull: false,
      },
      fecha: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.fn("NOW"),
      },
      leida: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
      id_usuario_destino: {
        type: Sequelize.INTEGER,
        allowNull: true,
        references: {
          model: "Users", // 👈 igual que en tu migration de Tasks
          key: "id_usuario",
        },
        onUpdate: "CASCADE",
        onDelete: "SET NULL",
      },
      createdAt: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.fn("NOW"),
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.fn("NOW"),
      },
    });
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable("Notifications");
  },
};
