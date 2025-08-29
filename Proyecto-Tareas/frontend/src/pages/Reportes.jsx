import { useState } from "react";
import api from "../api/axios";
import Layout from "../components/Layout";

function Reportes() {
  const [desde, setDesde] = useState("");
  const [hasta, setHasta] = useState("");
  const [tareas, setTareas] = useState([]);
  const [mensaje, setMensaje] = useState("");

  const token = localStorage.getItem("token");
  const headers = { Authorization: `Bearer ${token}` };

  const generar = async () => {
    try {
      const res = await api.get(`/reportes/tareas?desde=${desde}&hasta=${hasta}`, { headers });

      if (res.data.length === 0) {
        setMensaje("📭 No se encontraron tareas en este rango de fechas.");
        setTareas([]);
      } else {
        setMensaje("");
        setTareas(res.data);
      }
    } catch (err) {
      console.error("Error en reporte", err);
      setMensaje("❌ Error al generar el reporte. Verifica las fechas e intenta de nuevo.");
      setTareas([]);
    }
  };

  const descargar = (formato) => {
    window.open(`http://localhost:3000/api/reportes/tareas?desde=${desde}&hasta=${hasta}&formato=${formato}`, "_blank");
  };

  return (
    <Layout>
      <div className="min-h-screen pt-20 bg-gradient-to-br from-yellow-100 to-yellow-100">
        <h2 className="text-3xl font-bold p-10 text-center text-indigo-800 mb-2">
          📊 Reporte de Tareas
        </h2>

        <div className="max-w-2xl mx-auto bg-white p-6 rounded-xl shadow-lg">
          <div className="grid grid-cols-2 gap-4 mb-4">
            {/* Fecha desde */}
            <div className="flex flex-col">
              <label className="text-big font-semibold text-black mb-1">📅 Fecha desde</label>
              <input
                type="date"
                value={desde}
                onChange={(e) => setDesde(e.target.value)}
                className="px-3 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
              />
            </div>

            {/* Fecha hasta */}
            <div className="flex flex-col">
              <label className="text-big font-semibold text-black mb-1">📅 Fecha hasta</label>
              <input
                type="date"
                value={hasta}
                onChange={(e) => setHasta(e.target.value)}
                className="px-3 py-2 border rounded-lg focus:outline-none ring-2 ring-purple-500 focus:ring-4 focus:ring-indigo-600 shadow-sm bg-white"
              />
            </div>
          </div>

          {/* Botón */}
          <button
            onClick={generar}
            className="w-full bg-blue-600 hover:bg-purple-500 text-white font-semibold px-4 py-2 rounded-lg transition duration-200"
          >
            Generar Reporte
          </button>
        </div>

        {/* Mostrar mensajes de error o vacíos */}
        {mensaje && (
        <p className="p-6 text-center text-lg font-medium text-purple-800">{mensaje}</p>
      )}

      {tareas.length > 0 && (
        <div className="max-w-3xl mx-auto mt-10 bg-gradient-to-r from-purple-500 to-blue-500 border p-6 rounded-xl shadow-lg">
          <h3 className="text-2xl font-bold text-white mb-4 text-center">
            📋 Resultados del Reporte
          </h3>

          <ul className="space-y-3">
            {tareas.map((t) => (
              <li
                key={t.id_tarea}
                className="p-4 border rounded-lg bg-gradient-to-r from-white to-yellow-100 shadow-sm"
              >
                <strong className="text-black">{t.titulo}</strong> – Asignada a:{" "}
                <span className="font-medium text-indigo-800">
                  {t.asignado?.nombre || "Nadie"}
                </span>
                <div className="text-sm text-gray-700 mt-1">
                  ✅ Completada el:{" "}
                  {t.fecha_completada
                    ? new Date(t.fecha_completada).toLocaleDateString()
                    : "—"}
                </div>
              </li>
            ))}
          </ul>

          {/* Botones de descarga */}
          <div className="flex gap-4 mt-6 justify-center">
            <button
              onClick={() => descargar("csv")}
              className="bg-green-500 hover:bg-green-600 text-white px-5 py-2 rounded-lg shadow-md transition"
            >
              Descargar CSV
            </button>
            <button
              onClick={() => descargar("pdf")}
              className="bg-red-500 hover:bg-red-600 text-white px-5 py-2 rounded-lg shadow-md transition"
            >
              Descargar PDF
            </button>
          </div>
        </div>
        )}
      </div>
    </Layout>
  );
}

export default Reportes;
