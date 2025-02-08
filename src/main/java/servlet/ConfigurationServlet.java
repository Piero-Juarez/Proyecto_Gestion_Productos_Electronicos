package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import dao.DAOFactory;
import entity.producto.Categoria;
import entity.producto.EstadoProducto;
import entity.producto.Marca;
import entity.producto.Proveedor;
import entity.trabajador.Cargo;
import entity.trabajador.JornadaLaboral;
import interfaces.ProductoInterface;
import interfaces.TrabajadorInterface;

@WebServlet("/ConfigurationServlet")
public class ConfigurationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ConfigurationServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		ProductoInterface daoProducto = daoFactory.getProductoDAO();
		TrabajadorInterface daoTrabajador = daoFactory.getTrabajadorDAO();
		
		HttpSession session = request.getSession();
		String type = request.getParameter("type");
		
		switch (type) {
			case "obtenerListas" -> obtenerListas(request, response, daoFactory, session, daoProducto, daoTrabajador);
			case "agregarEntidad" -> agregarEntidad(request, response, daoFactory, session, daoProducto, daoTrabajador);
			case "modificarEntidad" -> modificarEntidad(request, response, daoFactory, session, daoProducto, daoTrabajador);
			case "eliminarEntidad" -> eliminarEntidad(request, response, daoFactory, session, daoProducto, daoTrabajador);
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
	}

	protected void obtenerListas(HttpServletRequest request, HttpServletResponse response, DAOFactory daoFactory, HttpSession session, ProductoInterface daoProducto, TrabajadorInterface daoTrabajador) throws ServletException, IOException {
		
		if (
				session.getAttribute("listadoCargos") == null ||
				session.getAttribute("listadoJornadaLaboral") == null ||
				session.getAttribute("listadoCategoria") == null ||
				session.getAttribute("listadoMarca") == null ||
				session.getAttribute("listadoProveedor") == null ||
				session.getAttribute("listadoEstadoProducto") == null
			) {
			
			// OBTENCIÓN DE LISTAS
			
			/* TRABAJADOR */
			List<Cargo> listadoCargos = daoTrabajador.listarCargos();
			session.setAttribute("listadoCargos", listadoCargos);
			
			List<JornadaLaboral> listadoJornadaLaboral = daoTrabajador.listarJornadaLaboral();
			session.setAttribute("listadoJornadaLaboral", listadoJornadaLaboral);
			
			/* PRODUCTO */
			List<Categoria> listadoCategoria = daoProducto.listarCategorias();
			session.setAttribute("listadoCategoria", listadoCategoria);
			
			List<Marca> listadoMarca = daoProducto.listarMarcas();
			session.setAttribute("listadoMarca", listadoMarca);
			
			List<Proveedor> listadoProveedor = daoProducto.listarProveedores();
			session.setAttribute("listadoProveedor", listadoProveedor);
			
			List<EstadoProducto> listadoEstadoProducto = daoProducto.listarEstadoProducto();
			session.setAttribute("listadoEstadoProducto", listadoEstadoProducto);
			
		}
		
		request.getRequestDispatcher("jsp/Configuration.jsp").forward(request, response);
	}
	
	protected void agregarEntidad(HttpServletRequest request, HttpServletResponse response, DAOFactory daoFactory, HttpSession session, ProductoInterface daoProducto, TrabajadorInterface daoTrabajador) throws ServletException, IOException {
		
		String dataClave = request.getParameter("data-clave");
		
		switch (dataClave) {
			case "jornadaLaboralTrabajador" -> {
				JornadaLaboral jornadaLaboralAux = new JornadaLaboral();
				jornadaLaboralAux.setNombreJornadaLaboral(request.getParameter("txtJornadaLaboral"));
				daoTrabajador.crearJornadaLaboral(jornadaLaboralAux);
				
				actualizarJornadaLaboral(daoTrabajador, session);
			}
		
			case "categoriaProducto" -> {
				Categoria categoriaAux = new Categoria();
				categoriaAux.setNombreCategoria(request.getParameter("txtnombreCategoria"));
				daoProducto.crearCategoria(categoriaAux);
				
				actualizarCategorias(daoProducto, session);
			}
			
			case "marcaProducto" -> {
				Marca marcaAux = new Marca();
				marcaAux.setNombreMarca(request.getParameter("txtNombreMarca"));
				daoProducto.crearMarca(marcaAux);
				
				actualizarMarcas(daoProducto, session);
			}
			
			case "proveedorProducto" -> {
				Proveedor provedorAux = new Proveedor();
				provedorAux.setNombreProveedor(request.getParameter("txtNombreProveedor"));
				daoProducto.crearProveedor(provedorAux);
				
				actualizarProveedores(daoProducto, session);
			}
			
			case "estadoProducto" -> {
				EstadoProducto estadoProductoAux = new EstadoProducto();
				estadoProductoAux.setNombreEstadoProducto(request.getParameter("txtNombreEstadoProducto"));
				daoProducto.crearEstadoProducto(estadoProductoAux);
				
				actualizarEstadosProductos(daoProducto, session);
			}
	
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
		request.getRequestDispatcher("jsp/Configuration.jsp").forward(request, response);
		
	}
	
	protected void modificarEntidad(HttpServletRequest request, HttpServletResponse response, DAOFactory daoFactory, HttpSession session, ProductoInterface daoProducto, TrabajadorInterface daoTrabajador) throws ServletException, IOException {

		String dataClave = request.getParameter("txtClave");
		
		switch (dataClave) {
			case "jornadaLaboralTrabajador" -> {
				int idJornadaLaboral = Integer.parseInt(request.getParameter("txtId"));
				
				JornadaLaboral jornadaLaboralEncontrada = daoTrabajador.encontrarJornadaLaboral(idJornadaLaboral);
				jornadaLaboralEncontrada.setNombreJornadaLaboral(request.getParameter("txtNuevoValor"));
				
				daoTrabajador.actualizarJornadaLaboral(jornadaLaboralEncontrada);
				
				actualizarJornadaLaboral(daoTrabajador, session);
			}
			
			case "categoriaProducto" -> {
				int idCategoria = Integer.parseInt(request.getParameter("txtId"));
				
				Categoria categoriaEncontrada = daoProducto.encontrarCategoria(idCategoria);
				categoriaEncontrada.setNombreCategoria(request.getParameter("txtNuevoValor"));
				
				daoProducto.actualizarCategoria(categoriaEncontrada);
				
				actualizarCategorias(daoProducto, session);
			}
			
			case "marcaProducto" -> {
				int idMarca = Integer.parseInt(request.getParameter("txtId"));
				
				Marca marcaEncontrada = daoProducto.encontrarMarca(idMarca);
				marcaEncontrada.setNombreMarca(request.getParameter("txtNuevoValor"));
				
				daoProducto.actualizarMarca(marcaEncontrada);
				
				actualizarMarcas(daoProducto, session);
			}
			
			case "proveedorProducto" -> {
				int idProveedor = Integer.parseInt(request.getParameter("txtId"));
				
				Proveedor proveedorEncontrado = daoProducto.encontrarProveedor(idProveedor);
				proveedorEncontrado.setNombreProveedor(request.getParameter("txtNuevoValor"));
				
				daoProducto.actualizarProveedor(proveedorEncontrado);
				
				actualizarProveedores(daoProducto, session);
			}
			
			case "estadoProducto" -> {
				int idEstadoProducto = Integer.parseInt(request.getParameter("txtId"));
				
				EstadoProducto estadoProductoEncontrado = daoProducto.encontrarEstadoProducto(idEstadoProducto);
				estadoProductoEncontrado.setNombreEstadoProducto(request.getParameter("txtNuevoValor"));
				
				daoProducto.actualizarEstadoProducto(estadoProductoEncontrado);
				
				actualizarEstadosProductos(daoProducto, session);
			}
			
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
		request.getRequestDispatcher("jsp/Configuration.jsp").forward(request, response);
		
	}
	
	protected void eliminarEntidad(HttpServletRequest request, HttpServletResponse response, DAOFactory daoFactory, HttpSession session, ProductoInterface daoProducto, TrabajadorInterface daoTrabajador) throws ServletException, IOException {

		String dataClave = request.getParameter("txtClave");
		
		switch (dataClave) {
			case "jornadaLaboralTrabajador" -> {
				int idJornadaLaboral = Integer.parseInt(request.getParameter("txtId"));
				int verificadorUsoJornadaLaboral = daoTrabajador.contarTrabajadoresPorJornadaLaboral(idJornadaLaboral);
				
				if (verificadorUsoJornadaLaboral > 0) {
					request.setAttribute("mensajeNoEliminacion", "No puedes eliminar esta entidad asociada con algún trabajador.<br>"
							+ "Antes debes quitarlo de todos los trabajadores asociados.");
				} else {
					daoTrabajador.eliminarJornadaLaboral(idJornadaLaboral);
					actualizarJornadaLaboral(daoTrabajador, session);
				}
			}
		
			case "categoriaProducto" -> {				
				int idCategoria = Integer.parseInt(request.getParameter("txtId"));
				int verificadorUsoCategoria = daoProducto.contarProductosPorCategoria(idCategoria);
				
				if (verificadorUsoCategoria > 0) {
					request.setAttribute("mensajeNoEliminacion", "No puedes eliminar esta entidad asociada con algún producto.<br>"
							+ "Antes debes quitarlo de todos los productos asociados.");
				} else {
					daoProducto.eliminarCategoria(idCategoria);
					actualizarCategorias(daoProducto, session);
				}

			}
			
			case "marcaProducto" -> {
				int idMarca = Integer.parseInt(request.getParameter("txtId"));
				int verificadorUsoMarca = daoProducto.contarProductosPorMarca(idMarca);
				
				if (verificadorUsoMarca > 0) {
					request.setAttribute("mensajeNoEliminacion", "No puedes eliminar esta entidad asociada con algún producto.<br>"
							+ "Antes debes quitarlo de todos los productos asociados.");
				} else {
					daoProducto.eliminarMarca(idMarca);
					actualizarMarcas(daoProducto, session);
				}
				
			}
			
			case "proveedorProducto" -> {
				int idProveedor = Integer.parseInt(request.getParameter("txtId"));
				int verificadorUsoProveedor = daoProducto.contarProductosPorProveedor(idProveedor);
				
				if (verificadorUsoProveedor > 0) {
					request.setAttribute("mensajeNoEliminacion", "No puedes eliminar esta entidad asociada con algún producto.<br>"
							+ "Antes debes quitarlo de todos los productos asociados.");
				} else {
					daoProducto.eliminarProveedor(idProveedor);
					actualizarProveedores(daoProducto, session);
				}
			}
			
			case "estadoProducto" -> {
				int idEstadoProducto = Integer.parseInt(request.getParameter("txtId"));
				int verificadorUsoEstadoProducto = daoProducto.contarProductosPorEstadoProducto(idEstadoProducto);
				
				if (verificadorUsoEstadoProducto > 0) {
					request.setAttribute("mensajeNoEliminacion", "No puedes eliminar esta entidad asociada con algún producto.<br>"
							+ "Antes debes quitarlo de todos los productos asociados.");
				} else {
					daoProducto.eliminarEstadoProducto(idEstadoProducto);
					actualizarEstadosProductos(daoProducto, session);
				}
			}
			
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
		request.getRequestDispatcher("jsp/Configuration.jsp").forward(request, response);
		
	}
	
	// Métodos para actualizar las listas
	protected void actualizarJornadaLaboral(TrabajadorInterface daoTrabajador, HttpSession session) {
		List<JornadaLaboral> listadoJornadaLaboral = daoTrabajador.listarJornadaLaboral();
		session.setAttribute("listadoJornadaLaboral", listadoJornadaLaboral);
	}
	
	protected void actualizarCategorias(ProductoInterface daoProducto, HttpSession session) {
		List<Categoria> listadoCategoria = daoProducto.listarCategorias();
		session.setAttribute("listadoCategoria", listadoCategoria);
	}
	
	protected void actualizarMarcas(ProductoInterface daoProducto, HttpSession session) {
		List<Marca> listadoMarca = daoProducto.listarMarcas();
		session.setAttribute("listadoMarca", listadoMarca);
	}
	
	protected void actualizarProveedores(ProductoInterface daoProducto, HttpSession session) {
		List<Proveedor> listadoProveedor = daoProducto.listarProveedores();
		session.setAttribute("listadoProveedor", listadoProveedor);
	}
	
	protected void actualizarEstadosProductos(ProductoInterface daoProducto, HttpSession session) {
		List<EstadoProducto> listadoEstadoProducto = daoProducto.listarEstadoProducto();
		session.setAttribute("listadoEstadoProducto", listadoEstadoProducto);
	}
	
}
