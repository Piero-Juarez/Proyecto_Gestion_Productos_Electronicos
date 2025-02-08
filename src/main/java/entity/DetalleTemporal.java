package entity;

public class DetalleTemporal {

	private int idProducto;
    private String nombreProducto;
    private String imagenProducto;   
    private double precioProducto;
    private int cantidadProducto;

    public DetalleTemporal(int idProducto, String nombre, String imagen, double precio, int cantidad) {
        this.idProducto = idProducto;
        this.nombreProducto = nombre;
        this.imagenProducto = imagen;
        this.precioProducto = precio;
        this.cantidadProducto = cantidad;
    }

    // Getters y setters
    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }
    
    public String getNombreProducto() { return nombreProducto; }
    public void setNombreProducto(String nombre) { this.nombreProducto = nombre; }

    public String getImagenProducto() { return imagenProducto; }
    public void setImagenProducto(String imagen) { this.imagenProducto = imagen; }

    public double getPrecioProducto() { return precioProducto; }
    public void setPrecioProducto(double precio) { this.precioProducto = precio; }

    public int getCantidadProducto() { return cantidadProducto; }
    public void setCantidadProducto(int cantidad) { this.cantidadProducto = cantidad; }
	
}
