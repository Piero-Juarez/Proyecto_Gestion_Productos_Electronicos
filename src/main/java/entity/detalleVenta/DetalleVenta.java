package entity.detalleVenta;

import java.math.BigDecimal;

public class DetalleVenta {

    private int idDetalleVenta;      
    private int idVenta;            
    private int idProducto;         
    private int cantidad;           
    private BigDecimal precioUnitario; 
    private BigDecimal igv;           
    private BigDecimal subtotal;       

    // Getters y Setters
    public int getIdDetalleVenta() { return idDetalleVenta; }
    public void setIdDetalleVenta(int idDetalleVenta) { this.idDetalleVenta = idDetalleVenta; }

    public int getIdVenta() { return idVenta; }
    public void setIdVenta(int idVenta) { this.idVenta = idVenta; }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public BigDecimal getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(BigDecimal precioUnitario) { this.precioUnitario = precioUnitario; }

    public BigDecimal getIgv() { return igv; }
    public void setIgv(BigDecimal igv) { this.igv = igv; }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
    
}