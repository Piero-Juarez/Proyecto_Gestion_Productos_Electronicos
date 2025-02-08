package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.DAOFactory;
import entity.usuarioRegistrado.UsuarioRegistrado;
import interfaces.UsuarioRegistradoInterface;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String type = request.getParameter("type");
		
		switch (type) {
			case "login" -> loginSession(request, response);
			case "logout" -> logoutSession(request, response);
			default -> response.sendRedirect("jsp/404.jsp");
		}
		
	}

	protected void loginSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String correoUsuario = request.getParameter("txtUsername");
		String contrasenhaUsuario = request.getParameter("txtPassUser");
		
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		UsuarioRegistradoInterface daoUsuarioRegistrado = daoFactory.getUsuarioRegistradoDAO();
		
		// PRIMERO EL DNI, LUEGO EL CORREO ELECTRÓNICO
		UsuarioRegistrado usuarioRegistrado = daoUsuarioRegistrado.validarInicioSesion(contrasenhaUsuario, correoUsuario);
		
		if (usuarioRegistrado != null) {
			
			// GUARDAR EN LA SESIÓN
			HttpSession session = request.getSession();
			session.setAttribute("usuarioRegistrado", usuarioRegistrado);
			
			response.sendRedirect("HomeServlet");
			
		} else {
			
			request.setAttribute("loginFallido", "Correo electrónico o contraseña incorrectos.<br>Inténtelo de nuevo.");
			request.getRequestDispatcher("jsp/Login.jsp").forward(request, response);
			
		}
		
	}
	
	protected void logoutSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect("jsp/Login.jsp");
	}
	
}
