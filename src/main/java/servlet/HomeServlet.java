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
import entity.producto.Producto;
import interfaces.ProductoInterface;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HomeServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("usuarioRegistrado") == null) {
            response.sendRedirect("jsp/Login.jsp");
            return;
        }
		
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		ProductoInterface daoProducto = daoFactory.getProductoDAO();
		
		List<Producto> listadoProductosDisponibles = daoProducto.cantidadProductosExistentes();
		List<Producto> listadoProductosStockMinimo = daoProducto.cantidadProductosBajoStock();
		List<Producto> listadoProductosSinStock = daoProducto.cantidadProductosSinStock();
		
		request.setAttribute("numeroProductosDisponibles", listadoProductosDisponibles.size());
		request.setAttribute("numeroProductosStockMinimo", listadoProductosStockMinimo.size());
		request.setAttribute("numeroProductosSinStock", listadoProductosSinStock.size());
		
		request.getRequestDispatcher("jsp/Home.jsp").forward(request, response);
		
	}

}
