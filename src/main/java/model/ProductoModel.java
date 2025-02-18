package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import database.MySQLConnection;
import entity.producto.Categoria;
import entity.producto.EstadoProducto;
import entity.producto.Marca;
import entity.producto.Producto;
import entity.producto.Proveedor;
import interfaces.ProductoInterface;

public class ProductoModel implements ProductoInterface {

	/*============================ TABLA PRODUCTO ============================*/
	@Override
	public void crearProducto(Producto nuevoProducto) {
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_agregarNuevoProducto(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			callableStatement.setString(1, nuevoProducto.getNombreProducto());
			callableStatement.setString(2, nuevoProducto.getModeloProducto());
			callableStatement.setString(3, nuevoProducto.getSkuProducto());
			callableStatement.setInt(4, nuevoProducto.getIdCategoria());
			callableStatement.setInt(5, nuevoProducto.getIdMarca());
			callableStatement.setString(6, nuevoProducto.getDetallesProducto());
			callableStatement.setDouble(7, nuevoProducto.getPrecioProducto());
			callableStatement.setInt(8, nuevoProducto.getStockProducto());
			callableStatement.setInt(9, nuevoProducto.getStockMinimoProducto());
			callableStatement.setInt(10, nuevoProducto.getIdProveedor());
			callableStatement.setDouble(11, nuevoProducto.getPesoProducto());
			callableStatement.setString(12, nuevoProducto.getDimensionesProducto());
			callableStatement.setString(13, nuevoProducto.getGarantiaProducto());
			callableStatement.setInt(14, nuevoProducto.getIdEstadoProducto());
			callableStatement.setDate(15, (Date) nuevoProducto.getFechaIncorporacionProducto());
			callableStatement.setString(16, nuevoProducto.getColorProducto());
			callableStatement.setString(17, nuevoProducto.getImagenProducto());
			
			callableStatement.execute();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if (callableStatement != null) { callableStatement.close(); }
				if (connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	@Override
	public Producto encontrarProducto(int idProducto) {
		Producto productoObtenido = null;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_encontrarProductoPorId(?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idProducto);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet.next()) {
				productoObtenido = new Producto();
				
				productoObtenido.setIdProducto(resultSet.getInt("id_producto"));
				productoObtenido.setNombreProducto(resultSet.getString("nombre_producto"));
	            productoObtenido.setModeloProducto(resultSet.getString("modelo"));
	            productoObtenido.setSkuProducto(resultSet.getString("sku"));
	            productoObtenido.setIdCategoria(resultSet.getInt("id_categoria"));
	            productoObtenido.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            productoObtenido.setIdMarca(resultSet.getInt("id_marca"));
	            productoObtenido.setNombreMarca(resultSet.getString("nombre_marca"));
	            productoObtenido.setDetallesProducto(resultSet.getString("detalles"));
	            productoObtenido.setPrecioProducto(resultSet.getDouble("precio"));
	            productoObtenido.setStockProducto(resultSet.getInt("stock"));
	            productoObtenido.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            productoObtenido.setIdProveedor(resultSet.getInt("id_proveedor"));
	            productoObtenido.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            productoObtenido.setPesoProducto(resultSet.getDouble("peso"));
	            productoObtenido.setDimensionesProducto(resultSet.getString("dimensiones"));
	            productoObtenido.setGarantiaProducto(resultSet.getString("garantia"));
	            productoObtenido.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            productoObtenido.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            productoObtenido.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            productoObtenido.setColorProducto(resultSet.getString("color_producto"));
	            productoObtenido.setImagenProducto(resultSet.getString("imagen_producto"));
				
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
		
		return productoObtenido;
	}

	@Override
	public List<Producto> listarProductos() {
		List<Producto> listadoProductos = new ArrayList<Producto>();
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_listadoProductos() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet != null && resultSet.next()) {
				Producto productoAux = new Producto();
				
				productoAux.setIdProducto(resultSet.getInt("id_producto"));
				productoAux.setNombreProducto(resultSet.getString("nombre_producto"));
				productoAux.setModeloProducto(resultSet.getString("modelo"));
				productoAux.setSkuProducto(resultSet.getString("sku"));
				productoAux.setIdCategoria(resultSet.getInt("id_categoria"));
				productoAux.setNombreCategoria(resultSet.getString("nombre_categoria"));
				productoAux.setIdMarca(resultSet.getInt("id_marca"));
				productoAux.setNombreMarca(resultSet.getString("nombre_marca"));
				productoAux.setDetallesProducto(resultSet.getString("detalles"));
				productoAux.setPrecioProducto(resultSet.getDouble("precio"));
				productoAux.setStockProducto(resultSet.getInt("stock"));
				productoAux.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            productoAux.setIdProveedor(resultSet.getInt("id_proveedor"));
	            productoAux.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            productoAux.setPesoProducto(resultSet.getDouble("peso"));
	            productoAux.setDimensionesProducto(resultSet.getString("dimensiones"));
	            productoAux.setGarantiaProducto(resultSet.getString("garantia"));
	            productoAux.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            productoAux.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            productoAux.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            productoAux.setColorProducto(resultSet.getString("color_producto"));
	            productoAux.setImagenProducto(resultSet.getString("imagen_producto"));
				
	            listadoProductos.add(productoAux);
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

		return listadoProductos;
	}

	@Override
	public void actualizarProducto(Producto productoExistente) {
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_actualizarProducto(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			// Setear parámetros del procedimiento
	        callableStatement.setInt(1, productoExistente.getIdProducto());
	        callableStatement.setString(2, productoExistente.getNombreProducto());
	        callableStatement.setString(3, productoExistente.getModeloProducto());
	        callableStatement.setString(4, productoExistente.getSkuProducto());
	        callableStatement.setInt(5, productoExistente.getIdCategoria());
	        callableStatement.setInt(6, productoExistente.getIdMarca());
	        callableStatement.setString(7, productoExistente.getDetallesProducto());
	        callableStatement.setDouble(8, productoExistente.getPrecioProducto());
	        callableStatement.setInt(9, productoExistente.getStockProducto());
	        callableStatement.setInt(10, productoExistente.getStockMinimoProducto());
	        callableStatement.setInt(11, productoExistente.getIdProveedor());
	        callableStatement.setDouble(12, productoExistente.getPesoProducto());
	        callableStatement.setString(13, productoExistente.getDimensionesProducto());
	        callableStatement.setString(14, productoExistente.getGarantiaProducto());
	        callableStatement.setInt(15, productoExistente.getIdEstadoProducto());
	        callableStatement.setDate(16, (Date) productoExistente.getFechaIncorporacionProducto());
	        callableStatement.setString(17, productoExistente.getColorProducto());
	        callableStatement.setString(18, productoExistente.getImagenProducto());

	        // Ejecutar el procedimiento
	        callableStatement.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
	            if (callableStatement != null) { callableStatement.close(); }
	            if (connection != null) { connection.close(); }
	            
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	@Override
	public void eliminarProducto(int idProducto) {
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_eliminarProductoPorId(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        callableStatement.setInt(1, idProducto);

	        callableStatement.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
	            if (callableStatement != null) { callableStatement.close(); }
	            if (connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
	
	@Override
	public int cantidadStockProductoSegunId(int idProducto) {
		
	    int stock = 0;
	    
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    
	    try {

	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_obtenerStockPorId(?, ?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        
	        callableStatement.setInt(1, idProducto);
	        callableStatement.registerOutParameter(2, java.sql.Types.INTEGER);
	        callableStatement.execute();
	        
	        stock = callableStatement.getInt(2);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (callableStatement != null) { callableStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	    return stock;
	    
	}

	@Override
	public void descontarStockPorId(int idProducto, int stockDescontado) {
	    Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	    	connection = MySQLConnection.getConection();
	    	String sentenciaSQL = "{CALL descontarStockPorId(?, ?)}";
	    	callableStatement = connection.prepareCall(sentenciaSQL);
	    	callableStatement.setInt(1, idProducto);
	    	callableStatement.setInt(2, stockDescontado);
	        callableStatement.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (callableStatement != null) { callableStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	}
	
	/*============================ TABLA CATEGORIA ============================*/
	@Override
	public int crearCategoria(Categoria nuevaCategoria) {
	 	int valor = 0;
	 	
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    try {
	    	
			connection= MySQLConnection.getConection();
	        String sentenciaSQL = "INSERT INTO Categoria VALUES (null,?)";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
	        
			preparedStatement.setString(1, nuevaCategoria.getNombreCategoria());                 			
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
	public Categoria encontrarCategoria(int idCategoria) {
		Categoria encontrarCategoria = null;
		
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
        	
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Categoria WHERE id_categoria = ?";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			preparedStatement.setInt(1, idCategoria);
			resultSet= preparedStatement.executeQuery();

			if (resultSet.next()) {
				encontrarCategoria = new Categoria();
				encontrarCategoria.setIdCategoria(resultSet.getInt("id_categoria"));
				encontrarCategoria.setNombreCategoria(resultSet.getString("nombre_categoria"));
            }
        
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error en buscar "+e.getMessage());
        } finally {
            try {
            	
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return encontrarCategoria; 
	}

	@Override
	public List<Categoria> listarCategorias() {
		List<Categoria> listaCategorias = new ArrayList<Categoria>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

			try {
				
				connection= MySQLConnection.getConection();
				String sentenciaSQL = "SELECT*FROM Categoria";
				preparedStatement = connection.prepareStatement(sentenciaSQL);
				resultSet= preparedStatement.executeQuery();

				while (resultSet.next()) {
					Categoria categoria = new Categoria();
					categoria.setIdCategoria(resultSet.getInt("id_categoria"));
					categoria.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            	listaCategorias.add(categoria);
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
			
			return listaCategorias;
	}

	@Override
	public int actualizarCategoria(Categoria categoriaExistente) {
		 int resultSet = 0;
		 Connection connection = null;
		 PreparedStatement preparedStatement = null;
		 
		 try {	
			 
			 connection = MySQLConnection.getConection();
		     String sentenciaSQL = "UPDATE Categoria SET "
		    		 + "nombre_categoria = ? "
		    		 + "WHERE id_categoria = ?";
		     
		     preparedStatement = connection.prepareStatement(sentenciaSQL);
		     preparedStatement.setString(1, categoriaExistente.getNombreCategoria());
		     preparedStatement.setInt(2, categoriaExistente.getIdCategoria());
		     resultSet = preparedStatement.executeUpdate();
		    
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
		 
		 return resultSet;
	}

	@Override
	public void eliminarCategoria(int idCategoria) {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

	    try {
	    	
	        connection = MySQLConnection.getConection(); 
	    	String sql = "DELETE FROM Categoria WHERE id_categoria = ?";
	    	preparedStatement = connection.prepareStatement(sql) ;
	    	preparedStatement.setInt(1, idCategoria);
	    	preparedStatement.executeUpdate();
	    
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
            try {
            	
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
	    
	}

	@Override
	public int contarProductosPorCategoria(int idCategoria) {
		int cantidad = 0;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_contarProductosPorCategoria(?, ?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idCategoria);
			callableStatement.registerOutParameter(2, Types.INTEGER);
			callableStatement.execute();
			
			cantidad = callableStatement.getInt(2);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if(callableStatement != null) { callableStatement.close(); }
				if(connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return cantidad;
	}
	
	/*============================ TABLA ESTADO PRODUCTO ============================*/
	@Override
	public int crearEstadoProducto(EstadoProducto nuevoEstadoProducto) {
		int valor = 0;
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "INSERT INTO Estado_Producto VALUES (null, ?)";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, nuevoEstadoProducto.getNombreEstadoProducto());
	        
	        valor = preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("Error en registrar estado de producto: " + e.getMessage());
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
	public EstadoProducto encontrarEstadoProducto(int idEstadoProducto) {
		EstadoProducto encontrarEstadoProducto = null;
		
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
        	
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Estado_Producto WHERE id_estado_producto=?";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			preparedStatement.setInt(1, idEstadoProducto);
			resultSet= preparedStatement.executeQuery();

			if (resultSet.next()) {
				encontrarEstadoProducto = new EstadoProducto();
				encontrarEstadoProducto.setIdEstadoProducto  (resultSet.getInt("id_estado_producto"));
				encontrarEstadoProducto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
            }
			
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error en buscar "+e.getMessage());
        } finally {
         
            try {
            	
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
                
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error al cerrar "+e.getMessage());
            }
        }
        
        return encontrarEstadoProducto; 
	}

	@Override
	public List<EstadoProducto> listarEstadoProducto() {
		List<EstadoProducto> listaEstadoProducto = new ArrayList<EstadoProducto>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT*FROM Estado_Producto";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			resultSet= preparedStatement.executeQuery();

	        while (resultSet.next()) {
	            EstadoProducto estadoproducto = new EstadoProducto();
	            estadoproducto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            estadoproducto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));	           
	            listaEstadoProducto.add(estadoproducto);
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
			
		return listaEstadoProducto;
	}

	@Override
	public int actualizarEstadoProducto(EstadoProducto estadoProductoExistente) {
		int resultSet = 0;
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    try {
	        
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "UPDATE Estado_Producto SET "
	            + "nombre_estado_producto = ? "
	            + "WHERE id_estado_producto = ?";
	        
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, estadoProductoExistente.getNombreEstadoProducto());
	        preparedStatement.setInt(2, estadoProductoExistente.getIdEstadoProducto());
	        resultSet = preparedStatement.executeUpdate();
	        
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
	    
	    return resultSet;
	}

	@Override
	public void eliminarEstadoProducto(int idEstadoProducto) {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
	    try {
	    	
	    	connection = MySQLConnection.getConection();
	    	String sentenciaSQL = "DELETE FROM Estado_Producto WHERE id_estado_producto= ?";
	    	preparedStatement = connection.prepareStatement(sentenciaSQL) ;  				
	    	preparedStatement.setInt(1, idEstadoProducto);
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

	@Override
	public int contarProductosPorEstadoProducto(int idEstadoProducto) {
		int cantidad = 0;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_contarProductosPorEstadoProducto(?, ?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idEstadoProducto);
			callableStatement.registerOutParameter(2, Types.INTEGER);
			callableStatement.execute();
			
			cantidad = callableStatement.getInt(2);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if(callableStatement != null) { callableStatement.close(); }
				if(connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return cantidad;
	}
	
	/*============================ TABLA MARCA ============================*/
	@Override
	public int crearMarca(Marca nuevaMarca) {
		 int valor = 0;
		 
		 Connection connection = null;
		 PreparedStatement preparedStatement = null;

		 try {
			 
			 connection = MySQLConnection.getConection();
			 String sentenciaSQL = "INSERT INTO Marca VALUES (null, ?)";
			 preparedStatement = connection.prepareStatement(sentenciaSQL);
			 preparedStatement.setString(1, nuevaMarca.getNombreMarca());
			 valor = preparedStatement.executeUpdate();
			 
		 } catch (Exception e) {
			 System.out.println("Error en registrar marca: " + e.getMessage());
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
	public Marca encontrarMarca(int idMarca) {
		Marca encontrarMarca = null;
		
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
        	
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Marca WHERE id_marca=?";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			preparedStatement.setInt(1, idMarca);
			resultSet= preparedStatement.executeQuery();

			if (resultSet.next()) {
				encontrarMarca = new Marca();
				encontrarMarca.setIdMarca(resultSet.getInt("id_marca"));
				encontrarMarca.setNombreMarca(resultSet.getString("nombre_marca"));
            }
			
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error en buscar "+e.getMessage());
        } finally {
         
            try {
            	
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
                
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error al cerrar "+e.getMessage());
            }
        }
        
        return encontrarMarca; 
	}

	@Override
	public List<Marca> listarMarcas() {
		List<Marca> listaMarcas = new ArrayList<Marca>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT*FROM Marca";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			resultSet= preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				Marca marca = new Marca();
				marca.setIdMarca(resultSet.getInt("id_marca"));
				marca.setNombreMarca(resultSet.getString("nombre_marca"));
				listaMarcas.add(marca);
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
		
		return listaMarcas;
	}

	@Override
	public int actualizarMarca(Marca marcaExistente) {
		int resultSet = 0;
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "UPDATE Marca SET "
	            + "nombre_marca = ? "
	            + "WHERE id_marca = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, marcaExistente.getNombreMarca());
	        preparedStatement.setInt(2, marcaExistente.getIdMarca());
	        resultSet = preparedStatement.executeUpdate();
	        
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
	    
	    return resultSet;
	}

	@Override
	public void eliminarMarca(int idMarca) {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
	    try {
	    	
	    	connection =  MySQLConnection.getConection();
			String sql = "DELETE FROM marca WHERE id_marca = ?";
	    	preparedStatement = connection.prepareStatement(sql);
	    	
	    	preparedStatement.setInt(1, idMarca);
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

	@Override
	public int contarProductosPorMarca(int idMarca) {
		int cantidad = 0;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_contarProductosPorMarca(?, ?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idMarca);
			callableStatement.registerOutParameter(2, Types.INTEGER);
			callableStatement.execute();
			
			cantidad = callableStatement.getInt(2);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if(callableStatement != null) { callableStatement.close(); }
				if(connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return cantidad;
	}
	
	/*============================ TABLA PROVEEDOR ============================*/
	@Override
	public int crearProveedor(Proveedor nuevoProveedor) {
		
		int valor = 0;
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "INSERT INTO Proveedor VALUES (null, ?)"; 
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, nuevoProveedor.getNombreProveedor());
	        valor = preparedStatement.executeUpdate();
	        
	    } catch (Exception e) {
	        System.out.println("Error en registrar proveedor: " + e.getMessage());
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
	public Proveedor encontrarProveedor(int idProveedor) {
		Proveedor encontrarProveedor = null;
		
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
        	
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Proveedor WHERE id_proveedor=?";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			preparedStatement.setInt(1, idProveedor);
			resultSet= preparedStatement.executeQuery();

			if (resultSet.next()) {
				encontrarProveedor = new Proveedor();
				encontrarProveedor.setIdProveedor(resultSet.getInt("id_proveedor"));
				encontrarProveedor.setNombreProveedor(resultSet.getString("nombre_proveedor"));
            }
			
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error en buscar "+e.getMessage());
        } finally {
         
            try {
            	
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
                
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error al cerrar "+e.getMessage());
            }
        }

        return encontrarProveedor;
	}

	@Override
	public List<Proveedor> listarProveedores() {
		List<Proveedor> listaProveedores = new ArrayList<Proveedor>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection= MySQLConnection.getConection();
			String sentenciaSQL = "SELECT*FROM Proveedor";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			resultSet= preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				Proveedor proveedor = new Proveedor();
				proveedor.setIdProveedor(resultSet.getInt("id_proveedor"));
				proveedor.setNombreProveedor(resultSet.getString("nombre_proveedor"));
				listaProveedores.add(proveedor);
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
		
		return listaProveedores;
	}

	@Override
	public int actualizarProveedor(Proveedor proveedorExistente) {
		
		int resultSet = 0;
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "UPDATE Proveedor SET "
	            + "nombre_proveedor = ? "
	            + "WHERE id_proveedor = ?";
	        
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, proveedorExistente.getNombreProveedor());
	        preparedStatement.setInt(2, proveedorExistente.getIdProveedor());
	        resultSet = preparedStatement.executeUpdate();
	        
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
	    
	    return resultSet;
	}

	@Override
	public void eliminarProveedor(int idProveedor) {
		
		Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "DELETE FROM Proveedor WHERE id_proveedor=?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idProveedor);
	        preparedStatement.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("Error en eliminar proveedor: " + e.getMessage());
	    } finally {
	        try {
	        	
	            if (preparedStatement != null) preparedStatement.close();
	            if (connection != null) connection.close();
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	}

	@Override
	public int contarProductosPorProveedor(int idProveedor) {
		int cantidad = 0;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_contarProductosPorProveedor(?, ?) }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idProveedor);
			callableStatement.registerOutParameter(2, Types.INTEGER);
			callableStatement.execute();
			
			cantidad = callableStatement.getInt(2);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if(callableStatement != null) { callableStatement.close(); }
				if(connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return cantidad;
	}

	@Override
	public List<Producto> obtenerProductosMasVendidos() {
		List<Producto> listaProducto = new ArrayList<Producto>();
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try{
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ call sp_obtenerProductosMasVendidos() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while(resultSet != null && resultSet.next()) {
				Producto productoVendido = new Producto();
				productoVendido.setIdProducto(resultSet.getInt("id_producto"));
				productoVendido.setNombreProducto(resultSet.getString("nombre_producto"));
				productoVendido.setCantidadesVendidas(resultSet.getInt("total_vendido"));
				listaProducto.add(productoVendido);
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
		
		return listaProducto;
	}

	@Override
	public List<Producto> cantidadProductosExistentes() {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosDisponibles() }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	@Override
	public List<Producto> cantidadProductosBajoStock() {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosStockMinimo() }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        // Ejecutar la consulta
	        resultSet = callableStatement.executeQuery();

	        // Procesar los resultados
	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	@Override
	public List<Producto> cantidadProductosSinStock() {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosSinStock() }";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	@Override
	public List<Producto> listarProductosPorIdCategoria(int idCategoria) {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosPorIdCategoria(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idCategoria);
	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	@Override
	public List<Producto> listarProductosPorIdMarca(int idMarca) {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosPorIdMarca(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idMarca);
	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	@Override
	public List<Producto> listarProductosPorIdProveedor(int idProveedor) {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosPorIdProveedor(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idProveedor);
	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	@Override
	public List<Producto> listarProductosPorIdEstadoProducto(int idEstadoProducto) {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;
	    List<Producto> productos = new ArrayList<>();

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_listarProductosPorIdEstadoProducto(?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setInt(1, idEstadoProducto);
	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Producto producto = new Producto();
	            producto.setIdProducto(resultSet.getInt("id_producto"));
	            producto.setNombreProducto(resultSet.getString("nombre_producto"));
	            producto.setModeloProducto(resultSet.getString("modelo"));
	            producto.setSkuProducto(resultSet.getString("sku"));
	            producto.setIdCategoria(resultSet.getInt("id_categoria"));
	            producto.setNombreCategoria(resultSet.getString("nombre_categoria"));
	            producto.setIdMarca(resultSet.getInt("id_marca"));
	            producto.setNombreMarca(resultSet.getString("nombre_marca"));
	            producto.setDetallesProducto(resultSet.getString("detalles"));
	            producto.setPrecioProducto(resultSet.getDouble("precio"));
	            producto.setStockProducto(resultSet.getInt("stock"));
	            producto.setStockMinimoProducto(resultSet.getInt("stock_minimo"));
	            producto.setIdProveedor(resultSet.getInt("id_proveedor"));
	            producto.setNombreProveedor(resultSet.getString("nombre_proveedor"));
	            producto.setPesoProducto(resultSet.getDouble("peso"));
	            producto.setDimensionesProducto(resultSet.getString("dimensiones"));
	            producto.setGarantiaProducto(resultSet.getString("garantia"));
	            producto.setIdEstadoProducto(resultSet.getInt("id_estado_producto"));
	            producto.setNombreEstadoProducto(resultSet.getString("nombre_estado_producto"));
	            producto.setFechaIncorporacionProducto(resultSet.getDate("fecha_incorporacion"));
	            producto.setColorProducto(resultSet.getString("color_producto"));
	            producto.setImagenProducto(resultSet.getString("imagen_producto"));

	            productos.add(producto);
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

	    return productos;
	}

	// SI DA ALGÚN TIPO DE RROR FUERTE CAMBIAR A VENTAMODEL
	@Override
	public List<Producto> listarProductosPorCategoria() {
		List<Producto> lista = new ArrayList<Producto>();
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_productos_vendidos_categoria() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet != null && resultSet.next()) {
				Producto productoAux = new Producto();
				
				productoAux.setNombreCategoria(resultSet.getString("nombre_categoria"));
				productoAux.setStockProducto(resultSet.getInt("suma_total"));
		
				lista.add(productoAux);
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
		
		return lista;
	}

	@Override
	public List<Producto> listarStockProducto() {
		List<Producto> listaStockProducto = new ArrayList<Producto>();
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_productos_stock() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet != null && resultSet.next()) {
				Producto productoAux = new Producto();
				
				
				productoAux.setNombreProducto(resultSet.getString("nombre_producto"));
				productoAux.setStockProducto(resultSet.getInt("stock"));
		
	            listaStockProducto.add(productoAux);
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
		
		return listaStockProducto;
	}

	@Override
	public List<Producto> listarProductosMasIngresos() {
		List<Producto> lista = new ArrayList<Producto>();
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_productos_generan_mas_ingresos() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet != null && resultSet.next()) {
				Producto productoAux = new Producto();
				
				productoAux.setNombreProducto(resultSet.getString("nombre_producto"));
				productoAux.setPrecioProducto(resultSet.getDouble("monto_total"));
				lista.add(productoAux);
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
		
		return lista;
	}

	@Override
	public List<Producto> listarCantidadProductosPorCategoria() {
		List<Producto> productoPorCategoria = new ArrayList<Producto>();
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ CALL sp_cantidad_productos_categoria() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while (resultSet != null && resultSet.next()) {
				Producto productoAux = new Producto();
				
				
				productoAux.setNombreCategoria(resultSet.getString("nombre_categoria"));
				productoAux.setStockProducto(resultSet.getInt("Cantidad"));
				productoPorCategoria.add(productoAux);
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
		
		return productoPorCategoria;
	}

}
