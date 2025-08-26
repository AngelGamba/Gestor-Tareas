# Gestor-Tareas
Aplicativo web para gestionar tareas en equipo

----comandos para instalar dependencias y base de datos----

>backend: 
npm install express mysql2 sequelize dotenv bcrypt jsonwebtoken cors

>frontend:
npm install

npm install axios react-router-dom

>database:
npx sequelize-cli db:migrate

----comandos para solucionar problemas----

1.error al instalar dependencias de la pagina oficial de npm

npm config set registry https://registry.npmjs.org/

comprobar: npm config get registry

deberia mostrar: https://registry.npmjs.org/
