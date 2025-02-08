package entity.producto;

import java.util.Date;

public class Producto {

	private int idProducto;
	private String nombreProducto;
	private String modeloProducto;
	private String skuProducto;
	private int idCategoria;
	private String nombreCategoria;
	private int idMarca;
	private String nombreMarca;
	private String detallesProducto;
	private double precioProducto;
	private int stockProducto;
	private int stockMinimoProducto;
	private int idProveedor;
	private String nombreProveedor;
	private double pesoProducto;
	private String dimensionesProducto;
	private String garantiaProducto;
	private int idEstadoProducto;
	private String nombreEstadoProducto;
	private Date fechaIncorporacionProducto;
	private String colorProducto; // add
	private String imagenProducto; // add
	private int cantidadesVendidas;
	//private Date fechaActualizacionProducto;
	
	public int getIdProducto() {return idProducto;}
	public void setIdProducto(int idProducto) {this.idProducto = idProducto;}
	
	public String getNombreProducto() {	return nombreProducto;}
	public void setNombreProducto(String nombreProducto) {this.nombreProducto = nombreProducto;}
	
	public String getModeloProducto() {return modeloProducto;}
	public void setModeloProducto(String modeloProducto) {this.modeloProducto = modeloProducto;}
	
	public String getSkuProducto() {return skuProducto;}
	public void setSkuProducto(String skuProducto) {this.skuProducto = skuProducto;}
	
	public int getIdCategoria() {return idCategoria;}
	public void setIdCategoria(int idCategoria) {this.idCategoria = idCategoria;}
	
	public String getNombreCategoria() {return nombreCategoria;}
	public void setNombreCategoria(String nombreCategoria) {this.nombreCategoria = nombreCategoria;}
	
	public int getIdMarca() {return idMarca;}
	public void setIdMarca(int idMarca) {this.idMarca = idMarca;}
	
	public String getNombreMarca() {return nombreMarca;}
	public void setNombreMarca(String nombreMarca) {this.nombreMarca = nombreMarca;}
	
	public String getDetallesProducto() {return detallesProducto;}
	public void setDetallesProducto(String detallesProducto) {this.detallesProducto = detallesProducto;}
	
	public double getPrecioProducto() {	return precioProducto;}
	public void setPrecioProducto(double precioProducto) {this.precioProducto = precioProducto;}
	
	public int getStockProducto() {return stockProducto;}
	public void setStockProducto(int stockProducto) {this.stockProducto = stockProducto;}
	
	public int getStockMinimoProducto() {return stockMinimoProducto;}
	public void setStockMinimoProducto(int stockMinimoProducto) {this.stockMinimoProducto = stockMinimoProducto;}
	
	public int getIdProveedor() {return idProveedor;}
	public void setIdProveedor(int idProveedor) {this.idProveedor = idProveedor;}
	
	public String getNombreProveedor() {return nombreProveedor;}
	public void setNombreProveedor(String nombreProveedor) {this.nombreProveedor = nombreProveedor;}
	
	public double getPesoProducto() {return pesoProducto;}
	public void setPesoProducto(double pesoProducto) {this.pesoProducto = pesoProducto;}
	
	public String getDimensionesProducto() {return dimensionesProducto;}
	public void setDimensionesProducto(String dimensionesProducto) {this.dimensionesProducto = dimensionesProducto;}
	
	public String getGarantiaProducto() {return garantiaProducto;}
	public void setGarantiaProducto(String garantiaProducto) {this.garantiaProducto = garantiaProducto;}
	
	public int getIdEstadoProducto() {return idEstadoProducto;}
	public void setIdEstadoProducto(int idEstadoProducto) {this.idEstadoProducto = idEstadoProducto;}
	
	public String getNombreEstadoProducto() {return nombreEstadoProducto;}
	public void setNombreEstadoProducto(String nombreEstadoProducto) {this.nombreEstadoProducto = nombreEstadoProducto;}
	
	public Date getFechaIncorporacionProducto() {return fechaIncorporacionProducto;}
	public void setFechaIncorporacionProducto(Date fechaIncorporacionProducto) {this.fechaIncorporacionProducto = fechaIncorporacionProducto;}

	public String getColorProducto() { return colorProducto; }
	public void setColorProducto(String colorProducto) { this.colorProducto = colorProducto; }
	
	public String getImagenProducto() { return imagenProducto; }
	public void setImagenProducto(String imagenProducto) { this.imagenProducto = imagenProducto; }
	
	public int getCantidadesVendidas() { return cantidadesVendidas; }
	public void setCantidadesVendidas(int cantidadesVendidas) { this.cantidadesVendidas = cantidadesVendidas;}
	
}
