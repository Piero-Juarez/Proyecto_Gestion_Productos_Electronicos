package servlet;

import java.io.IOException;
import java.util.List;

import dao.DAOFactory;
import entity.cliente.Cliente;
import entity.producto.Producto;
import interfaces.ClienteInterface;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ClientsServlet")
public class ClientsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ClientsServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type =request.getParameter("type");
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		ClienteInterface daoCliente=daoFactory.getClienteDAO();
		HttpSession session=request.getSession();
		
		switch(type) {
			case "listar": 
				
				if(session.getAttribute("listaClientes")==null) {
					List<Cliente> listaCliente = daoCliente.listarClientes();
					session.setAttribute("listaClientes", listaCliente);				
				}
				
				request.getRequestDispatcher("jsp/Clients.jsp").forward(request, response);
				break;
				
			case "detalleCliente":
				
	            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
	            
	            Cliente detalleCliente = daoCliente.encontrarCliente(idCliente);
				session.setAttribute("detallesCliente",detalleCliente);
				listaProductosPorCliente(request,response,session,daoCliente,idCliente);
				request.getRequestDispatcher("jsp/DetailClient.jsp").forward(request, response);
				break;
			case "actualizar" : 
				int idClientex =Integer.parseInt( request.getParameter("txtidCliente"));
				actualizarCliente(request,response,session, daoCliente, idClientex);
				break;
			case "eliminar" : 
				int idClienteDelete =Integer.parseInt( request.getParameter("idClienteDelete")); 
				eliminarCliente(request,response,session,daoCliente,idClienteDelete);
				
				break;
			case "registrarCliente" : 
				if(request.getParameter("tipoCliente")!= null) {
					
					String tipoCliente = request.getParameter("tipoCliente");
				
					switch(tipoCliente) {
						case "ClienteDni" -> session.setAttribute("TipoCliente", tipoCliente);
						case "ClienteRuc" -> session.setAttribute("TipoCliente", tipoCliente);
					}
					
					request.getRequestDispatcher("jsp/RegisterClients.jsp").forward(request, response);
					
				} else {
					registrarCliente(request, response, session, daoCliente);
				}

				break;
		}
		
	}
	protected void registrarCliente(HttpServletRequest request, HttpServletResponse response,HttpSession session, ClienteInterface daoCliente) throws ServletException, IOException{
		String nombre = request.getParameter("txtNombreCliente");
		String apellido = request.getParameter("txtApellidoCliente");
		String dni = request.getParameter("txtDniCliente");
		String razonSocial = request.getParameter("txtRazonSocial");
		String nombreComercial = request.getParameter("txtNombreComercial");
		String direccion = request.getParameter("txtDireccionFiscal");
		String ruc = request.getParameter("txtRuc");
		
		Cliente nuevoCliente = new Cliente();
		
		nuevoCliente.setNombreCliente(nombre);
		nuevoCliente.setApellidoCliente(apellido);
		
		if(dni!=null) {nuevoCliente.setDniCliente(dni);}
		else {nuevoCliente.setDniCliente("N/A");}
		
		if(razonSocial!=null) {nuevoCliente.setRazonSocialCliente(razonSocial);}
		else {nuevoCliente.setRazonSocialCliente("N/A");}
		
		if(nombreComercial!=null) {nuevoCliente.setNombreComercialCliente(nombreComercial);}
		else {nuevoCliente.setNombreComercialCliente("N/A");}

		if(direccion!=null) {nuevoCliente.setDireccionFiscalCliente(direccion);}
		else {nuevoCliente.setDireccionFiscalCliente("N/A");}
		
		if(ruc!=null) {nuevoCliente.setRucCliente(ruc);}
		else {nuevoCliente.setRucCliente("N/A");}
		
		daoCliente.crearCliente(nuevoCliente);
		actualizarTablaCliente(session, daoCliente);
		request.getRequestDispatcher("jsp/Clients.jsp").forward(request, response);
	}
	
	protected void actualizarCliente(HttpServletRequest request, HttpServletResponse response,HttpSession session, ClienteInterface daoCliente, int idCliente) throws ServletException, IOException{
		String nombre = request.getParameter("txtNombreCliente");
		String apellido = request.getParameter("txtApellidoCliente");
		String dni = request.getParameter("txtDniCliente");
		String razonSocial = request.getParameter("txtRazonSocial");
		String nombreComercial = request.getParameter("txtNombreComercial");
		String direccion = request.getParameter("txtDireccionFiscal");
		String ruc = request.getParameter("txtRuc");
		
		Cliente clienteActualizado = new Cliente();
		clienteActualizado.setIdCliente(idCliente);
		clienteActualizado.setNombreCliente(nombre);
		clienteActualizado.setApellidoCliente(apellido);

		if(dni!=null) {clienteActualizado.setDniCliente(dni);}
		else {clienteActualizado.setDniCliente("N/A");}
		
		if(razonSocial!=null) {clienteActualizado.setRazonSocialCliente(razonSocial);}
		else {clienteActualizado.setRazonSocialCliente("N/A");}
		
		if(nombreComercial!=null) {clienteActualizado.setNombreComercialCliente(nombreComercial);}
		else {clienteActualizado.setNombreComercialCliente("N/A");}

		if(direccion!=null) {clienteActualizado.setDireccionFiscalCliente(direccion);}
		else {clienteActualizado.setDireccionFiscalCliente("N/A");}

		if(ruc!=null) {clienteActualizado.setRucCliente(ruc);}
		else {clienteActualizado.setRucCliente("N/A");}
		
		int valor = daoCliente.actualizarCliente(clienteActualizado);
		
		if(valor==1) {
			actualizarTablaCliente(session, daoCliente);
			request.getRequestDispatcher("jsp/Clients.jsp").forward(request, response);

		}else {
			request.setAttribute("mensaje","Ocurrió un problema");
			request.getRequestDispatcher("jsp/404.jsp").forward(request, response);
		}		
	}
	
	protected void actualizarTablaCliente( HttpSession session,ClienteInterface daoCliente) throws ServletException, IOException {
		List<Cliente> listaCliente = daoCliente.listarClientes();
		session.setAttribute("listaClientes", listaCliente);
	}
	protected void eliminarCliente(HttpServletRequest request, HttpServletResponse response,HttpSession session,ClienteInterface daoCliente,int idCliente) throws ServletException, IOException{
		daoCliente.eliminarCliente(idCliente);
		actualizarTablaCliente(session, daoCliente);
		request.getRequestDispatcher("jsp/Clients.jsp").forward(request, response);
	}
	protected void listaProductosPorCliente(HttpServletRequest request, HttpServletResponse response, HttpSession session,ClienteInterface daoCliente, int idCliente) throws ServletException, IOException{
		List<Producto> listaCompras = daoCliente.listaProductosCompraCliente(idCliente);
		session.setAttribute("listaCompras", listaCompras);
		
	}

}
