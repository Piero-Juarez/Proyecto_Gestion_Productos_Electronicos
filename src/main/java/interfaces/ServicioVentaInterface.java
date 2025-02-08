package interfaces;

import java.util.List;

import entity.detalleVenta.DetalleVenta;
import entity.venta.Venta;

public interface ServicioVentaInterface {

	// CRUD SERVICIO VENTA
	public void crearVentaConDetalles(Venta nuevaVenta, List<DetalleVenta> nuevosDetallesVentas);
	public Venta encontrarVentaConDetalles(int idVenta);
	public void actualizarVentaConDetalles(Venta ventaExistente, List<DetalleVenta> detallesExistentes);
	public void eliminarVentaConDetalles(int idVenta);
	
}
