package entity.cliente;

public class Cliente {
	
	private int idCliente;
	private String nombreCliente;
	private String ApellidoCliente;
	private String dniCliente;
	private String razonSocialCliente;
	private String nombreComercialCliente;
	private String direccionFiscalCliente;
	private String rucCliente;
	private int totalUnidadesCompra;
	private double totalDineroGastado;
	
	public int getIdCliente() {	return idCliente;}
	public void setIdCliente(int idCliente) {this.idCliente = idCliente;}
	
	public String getNombreCliente() {return nombreCliente;}
	public void setNombreCliente(String nombreCliente) {this.nombreCliente = nombreCliente;}
	
	public String getApellidoCliente() {return ApellidoCliente;	}
	public void setApellidoCliente(String apellidoCliente) {ApellidoCliente = apellidoCliente;}
	
	public String getDniCliente() {return dniCliente;}
	public void setDniCliente(String dniCliente) {this.dniCliente = dniCliente;}
	
	public String getRazonSocialCliente() {return razonSocialCliente;}
	public void setRazonSocialCliente(String razonSocialCliente) {this.razonSocialCliente = razonSocialCliente;}
	
	public String getNombreComercialCliente() {return nombreComercialCliente;}
	public void setNombreComercialCliente(String nombreComercialCliente) {this.nombreComercialCliente = nombreComercialCliente;}
	
	public String getDireccionFiscalCliente() {return direccionFiscalCliente;}
	public void setDireccionFiscalCliente(String direccionFiscalCliente) {this.direccionFiscalCliente = direccionFiscalCliente;	}
	
	public String getRucCliente() {return rucCliente;}
	public void setRucCliente(String rucCliente) {this.rucCliente = rucCliente;}
	
	public int getTotalUnidadesCompra() { return totalUnidadesCompra; }
	public void setTotalUnidadesCompra(int totalUnidadesCompra) { this.totalUnidadesCompra = totalUnidadesCompra; }
	
	public double getTotalDineroGastado() { return totalDineroGastado; }
	public void setTotalDineroGastado(double totalDineroGastado) { this.totalDineroGastado = totalDineroGastado; }
	
}
