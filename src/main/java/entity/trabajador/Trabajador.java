package entity.trabajador;

import java.util.Date;

public class Trabajador {

	private int idtrabajador;
	private String nombresTrabajador;
	private String ApellidosTrabajador;
	private String dni;
	private String correoElectronicoTrabajador;
	private String numeroTelefonoTrabajador;
	private String direccionTrabajador;
	private int idCargo;
	private String nombreCargo;
	private Date fechaContratacionTrabajador;
	private int idJornadaLaboral;
	private String nombreJornadaLaboral;
	private double salarioTrabajador;
	private int ventasTrabajador;
	
	public int getIdtrabajador() {return idtrabajador;}
	public void setIdtrabajador(int idtrabajador) {	this.idtrabajador = idtrabajador;}
	
	public String getNombresTrabajador() {return nombresTrabajador;	}
	public void setNombresTrabajador(String nombresTrabajador) {this.nombresTrabajador = nombresTrabajador;	}
	
	public String getApellidosTrabajador() {return ApellidosTrabajador;}
	public void setApellidosTrabajador(String apellidosTrabajador) {ApellidosTrabajador = apellidosTrabajador;}
	
	public String getDni() {return dni;	}
	public void setDni(String dni) {this.dni = dni;}
	
	public String getCorreoElectronicoTrabajador() {return correoElectronicoTrabajador;	}
	public void setCorreoElectronicoTrabajador(String correoElectronicoTrabajador) {this.correoElectronicoTrabajador = correoElectronicoTrabajador;	}
	
	public String getNumeroTelefonoTrabajador() {return numeroTelefonoTrabajador;}
	public void setNumeroTelefonoTrabajador(String numeroTelefonoTrabajador) {this.numeroTelefonoTrabajador = numeroTelefonoTrabajador;	}
	
	public String getDireccionTrabajador() {return direccionTrabajador;}
	public void setDireccionTrabajador(String direccionTrabajador) {this.direccionTrabajador = direccionTrabajador;}
	
	public int getIdCargo() {return idCargo;}
	public void setIdCargo(int idCargo) {this.idCargo = idCargo;}
	
	public String getNombreCargo() {return nombreCargo;}
	public void setNombreCargo(String nombreCargo) {this.nombreCargo = nombreCargo;}
	
	public Date getFechaContratacionTrabajador() {return fechaContratacionTrabajador;}
	public void setFechaContratacionTrabajador(Date fechaContratacionTrabajador) {this.fechaContratacionTrabajador = fechaContratacionTrabajador;}
	
	public int getIdJornadaLaboral() {return idJornadaLaboral;}
	public void setIdJornadaLaboral(int idJornadaLaboral) {this.idJornadaLaboral = idJornadaLaboral;}
	
	public String getNombreJornadaLaboral() {return nombreJornadaLaboral;}
	public void setNombreJornadaLaboral(String nombreJornadaLaboral) {this.nombreJornadaLaboral = nombreJornadaLaboral;}
	
	public double getSalarioTrabajador() {return salarioTrabajador;	}
	public void setSalarioTrabajador(double salarioTrabajador) {this.salarioTrabajador = salarioTrabajador;}
	
	public int getVentasTrabajador() {return ventasTrabajador;}
	public void setVentasTrabajador(int ventasTrabajador) {	this.ventasTrabajador = ventasTrabajador;}
	
}
