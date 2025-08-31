import { useState, useEffect } from "react";
import api from "../api/axios";
import Layout from "../components/Layout";
import { useNavigate } from "react-router-dom";

function Buscar() {
  const [tareas, setTareas] = useState([]);
  const [search, setSearch] = useState("");
  const [filtered, setFiltered] = useState([]);

  const token = localStorage.getItem("token");
  const idUsuario = parseInt(localStorage.getItem("id_usuario")); // 👈 usuario actual
  const headers = { Authorization: `Bearer ${token}` };

  const navigate = useNavigate();

  // Traer todas las tareas creadas o asignadas al usuario actual
  useEffect(() => {
    const fetchTareas = async () => {
      try {
        const res = await api.get("/tareas", { headers });

        // 👇 Filtrar SOLO tareas creadas o asignadas al usuario actual
        const propias = res.data.filter(
          (t) =>
            t.creador?.id_usuario === idUsuario ||
            t.asignado?.id_usuario === idUsuario
        );

        setTareas(propias);
        setFiltered(propias);
      } catch (err) {
        console.error("Error al traer tareas", err);
      }
    };
    fetchTareas();
  }, [idUsuario]);

  // Filtrado reactivo por título
  useEffect(() => {
    if (search.trim() === "") {
      setFiltered(tareas);
    } else {
      const lower = search.toLowerCase();
      setFiltered(tareas.filter((t) => t.titulo.toLowerCase().includes(lower)));
    }
  }, [search, tareas]);

  // 🔗 Ir a la tarea seleccionada
  const irATarea = (id_tarea) => {
    navigate(`/tareas?highlight=${id_tarea}`);
  };

  return (
    <Layout>
      <div className="min-h-screen pt-20 p-20 bg-gradient-to-br from-blue-500 to-purple-200">
        <h2 className="text-3xl font-bold p-10 text-center text-black mb-1">
          🔍 Buscar Tareas
        </h2>

        {/* Search box */}
        <div className="flex justify-center mb-10">
          <input
            type="text"
            placeholder="Escribe el nombre de la tarea..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-2/3 px-4 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
          />
        </div>

        {/* Resultados */}
        <div className="max-w-4xl mx-auto bg-gradient-to-r from-purple-500 to-blue-500 p-6 rounded-2xl shadow-xl">
          {filtered.length === 0 ? (
            <p className="text-center text-white">
              No se encontraron tareas
            </p>
          ) : (
            <ul className="space-y-4">
              {filtered.map((t) => (
                <li
                  key={t.id_tarea}
                  onClick={() => irATarea(t.id_tarea)}
                  className="bg-gray-50 shadow-md rounded-xl p-5 border hover:shadow-xl transition cursor-pointer"
                >
                  <h4 className="text-lg font-semibold text-blue-700">
                    {t.titulo}
                  </h4>
                  <p className="text-gray-600">{t.descripcion}</p>
                  <p className="text-sm text-purple-500 mt-1">
                    Creada por: {t.creador?.nombre} | Asignada a:{" "}
                    {t.asignado?.nombre || "Nadie"}
                  </p>
                  <p className="text-sm text-red-500 mt-1">
                    Vence:{" "}
                    {t.fecha_vencimiento
                      ? new Date(t.fecha_vencimiento)
                          .toISOString()
                          .split("T")[0]
                      : "Sin fecha"}
                  </p>
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
    </Layout>
  );
}

export default Buscar;
