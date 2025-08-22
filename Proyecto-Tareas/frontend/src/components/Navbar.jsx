import { Link, useNavigate } from "react-router-dom";

function Navbar() {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("token");
    navigate("/login");
  };

  return (
    <nav className="bg-gradient-to-br from-blue-700 to-purple-700 text-white py-4 shadow-md fixed top-0 left-0 w-full">
      <div className="flex justify-between items-center max-w-6xl mx-auto">
        {/* Logo */}
        <Link to="/tareas" className="text-white text-xl font-bold tracking-wide">
          🚀 Gestor Tareas
        </Link>

        {/* Links */}
        <div className="flex gap-6">
            <Link to="/dashboard" className="text-white hover:text-purple-200 transition font-medium">
                Dashboard
            </Link>
            <Link to="/tareas" className="text-white hover:text-purple-200 transition font-medium">
                Tareas
            </Link>
            <Link to="/reportes" className="text-white hover:text-purple-200 transition font-medium">
                Reportes
            </Link>
        </div>

        {/* Logout */}
        <button
          onClick={handleLogout}
          className="text-black bg-blue-400 hover:bg-red-400 px-4 py-2 rounded-lg font-medium transition"
        >
          Logout
        </button>
      </div>
    </nav>
  );
}

export default Navbar;
