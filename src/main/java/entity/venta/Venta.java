package entity.venta;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

public class Venta {
    
    private int idVenta;
    private LocalDate fecha;               
    private LocalTime hora;                
    private int idComprobantePago;    
    private int idCliente;            
    private int idTrabajador;         
    private BigDecimal montoTotal;    
    private int idMetodoPago;         
    private BigDecimal dineroCliente; 
    private BigDecimal vueltoEfectivo;

    // Getters y Setters
    public int getIdVenta() { return idVenta; }
    public void setIdVenta(int idVenta) { this.idVenta = idVenta; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public LocalTime getHora() { return hora; }
    public void setHora(LocalTime hora) { this.hora = hora; }

    public int getIdComprobantePago() { return idComprobantePago; }
    public void setIdComprobantePago(int idComprobantePago) { this.idComprobantePago = idComprobantePago; }

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public int getIdTrabajador() { return idTrabajador; }
    public void setIdTrabajador(int idTrabajador) { this.idTrabajador = idTrabajador; }

    public BigDecimal getMontoTotal() { return montoTotal; }
    public void setMontoTotal(BigDecimal montoTotal) { this.montoTotal = montoTotal; }

    public int getIdMetodoPago() { return idMetodoPago; }
    public void setIdMetodoPago(int idMetodoPago) { this.idMetodoPago = idMetodoPago; }

    public BigDecimal getDineroCliente() { return dineroCliente; }
    public void setDineroCliente(BigDecimal dineroCliente) { this.dineroCliente = dineroCliente; }

    public BigDecimal getVueltoEfectivo() { return vueltoEfectivo; }
    public void setVueltoEfectivo(BigDecimal vueltoEfectivo) { this.vueltoEfectivo = vueltoEfectivo; }
    
}
