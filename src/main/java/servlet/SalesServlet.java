package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import dao.DAOFactory;
import entity.DetalleTemporal;
import entity.cliente.Cliente;
import entity.detalleVenta.DetalleVenta;
import entity.producto.Producto;
import entity.trabajador.Trabajador;
import entity.venta.ComprobantePago;
import entity.venta.MetodoPago;
import entity.venta.Venta;
import interfaces.ClienteInterface;
import interfaces.DetalleVentaInterface;
import interfaces.ProductoInterface;
import interfaces.TrabajadorInterface;
import interfaces.VentaInterface;

@WebServlet("/SalesServlet")
public class SalesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SalesServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		ProductoInterface daoProducto = daoFactory.getProductoDAO();
		VentaInterface daoVenta = daoFactory.getVentaDAO();
		ClienteInterface daoCliente = daoFactory.getClienteDAO();
		DetalleVentaInterface daoDetalleVenta = daoFactory.getDetalleVentaDAO();
		TrabajadorInterface daoTrabajador = daoFactory.getTrabajadorDAO();
		
		HttpSession session = request.getSession();
		String service = request.getParameter("service");
		
		switch (service) {
			case "llenadoInicial" -> llenadoInicial(request, response, daoProducto, daoVenta, session);
			case "encontrarClientePorDNI" -> encontrarClientePorDNI(request, response, daoCliente, session);
			case "encontrarClientePorRUC" -> encontrarClientePorRUC(request, response, daoCliente, session);
			case "preAgregarProducto" -> preAgregarProducto(request, response, daoProducto, session);
			case "postAgregarProducto" -> postAgregarProducto(request, response, daoProducto, session);
			case "eliminarProducto" -> eliminarProducto(request, response, session);
			case "realizarVenta" -> realizarVenta(request, response, daoVenta, daoDetalleVenta, session, daoCliente, daoTrabajador, daoProducto);
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
	}

	protected void llenadoInicial(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, VentaInterface daoVenta, HttpSession session) throws ServletException, IOException {

		limpiezaTotal(session);
		
		String decision = request.getParameter("decision");
		ComprobantePago comprobantePagoObtenido = daoVenta.encontrarComprobantePago(Integer.parseInt(request.getParameter("comprobantePagoSolicitado")));
		
		if (decision.equalsIgnoreCase("boleta")) {
			int ultimoIdBoleta = daoVenta.obtenerMaximoBoleta() + 1;
			session.setAttribute("ultimoIdBoleta", ultimoIdBoleta);
		} else if (decision.equalsIgnoreCase("factura")) {
			int ultimoIdFactura = daoVenta.obtenerMaximoFactura() + 1;
			System.out.println("ULTIMA VENTA FACTURA -> " + ultimoIdFactura);
			session.setAttribute("ultimoIdFactura", ultimoIdFactura);
		}
		
		session.setAttribute("idComprobantePago", comprobantePagoObtenido.getIdComprobantePago());
		session.setAttribute("decisionUsuario", decision);
		
		listarProductos(request, response, daoProducto, session);
		listarMetodoPago(request, response, daoVenta, session);
		
		if (decision.equalsIgnoreCase("boleta")) { request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response); }
		else if (decision.equalsIgnoreCase("factura")) { request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response); }
		
	}
	
	protected void preAgregarProducto(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		String decision = (String) session.getAttribute("decisionUsuario");
		System.out.println("decision -> " + decision);
		
		int idProducto = Integer.parseInt(request.getParameter("idProducto"));
		Producto productoObtenido = daoProducto.encontrarProducto(idProducto);
		
		session.setAttribute("idProductoObtenido", productoObtenido.getIdProducto());
		session.setAttribute("nombreProductoObtenido", productoObtenido.getNombreProducto());
		session.setAttribute("stockProductoObtenido", productoObtenido.getStockProducto());
		session.setAttribute("precioProductoObtenido", productoObtenido.getPrecioProducto());
		
		if (decision.equalsIgnoreCase("boleta")) { request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response); }
		else if (decision.equalsIgnoreCase("factura")) { request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response); }
		
	}
	
	protected void postAgregarProducto(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		
		String decision = (String) session.getAttribute("decisionUsuario");
		String cantidadCompradorRecibido = request.getParameter("cantidadComprador") == "" ? "0" : request.getParameter("cantidadComprador");
		
		int idProducto = Integer.parseInt(request.getParameter("idProducto"));
		int cantidadComprador = Integer.parseInt(cantidadCompradorRecibido);
		
		if(cantidadComprador > daoProducto.cantidadStockProductoSegunId(idProducto)) {
			request.setAttribute("mensajeStockInvalido", "El stock ingresado supera al stock actual.<br>"
					+ "Por favor ingrese un stock válido.");
		} else {
			
			// OBTIENE LISTA CREADA
			List<DetalleTemporal> listaCarrito = (List<DetalleTemporal>) session.getAttribute("listaCarrito");
			if (listaCarrito == null) { listaCarrito = new ArrayList<DetalleTemporal>(); }
			
			// VERIRICA SI EL PRODUCTO YA EXISTE EN LA LISTA
			DetalleTemporal detalleExistente = null;
			for (DetalleTemporal detalle : listaCarrito) {
				if (detalle.getIdProducto() == idProducto) {
					detalleExistente = detalle;
					break;
				}
			}
			
			// SI EXISTE SE SUMA LA CANTIDAD
			if (detalleExistente != null) {
				int nuevaCantidad = detalleExistente.getCantidadProducto() + cantidadComprador;
				
				// VERIFICACIÓN DE STOCK NUEVAMENTE
				if (nuevaCantidad > daoProducto.cantidadStockProductoSegunId(idProducto)) {
					request.setAttribute("mensajeStockInvalido", "El stock ingresado supera al stock actual.<br>"
							+ "Por favor ingrese un stock válido.");
				} else {
					detalleExistente.setCantidadProducto(nuevaCantidad);
				}
				
			} else {
				
				// SI NO EXISTE SE CREA UN NUEVO DETALLETEMPORAL
				Producto productoObtenido = daoProducto.encontrarProducto(idProducto);
				DetalleTemporal nuevoDetalle = new DetalleTemporal(
						productoObtenido.getIdProducto(),
						productoObtenido.getNombreProducto(),
						productoObtenido.getImagenProducto(),
						productoObtenido.getPrecioProducto(),
						cantidadComprador
				);
				
				// SE AGERGA A LA LISTA
				listaCarrito.add(nuevoDetalle);
				
			}
			
			session.setAttribute("listaCarrito", listaCarrito);
			calcularNumerosTotales(session);
			
		}
		
		if (decision.equalsIgnoreCase("boleta")) { request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response); }
		else if (decision.equalsIgnoreCase("factura")) { request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response); }
		
	}
	
	protected void eliminarProducto(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {

		String decision = (String) session.getAttribute("decisionUsuario");
	    int idProducto = Integer.parseInt(request.getParameter("idProducto"));

	    List<DetalleTemporal> listaCarrito = (List<DetalleTemporal>) session.getAttribute("listaCarrito");

	    if (listaCarrito != null) {
	        listaCarrito.removeIf(detalle -> detalle.getIdProducto() == idProducto);
	        session.setAttribute("listaCarrito", listaCarrito);
	        calcularNumerosTotales(session);
	    }

		if (decision.equalsIgnoreCase("boleta")) { request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response); }
		else if (decision.equalsIgnoreCase("factura")) { request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response); }
		
	}

	
	protected void encontrarClientePorDNI(HttpServletRequest request, HttpServletResponse response, ClienteInterface daoCliente, HttpSession session) throws ServletException, IOException {
		
		String dniCliente = request.getParameter("dniCliente");
		Cliente clienteObtenido = daoCliente.encontrarClientePorDNI(dniCliente);
		
		if (clienteObtenido != null) {
			
			session.setAttribute("idClienteObtenido", clienteObtenido.getIdCliente());
			session.setAttribute("dniClienteObtenido", clienteObtenido.getDniCliente());
			session.setAttribute("nombreClienteObtenido", clienteObtenido.getNombreCliente());
			session.setAttribute("apellidosClienteObtenido", clienteObtenido.getApellidoCliente());

		} else {
			
			request.setAttribute("mensajeClienteNoEncontrado", "El DNI del cliente ingresado no se encuentra registrado o no es válido. Por favor inténtelo de nuevo o registrelo antes de realizar la venta.");
			
		}
		
		request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response);
		
	}
	
	protected void encontrarClientePorRUC(HttpServletRequest request, HttpServletResponse response, ClienteInterface daoCliente, HttpSession session) throws ServletException, IOException {
		
		String rucCliente = request.getParameter("rucCliente");
		Cliente clienteObtenido = daoCliente.encontrarClientePorRUC(rucCliente);
		
		if (clienteObtenido != null) {
			
			session.setAttribute("idClienteObtenido", clienteObtenido.getIdCliente());
			session.setAttribute("razonSocialClienteObtenido", clienteObtenido.getRazonSocialCliente());
			session.setAttribute("nombreComercialClienteObtenido", clienteObtenido.getNombreComercialCliente());
			session.setAttribute("direccionFiscalClienteObtenido", clienteObtenido.getDireccionFiscalCliente());
			session.setAttribute("rucClienteObtenido", clienteObtenido.getRucCliente());

		} else {
			
			request.setAttribute("mensajeClienteNoEncontrado", "El RUC del cliente ingresado no se encuentra registrado o no es válido. Por favor inténtelo de nuevo o registrelo antes de realizar la venta.");
			
		}

		request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response);
		
	}
	
	protected void realizarVenta(HttpServletRequest request, HttpServletResponse response, VentaInterface daoVenta, DetalleVentaInterface daoDetalleVenta, HttpSession session, ClienteInterface daoCliente, TrabajadorInterface daoTrabajador, ProductoInterface daoProducto) throws ServletException, IOException {

		String decision = (String) session.getAttribute("decisionUsuario");
		
		LocalDate fechaObtenida = LocalDate.now();
		LocalTime horaObtenida = LocalTime.now();
		int idComprobantePagoObtenidio = Integer.parseInt(request.getParameter("idComprobantePago"));
		int idClienteObtenido = Integer.parseInt(request.getParameter("idCliente"));
		int idTrabajadorObtenido = Integer.parseInt(request.getParameter("idTrabajador"));
		String preMontoTotal = request.getParameter("montoTotal");
		preMontoTotal = preMontoTotal.replace(",", ".");
		BigDecimal montoTotalObtenido = new BigDecimal(preMontoTotal);
		int idMetodoPagoObtenido = Integer.parseInt(request.getParameter("idMetodoPago"));
		String preDineroCliente = (request.getParameter("dineroCliente") == null || request.getParameter("dineroCliente").trim().isEmpty()) ? "0" : request.getParameter("dineroCliente");
		preDineroCliente = preDineroCliente.replace(",", ".");
		BigDecimal dineroClienteObtenido = new BigDecimal(preDineroCliente);
		String preVueltoEfectivo = (request.getParameter("vueltoCliente") == null || request.getParameter("vueltoCliente").trim().isEmpty()) ? "0" : request.getParameter("vueltoCliente");
		preVueltoEfectivo = preVueltoEfectivo.replace(",", ".");
		BigDecimal vueltoEfectivoObtenido = new BigDecimal(preVueltoEfectivo);
		
		Venta nuevaVenta = new Venta();
		nuevaVenta.setFecha(fechaObtenida);
		nuevaVenta.setHora(horaObtenida);
		nuevaVenta.setIdComprobantePago(idComprobantePagoObtenidio);
		nuevaVenta.setIdCliente(idClienteObtenido);
		nuevaVenta.setIdTrabajador(idTrabajadorObtenido);
		nuevaVenta.setMontoTotal(montoTotalObtenido);
		nuevaVenta.setIdMetodoPago(idMetodoPagoObtenido);
		nuevaVenta.setDineroCliente(dineroClienteObtenido);
		nuevaVenta.setVueltoEfectivo(vueltoEfectivoObtenido);
		
		int ventaExitosa = daoVenta.crearVenta(nuevaVenta);
		if (ventaExitosa == 1) {
			this.realizarDetalleVenta(request, response, daoVenta, daoDetalleVenta, session, nuevaVenta, daoCliente, daoTrabajador, daoProducto, decision);
		} else {
			if (decision.equalsIgnoreCase("boleta")) {
				request.setAttribute("mensajeVentaFallida", "Ocurrió un error inesperado. Por favor inténtelo de nuevo.");
				request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response);
			} else if (decision.equalsIgnoreCase("factura")) {
				request.setAttribute("mensajeVentaFallida", "Ocurrió un error inesperado. Por favor inténtelo de nuevo.");
				request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response);
			}
		}
		
	}
	
	protected void realizarDetalleVenta(HttpServletRequest request, HttpServletResponse response, VentaInterface daoVenta, DetalleVentaInterface daoDetalleVenta, HttpSession session, Venta ventaObtenida, ClienteInterface daoCliente, TrabajadorInterface daoTrabajador, ProductoInterface daoProducto, String decision) throws ServletException, IOException {
		
		int ultimoIdVenta = daoVenta.obtenerUltimoIdVenta();
		int ultimaVentaBoleta = daoVenta.obtenerMaximoBoleta();
		int ultimaVentaFactura = daoVenta.obtenerMaximoFactura();
		
		List<DetalleTemporal> listaCarrito = (List<DetalleTemporal>) session.getAttribute("listaCarrito");
		for (DetalleTemporal item : listaCarrito) {
			DetalleVenta detalleVentaAux = new DetalleVenta();
			detalleVentaAux.setIdVenta(ultimoIdVenta);
			detalleVentaAux.setIdProducto(item.getIdProducto());
			detalleVentaAux.setCantidad(item.getCantidadProducto());
			
			// Convierte el precio del producto a BigDecimal
			BigDecimal precioProducto = new BigDecimal(item.getPrecioProducto());
			    
			// Establece el precio unitario
			detalleVentaAux.setPrecioUnitario(precioProducto);
			    
			// Calcula el IGV (18%)
			BigDecimal igv = precioProducto.multiply(new BigDecimal("0.18")).setScale(2, RoundingMode.HALF_UP);
			detalleVentaAux.setIgv(igv);

			// Calcula el subtotal: (precioProducto + IGV) * cantidadProducto
			BigDecimal subtotal = precioProducto.add(igv).multiply(new BigDecimal(item.getCantidadProducto())).setScale(2, RoundingMode.HALF_UP);
			detalleVentaAux.setSubtotal(subtotal);
				
			daoDetalleVenta.crearDetalleVenta(detalleVentaAux);
			    
			// Descontar el stock
			daoProducto.descontarStockPorId(item.getIdProducto(), item.getCantidadProducto());
		}
		
		if (decision.equalsIgnoreCase("boleta")) { this.crearPDFBoleta(request, response, ventaObtenida, daoDetalleVenta, daoCliente, daoTrabajador, ultimoIdVenta, daoProducto, daoVenta, ultimaVentaBoleta); }
		else if (decision.equalsIgnoreCase("factura")) { this.crearPDFFactura(request, response, ventaObtenida, daoDetalleVenta, daoCliente, daoTrabajador, ultimoIdVenta, daoProducto, daoVenta, ultimaVentaFactura); }

	}
	
	protected void crearPDFBoleta(HttpServletRequest request, HttpServletResponse response, Venta ventaObtenida, DetalleVentaInterface daoDetalleVenta, ClienteInterface daoCliente, TrabajadorInterface daoTrabajador, int ultimoIdVenta, ProductoInterface daoProducto, VentaInterface daoVenta, int ultimaVentaBoleta) throws ServletException, IOException {
	
		String nombreBoleta = "Boleta_" + ultimaVentaBoleta + ".pdf";
		Cliente clienteObtenido = daoCliente.encontrarCliente(ventaObtenida.getIdCliente());
		Trabajador trabajadorObtenido = daoTrabajador.encontrarTrabajador(ventaObtenida.getIdTrabajador());
		List<DetalleVenta> listaDetalleVentaObtenido = daoDetalleVenta.listarPorIdVenta(ultimoIdVenta);
		BigDecimal igvAux = BigDecimal.ZERO;
		MetodoPago metodoPagoObtenido = daoVenta.encontrarMetodoPago(ventaObtenida.getIdMetodoPago());

	    String rutaFisica = getServletContext().getRealPath("/pdfBoletas/" + nombreBoleta);
	    try(FileOutputStream fos = new FileOutputStream(rutaFisica)) {
	        Document document = new Document(
	            PageSize.A4, 36, 36, 36, 36
	        );

	        PdfWriter.getInstance(document, fos);

	        document.open();

	        // ========== ENCABEZADO ==========
	        Paragraph titulo = new Paragraph("BOLETA", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18));
	        titulo.setAlignment(Element.ALIGN_CENTER);
	        document.add(titulo);

	        // Espacio
	        document.add(new Paragraph(" "));

	        PdfPTable tablaEncabezado = new PdfPTable(2);
	        tablaEncabezado.setWidthPercentage(100);

	        tablaEncabezado.addCell("Nro. Boleta:");
	        tablaEncabezado.addCell("B-" + String.valueOf(ultimaVentaBoleta));

	        tablaEncabezado.addCell("Fecha:");
	        tablaEncabezado.addCell(String.valueOf(ventaObtenida.getFecha()));

	        tablaEncabezado.addCell("Hora:");
	        tablaEncabezado.addCell(String.valueOf(ventaObtenida.getHora()));

	        tablaEncabezado.addCell("Nombre Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getNombreCliente()));

	        tablaEncabezado.addCell("Apellido Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getApellidoCliente()));

	        tablaEncabezado.addCell("DNI Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getDniCliente()));

	        tablaEncabezado.addCell("Nombre Trabajador:");
	        tablaEncabezado.addCell(String.valueOf(trabajadorObtenido.getNombresTrabajador()));

	        tablaEncabezado.addCell("Cargo Trabajador:");
	        tablaEncabezado.addCell(String.valueOf(trabajadorObtenido.getNombreCargo()));

	        document.add(tablaEncabezado);

	        document.add(new Paragraph(" "));

	        // ========== CUERPO (Detalle de Productos) ==========
	        PdfPTable tablaDetalle = new PdfPTable(6);
	        tablaDetalle.setWidthPercentage(100);

	        tablaDetalle.addCell(encabezadoTabla("SKU"));
	        tablaDetalle.addCell(encabezadoTabla("Producto"));
	        tablaDetalle.addCell(encabezadoTabla("Cantidad"));
	        tablaDetalle.addCell(encabezadoTabla("Precio Unit."));
	        tablaDetalle.addCell(encabezadoTabla("IGV 18%"));
	        tablaDetalle.addCell(encabezadoTabla("Subtotal"));

	        for(DetalleVenta item: listaDetalleVentaObtenido) {
	        	Producto productoAux = daoProducto.encontrarProducto(item.getIdProducto());
		        tablaDetalle.addCell(String.valueOf(productoAux.getSkuProducto()));
		        tablaDetalle.addCell(String.valueOf(productoAux.getNombreProducto()));
		        tablaDetalle.addCell(String.valueOf(item.getCantidad()));
		        tablaDetalle.addCell("S/" + String.valueOf(item.getPrecioUnitario()));
		        tablaDetalle.addCell("S/" + String.valueOf(item.getIgv()));
		        tablaDetalle.addCell("S/" + String.valueOf(item.getSubtotal()));
		        igvAux = igvAux.add(item.getIgv());
	        }

	        document.add(tablaDetalle);

	        document.add(new Paragraph(" "));

	        // ========== PIE (Resumen de montos y método de pago) ==========
	        PdfPTable tablaPie = new PdfPTable(2);
	        tablaPie.setWidthPercentage(100);

	        tablaPie.addCell("Monto Total:");
	        tablaPie.addCell("S/" + ventaObtenida.getMontoTotal());

	        tablaPie.addCell("IGV Total (18%):");
	        tablaPie.addCell("S/" + String.valueOf(igvAux));

	        tablaPie.addCell("Método de Pago:");
	        tablaPie.addCell(String.valueOf(metodoPagoObtenido.getNombreMetodoPago()));

	        String mensajeDineroCliente = ventaObtenida.getDineroCliente().compareTo(BigDecimal.ZERO) == 0 ? "N/A" : "S/" + ventaObtenida.getDineroCliente();
	        tablaPie.addCell("Dinero del Cliente:");
	        tablaPie.addCell(mensajeDineroCliente);

	        String mensajeVueltoCliente = ventaObtenida.getVueltoEfectivo().compareTo(BigDecimal.ZERO) == 0 ? "N/A" : "S/" + ventaObtenida.getVueltoEfectivo();
	        tablaPie.addCell("Vuelto:");
	        tablaPie.addCell(mensajeVueltoCliente);

	        document.add(tablaPie);

	        document.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new ServletException("Error al generar el PDF", e);
	    }
	    
	    String rutaPublica = request.getContextPath() + "/pdfBoletas/" + nombreBoleta;
	    request.setAttribute("descargarPDF", rutaPublica);
	    request.setAttribute("ventaCompletado", "La venta se completo con éxito.");
	    request.getRequestDispatcher("jsp/TicketSale.jsp").forward(request, response);
	    
	}

	protected void crearPDFFactura(HttpServletRequest request, HttpServletResponse response, Venta ventaObtenida, DetalleVentaInterface daoDetalleVenta, ClienteInterface daoCliente, TrabajadorInterface daoTrabajador, int ultimoIdVenta, ProductoInterface daoProducto, VentaInterface daoVenta, int ultimaVentaFactura) throws ServletException, IOException {
		
		String nombreBoleta = "Factura_" + ultimaVentaFactura + ".pdf";
		Cliente clienteObtenido = daoCliente.encontrarCliente(ventaObtenida.getIdCliente());
		Trabajador trabajadorObtenido = daoTrabajador.encontrarTrabajador(ventaObtenida.getIdTrabajador());
		List<DetalleVenta> listaDetalleVentaObtenido = daoDetalleVenta.listarPorIdVenta(ultimoIdVenta);
		BigDecimal igvAux = BigDecimal.ZERO;
		MetodoPago metodoPagoObtenido = daoVenta.encontrarMetodoPago(ventaObtenida.getIdMetodoPago());

	    String rutaFisica = getServletContext().getRealPath("/pdfFacturas/" + nombreBoleta);
	    try(FileOutputStream fos = new FileOutputStream(rutaFisica)) {
	        Document document = new Document(
	            PageSize.A4, 36, 36, 36, 36
	        );

	        PdfWriter.getInstance(document, fos);

	        document.open();

	        // ========== ENCABEZADO ==========
	        Paragraph titulo = new Paragraph("FACTURA", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18));
	        titulo.setAlignment(Element.ALIGN_CENTER);
	        document.add(titulo);

	        // Espacio
	        document.add(new Paragraph(" "));

	        PdfPTable tablaEncabezado = new PdfPTable(2);
	        tablaEncabezado.setWidthPercentage(100);

	        tablaEncabezado.addCell("Nro. Factura:");
	        tablaEncabezado.addCell("F-" + String.valueOf(ultimaVentaFactura));

	        tablaEncabezado.addCell("Fecha:");
	        tablaEncabezado.addCell(String.valueOf(ventaObtenida.getFecha()));

	        tablaEncabezado.addCell("Hora:");
	        tablaEncabezado.addCell(String.valueOf(ventaObtenida.getHora()));

	        tablaEncabezado.addCell("Nombre Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getNombreCliente()));

	        tablaEncabezado.addCell("Apellido Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getApellidoCliente()));

	        tablaEncabezado.addCell("RUC Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getRucCliente()));

	        tablaEncabezado.addCell("Razón Social Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getRazonSocialCliente()));
	        
	        tablaEncabezado.addCell("Nombre Comercial Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getNombreComercialCliente()));
	        
	        tablaEncabezado.addCell("Dirección Fiscal Cliente:");
	        tablaEncabezado.addCell(String.valueOf(clienteObtenido.getDireccionFiscalCliente()));
	        
	        tablaEncabezado.addCell("Nombre Trabajador:");
	        tablaEncabezado.addCell(String.valueOf(trabajadorObtenido.getNombresTrabajador()));

	        tablaEncabezado.addCell("Cargo Trabajador:");
	        tablaEncabezado.addCell(String.valueOf(trabajadorObtenido.getNombreCargo()));

	        document.add(tablaEncabezado);

	        // Espacio
	        document.add(new Paragraph(" "));

	        // ========== CUERPO (Detalle de Productos) ==========
	        PdfPTable tablaDetalle = new PdfPTable(6);
	        tablaDetalle.setWidthPercentage(100);

	        
	        // Encabezados de tabla
	        tablaDetalle.addCell(encabezadoTabla("SKU"));
	        tablaDetalle.addCell(encabezadoTabla("Producto"));
	        tablaDetalle.addCell(encabezadoTabla("Cantidad"));
	        tablaDetalle.addCell(encabezadoTabla("Precio Unit."));
	        tablaDetalle.addCell(encabezadoTabla("IGV 18%"));
	        tablaDetalle.addCell(encabezadoTabla("Subtotal"));

	        for(DetalleVenta item: listaDetalleVentaObtenido) {
	        	Producto productoAux = daoProducto.encontrarProducto(item.getIdProducto());
		        tablaDetalle.addCell(String.valueOf(productoAux.getSkuProducto()));
		        tablaDetalle.addCell(String.valueOf(productoAux.getNombreProducto()));
		        tablaDetalle.addCell(String.valueOf(item.getCantidad()));
		        tablaDetalle.addCell("S/" + String.valueOf(item.getPrecioUnitario()));
		        tablaDetalle.addCell("S/" + String.valueOf(item.getIgv()));
		        tablaDetalle.addCell("S/" + String.valueOf(item.getSubtotal()));
		        igvAux = igvAux.add(item.getIgv());
	        }

	        document.add(tablaDetalle);

	        document.add(new Paragraph(" "));

	        // ========== PIE (Resumen de montos y método de pago) ==========
	        PdfPTable tablaPie = new PdfPTable(2);
	        tablaPie.setWidthPercentage(100);

	        tablaPie.addCell("Monto Total:");
	        tablaPie.addCell("S/" + ventaObtenida.getMontoTotal());

	        tablaPie.addCell("IGV Total (18%):");
	        tablaPie.addCell("S/" + String.valueOf(igvAux));

	        tablaPie.addCell("Método de Pago:");
	        tablaPie.addCell(String.valueOf(metodoPagoObtenido.getNombreMetodoPago()));

	        String mensajeDineroCliente = ventaObtenida.getDineroCliente().compareTo(BigDecimal.ZERO) == 0 ? "N/A" : "S/" + ventaObtenida.getDineroCliente();
	        tablaPie.addCell("Dinero del Cliente:");
	        tablaPie.addCell(mensajeDineroCliente);

	        String mensajeVueltoCliente = ventaObtenida.getVueltoEfectivo().compareTo(BigDecimal.ZERO) == 0 ? "N/A" : "S/" + ventaObtenida.getVueltoEfectivo();
	        tablaPie.addCell("Vuelto:");
	        tablaPie.addCell(mensajeVueltoCliente);

	        document.add(tablaPie);

	        document.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new ServletException("Error al generar el PDF", e);
	    }
	    
	    String rutaPublica = request.getContextPath() + "/pdfFacturas/" + nombreBoleta;
	    request.setAttribute("descargarPDF", rutaPublica);
	    request.setAttribute("ventaCompletado", "La venta se completo con éxito.");
	    request.getRequestDispatcher("jsp/BillSale.jsp").forward(request, response);
	    
	}
	
	private PdfPCell encabezadoTabla(String texto) {
	    Font fontEncabezado = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
	    PdfPCell cell = new PdfPCell(new Paragraph(texto, fontEncabezado));
	    
	    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBackgroundColor(new Color(230, 230, 230)); // Gris claro
	    return cell;
	}
	
	protected void listarProductos(HttpServletRequest request, HttpServletResponse response, ProductoInterface daoProducto, HttpSession session) throws ServletException, IOException {
		List<Producto> listadoProductos = daoProducto.listarProductos();
		session.setAttribute("listadoProductos", listadoProductos);
	}
	
	protected void listarMetodoPago(HttpServletRequest request, HttpServletResponse response, VentaInterface daoVenta, HttpSession session) throws ServletException, IOException {
		List<MetodoPago> listadoMetodoPago = daoVenta.listarMetodoPago();
		session.setAttribute("listadoMetodoPago", listadoMetodoPago);
	}
	
	protected void calcularNumerosTotales(HttpSession session) {
		List<DetalleTemporal> listaCarrito = (List<DetalleTemporal>) session.getAttribute("listaCarrito");
		DecimalFormat decimnalFormat = new DecimalFormat("#.00");
		
		double subtotal = 0.0;
		for (DetalleTemporal detalleSuma : listaCarrito) {
			subtotal += detalleSuma.getPrecioProducto() * detalleSuma.getCantidadProducto();
		}

		double igv = subtotal * 0.18;
		double montoTotal = subtotal + igv;
		
		session.setAttribute("subtotalCarrito", decimnalFormat.format(subtotal));
		session.setAttribute("igvCarrito", decimnalFormat.format(igv));
		session.setAttribute("montoTotalCarrito", decimnalFormat.format(montoTotal));
	}
	
	protected void limpiezaTotal(HttpSession session) {
		session.removeAttribute("idClienteObtenido");
		session.removeAttribute("dniClienteObtenido");
		session.removeAttribute("nombreClienteObtenido");
		session.removeAttribute("apellidosClienteObtenido");
		session.removeAttribute("razonSocialClienteObtenido");
		session.removeAttribute("nombreComercialClienteObtenido");
		session.removeAttribute("direccionFiscalClienteObtenido");
		session.removeAttribute("rucClienteObtenido");
		
		session.removeAttribute("idProductoObtenido");
		session.removeAttribute("nombreProductoObtenido");
		session.removeAttribute("stockProductoObtenido");
		session.removeAttribute("precioProductoObtenido");
		
		session.removeAttribute("listaCarrito");
		
		session.removeAttribute("subtotalCarrito");
		session.removeAttribute("igvCarrito");
		session.removeAttribute("montoTotalCarrito");
		
		session.removeAttribute("ultimoIdBoleta");
		session.removeAttribute("ultimoIdFactura");
		session.removeAttribute("idComprobantePago");
		
		session.removeAttribute("descision");
	}
	
}
