import bcrypt from "bcrypt";

export async function up(queryInterface, Sequelize) {
  const password = await bcrypt.hash("Admin474", 10);
  await queryInterface.bulkInsert("Users", [
    {
      nombre: "Administrador",
      correo: "admin@tareas.com",
      contraseña: password,
      rol: "admin",
      createdAt: new Date(),
      updatedAt: new Date(),
    },
  ]);
}

export async function down(queryInterface, Sequelize) {
  await queryInterface.bulkDelete("Users", { correo: "admin@tareas.com" });
}
