package interfaces;

import java.util.List;

import entity.cliente.Cliente;
import entity.producto.Producto;

public interface ClienteInterface {

	// CRUD
	public void crearCliente(Cliente nuevoCliente);
	public Cliente encontrarCliente(int idCliente);
	public List<Cliente> listarClientes();
	public int actualizarCliente(Cliente clienteExistente);
	public void eliminarCliente(int idCliente);
	
	public Cliente encontrarClientePorDNI(String DNICliente);
	public Cliente encontrarClientePorRUC(String RucCliente);
	public List<Producto> listaProductosCompraCliente(int idCliente);
	public List<Cliente> listaClienteMasCompras();
}
