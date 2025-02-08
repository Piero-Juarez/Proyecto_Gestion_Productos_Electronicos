package dao;

import interfaces.ClienteInterface;
import interfaces.DetalleVentaInterface;
import interfaces.ProductoInterface;
import interfaces.ServicioVentaInterface;
import interfaces.TrabajadorInterface;
import interfaces.UsuarioRegistradoInterface;
import interfaces.VentaInterface;

public abstract class DAOFactory {

	public static final int MYSQL = 1;
	public static final int SQLSERVER = 2;
	public static final int ORACLE = 3;

	public abstract TrabajadorInterface getTrabajadorDAO();
	public abstract ClienteInterface getClienteDAO();
	public abstract ProductoInterface getProductoDAO();
	public abstract VentaInterface getVentaDAO();
	public abstract DetalleVentaInterface getDetalleVentaDAO();
	public abstract ServicioVentaInterface getServicioVentaDAO();
	public abstract UsuarioRegistradoInterface getUsuarioRegistradoDAO();
	
	public static DAOFactory getDAOFactory(int tipo) {
		switch (tipo) {
			case MYSQL: return new MySQLDAOFactory();
			case SQLSERVER: return null;
			case ORACLE: return null;
			default: return null;
		}
	}
	
}
