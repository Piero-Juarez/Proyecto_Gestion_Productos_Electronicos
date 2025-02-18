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
import entity.cliente.Cliente;
import entity.cliente.ClienteDocumento;
import entity.producto.Producto;
import entity.trabajador.Trabajador;
import entity.venta.MetodoPagoPreferido;
import entity.venta.Venta;
import entity.venta.VentasDiarias;
import interfaces.ClienteInterface;
import interfaces.ProductoInterface;
import interfaces.TrabajadorInterface;
import interfaces.VentaInterface;


@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReportsServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		
		ProductoInterface daoProducto = daoFactory.getProductoDAO();
		TrabajadorInterface daoTrabajador = daoFactory.getTrabajadorDAO();
		VentaInterface daoVenta = daoFactory.getVentaDAO();
		ClienteInterface daoCliente = daoFactory.getClienteDAO();
		
		HttpSession session = request.getSession();
		
		// LIMPIAR SESION
		limpiezaTotal(request, response, session);
		
		// LISTADO
		listaClientesMasCompra(request,response,session,daoCliente);
		listarVentasDiarias(request,response,session,daoVenta);
		listarTrabajadoresMasVentas(request,response, session, daoTrabajador);
		listarProductosMasVendedidos(request, response, session, daoProducto);
		listarStockProductos(request, response, session, daoProducto);
		listarVentasPorCategoria(request, response, session, daoProducto);
		listarProducosConMasIngresos(request, response, session, daoProducto);
		listarMetodosPreferidosCliente(request, response, session, daoCliente);
		listarMontoTotalDiario(request, response, session, daoVenta);
		listarProductosPorCategoria(request, response, session, daoProducto);
		listarClientePorDocumento(request, response, session, daoCliente);
		request.getRequestDispatcher("jsp/Reports.jsp").forward(request, response);
		
	}

	protected void listarProductosMasVendedidos(HttpServletRequest request, HttpServletResponse response, HttpSession session, ProductoInterface daoProducto) throws ServletException, IOException {
		List<Producto> listaProductosVendido = daoProducto.obtenerProductosMasVendidos();
		session.setAttribute("listaProductosVendidos", listaProductosVendido);
	}
	
	protected void listarTrabajadoresMasVentas(HttpServletRequest request, HttpServletResponse response, HttpSession session, TrabajadorInterface daoTrabajador) throws ServletException, IOException {
		List<Trabajador> listaTrabajadorMasVenta = daoTrabajador.TrabajadoresConMasVentas();
		session.setAttribute("listaTrabajadorMasVenta", listaTrabajadorMasVenta);
	}
	
	protected void listarVentasDiarias(HttpServletRequest request, HttpServletResponse response, HttpSession session, VentaInterface daoVenta) throws ServletException, IOException {
		List<VentasDiarias> listaVentasDiarias = daoVenta.ventasDiarias();
		session.setAttribute("listaVentasDiarias", listaVentasDiarias);
	}
	
	protected void listaClientesMasCompra(HttpServletRequest request, HttpServletResponse response, HttpSession session, ClienteInterface daoCliente) throws ServletException, IOException {
		List<Cliente> listaMasCompras= daoCliente.listaClienteMasCompras();
		session.setAttribute("listaClientesMasCompras", listaMasCompras);
	}
	
	protected void listarStockProductos(HttpServletRequest request, HttpServletResponse response, HttpSession session, ProductoInterface daoProducto) throws ServletException, IOException {
		List<Producto> listaStockProducto = daoProducto.listarStockProducto();
		session.setAttribute("listaStockProducto", listaStockProducto);
	}
	
	protected void listarVentasPorCategoria(HttpServletRequest request, HttpServletResponse response, HttpSession session, ProductoInterface daoProducto) throws ServletException, IOException {
		List<Producto> listaVentaCategoria = daoProducto.listarProductosPorCategoria();
		session.setAttribute("listaVentaCategoria", listaVentaCategoria);
	}
	
	protected void listarProducosConMasIngresos(HttpServletRequest request, HttpServletResponse response, HttpSession session, ProductoInterface daoProducto) throws ServletException, IOException {
		List<Producto> listaProducos = daoProducto.listarProductosMasIngresos();
		session.setAttribute("listaProducosMasIngresos", listaProducos);
	}
	
	protected void listarMetodosPreferidosCliente(HttpServletRequest request, HttpServletResponse response, HttpSession session, ClienteInterface daoCliente) throws ServletException, IOException {
		List<MetodoPagoPreferido> listaMetodos = daoCliente.metodoPagoPreferidoCliente();
		session.setAttribute("listaMetodosPreferidos", listaMetodos);
	}
	
	protected void listarMontoTotalDiario(HttpServletRequest request, HttpServletResponse response, HttpSession session, VentaInterface daoVenta) throws ServletException, IOException {
		List<Venta> listaMontoTotalDiario = daoVenta.montoTotalDiario();
		session.setAttribute("listaMontoTotalDiario", listaMontoTotalDiario);
	}
	
	protected void listarProductosPorCategoria(HttpServletRequest request, HttpServletResponse response, HttpSession session, ProductoInterface daoProducto) throws ServletException, IOException {
		List<Producto> listaProductoPorCategoria = daoProducto.listarCantidadProductosPorCategoria();
		session.setAttribute("listaProductoPorCategoria", listaProductoPorCategoria);
	}
	
	protected void listarClientePorDocumento(HttpServletRequest request, HttpServletResponse response, HttpSession session, ClienteInterface daoCliente) throws ServletException, IOException {
		List<ClienteDocumento> listaClientePorDocumento = daoCliente.listaCantidadClienteSegunDocumento();
		session.setAttribute("listaClientePorDocumento", listaClientePorDocumento);
	}
	
	protected void limpiezaTotal(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
		session.removeAttribute("listaProductosVendidos");
		session.removeAttribute("listaTrabajadorMasVenta");
		session.removeAttribute("listaVentasDiarias");
		session.removeAttribute("listaClientesMasCompras");
		
		session.removeAttribute("listaStockProducto");
		session.removeAttribute("listaVentaCategoria");
		session.removeAttribute("listaProducosMasIngresos");
		session.removeAttribute("listaMetodosPreferidos");
		session.removeAttribute("listaMontoTotalDiario");
		session.removeAttribute("listaProductoPorCategoria");
		session.removeAttribute("listaClientePorDocumento");
	}
	
}
