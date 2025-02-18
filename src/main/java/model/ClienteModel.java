package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.MySQLConnection;
import entity.cliente.Cliente;
import entity.cliente.ClienteDocumento;
import entity.producto.Producto;
import entity.venta.MetodoPagoPreferido;
import interfaces.ClienteInterface;

public class ClienteModel implements ClienteInterface {

	@Override
	public void crearCliente(Cliente nuevoCliente) {
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			 connection = MySQLConnection.getConection();
		     String sentenciaSQL = "{CALL sp_agregarCliente(?,?,?,?,?,?,?)}";

		    callableStatement = connection.prepareCall(sentenciaSQL);

		    callableStatement.setString(1, nuevoCliente.getNombreCliente());
		    callableStatement.setString(2, nuevoCliente.getApellidoCliente());
		    callableStatement.setString(3, nuevoCliente.getDniCliente());
		    callableStatement.setString(4, nuevoCliente.getRazonSocialCliente());
		    callableStatement.setString(5, nuevoCliente.getNombreComercialCliente());
		    callableStatement.setString(6, nuevoCliente.getDireccionFiscalCliente());
		    callableStatement.setString(7, nuevoCliente.getRucCliente());

		    callableStatement.execute();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(callableStatement != null) {callableStatement.close();}
				if(connection != null) {connection.close();}
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	@Override
	public Cliente encontrarCliente(int idCliente) {
		Cliente cliente = null;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;

		    try {
		    	 	connection = MySQLConnection.getConection();
			        String sentenciaSQL = "{CALL sp_encontrarClientePorID(?)}";
			        callableStatement = connection.prepareCall(sentenciaSQL);
			        callableStatement.setInt(1, idCliente);
			        resultSet = callableStatement.executeQuery();
			        
			       if(resultSet.next()) {
			    	   cliente = new Cliente();
			           cliente.setIdCliente(resultSet.getInt("id_cliente"));
			           cliente.setNombreCliente(resultSet.getString("nombre"));
			           cliente.setApellidoCliente(resultSet.getString("apellido"));
			           cliente.setDniCliente(resultSet.getString("dni"));
			           cliente.setRazonSocialCliente(resultSet.getString("razon_social"));
			           cliente.setNombreComercialCliente(resultSet.getString("nombre_comercial"));
			           cliente.setDireccionFiscalCliente(resultSet.getString("direccion_fiscal"));
			           cliente.setRucCliente(resultSet.getString("ruc"));
			       }
			       
		    } catch (Exception e) {
		    	e.printStackTrace();
		    } finally {
				try {
					
					if (resultSet != null) { resultSet.close(); }
		            if (callableStatement != null) { callableStatement.close(); }
		            if (connection != null) { connection.close(); }
					
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		    
		return cliente;
	}

	@Override
	public List<Cliente> listarClientes() {
		List<Cliente> listaCliente = new ArrayList<Cliente>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Cliente";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			resultSet= preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				Cliente cliente = new Cliente();
				cliente.setIdCliente(resultSet.getInt("id_cliente"));
				cliente.setNombreCliente(resultSet.getString("nombre"));
				cliente.setApellidoCliente(resultSet.getString("apellido"));
				cliente.setDniCliente(resultSet.getString("dni"));
				cliente.setRazonSocialCliente(resultSet.getString("razon_social"));
				cliente.setNombreComercialCliente(resultSet.getString("nombre_comercial"));
				cliente.setDireccionFiscalCliente(resultSet.getString("direccion_fiscal"));
				cliente.setRucCliente(resultSet.getString("ruc"));
				
				listaCliente.add(cliente);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				
				if(resultSet != null) { resultSet.close(); }
				if(preparedStatement != null) { preparedStatement.close(); }
				if(connection != null) { connection.close(); }
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return listaCliente;
	}

	@Override
	public int actualizarCliente(Cliente clienteExistente) {
		int valor=0;
		
		 Connection connection = null;
		 CallableStatement callableStatement = null;
		 
		 try {
			 
			 connection = MySQLConnection.getConection();
		     String sentenciaSQL = "{ CALL sp_actualizarCliente(?, ?, ?, ?, ?, ?, ?, ?) }";
		     callableStatement = connection.prepareCall(sentenciaSQL);
		     
		     callableStatement.setInt(1, clienteExistente.getIdCliente());
		     callableStatement.setString(2, clienteExistente.getNombreCliente());
		     callableStatement.setString(3, clienteExistente.getApellidoCliente());
		     callableStatement.setString(4, clienteExistente.getDniCliente());
		     callableStatement.setString(5, clienteExistente.getRazonSocialCliente());
		     callableStatement.setString(6, clienteExistente.getNombreComercialCliente());
		     callableStatement.setString(7, clienteExistente.getDireccionFiscalCliente());
		     callableStatement.setString(8, clienteExistente.getRucCliente());
		 	
		     valor = callableStatement.executeUpdate();
		     
		 }catch(Exception e) {
			e.printStackTrace();
		 } finally {
			 try {
		        	
				 if (callableStatement != null) { callableStatement.close(); }
				 if (connection != null) { connection.close(); }
		            
			 } catch (Exception e2) {e2.printStackTrace();}
		 }
		 
		 return valor;
	}

	@Override
	public void eliminarCliente(int idCliente) {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			 connection = MySQLConnection.getConection();
		     String sentenciaSQL = "DELETE FROM Cliente WHERE id_cliente = ?";
		     preparedStatement = connection.prepareStatement(sentenciaSQL);
		        preparedStatement.setInt(1, idCliente);
		        preparedStatement.executeUpdate();
		}catch(Exception e) {
			 e.printStackTrace();
		}finally {
	        try {
	        	
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	            
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
		
	}

	@Override
	public Cliente encontrarClientePorDNI(String DNICliente) {
		
	    Cliente encontrarCliente = null;
	    
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    
	    try {
	        
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_encontrarClientePorDni(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        callableStatement.setString(1, DNICliente);
	        
	        resultSet = callableStatement.executeQuery();
	        
	        if (resultSet.next()) {
	            encontrarCliente = new Cliente();
	            encontrarCliente.setIdCliente(resultSet.getInt("id_cliente"));
	            encontrarCliente.setNombreCliente(resultSet.getString("nombre"));
	            encontrarCliente.setApellidoCliente(resultSet.getString("apellido"));
	            encontrarCliente.setDniCliente(resultSet.getString("dni"));
	            encontrarCliente.setRazonSocialCliente(resultSet.getString("razon_social"));
	            encontrarCliente.setNombreComercialCliente(resultSet.getString("nombre_comercial"));
	            encontrarCliente.setDireccionFiscalCliente(resultSet.getString("direccion_fiscal"));
	            encontrarCliente.setRucCliente(resultSet.getString("ruc"));
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) { resultSet.close(); }
	            if (callableStatement != null) { callableStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    return encontrarCliente;
	    
	}

	@Override
	public Cliente encontrarClientePorRUC(String RucCliente) {
	    Cliente cliente = null;
	    
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "CALL sp_encontrarClientePorRuc(?)";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);

	        preparedStatement.setString(1, RucCliente);
	        resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	            cliente = new Cliente();
	            cliente.setIdCliente(resultSet.getInt("id_cliente"));
	            cliente.setNombreCliente(resultSet.getString("nombre"));
	            cliente.setApellidoCliente(resultSet.getString("apellido"));
	            cliente.setDniCliente(resultSet.getString("dni"));
	            cliente.setRazonSocialCliente(resultSet.getString("razon_social"));
	            cliente.setNombreComercialCliente(resultSet.getString("nombre_comercial"));
	            cliente.setDireccionFiscalCliente(resultSet.getString("direccion_fiscal"));
	            cliente.setRucCliente(resultSet.getString("ruc"));
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
	    
	    return cliente;
	}

	@Override
	public List<Producto> listaProductosCompraCliente(int idCliente) {
		List<Producto> listaDeCompra = new ArrayList<Producto>();
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		try {
			connection = MySQLConnection.getConection();
			connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{CALL sp_comprasRealizadasCliente(?)}";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        callableStatement.setInt(1,idCliente);
	        resultSet = callableStatement.executeQuery();
	        
			while(resultSet != null && resultSet.next()) {
				Producto compras = new Producto();
				compras.setNombreProducto(resultSet.getString("nombre_producto"));
				compras.setStockProducto(resultSet.getInt("total_cantidad"));
				listaDeCompra.add(compras);
	        }
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(resultSet != null) { resultSet.close(); }
				if(callableStatement != null) { callableStatement.close(); }
				if(connection != null) { connection.close(); }
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return listaDeCompra;
	}

	@Override
	public List<Cliente> listaClienteMasCompras() {
		List<Cliente> listaMasUnidades = new ArrayList<Cliente>();
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try{
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ call sp_clientesConMasCompras() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while(resultSet != null && resultSet.next()) {
				Cliente clienteCompras = new Cliente();
				clienteCompras.setNombreCliente(resultSet.getString("nombre"));
				clienteCompras.setApellidoCliente(resultSet.getString("apellido"));
				clienteCompras.setTotalUnidadesCompra(resultSet.getInt("total_productos"));
				clienteCompras.setTotalDineroGastado(resultSet.getDouble("total_compras"));
				listaMasUnidades.add(clienteCompras);
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
		
		return listaMasUnidades	;
	}

	@Override
	public List<ClienteDocumento> listaCantidadClienteSegunDocumento() {
		List<ClienteDocumento> lista = new ArrayList<ClienteDocumento>();
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try{
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ call sp_distribucionClientesPorDocumento() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while(resultSet != null && resultSet.next()) {
				ClienteDocumento clienteDocumento = new ClienteDocumento();
				clienteDocumento.setTipoDocumento(resultSet.getString("tipo_documento"));
				clienteDocumento.setContadorClienteDocumento(resultSet.getInt("cantidad_clientes"));
				lista.add(clienteDocumento);
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
		
		return lista;
	}

	@Override
	public List<MetodoPagoPreferido> metodoPagoPreferidoCliente() {
		List<MetodoPagoPreferido> metodoPagoPreferido = new ArrayList <MetodoPagoPreferido>();
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_preferencia_pago() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet != null && resultSet.next()) {
				MetodoPagoPreferido productoAux = new MetodoPagoPreferido();
				
				productoAux.setNombreMetodoPago(resultSet.getString("nombre"));
				productoAux.setContadorMetodoPago(resultSet.getInt("metodo_pago"));
				metodoPagoPreferido.add(productoAux);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
	            if (resultSet != null) { resultSet.close(); }
	            if (callableStatement != null) { callableStatement.close(); }
	            if (connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return metodoPagoPreferido;
	}

}
