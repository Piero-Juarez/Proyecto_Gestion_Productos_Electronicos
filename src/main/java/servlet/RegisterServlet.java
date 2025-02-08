package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TrabajadorModel;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import dao.DAOFactory;
import entity.trabajador.Cargo;
import entity.trabajador.JornadaLaboral;
import entity.trabajador.Trabajador;
import interfaces.TrabajadorInterface;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegisterServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String type = request.getParameter("type");
		
        int idTrabajador; 

		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		TrabajadorInterface daoTrabajador = daoFactory.getTrabajadorDAO();
		HttpSession session=request.getSession();
		
		switch(type) {
		case "listar" :
			actualizarTablaTrabajador(session, daoTrabajador);
			request.getRequestDispatcher("jsp/Register.jsp").forward(request, response);
			break;
		case "registrar": 
			
			CargarCombobox(request,response,session, daoTrabajador);				
			request.getRequestDispatcher("jsp/RegisterWorker.jsp").forward(request, response);
			break;
			
		case "detalleTrabajador":
			
            idTrabajador =  Integer.parseInt(request.getParameter("idTrabajador"));
			Trabajador detalleTrabajador = daoTrabajador.encontrarTrabajador(idTrabajador);
			
			CargarCombobox(request,response,session, daoTrabajador);	
			
			session.setAttribute("detalleTrabajador",detalleTrabajador);
			
			request.getRequestDispatcher("jsp/WorkerDetail.jsp").forward(request, response);
			
			break;
		case "registrarTrabajador":
			agregarTrabajador(request,response);
			actualizarTablaTrabajador(session, daoTrabajador);

			break;
		case "actualizar":
	        idTrabajador = Integer.parseInt(request.getParameter("txtIdTrabajador"));
			actualizarInfoTrabajador(request, response, session,daoTrabajador, idTrabajador);

			break;
		case "eliminar":
			idTrabajador = Integer.parseInt(request.getParameter("txtIdTrabajador"));
			eliminarTrabajador(request, session, response, daoTrabajador,idTrabajador);
			break;
		default : request.getRequestDispatcher("jsp/404,jsp").forward(request, response);
			
		}
	}
	
	
	protected void agregarTrabajador(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nombreTrabajador = request.getParameter("txtNombreTrabajador");
		String apellidoTrabajador = request.getParameter("txtApellidoTrabajador");
		String dni = request.getParameter("txtDniTrabajador");
		String correo = request.getParameter("txtCorreoTrabajador");
		String numeroTelefono = request.getParameter("txtNumeroTrabajador");
		String direccionTrabajador = request.getParameter("txtDireccionTrabajador");
		int  jornadaLaboral =Integer.parseInt(request.getParameter("cboJornadaLaboral"));
		
		String fechaContratacion = request.getParameter("txtFechaContratacion");
		
		java.util.Date fechaSQL = null;
		try {
			LocalDate fechaLocalDate = LocalDate.parse(fechaContratacion);
			fechaSQL = Date.valueOf(fechaLocalDate); 
			if (fechaSQL == null) {
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
			
			int cargo =Integer.parseInt(request.getParameter("cboCargo")) ;
			double salario =Double.parseDouble(request.getParameter("txtSalario"));
			Trabajador nuevoTrabajador = new Trabajador();
			nuevoTrabajador.setNombresTrabajador(nombreTrabajador);
			nuevoTrabajador.setApellidosTrabajador(apellidoTrabajador);
			nuevoTrabajador.setDni(dni);
			nuevoTrabajador.setCorreoElectronicoTrabajador(correo);
			nuevoTrabajador.setNumeroTelefonoTrabajador(numeroTelefono);
			nuevoTrabajador.setDireccionTrabajador(direccionTrabajador);
			nuevoTrabajador.setIdJornadaLaboral(jornadaLaboral);
			System.out.print("jornada ID :" + jornadaLaboral);
			nuevoTrabajador.setFechaContratacionTrabajador(fechaSQL);
			nuevoTrabajador.setIdCargo(cargo);
			System.out.print("cargo ID :" + cargo);
			nuevoTrabajador.setSalarioTrabajador(salario);
			System.out.print("salario :" + salario);
			TrabajadorModel  trabajadorModel =new TrabajadorModel();
			int valor = trabajadorModel.crearTrabajador(nuevoTrabajador);
			
			if(valor==1) {
				request.getRequestDispatcher("jsp/RegisterWorker.jsp").forward(request, response);
			}else {
				request.setAttribute("mensaje","Ocurrió un problema");
				request.getRequestDispatcher("jsp/404.jsp").forward(request, response);
			}
			System.out.print(trabajadorModel);
	}
	
	protected void actualizarTablaTrabajador( HttpSession session,TrabajadorInterface daoTrabajador) throws ServletException, IOException {
		List<Trabajador> listaTrabajador = daoTrabajador.listarTrabajadores();
		session.setAttribute("listaTrabajador", listaTrabajador);
		
	}
	
	private void CargarCombobox(HttpServletRequest request, HttpServletResponse response, HttpSession session, TrabajadorInterface daoTrabajador) throws ServletException, IOException{
		if(session.getAttribute("jornadaLaboral")==null) {
			List<JornadaLaboral> jornadaLaboral = daoTrabajador.listarJornadaLaboral();
			session.setAttribute("jornadaLaboral", jornadaLaboral);
		}
		if(session.getAttribute("cargoTrabajador")==null) {
			List<Cargo> cargoTrabajador = daoTrabajador.listarCargos();
			session.setAttribute("cargoTrabajador", cargoTrabajador);
		}
	}
	
	
	protected void actualizarInfoTrabajador( HttpServletRequest request, HttpServletResponse response, HttpSession session, TrabajadorInterface daoTrabajador, int idTrabajador) throws ServletException, IOException {
		
		String nombreTrabajador = request.getParameter("txtNombreTrabajador");
		String apellidoTrabajador = request.getParameter("txtApellidoTrabajador");
		String dni = request.getParameter("txtDniTrabajador");
		String correo = request.getParameter("txtCorreoTrabajador");
		String numeroTelefono = request.getParameter("txtNumeroTrabajador");
		String direccionTrabajador = request.getParameter("txtDireccionTrabajador");
		String fechaContratacion = request.getParameter("txtFechaContratacion");
		int  jornadaLaboral =Integer.parseInt(request.getParameter("cboJornadaLaboral"));
		int cargo =Integer.parseInt(request.getParameter("cboCargo")) ;
		double salario = Double.parseDouble(request.getParameter("txtSalario"));
		
		java.util.Date fechaSQL = null;
		try {LocalDate fechaLocalDate = LocalDate.parse(fechaContratacion);
			fechaSQL = Date.valueOf(fechaLocalDate); 
			if (fechaSQL == null) { System.out.println("Fecha de contratación no asignada.");}
		}catch(Exception e) {e.printStackTrace(); System.out.println("Error en el formato de fecha: " + e.getMessage());}
		
		
		Trabajador trabajadorActualizado = new Trabajador();
		
		trabajadorActualizado.setNombresTrabajador(nombreTrabajador);
		trabajadorActualizado.setApellidosTrabajador(apellidoTrabajador);
		trabajadorActualizado.setDni(dni);
		trabajadorActualizado.setCorreoElectronicoTrabajador(correo);
		trabajadorActualizado.setNumeroTelefonoTrabajador(numeroTelefono);
		trabajadorActualizado.setDireccionTrabajador(direccionTrabajador);
		trabajadorActualizado.setIdCargo(cargo);
		trabajadorActualizado.setFechaContratacionTrabajador(fechaSQL);
		trabajadorActualizado.setIdJornadaLaboral(jornadaLaboral);
		trabajadorActualizado.setSalarioTrabajador(salario);
		trabajadorActualizado.setIdtrabajador(idTrabajador);

		int valor= daoTrabajador.actualizarTrabajador(trabajadorActualizado);
		
		if(valor==1) {
			System.out.println("Actualizo en BD");
			actualizarTablaTrabajador(session, daoTrabajador);

			request.getRequestDispatcher("jsp/Register.jsp").forward(request, response);

		}else {
			System.out.println("No insertó en BD");
			request.setAttribute("mensaje","Ocurrió un problema");
			request.getRequestDispatcher("jsp/404.jsp").forward(request, response);
		}		
	}
	
	protected void eliminarTrabajador(HttpServletRequest request, HttpSession session,HttpServletResponse response, TrabajadorInterface daoTrabajador, int idTrabajador) throws ServletException, IOException {
		daoTrabajador.eliminarTrabajador(idTrabajador);
		actualizarTablaTrabajador(session, daoTrabajador);
		request.getRequestDispatcher("jsp/Register.jsp").forward(request, response);

	}
	

}
