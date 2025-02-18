package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;

import database.MySQLConnection;
import entity.venta.ComprobantePago;
import entity.venta.MetodoPago;
import entity.venta.Venta;
import entity.venta.VentasDiarias;
import interfaces.VentaInterface;

public class VentaModel implements VentaInterface {

	/*============================ TABLA VENTA ============================*/
	@Override
	public int crearVenta(Venta nuevaVenta) {
		int valor = 0;

	    Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_crearVenta(?, ?, ?, ?, ?, ?, ?, ?, ?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        java.sql.Date sqlDate = java.sql.Date.valueOf(nuevaVenta.getFecha());
	        java.sql.Time sqlTime = java.sql.Time.valueOf(nuevaVenta.getHora());
	        
	        callableStatement.setDate(1, sqlDate);
	        callableStatement.setTime(2, sqlTime);
	        callableStatement.setInt(3, nuevaVenta.getIdComprobantePago());
	        callableStatement.setInt(4, nuevaVenta.getIdCliente());
	        callableStatement.setInt(5, nuevaVenta.getIdTrabajador());
	        callableStatement.setBigDecimal(6, nuevaVenta.getMontoTotal());
	        callableStatement.setInt(7, nuevaVenta.getIdMetodoPago());
	        callableStatement.setBigDecimal(8, nuevaVenta.getDineroCliente());
	        callableStatement.setBigDecimal(9, nuevaVenta.getVueltoEfectivo());

	        valor = callableStatement.executeUpdate();
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

	    return valor;
	}

	@Override
	public Venta encontrarVentaPorId(int idVenta) {
		Venta ventaAux = null;

	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_encontrarVenta(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        callableStatement.setInt(1, idVenta);

	        resultSet = callableStatement.executeQuery();

	        if (resultSet.next()) {
	            ventaAux = new Venta();
	            ventaAux.setIdVenta(resultSet.getInt("id_venta"));
	            ventaAux.setFecha(resultSet.getDate("fecha").toLocalDate());
	            ventaAux.setHora( resultSet.getTime("hora").toLocalTime());
	            ventaAux.setIdComprobantePago(resultSet.getInt("id_comprobante_pago"));
	            ventaAux.setIdCliente(resultSet.getInt("id_cliente"));
	            ventaAux.setIdTrabajador(resultSet.getInt("id_trabajador"));
	            ventaAux.setMontoTotal(resultSet.getBigDecimal("monto_total"));
	            ventaAux.setIdMetodoPago(resultSet.getInt("id_metodo_pago"));
	            ventaAux.setDineroCliente(resultSet.getBigDecimal("dinero_cliente"));
	            ventaAux.setVueltoEfectivo(resultSet.getBigDecimal("vuelto_efectivo"));
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

	    return ventaAux;
	}

	@Override
	public List<Venta> listarVentas() {
		List<Venta> ventas = new ArrayList<>();

	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_listarVentas() }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Venta ventaAux = new Venta();
	            ventaAux.setIdVenta(resultSet.getInt("id_venta"));
	            ventaAux.setFecha(resultSet.getDate("fecha").toLocalDate());
	            ventaAux.setHora( resultSet.getTime("hora").toLocalTime());
	            ventaAux.setIdComprobantePago(resultSet.getInt("id_comprobante_pago"));
	            ventaAux.setIdCliente(resultSet.getInt("id_cliente"));
	            ventaAux.setIdTrabajador(resultSet.getInt("id_trabajador"));
	            ventaAux.setMontoTotal(resultSet.getBigDecimal("monto_total"));
	            ventaAux.setIdMetodoPago(resultSet.getInt("id_metodo_pago"));
	            ventaAux.setDineroCliente(resultSet.getBigDecimal("dinero_cliente"));
	            ventaAux.setVueltoEfectivo(resultSet.getBigDecimal("vuelto_efectivo"));
	            ventas.add(ventaAux);
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

	    return ventas;
	}

	@Override
	public int actualizarVenta(Venta ventaExistente) {
		int valor = 0;

	    Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_actualizarVenta(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        java.sql.Date sqlDate = java.sql.Date.valueOf(ventaExistente.getFecha());
	        java.sql.Time sqlTime = java.sql.Time.valueOf(ventaExistente.getHora());
	        
	        callableStatement.setInt(1, ventaExistente.getIdVenta());
	        callableStatement.setDate(2, sqlDate);
	        callableStatement.setTime(3, sqlTime);
	        callableStatement.setInt(4, ventaExistente.getIdComprobantePago());
	        callableStatement.setInt(5, ventaExistente.getIdCliente());
	        callableStatement.setInt(6, ventaExistente.getIdTrabajador());
	        callableStatement.setBigDecimal(7, ventaExistente.getMontoTotal());
	        callableStatement.setInt(8, ventaExistente.getIdMetodoPago());
	        callableStatement.setBigDecimal(9, ventaExistente.getDineroCliente());
	        callableStatement.setBigDecimal(10, ventaExistente.getVueltoEfectivo());

	        valor = callableStatement.executeUpdate();
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

	    return valor;
	}

	@Override
	public int eliminarVentaPorId(int idVenta) {
		int valor = 0;

	    Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_eliminarVenta(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        callableStatement.setInt(1, idVenta);

	        valor = callableStatement.executeUpdate();
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

	    return valor;
	}

	@Override
	public List<Venta> encontrarVentasPorCliente(int idCliente) {
		List<Venta> listaVentas = new ArrayList<>();

	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_encontrarVentasPorCliente(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        callableStatement.setInt(1, idCliente);

	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Venta venta = new Venta();
	            venta.setIdVenta(resultSet.getInt("id_venta"));
	            venta.setFecha(resultSet.getDate("fecha").toLocalDate());
	            venta.setHora(resultSet.getTime("hora").toLocalTime());
	            venta.setIdComprobantePago(resultSet.getInt("id_comprobante_pago"));
	            venta.setIdCliente(resultSet.getInt("id_cliente"));
	            venta.setIdTrabajador(resultSet.getInt("id_trabajador"));
	            venta.setMontoTotal(resultSet.getBigDecimal("monto_total"));
	            venta.setIdMetodoPago(resultSet.getInt("id_metodo_pago"));
	            venta.setDineroCliente(resultSet.getBigDecimal("dinero_cliente"));
	            venta.setVueltoEfectivo(resultSet.getBigDecimal("vuelto_efectivo"));
	            listaVentas.add(venta);
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

	    return listaVentas;
	}

	@Override
	public List<Venta> encontrarVentasPorFecha(Date fechaInicio, Date fechaFin) {
		List<Venta> listaVentas = new ArrayList<>();

	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_encontrarVentasPorFecha(?, ?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        callableStatement.setDate(1, new Date(fechaInicio.getTime()));
	        callableStatement.setDate(2, new Date(fechaFin.getTime()));

	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Venta venta = new Venta();
	            venta.setIdVenta(resultSet.getInt("id_venta"));
	            venta.setFecha(resultSet.getDate("fecha").toLocalDate());
	            venta.setHora(resultSet.getTime("hora").toLocalTime());
	            venta.setIdComprobantePago(resultSet.getInt("id_comprobante_pago"));
	            venta.setIdCliente(resultSet.getInt("id_cliente"));
	            venta.setIdTrabajador(resultSet.getInt("id_trabajador"));
	            venta.setMontoTotal(resultSet.getBigDecimal("monto_total"));
	            venta.setIdMetodoPago(resultSet.getInt("id_metodo_pago"));
	            venta.setDineroCliente(resultSet.getBigDecimal("dinero_cliente"));
	            venta.setVueltoEfectivo(resultSet.getBigDecimal("vuelto_efectivo"));
	            listaVentas.add(venta);
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

	    return listaVentas;
	}

	@Override
	public int obtenerUltimoIdVenta() {
	    int ultimoIdVenta = 0;

	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{ CALL sp_ObtenerUltimoIdVenta(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        callableStatement.registerOutParameter(1, java.sql.Types.INTEGER);

	        callableStatement.execute();

	        ultimoIdVenta = callableStatement.getInt(1);
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

	    return ultimoIdVenta;
	}
	
	/*============================ TABLA METODO PAGO ============================*/
	@Override
	public int crearMetodoPago(MetodoPago nuevoMetodoPago) {
		
		int valor = 0;

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = MySQLConnection.getConection();
            String sentenciaSQL = "INSERT INTO Metodo_Pago VALUES (null, ?)";
            preparedStatement = connection.prepareStatement(sentenciaSQL);
            preparedStatement.setString(1, nuevoMetodoPago.getNombreMetodoPago());

            valor = preparedStatement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return valor;
        
	}

	@Override
	public MetodoPago encontrarMetodoPago(int idMetodoPago) {
		
		MetodoPago metodoPagoEncontrado = null;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = MySQLConnection.getConection();
            String sentenciaSQL = "SELECT * FROM Metodo_Pago WHERE id_metodo_pago = ?";
            preparedStatement = connection.prepareStatement(sentenciaSQL);
            preparedStatement.setInt(1, idMetodoPago);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                metodoPagoEncontrado = new MetodoPago();
                metodoPagoEncontrado.setIdMetodoPago(resultSet.getInt("id_metodo_pago"));
                metodoPagoEncontrado.setNombreMetodoPago(resultSet.getString("nombre"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return metodoPagoEncontrado;
        
	}

	@Override
	public List<MetodoPago> listarMetodoPago() {
		
		List<MetodoPago> listaMetodoPago = new ArrayList<MetodoPago>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = MySQLConnection.getConection();
            String sentenciaSQL = "SELECT * FROM Metodo_Pago";
            preparedStatement = connection.prepareStatement(sentenciaSQL);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                MetodoPago metodoPago = new MetodoPago();
                metodoPago.setIdMetodoPago(resultSet.getInt("id_metodo_pago"));
                metodoPago.setNombreMetodoPago(resultSet.getString("nombre"));
                listaMetodoPago.add(metodoPago);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return listaMetodoPago;
        
	}

	@Override
	public int actualizarMetodoPago(MetodoPago metodoPagoExistente) {
		
        int valor = 0;

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = MySQLConnection.getConection();
            String sentenciaSQL = "UPDATE Metodo_Pago SET nombre = ? WHERE id_metodo_pago = ?";
            preparedStatement = connection.prepareStatement(sentenciaSQL);
            preparedStatement.setString(1, metodoPagoExistente.getNombreMetodoPago());
            preparedStatement.setInt(2, metodoPagoExistente.getIdMetodoPago());

            valor = preparedStatement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return valor;
        
	}

	@Override
	public void eliminarMetodoPago(int idMetodoPago) {
		
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = MySQLConnection.getConection();
            String sentenciaSQL = "DELETE FROM Metodo_Pago WHERE id_metodo_pago = ?";
            preparedStatement = connection.prepareStatement(sentenciaSQL);
            preparedStatement.setInt(1, idMetodoPago);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
		
	}

	/*============================ TABLA COMPROBANTE PAGO ============================*/
	@Override
	public void crearComprobantePago(ComprobantePago nuevoComprobantePago) {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "INSERT INTO Comprobante_Pago (nombre) VALUES (?)";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);

	        preparedStatement.setString(1, nuevoComprobantePago.getNombreComprobantePago());
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) preparedStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public ComprobantePago encontrarComprobantePago(int idComprobantePago) {
	    ComprobantePago comprobantePago = null;
		
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "SELECT * FROM Comprobante_Pago WHERE id_comprobante_pago = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idComprobantePago);

	        resultSet = preparedStatement.executeQuery();
	        if (resultSet.next()) {
	            comprobantePago = new ComprobantePago();
	            comprobantePago.setIdComprobantePago(resultSet.getInt("id_comprobante_pago"));
	            comprobantePago.setNombreComprobantePago(resultSet.getString("nombre"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (preparedStatement != null) preparedStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }

	    return comprobantePago;
	}

	@Override
	public List<ComprobantePago> listarComprobantePago() {
	    List<ComprobantePago> listaComprobantes = new ArrayList<>();
	    
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "SELECT * FROM Comprobante_Pago";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {
	            ComprobantePago comprobantePago = new ComprobantePago();
	            comprobantePago.setIdComprobantePago(resultSet.getInt("id_comprobante_pago"));
	            comprobantePago.setNombreComprobantePago(resultSet.getString("nombre"));
	            listaComprobantes.add(comprobantePago);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (preparedStatement != null) preparedStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }

	    return listaComprobantes;
	}

	@Override
	public void actualizarComprobantePago(ComprobantePago comprobantePagoExistente) {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "UPDATE Comprobante_Pago SET nombre = ? WHERE id_comprobante_pago = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);

	        preparedStatement.setString(1, comprobantePagoExistente.getNombreComprobantePago());
	        preparedStatement.setInt(2, comprobantePagoExistente.getIdComprobantePago());

	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) preparedStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public void eliminarComprobantePago(int idComprobantePago) {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "DELETE FROM Comprobante_Pago WHERE id_comprobante_pago = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);

	        preparedStatement.setInt(1, idComprobantePago);
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) preparedStatement.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public int obtenerMaximoBoleta() {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    int maxBoleta = 0;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_obtenerMaximoBoleta(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        callableStatement.registerOutParameter(1, java.sql.Types.INTEGER);
	        callableStatement.execute();

	        maxBoleta = callableStatement.getInt(1);
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
	    return maxBoleta;
	}

	@Override
	public int obtenerMaximoFactura() {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    int maxFactura = 0;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_obtenerMaximoFactura(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        callableStatement.registerOutParameter(1, java.sql.Types.INTEGER);
	        callableStatement.execute();

	        maxFactura = callableStatement.getInt(1);
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
	    return maxFactura;
	}

	@Override
	public List<VentasDiarias> ventasDiarias() {
		List<VentasDiarias> listaVentas = new ArrayList<>();

		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try{
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ call sp_ventasDiarias() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
	        
			while(resultSet != null && resultSet.next()) {
				VentasDiarias ventaDiaria = new VentasDiarias();
				ventaDiaria.setFechaVenta(resultSet.getDate("fecha"));
				ventaDiaria.setCantidadTotal(resultSet.getInt("cantidad_total"));
				listaVentas.add(ventaDiaria);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				 if (resultSet != null) { resultSet.close(); }
		         if (callableStatement != null) { callableStatement.close(); }
		         if (connection != null) { connection.close(); }
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return listaVentas;
	}

	@Override
	public List<Venta> montoTotalDiario() {
		List<Venta> listaVenta = new ArrayList<Venta> ();
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try{
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ call sp_montoTotalDia() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
	        
			while(resultSet != null && resultSet.next()) {
				Venta ventaDiaria = new Venta();
				ventaDiaria.setFecha(resultSet.getDate("fecha").toLocalDate());
				ventaDiaria.setMontoTotal(resultSet.getBigDecimal("total_ventas"));
				listaVenta.add(ventaDiaria);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				 if (resultSet != null) { resultSet.close(); }
		         if (callableStatement != null) { callableStatement.close(); }
		         if (connection != null) { connection.close(); }
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return listaVenta;
	}

}
