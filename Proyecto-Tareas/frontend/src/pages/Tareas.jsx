import { useState, useEffect } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";

function Tareas() {
  const [tareas, setTareas] = useState([]);
  const [titulo, setTitulo] = useState("");
  const [descripcion, setDescripcion] = useState("");
  const [usuarios, setUsuarios] = useState([]);
  const [desde, setDesde] = useState("");
  const [hasta, setHasta] = useState("");
  const [reporte, setReporte] = useState([]);

  const navigate = useNavigate();
  const token = localStorage.getItem("token");

  const headers = { Authorization: `Bearer ${token}` };

  // Traer tareas
  const fetchTareas = async () => {
    try {
      const res = await api.get("/tareas", { headers });
      setTareas(res.data);
    } catch (err) {
      if (err.response?.status === 401) navigate("/login");
    }
  };

  // Traer usuarios (para asignar)
  const fetchUsuarios = async () => {
    try {
      const res = await api.get("/usuarios", { headers });
      setUsuarios(res.data);
    } catch (err) {
      console.error("Error al traer usuarios", err);
    }
  };

  // Crear tarea
  const crearTarea = async (e) => {
    e.preventDefault();
    await api.post("/tareas", { titulo, descripcion }, { headers });
    setTitulo("");
    setDescripcion("");
    fetchTareas();
  };

  // Asignar tarea
  const asignarTarea = async (id, id_usuario_asignado) => {
    await api.put(`/tareas/${id}/asignar`, { id_usuario_asignado }, { headers });
    fetchTareas();
  };

  // Cambiar estado
  const cambiarEstado = async (id, estado) => {
    await api.put(`/tareas/${id}/estado`, { estado }, { headers });
    fetchTareas();
  };

  // Generar reporte
  const generarReporte = async (e) => {
    e.preventDefault();
    try {
      const res = await api.get(`/tareas/reportes?desde=${desde}&hasta=${hasta}`, { headers });
      setReporte(res.data);
    } catch (err) {
      alert("Solo administradores pueden generar reportes");
    }
  };

  useEffect(() => {
    fetchTareas();
    fetchUsuarios();
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-500 to-purple-200">
      <h2 className="text-3xl font-bold p-6 text-center text-black mb-8">
        📌 Gestor de Tareas
      </h2>

      {/* Crear tarea */}
      <div className="bg-white p-6 rounded-xl shadow-lg mb-8">
        <h3 className="text-xl font-semibold text-gray-700 mb-4">➕ Crear nueva tarea</h3>
        <form onSubmit={crearTarea} className="flex flex-col md:flex-row gap-4">
          <input
            type="text"
            placeholder="Título"
            value={titulo}
            onChange={(e) => setTitulo(e.target.value)}
            className="flex-1 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
            required
          />
          <input
            type="text"
            placeholder="Descripción"
            value={descripcion}
            onChange={(e) => setDescripcion(e.target.value)}
            className="flex-1 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
            required
          />
          <button
            type="submit"
            className="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded-lg font-medium transition"
          >
            Crear
          </button>
        </form>
      </div>

      {/* Listado de tareas */}
      <h3 className="text-2xl font-semibold text-black mb-4">📋 Mis tareas</h3>
      <ul className="space-y-4">
        {tareas.map((t) => (
          <li
            key={t.id_tarea}
            className="bg-white shadow-md rounded-xl p-5 border hover:shadow-xl transition"
          >
            <div className="flex justify-between items-center">
              <div>
                <h4 className="text-lg font-semibold text-gray-800">{t.titulo}</h4>
                <p className="text-gray-500">{t.descripcion}</p>
                <p className="text-sm text-gray-400 mt-1">
                  Creada por: {t.creador?.nombre} | Asignada a:{" "}
                  {t.asignado?.nombre || "Nadie"}
                </p>
              </div>
              <span
                className={`px-3 py-1 rounded-full text-sm font-medium ${
                  t.estado === "pendiente"
                    ? "bg-yellow-100 text-yellow-700"
                    : t.estado === "en progreso"
                    ? "bg-blue-100 text-blue-700"
                    : "bg-green-100 text-green-700"
                }`}
              >
                {t.estado}
              </span>
            </div>

            {/* Asignar & Cambiar estado */}
            <div className="flex gap-2 mt-4">
              <select
                onChange={(e) => asignarTarea(t.id_tarea, e.target.value)}
                className="border px-3 py-2 rounded-lg focus:ring-2 focus:ring-indigo-500"
              >
                <option value="">Asignar a...</option>
                {usuarios.map((u) => (
                  <option key={u.id_usuario} value={u.id_usuario}>
                    {u.nombre}
                  </option>
                ))}
              </select>

              <select
                onChange={(e) => cambiarEstado(t.id_tarea, e.target.value)}
                value={t.estado}
                className="border px-3 py-2 rounded-lg focus:ring-2 focus:ring-indigo-500"
              >
                <option value="pendiente">Pendiente</option>
                <option value="en progreso">En progreso</option>
                <option value="completada">Completada</option>
              </select>
            </div>
          </li>
        ))}
      </ul>

      {/* Reportes */}
      <div className="bg-white p-6 rounded-xl shadow-lg mt-10">
        <h3 className="text-xl font-semibold text-gray-700 mb-4">
          📊 Generar Reporte (solo admin)
        </h3>
        <form onSubmit={generarReporte} className="flex flex-col md:flex-row gap-4">
          <input
            type="date"
            value={desde}
            onChange={(e) => setDesde(e.target.value)}
            className="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
            required
          />
          <input
            type="date"
            value={hasta}
            onChange={(e) => setHasta(e.target.value)}
            className="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
            required
          />
          <button
            type="submit"
            className="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-lg font-medium transition"
          >
            Generar
          </button>
        </form>

        {reporte.length > 0 && (
          <div className="mt-6">
            <h4 className="text-lg font-semibold text-gray-700 mb-2">
              Reporte de tareas completadas
            </h4>
            <ul className="space-y-2">
              {reporte.map((r) => (
                <li
                  key={r.id_tarea}
                  className="bg-gray-50 p-3 rounded-lg border"
                >
                  {r.titulo} - {r.descripcion} ({r.estado})
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
    </div>
  );
}

export default Tareas;
