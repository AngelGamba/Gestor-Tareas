import { useNavigate } from "react-router-dom";

function Home() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-blue-500 to-purple-200 px-6">
      {/* Hero */}
      <div className="text-center max-w-2xl">
        <h1 className="text-4xl md:text-5xl font-extrabold text-white drop-shadow-lg">
          🚀 Bienvenido a tu Gestor de Tareas
        </h1>
        <p className="mt-4 text-lg text-white/90">
          Organiza, asigna y controla tus tareas de manera fácil y rápida.  
          Diseñado para equipos y administradores.
        </p>

        {/* Botones */}
        <div className="mt-8 flex flex-col sm:flex-row gap-4 justify-center">
          <button
            onClick={() => navigate("/login")}
            className="px-6 py-3 bg-white text-blue-600 font-semibold rounded-xl shadow hover:bg-blue-100 transition"
          >
            Iniciar Sesión
          </button>
          <button
            onClick={() => navigate("/register")}
            className="px-6 py-3 bg-purple-600 text-white font-semibold rounded-xl shadow hover:bg-purple-700 transition"
          >
            Registrarse
          </button>
        </div>
      </div>

      {/* Features */}
      <div className="mt-16 grid gap-8 md:grid-cols-3 text-center max-w-4xl w-full">
        <div className="bg-white rounded-xl p-6 shadow-lg hover:shadow-2xl transition">
          <h3 className="text-lg font-bold text-blue-700">📋 Organización</h3>
          <p className="text-gray-600 mt-2">
            Crea y administra tus tareas con facilidad en un solo lugar.
          </p>
        </div>
        <div className="bg-white rounded-xl p-6 shadow-lg hover:shadow-2xl transition">
          <h3 className="text-lg font-bold text-purple-700">🤝 Colaboración</h3>
          <p className="text-gray-600 mt-2">
            Asigna tareas a tu equipo y mantén el control del progreso.
          </p>
        </div>
        <div className="bg-white rounded-xl p-6 shadow-lg hover:shadow-2xl transition">
          <h3 className="text-lg font-bold text-green-700">📊 Reportes</h3>
          <p className="text-gray-600 mt-2">
            Genera reportes detallados y lleva el seguimiento de tu productividad.
          </p>
        </div>
      </div>
    </div>
  );
}

export default Home;
