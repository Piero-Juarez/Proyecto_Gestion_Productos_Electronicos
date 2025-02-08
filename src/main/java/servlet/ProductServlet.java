package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import dao.DAOFactory;
import entity.producto.Categoria;
import entity.producto.EstadoProducto;
import entity.producto.Marca;
import entity.producto.Producto;
import entity.producto.Proveedor;
import interfaces.ProductoInterface;

@WebServlet("/ProductServlet")
@MultipartConfig
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private static final String RUTA_RELATIVA = "imagesProducts/";
	
    public ProductServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		ProductoInterface daoProducto = daoFactory.getProductoDAO();
		
		HttpSession session = request.getSession();
		String service = request.getParameter("service");
		
		switch (service) {
			case "Product" -> productServlet(request, response, daoProducto, session);
			case "AddProduct" -> addProductServlet(request, response, daoProducto, session);
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
	}

	protected void productServlet(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		if (session.getAttribute("listadoProductos") == null) {
			actualizarProductos(daoProducto, session);
		}
		
		request.getRequestDispatcher("jsp/Products.jsp").forward(request, response);
		
	}
	
	protected void addProductServlet(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		String serviceAdd = request.getParameter("serviceAdd");
		
		switch (serviceAdd) {
			case "listar" -> listarSelectsAddProduct(request, response, daoProducto, session);
			case "listarModificar" -> listarSelectsModifyProduct(request, response, daoProducto, session);
			case "agregar" -> principalAddProduct(request, response, daoProducto, session);
			case "obtener" -> obtenerAddProduct(request, response, daoProducto, session);
			case "eliminar" -> eliminarProducto(request, response, daoProducto, session);
			case "modificar" -> modificarProduco(request, response, daoProducto, session);
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
	}
	
	protected void listarSelectsAddProduct(HttpServletRequest request, HttpServletResponse response,ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		if (
				session.getAttribute("listadoCategoria") == null ||
				session.getAttribute("listadoMarca") == null ||
				session.getAttribute("listadoProveedor") == null ||
				session.getAttribute("listadoEstadoProducto") == null ||
				session.getAttribute("listadoProductos") == null
			) {
			
			actualizarCategorias(daoProducto, session);
			actualizarMarcas(daoProducto, session);
			actualizarProveedores(daoProducto, session);
			actualizarEstadosProductos(daoProducto, session);
			actualizarProductos(daoProducto, session);
		}
		
		request.getRequestDispatcher("jsp/AddProduct.jsp").forward(request, response);
		
	}
	
	protected void listarSelectsModifyProduct(HttpServletRequest request, HttpServletResponse response,ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		if (
				session.getAttribute("listadoCategoria") == null ||
				session.getAttribute("listadoMarca") == null ||
				session.getAttribute("listadoProveedor") == null ||
				session.getAttribute("listadoEstadoProducto") == null ||
				session.getAttribute("listadoProductos") == null
			) {
			
			actualizarCategorias(daoProducto, session);
			actualizarMarcas(daoProducto, session);
			actualizarProveedores(daoProducto, session);
			actualizarEstadosProductos(daoProducto, session);
			actualizarProductos(daoProducto, session);
		}
		
		request.getRequestDispatcher("jsp/DetailProduct.jsp").forward(request, response);
		
	}
	
	protected void principalAddProduct(HttpServletRequest request, HttpServletResponse response,ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		String nombreProducto = request.getParameter("txtNombreProducto");
		String modeloProducto = request.getParameter("txtModeloProducto");
		String skuProducto = request.getParameter("txtSkuProducto");
		int idCategoria = Integer.parseInt(request.getParameter("cboCategoria"));
		int idMarca = Integer.parseInt(request.getParameter("cboMarca"));
		String detallesProducto = request.getParameter("txtDetallesProducto");
		Double precioProducto = Double.parseDouble(request.getParameter("txtPrecioProducto"));
		int stockProducto = Integer.parseInt(request.getParameter("txtStockProducto"));
		int stockMinimoProducto = Integer.parseInt(request.getParameter("txtStockMinimoProducto"));
		int idProveedor = Integer.parseInt(request.getParameter("cboProveedor"));
		double pesoProducto = Double.parseDouble(request.getParameter("txtPesoProducto"));
		String dimensionesProducto = request.getParameter("txtDimensionesProducto");
		String garantiaProducto = request.getParameter("txtGarantiaProducto");
		int idEstadoProducto = Integer.parseInt(request.getParameter("cboEstadoProducto"));
		
		/* PASOS ESPECIALES PARA LA FECHA */
		String fechaIncorporacionProducto = request.getParameter("txtFechaIncorporacionProducto");
		java.util.Date fechaSQL = null;
		
		try {
			LocalDate fechaLocalDate = LocalDate.parse(fechaIncorporacionProducto);
			fechaSQL = Date.valueOf(fechaLocalDate); // variable para la base de datos
		} catch (Exception e) { e.printStackTrace(); }
		
		String colorProducto = request.getParameter("txtColorProducto");
		
		/* PASOS ESPECIALES PARA EL GUARDADO DE IMAGEN */
		Part fotoProducto = request.getPart("txtFotoProducto");
		String nombreImagen = Paths.get(fotoProducto.getSubmittedFileName()).getFileName().toString();
		
		String rutaReal = getServletContext().getRealPath("/");
		File directorioImagenes = new File(rutaReal + "imagesProducts/");
		File imagenArchivo = new File(directorioImagenes, nombreImagen);
		fotoProducto.write(imagenArchivo.getAbsolutePath());

		String fotoProductoURL = "imagesProducts/" + nombreImagen; // Variable para la base de datos
		
		// CREACIÓN DEL OBJETO
		Producto productoAux = new Producto();
		productoAux.setNombreProducto(nombreProducto);
		productoAux.setModeloProducto(modeloProducto);
		productoAux.setSkuProducto(skuProducto);
		productoAux.setIdCategoria(idCategoria);
		productoAux.setIdMarca(idMarca);
		productoAux.setDetallesProducto(detallesProducto);
		productoAux.setPrecioProducto(precioProducto);
		productoAux.setStockProducto(stockProducto);
		productoAux.setStockMinimoProducto(stockMinimoProducto);
		productoAux.setIdProveedor(idProveedor);
		productoAux.setPesoProducto(pesoProducto);
		productoAux.setDimensionesProducto(dimensionesProducto);
		productoAux.setGarantiaProducto(garantiaProducto);
		productoAux.setIdEstadoProducto(idEstadoProducto);
		productoAux.setFechaIncorporacionProducto(fechaSQL);
		productoAux.setColorProducto(colorProducto);
		productoAux.setImagenProducto(fotoProductoURL);
		
		daoProducto.crearProducto(productoAux);
		
		actualizarProductos(daoProducto, session);
		
		request.getRequestDispatcher("jsp/Products.jsp").forward(request, response);
		
	}
	
	protected void obtenerAddProduct(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		int idProducto = Integer.parseInt(request.getParameter("idProducto"));
		Producto productoEncontrado = daoProducto.encontrarProducto(idProducto);
		
		session.setAttribute("productoEncontrado", productoEncontrado);
		
		request.getRequestDispatcher("jsp/DetailProduct.jsp").forward(request, response);
		
	}
	
	protected void modificarProduco(HttpServletRequest request, HttpServletResponse response,ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		int idProducto = Integer.parseInt(request.getParameter("txtIdProductoModificar"));
		String nombreProducto = request.getParameter("txtNombreProducto");
		String modeloProducto = request.getParameter("txtModeloProducto");
		String skuProducto = request.getParameter("txtSkuProducto");
		int idCategoria = Integer.parseInt(request.getParameter("cboCategoria"));
		int idMarca = Integer.parseInt(request.getParameter("cboMarca"));
		String detallesProducto = request.getParameter("txtDetallesProducto");
		Double precioProducto = Double.parseDouble(request.getParameter("txtPrecioProducto"));
		int stockProducto = Integer.parseInt(request.getParameter("txtStockProducto"));
		int stockMinimoProducto = Integer.parseInt(request.getParameter("txtStockMinimoProducto"));
		int idProveedor = Integer.parseInt(request.getParameter("cboProveedor"));
		double pesoProducto = Double.parseDouble(request.getParameter("txtPesoProducto"));
		String dimensionesProducto = request.getParameter("txtDimensionesProducto");
		String garantiaProducto = request.getParameter("txtGarantiaProducto");
		int idEstadoProducto = Integer.parseInt(request.getParameter("cboEstadoProducto"));
		
		/* PASOS ESPECIALES PARA LA FECHA */
		String fechaIncorporacionProducto = request.getParameter("txtFechaIncorporacionProducto");
		java.util.Date fechaSQL = null;
		
		try {
			LocalDate fechaLocalDate = LocalDate.parse(fechaIncorporacionProducto);
			fechaSQL = Date.valueOf(fechaLocalDate); // variable para la base de datos
		} catch (Exception e) { e.printStackTrace(); }
		
		String colorProducto = request.getParameter("txtColorProducto");
		
		/* PASOS ESPECIALES PARA EL GUARDADO DE IMAGEN */
		Part fotoProducto = request.getPart("txtFotoProducto");
		Producto productoEncontrado = daoProducto.encontrarProducto(idProducto);

		String nuevaFotoProductoURL = null;

		// Obtener rutas reales del servidor
		String rutaReal = getServletContext().getRealPath("/");
		File directorioImagenes = new File(rutaReal + "imagesProducts/");

		if (fotoProducto != null && fotoProducto.getSize() > 0) {
		    // Guardar nueva imagen
		    String nombreImagen = Paths.get(fotoProducto.getSubmittedFileName()).getFileName().toString();
		    File imagenArchivo = new File(directorioImagenes, nombreImagen);
		    fotoProducto.write(imagenArchivo.getAbsolutePath());
		    nuevaFotoProductoURL = "/imagesProducts/" + nombreImagen; // Usar ruta contextual
		} else {
		    // Mantener imagen existente
		    nuevaFotoProductoURL = productoEncontrado.getImagenProducto();
		}

		// Eliminar imagen anterior solo si hay una nueva
		if (!nuevaFotoProductoURL.equals(productoEncontrado.getImagenProducto())) {
		    String nombreImagenAntigua = Paths.get(productoEncontrado.getImagenProducto()).getFileName().toString();
		    File imagenAntigua = new File(directorioImagenes, nombreImagenAntigua);
		    
		    if (imagenAntigua.exists()) {
		        if (!imagenAntigua.delete()) {
		            System.err.println("Error al eliminar imagen antigua: " + imagenAntigua.getAbsolutePath());
		        }
		    } else {
		        System.err.println("Imagen antigua no encontrada: " + imagenAntigua.getAbsolutePath());
		    }
		}

		// CREACIÓN DEL OBJETO
		Producto productoAux = new Producto();
		productoAux.setIdProducto(idProducto);
		productoAux.setNombreProducto(nombreProducto);
		productoAux.setModeloProducto(modeloProducto);
		productoAux.setSkuProducto(skuProducto);
		productoAux.setIdCategoria(idCategoria);
		productoAux.setIdMarca(idMarca);
		productoAux.setDetallesProducto(detallesProducto);
		productoAux.setPrecioProducto(precioProducto);
		productoAux.setStockProducto(stockProducto);
		productoAux.setStockMinimoProducto(stockMinimoProducto);
		productoAux.setIdProveedor(idProveedor);
		productoAux.setPesoProducto(pesoProducto);
		productoAux.setDimensionesProducto(dimensionesProducto);
		productoAux.setGarantiaProducto(garantiaProducto);
		productoAux.setIdEstadoProducto(idEstadoProducto);
		productoAux.setFechaIncorporacionProducto(fechaSQL);
		productoAux.setColorProducto(colorProducto);
		productoAux.setImagenProducto(nuevaFotoProductoURL);
		
		daoProducto.actualizarProducto(productoAux);
		
		actualizarProductos(daoProducto, session);
		
		request.getRequestDispatcher("jsp/Products.jsp").forward(request, response);
		
	}

	protected void eliminarProducto(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		int idProducto = Integer.parseInt(request.getParameter("txtIdProductoEliminar"));
		Producto productoEncontrado = daoProducto.encontrarProducto(idProducto);
		
		// Elimina la imagen del producto seleccionado
		String imagenURL = productoEncontrado.getImagenProducto();
		if (imagenURL != null && !imagenURL.isEmpty()) {
	        // Construir la ruta completa de la imagen
	        String rutaReal = getServletContext().getRealPath("/");
	        File imagenArchivo = new File(rutaReal, imagenURL);

	        // Eliminar la imagen si existe
	        if (imagenArchivo.exists()) {
	            if (imagenArchivo.delete()) {
	                System.out.println("Imagen eliminada: " + imagenArchivo.getAbsolutePath());
	            } else {
	                System.err.println("No se pudo eliminar la imagen: " + imagenArchivo.getAbsolutePath());
	            }
	        } else {
	            System.err.println("La imagen no existe: " + imagenArchivo.getAbsolutePath());
	        }
	    }
		
		daoProducto.eliminarProducto(idProducto);
		actualizarProductos(daoProducto, session);
		request.getRequestDispatcher("jsp/Products.jsp").forward(request, response);
		
	}
	
	// Métodos para actualizar los selects
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
	
	protected void actualizarProductos(ProductoInterface daoProducto, HttpSession session) {
		List<Producto> listadoProductos = daoProducto.listarProductos();
		session.setAttribute("listadoProductos", listadoProductos);
	}
	
}
