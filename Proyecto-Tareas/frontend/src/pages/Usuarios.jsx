import { useEffect, useState } from "react";
import api from "../api/axios";
import Layout from "../components/Layout";

function Admin() {
  const [usuarios, setUsuarios] = useState([]);
  const token = localStorage.getItem("token");
  const headers = { Authorization: `Bearer ${token}` };

  useEffect(() => {
    const fetchUsuarios = async () => {
      try {
        const res = await api.get("/usuarios", { headers });
        setUsuarios(res.data);
      } catch (err) {
        console.error("Error al traer usuarios", err);
      }
    };
    fetchUsuarios();
  }, []);

  const cambiarRol = async (id, nuevoRol) => {
    try {
      await api.put(`/usuarios/${id}/rol`, { rol: nuevoRol }, { headers });
      setUsuarios(
        usuarios.map((u) =>
          u.id_usuario === id ? { ...u, rol: nuevoRol } : u
        )
      );
    } catch (err) {
      console.error("Error al cambiar rol", err);
    }
  };

  return (
    <Layout>
      <div className="min-h-screen pt-20 bg-gradient-to-br from-yellow-100 to-yellow-100">
        <h2 className="text-3xl font-bold p-10 text-center text-indigo-800 mb-2">
          👑 Panel de Usuarios
        </h2>
        <div className="max-w-4xl mx-auto bg-gradient-to-r from-purple-500 to-blue-500 p-6 rounded-xl shadow-lg">
          <h3 className="text-xl text-white font-semibold mb-4">
            Usuarios Registrados
          </h3>
          {usuarios.length === 0 ? (
            <p>No hay usuarios</p>
          ) : (
            <ul className="space-y-4">
              {usuarios.map((u) => (
                <li
                  key={u.id_usuario}
                  className="p-4 bg-gradient-to-r from-white to-yellow-100 rounded-lg shadow flex justify-between items-center"
                >
                  <span>
                    <strong>{u.nombre}</strong> ({u.correo})
                    <span
                      className={`ml-2 px-2 py-0.5 rounded-full text-xs text-white ${
                        u.rol === "admin" ? "bg-yellow-500" : "bg-blue-500"
                      }`}
                    >
                      {u.rol}
                    </span>
                  </span>

                  {/* Selector de rol */}
                  <select
                    value={u.rol}
                    onChange={(e) => cambiarRol(u.id_usuario, e.target.value)}
                    className="px-4 py-2 border rounded-lg px-4 py-2 focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
                  >
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                  </select>
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
    </Layout>
  );
}

export default Admin;
