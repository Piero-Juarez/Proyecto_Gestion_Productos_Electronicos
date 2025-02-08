package entity.venta;

import java.sql.Date;

public class VentasDiarias {

	private Date fechaVenta;
	private int cantidadTotal;
	
	public Date getFechaVenta() { return fechaVenta; }
	public void setFechaVenta(Date fechaVenta) { this.fechaVenta = fechaVenta; }
	
	public int getCantidadTotal() { return cantidadTotal; }
	public void setCantidadTotal(int cantidadTotal) { this.cantidadTotal = cantidadTotal; }
	
}
