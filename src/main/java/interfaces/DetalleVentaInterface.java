package interfaces;

import java.util.List;

import entity.detalleVenta.DetalleVenta;

public interface DetalleVentaInterface {

	// CRUD DETALLE VENTA
	public void crearDetalleVenta(DetalleVenta nuevoDetalleVenta);
	public List<DetalleVenta> listarVentas();
	public List<DetalleVenta> listarPorIdVenta(int idVenta);
	public DetalleVenta encontrarDetalleVentaPorId(int idDetalleVenta);
	public void actualizarDetalleVenta(DetalleVenta detalleVentaExistente);
	public void eliminarDetalleVenta(int idDetalleVenta);
	
}
