package dao;

import interfaces.ClienteInterface;
import interfaces.DetalleVentaInterface;
import interfaces.ProductoInterface;
import interfaces.ServicioVentaInterface;
import interfaces.TrabajadorInterface;
import interfaces.UsuarioRegistradoInterface;
import interfaces.VentaInterface;
import model.ClienteModel;
import model.DetalleVentaModel;
import model.ProductoModel;
import model.ServicioVentaModel;
import model.TrabajadorModel;
import model.UsuarioRegistradoModel;
import model.VentaModel;

public class MySQLDAOFactory extends DAOFactory {

	@Override
	public TrabajadorInterface getTrabajadorDAO() { return new TrabajadorModel(); }

	@Override
	public ClienteInterface getClienteDAO() { return new ClienteModel(); }

	@Override
	public ProductoInterface getProductoDAO() { return new ProductoModel(); }

	@Override
	public VentaInterface getVentaDAO() { return new VentaModel(); }

	@Override
	public DetalleVentaInterface getDetalleVentaDAO() { return new DetalleVentaModel(); }

	@Override
	public ServicioVentaInterface getServicioVentaDAO() { return new ServicioVentaModel(); }

	@Override
	public UsuarioRegistradoInterface getUsuarioRegistradoDAO() { return new UsuarioRegistradoModel(); }

}
