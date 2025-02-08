package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import database.MySQLConnection;
import entity.detalleVenta.DetalleVenta;
import interfaces.DetalleVentaInterface;

public class DetalleVentaModel implements DetalleVentaInterface {

	@Override
	public void crearDetalleVenta(DetalleVenta nuevoDetalleVenta) {
		Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String llamadaProcedure = "{ CALL crearDetalleVenta(?, ?, ?, ?, ?, ?) }";
	        callableStatement = connection.prepareCall(llamadaProcedure);

	        callableStatement.setInt(1, nuevoDetalleVenta.getIdVenta());
	        callableStatement.setInt(2, nuevoDetalleVenta.getIdProducto());
	        callableStatement.setInt(3, nuevoDetalleVenta.getCantidad());
	        callableStatement.setBigDecimal(4, nuevoDetalleVenta.getPrecioUnitario());
	        callableStatement.setBigDecimal(5, nuevoDetalleVenta.getIgv());
	        callableStatement.setBigDecimal(6, nuevoDetalleVenta.getSubtotal());

	        callableStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (callableStatement != null) callableStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public List<DetalleVenta> listarVentas() {
		List<DetalleVenta> lista = new ArrayList<>();
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String llamadaProcedure = "{ CALL listarDetalleVenta() }";
	        callableStatement = connection.prepareCall(llamadaProcedure);

	        resultSet = callableStatement.executeQuery();
	        while (resultSet.next()) {
	            DetalleVenta detalleVenta = new DetalleVenta();
	            detalleVenta.setIdDetalleVenta(resultSet.getInt("id_detalle_venta"));
	            detalleVenta.setIdVenta(resultSet.getInt("id_venta"));
	            detalleVenta.setIdProducto(resultSet.getInt("id_producto"));
	            detalleVenta.setCantidad(resultSet.getInt("cantidad"));
	            detalleVenta.setPrecioUnitario(resultSet.getBigDecimal("precio_unitario"));
	            detalleVenta.setIgv(resultSet.getBigDecimal("igv"));
	            detalleVenta.setSubtotal(resultSet.getBigDecimal("subtotal"));
	            lista.add(detalleVenta);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (callableStatement != null) callableStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return lista;
	}

	@Override
	public List<DetalleVenta> listarPorIdVenta(int idVenta) {
		List<DetalleVenta> lista = new ArrayList<>();
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String llamadaProcedure = "{ CALL listarDetalleVentaPorIdVenta(?) }";
	        callableStatement = connection.prepareCall(llamadaProcedure);
	        callableStatement.setInt(1, idVenta);

	        resultSet = callableStatement.executeQuery();
	        while (resultSet.next()) {
	            DetalleVenta detalleVenta = new DetalleVenta();
	            detalleVenta.setIdDetalleVenta(resultSet.getInt("id_detalle_venta"));
	            detalleVenta.setIdVenta(resultSet.getInt("id_venta"));
	            detalleVenta.setIdProducto(resultSet.getInt("id_producto"));
	            detalleVenta.setCantidad(resultSet.getInt("cantidad"));
	            detalleVenta.setPrecioUnitario(resultSet.getBigDecimal("precio_unitario"));
	            detalleVenta.setIgv(resultSet.getBigDecimal("igv"));
	            detalleVenta.setSubtotal(resultSet.getBigDecimal("subtotal"));
	            lista.add(detalleVenta);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (callableStatement != null) callableStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return lista;
	}

	@Override
	public DetalleVenta encontrarDetalleVentaPorId(int idDetalleVenta) {
		DetalleVenta detalleVenta = null;
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String llamadaProcedure = "{ CALL encontrarDetalleVentaPorId(?) }";
	        callableStatement = connection.prepareCall(llamadaProcedure);
	        callableStatement.setInt(1, idDetalleVenta);

	        resultSet = callableStatement.executeQuery();
	        if (resultSet.next()) {
	            detalleVenta = new DetalleVenta();
	            detalleVenta.setIdDetalleVenta(resultSet.getInt("id_detalle_venta"));
	            detalleVenta.setIdVenta(resultSet.getInt("id_venta"));
	            detalleVenta.setIdProducto(resultSet.getInt("id_producto"));
	            detalleVenta.setCantidad(resultSet.getInt("cantidad"));
	            detalleVenta.setPrecioUnitario(resultSet.getBigDecimal("precio_unitario"));
	            detalleVenta.setIgv(resultSet.getBigDecimal("igv"));
	            detalleVenta.setSubtotal(resultSet.getBigDecimal("subtotal"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (callableStatement != null) callableStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return detalleVenta;
	}

	@Override
	public void actualizarDetalleVenta(DetalleVenta detalleVentaExistente) {
		Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String llamadaProcedure = "{ CALL actualizarDetalleVenta(?, ?, ?, ?, ?, ?, ?) }";
	        callableStatement = connection.prepareCall(llamadaProcedure);

	        callableStatement.setInt(1, detalleVentaExistente.getIdDetalleVenta());
	        callableStatement.setInt(2, detalleVentaExistente.getIdVenta());
	        callableStatement.setInt(3, detalleVentaExistente.getIdProducto());
	        callableStatement.setInt(4, detalleVentaExistente.getCantidad());
	        callableStatement.setBigDecimal(5, detalleVentaExistente.getPrecioUnitario());
	        callableStatement.setBigDecimal(6, detalleVentaExistente.getIgv());
	        callableStatement.setBigDecimal(7, detalleVentaExistente.getSubtotal());

	        callableStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (callableStatement != null) callableStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public void eliminarDetalleVenta(int idDetalleVenta) {
		Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String llamadaProcedure = "{ CALL eliminarDetalleVenta(?) }";
	        callableStatement = connection.prepareCall(llamadaProcedure);
	        callableStatement.setInt(1, idDetalleVenta);

	        callableStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (callableStatement != null) callableStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}


}
