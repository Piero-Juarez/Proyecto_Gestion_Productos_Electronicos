package interfaces;

import java.util.List;

import entity.producto.Categoria;
import entity.producto.EstadoProducto;
import entity.producto.Marca;
import entity.producto.Producto;
import entity.producto.Proveedor;

public interface ProductoInterface {

	// CRUD PRODUCTO
	public void crearProducto(Producto nuevoProducto);
	public Producto encontrarProducto(int idProducto);
	public List<Producto> listarProductos();
	public void actualizarProducto(Producto productoExistente);
	public void eliminarProducto(int idProducto);
	
	public List<Producto> cantidadProductosExistentes();
	public List<Producto> cantidadProductosBajoStock();
	public List<Producto> cantidadProductosSinStock();
	
	public List<Producto> obtenerProductosMasVendidos();
	public int cantidadStockProductoSegunId(int idProducto);
	public void descontarStockPorId(int idProducto, int stockDescontado);
	
	// CRUD CATEGORIA
	public int crearCategoria(Categoria nuevaCategoria);
	public Categoria encontrarCategoria(int idCategoria);
	public List<Categoria> listarCategorias();
	public int actualizarCategoria(Categoria categoriaExistente);
	public void eliminarCategoria(int idCategoria);
	
	public int contarProductosPorCategoria(int idCategoria);
	
	// CRUD ESTADO PRODUCTO
	public int crearEstadoProducto(EstadoProducto nuevoEstadoProducto);
	public EstadoProducto encontrarEstadoProducto(int idEstadoProducto);
	public List<EstadoProducto> listarEstadoProducto();
	public int actualizarEstadoProducto(EstadoProducto estadoProductoExistente);
	public void eliminarEstadoProducto(int idEstadoProducto);
	
	public int contarProductosPorEstadoProducto(int idEstadoProducto);
	
	// CRUD MARCA
	public int crearMarca(Marca nuevaMarca);
	public Marca encontrarMarca(int idMarca);
	public List<Marca> listarMarcas();
	public int actualizarMarca(Marca marcaExistente);
	public void eliminarMarca(int idMarca);
	
	public int contarProductosPorMarca(int idMarca);
	
	// CRUD PROVEEDOR
	public int crearProveedor(Proveedor nuevoProveedor);
	public Proveedor encontrarProveedor(int idProveedor);
	public List<Proveedor> listarProveedores();
	public int actualizarProveedor(Proveedor proveedorExistente);
	public void eliminarProveedor(int idProveedor);
	
	public int contarProductosPorProveedor(int idProveedor);
	
}
