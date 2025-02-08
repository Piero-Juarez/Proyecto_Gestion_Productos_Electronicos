package interfaces;


import java.sql.Date;
import java.util.List;

import entity.venta.ComprobantePago;
import entity.venta.MetodoPago;
import entity.venta.Venta;
import entity.venta.VentasDiarias;

public interface VentaInterface {

	// CRUD VENTA
	public int crearVenta(Venta nuevaVenta);
	public Venta encontrarVentaPorId(int idVenta);
	public List<Venta> listarVentas();
	public int actualizarVenta(Venta ventaExistente);
	public int eliminarVentaPorId(int idVenta);
	
	public List<VentasDiarias> ventasDiarias();
	
	// FUNCIONES ADICINALES
	public List<Venta> encontrarVentasPorCliente(int idCliente);
	public List<Venta> encontrarVentasPorFecha(Date fechaInicio, Date fechaFin);
	public int obtenerUltimoIdVenta();
	public int obtenerMaximoBoleta();
	public int obtenerMaximoFactura();
	
	// CRUD METODO PAGO
	public int crearMetodoPago(MetodoPago nuevoMetodoPago);
	public MetodoPago encontrarMetodoPago(int idMetodoPago);
	public List<MetodoPago> listarMetodoPago();
	public int actualizarMetodoPago(MetodoPago metodoPagoExistente);
	public void eliminarMetodoPago(int idMetodoPago);
	
	// CRUD COMPROBANTE PAGO
	public void crearComprobantePago(ComprobantePago nuevoComprobantePago);
	public ComprobantePago encontrarComprobantePago(int idComprobantePago);
	public List<ComprobantePago> listarComprobantePago();
	public void actualizarComprobantePago(ComprobantePago comprobantePagoExistente);
	public void eliminarComprobantePago(int idComprobantePago);
	
}
