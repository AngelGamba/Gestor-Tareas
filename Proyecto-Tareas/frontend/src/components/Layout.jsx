import Navbar from "../components/Navbar";

function Layout({ children }) {
  return (
    <div className="">
      {/* Navbar fijo arriba */}
        <>
      <Navbar />
    </>
      {/* Contenido principal */}
      <main className="flex-1 w-full px-6 ">
        {children}
      </main>
    </div>
  );
}

export default Layout;
