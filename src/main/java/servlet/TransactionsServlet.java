package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import dao.DAOFactory;
import entity.cliente.Cliente;
import entity.detalleVenta.DetalleVenta;
import entity.trabajador.Trabajador;
import entity.venta.ComprobantePago;
import entity.venta.MetodoPago;
import entity.venta.Venta;
import interfaces.ClienteInterface;
import interfaces.DetalleVentaInterface;
import interfaces.TrabajadorInterface;
import interfaces.VentaInterface;

@WebServlet("/TransactionsServlet")
public class TransactionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TransactionsServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		HttpSession sesion = request.getSession();
		
		VentaInterface daoVenta = daoFactory.getVentaDAO();
		DetalleVentaInterface daoDetalleVenta = daoFactory.getDetalleVentaDAO();
		ClienteInterface daoCliente = daoFactory.getClienteDAO();
		TrabajadorInterface daoTrabajador = daoFactory.getTrabajadorDAO();
		String service = request.getParameter("service");
		
		switch (service) {
			case "listarVentas" -> listarVentas(request, response, daoVenta, sesion);
			case "detalleVenta" -> detalleVenta(request, response, daoVenta, daoDetalleVenta, daoCliente, daoTrabajador);
			case "filtrarPorFecha" -> filtrarPorFecha(request, response, daoVenta, sesion);
			default -> response.sendRedirect("jsp/404.jsp");
		}

	}
	
	protected void listarVentas(HttpServletRequest request, HttpServletResponse response, VentaInterface daoVenta, HttpSession sesion) throws ServletException, IOException {

		limpiar(request, response, sesion);
		
		List<Venta> listadoVentas = daoVenta.listarVentas();
		sesion.setAttribute("listaVentas", listadoVentas);
		
		request.getRequestDispatcher("jsp/Transactions.jsp").forward(request, response);
		
	}
	
	protected void detalleVenta(HttpServletRequest request, HttpServletResponse response, VentaInterface daoVenta, DetalleVentaInterface daoDetalleVenta, ClienteInterface daoCliente, TrabajadorInterface daoTrabajador) throws ServletException, IOException {
		
		int idVentaObtenido = Integer.parseInt(request.getParameter("idVenta"));
		Venta ventaEncontrada = daoVenta.encontrarVentaPorId(idVentaObtenido);
		
		ComprobantePago comprobantePagoEncontrado = daoVenta.encontrarComprobantePago(ventaEncontrada.getIdComprobantePago());
		MetodoPago metodoPagoEncontrado = daoVenta.encontrarMetodoPago(ventaEncontrada.getIdMetodoPago());
		Cliente clienteEncontrado = daoCliente.encontrarCliente(ventaEncontrada.getIdCliente());
		Trabajador trabajadorEncontrado = daoTrabajador.encontrarTrabajador(ventaEncontrada.getIdTrabajador());
		
		// DATOS VENTA
		request.setAttribute("idVentaEnviada", ventaEncontrada.getIdVenta());
		request.setAttribute("fechaEnviada", ventaEncontrada.getFecha());
		request.setAttribute("horaEnviada", ventaEncontrada.getHora());
		request.setAttribute("comprobantePagoEnviado", comprobantePagoEncontrado.getNombreComprobantePago());
		request.setAttribute("metodoPagoEnviado", metodoPagoEncontrado.getNombreMetodoPago());
		request.setAttribute("montoTotalEnviado", ventaEncontrada.getMontoTotal());
		
		String dineroCliente = String.valueOf(ventaEncontrada.getDineroCliente()).equalsIgnoreCase("0.00") ? "N/A" : String.valueOf("S/" + ventaEncontrada.getDineroCliente());
		String vueltoCliente = String.valueOf(ventaEncontrada.getVueltoEfectivo()).equalsIgnoreCase("0.00") ? "N/A" : String.valueOf("S/" + ventaEncontrada.getVueltoEfectivo());
		request.setAttribute("dineroClienteEnviado", dineroCliente);
		request.setAttribute("vueltoClienteEnviado", vueltoCliente);
		
		// DATOS CLIENTE
		request.setAttribute("nombreClienteEnviado", clienteEncontrado.getNombreCliente());
		request.setAttribute("apellidoClienteEnviado", clienteEncontrado.getApellidoCliente());
		request.setAttribute("dniClienteEnviado", clienteEncontrado.getDniCliente());
		request.setAttribute("razonSocialClienteEnviado", clienteEncontrado.getRazonSocialCliente());
		request.setAttribute("nombreComercialClienteEnviado", clienteEncontrado.getNombreComercialCliente());
		request.setAttribute("direccionFiscalClienteEnviado", clienteEncontrado.getDireccionFiscalCliente());
		request.setAttribute("rucClienteClienteEnviado", clienteEncontrado.getRucCliente());
		
		// DATOS TRABAJADOR
		request.setAttribute("nombreTrabajadorEnviado", trabajadorEncontrado.getNombreCargo());
		request.setAttribute("apellidoTrabajadorEnviado", trabajadorEncontrado.getApellidosTrabajador());
		request.setAttribute("cargoTrabajadorEnviado", trabajadorEncontrado.getNombreCargo());
		
		// LISTA DETALLE VENTA
		List<DetalleVenta> detalleVenta = daoDetalleVenta.listarPorIdVenta(idVentaObtenido);
		request.setAttribute("listadoDetalleVenta", detalleVenta);
		
		request.getRequestDispatcher("jsp/TransactionDetail.jsp").forward(request, response);
		
	}
	
	protected void filtrarPorFecha(HttpServletRequest request, HttpServletResponse response, VentaInterface daoVenta, HttpSession sesion) throws ServletException, IOException {

		String fechaInicio = request.getParameter("fehaInicioFiltro");
		String fechaFin = request.getParameter("fechaFinFiltro");
		
		limpiar(request, response, sesion);
		
		List<Venta> listadoVentas = daoVenta.encontrarVentasPorFecha(Date.valueOf(fechaInicio), Date.valueOf(fechaFin));
		sesion.setAttribute("listaVentas", listadoVentas);
		sesion.setAttribute("mensajeBorrarFiltro", "Borrar Filtro");
		sesion.setAttribute("textoFechaInicio", fechaInicio);
		sesion.setAttribute("textoFechaFin", fechaFin);
		
		request.getRequestDispatcher("jsp/Transactions.jsp").forward(request, response);
		
	}
	
	protected void limpiar(HttpServletRequest request, HttpServletResponse response, HttpSession sesion) throws ServletException, IOException {
		sesion.removeAttribute("listaVentas");
		sesion.removeAttribute("mensajeBorrarFiltro");
		sesion.removeAttribute("textoFechaInicio");
		sesion.removeAttribute("textoFechaFin");
	}

}
