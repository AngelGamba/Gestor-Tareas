import { useState, useEffect } from "react";
import api from "../api/axios";
import { useNavigate } from "react-router-dom";
import Layout from "../components/Layout";

function Tareas() {
  const [tareas, setTareas] = useState([]);
  const [titulo, setTitulo] = useState("");
  const [descripcion, setDescripcion] = useState("");
  const [fechaVencimiento, setFechaVencimiento] = useState("");
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

  // 👉 Para que el calendario no deje elegir fechas pasadas
  const todayISO = new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
    .toISOString()
    .slice(0, 10);

  // Crear tarea
  const crearTarea = async (e) => {
    e.preventDefault();
    try {
      const payload = { titulo, descripcion };
      if (fechaVencimiento && fechaVencimiento !== "") {
        payload.fecha_vencimiento = fechaVencimiento; // solo si hay fecha
      }
      await api.post("/tareas", payload, { headers });
      setTitulo("");
      setDescripcion("");
      setFechaVencimiento("");
      fetchTareas();
    } catch (e) {
      alert(e.response?.data?.error || "No se pudo crear la tarea");
    }
  };

  // Asignar tarea
  const asignarTarea = async (id_tarea, id_usuario_asignado) => {
    const idNum = Number(id_usuario_asignado);
    if (!idNum) return; // evita enviar vacío
    try {
      await api.put(
        `/tareas/${id_tarea}/asignar`,
        { id_usuario_asignado: idNum },
        { headers }
      );
      fetchTareas();
    } catch (e) {
      alert("No se pudo asignar la tarea");
    }
  };

  // Cambiar estado
  const cambiarEstado = async (id_tarea, estado) => {
    try {
      await api.put(`/tareas/${id_tarea}/estado`, { estado }, { headers });
      fetchTareas();
    } catch (e) {
      alert("No se pudo cambiar el estado");
    }
  };

  // Generar reporte
  const generarReporte = async (e) => {
    e.preventDefault();
    try {
      const res = await api.get(
        `/tareas/reportes?desde=${desde}&hasta=${hasta}`,
        { headers }
      );
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
    <Layout>
      <div className="min-h-screen pt-20 bg-gradient-to-br from-blue-500 to-purple-200">
        <h2 className="text-3xl font-bold p-10 text-center text-black mb-2">
          📌 Gestor de Tareas
        </h2>
        {/* Crear tarea */}
        <div className="bg-white p-6 rounded-xl shadow-lg mb-8">
          <h3 className="text-xl font-semibold text-black mb-4">
            ➕ Crear nueva tarea
          </h3>
          <form onSubmit={crearTarea} className="flex flex-col md:flex-row gap-4">
            <input
              type="text"
              placeholder="Título"
              value={titulo}
              onChange={(e) => setTitulo(e.target.value)}
              className="flex-1 px-4 py-2 border rounded-lg ring-1 focus:ring-2 focus:ring-indigo-500"
              required
            />
            <input
              type="text"
              placeholder="Descripción"
              value={descripcion}
              onChange={(e) => setDescripcion(e.target.value)}
              className="flex-1 px-4 py-2 border rounded-lg ring-1 focus:ring-2 focus:ring-indigo-500"
              required
            />
            <input
              type="date"
              value={fechaVencimiento}
              onChange={(e) => setFechaVencimiento(e.target.value)}
              min={todayISO}
              className="px-4 py-2 border rounded-lg ring-1 focus:ring-2 focus:ring-indigo-500"
            />
            <button
              type="submit"
              className="bg-blue-600 hover:bg-purple-500 text-white px-6 py-2 rounded-lg font-medium transition"
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
                  <h4 className="text-lg font-semibold text-blue-700">
                    {t.titulo}
                  </h4>
                  <p className="text-gray-600">{t.descripcion}</p>
                  <p className="text-sm text-purple-500 mt-1">
                    Creada por: {t.creador?.nombre} | Asignada a:{" "}
                    {t.asignado?.nombre || "Nadie"}
                  </p>
                  <p className="text-sm text-red-500 mt-1">
                    Vence: {t.fecha_vencimiento 
                    ? new Date(t.fecha_vencimiento).toISOString().split("T")[0] : "Sin fecha"}
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
                  className="border px-3 py-2 rounded-lg ring-1 focus:ring-2 focus:ring-indigo-500"
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
                  className="border px-3 py-2 rounded-lg ring-1 focus:ring-2 focus:ring-indigo-500"
                >
                  <option value="pendiente">Pendiente</option>
                  <option value="en progreso">En progreso</option>
                  <option value="completada">Completada</option>
                </select>
              </div>
            </li>
          ))}
        </ul>
      </div>
    </Layout>
  );
}

export default Tareas;
