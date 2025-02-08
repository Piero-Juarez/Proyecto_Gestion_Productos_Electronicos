package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import database.MySQLConnection;
import entity.trabajador.Cargo;
import entity.trabajador.JornadaLaboral;
import entity.trabajador.Trabajador;
import interfaces.TrabajadorInterface;

public class TrabajadorModel implements TrabajadorInterface {

	/*============================ TABLA TRABAJADOR ============================*/
	@Override
	public int crearTrabajador(Trabajador nuevoTrabajador) {
	    int valor = 0;
	    
	    Connection connection = null;
	    CallableStatement callableStatement = null;

	    try {
	        connection = MySQLConnection.getConection();

	        String llamadaProcedure = "{ CALL agregarTrabajador(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";
	        callableStatement = connection.prepareCall(llamadaProcedure);

	        callableStatement.setString(1, nuevoTrabajador.getNombresTrabajador());
	        callableStatement.setString(2, nuevoTrabajador.getApellidosTrabajador());
	        callableStatement.setString(3, nuevoTrabajador.getDni());
	        callableStatement.setString(4, nuevoTrabajador.getCorreoElectronicoTrabajador());
	        callableStatement.setString(5, nuevoTrabajador.getNumeroTelefonoTrabajador());
	        callableStatement.setString(6, nuevoTrabajador.getDireccionTrabajador());
	        callableStatement.setInt(7, nuevoTrabajador.getIdCargo());
	        callableStatement.setDate(8, new java.sql.Date(nuevoTrabajador.getFechaContratacionTrabajador().getTime()));
	        callableStatement.setInt(9, nuevoTrabajador.getIdJornadaLaboral());
	        callableStatement.setDouble(10, nuevoTrabajador.getSalarioTrabajador());
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
	public Trabajador encontrarTrabajador(int idTrabajador) {
	    Trabajador trabajador = null;
	    
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String SQL = "{CALL sp_encontrarTrabajador(?)}";
	        callableStatement = connection.prepareCall(SQL);
	        callableStatement.setInt(1, idTrabajador);
	        resultSet = callableStatement.executeQuery();

	        if (resultSet.next()) {
	            trabajador = new Trabajador();
	            trabajador.setIdtrabajador(resultSet.getInt("id_trabajador"));
	            trabajador.setNombresTrabajador(resultSet.getString("nombres"));
	            trabajador.setApellidosTrabajador(resultSet.getString("apellidos"));
	            trabajador.setDni(resultSet.getString("dni"));
	            trabajador.setCorreoElectronicoTrabajador(resultSet.getString("correo_electronico"));
	            trabajador.setNumeroTelefonoTrabajador(resultSet.getString("numero_telefono"));
	            trabajador.setDireccionTrabajador(resultSet.getString("direccion"));
	            trabajador.setIdCargo(resultSet.getInt("id_cargo"));
	            trabajador.setNombreCargo(resultSet.getString("nombre_cargo"));
	            trabajador.setFechaContratacionTrabajador(resultSet.getDate("fecha_contratacion"));
	            trabajador.setIdJornadaLaboral(resultSet.getInt("id_jornada_laboral"));
	            trabajador.setNombreJornadaLaboral(resultSet.getString("nombre_jornada_laboral"));
	            trabajador.setSalarioTrabajador(resultSet.getDouble("salario"));
	            
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

	    return trabajador;
	}

	@Override
	public List<Trabajador> listarTrabajadores() {
		
	    List<Trabajador> listaTrabajadores = new ArrayList<Trabajador>();
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String SQL = "{CALL sp_listadoTrabajador()}";
	        callableStatement = connection.prepareCall(SQL);
	        resultSet = callableStatement.executeQuery();

	        while (resultSet.next()) {
	            Trabajador trabajador = new Trabajador();
	            trabajador.setIdtrabajador(resultSet.getInt("id_trabajador"));
	            trabajador.setNombresTrabajador(resultSet.getString("nombres"));
	            trabajador.setApellidosTrabajador(resultSet.getString("apellidos"));
	            trabajador.setDni(resultSet.getString("dni"));
	            trabajador.setCorreoElectronicoTrabajador(resultSet.getString("correo_electronico"));
	            trabajador.setNumeroTelefonoTrabajador(resultSet.getString("numero_telefono"));
	            trabajador.setDireccionTrabajador(resultSet.getString("direccion"));
	            trabajador.setIdCargo(resultSet.getInt("id_cargo"));
	            trabajador.setNombreCargo(resultSet.getString("nombre_cargo"));
	            trabajador.setFechaContratacionTrabajador(resultSet.getDate("fecha_contratacion"));
	            trabajador.setIdJornadaLaboral(resultSet.getInt("id_jornada_laboral"));
	            trabajador.setNombreJornadaLaboral(resultSet.getString("nombre_jornada_laboral"));
	            trabajador.setSalarioTrabajador(resultSet.getDouble("salario"));
	            listaTrabajadores.add(trabajador);

	            
	        }
	    } catch (Exception e) {
            System.out.println("error al encontrar trabajadores");

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

	    return listaTrabajadores;
	}

	@Override
	public int actualizarTrabajador(Trabajador trabajadorExistente) {
		int valor=0;
		
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    
	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "{ CALL sp_actualizarTrabajador(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";
	        callableStatement = connection.prepareCall(sentenciaSQL);
	        
	        callableStatement.setInt(1, trabajadorExistente.getIdtrabajador());
	        callableStatement.setString(2, trabajadorExistente.getNombresTrabajador());
	        callableStatement.setString(3, trabajadorExistente.getApellidosTrabajador());
	        callableStatement.setString(4, trabajadorExistente.getDni());
	        callableStatement.setString(5, trabajadorExistente.getCorreoElectronicoTrabajador());
	        callableStatement.setString(6, trabajadorExistente.getNumeroTelefonoTrabajador());
	        callableStatement.setString(7, trabajadorExistente.getDireccionTrabajador());
	        callableStatement.setInt(8, trabajadorExistente.getIdCargo());
	        callableStatement.setDouble(9, trabajadorExistente.getSalarioTrabajador());
	        callableStatement.setDate(10, new java.sql.Date(trabajadorExistente.getFechaContratacionTrabajador().getTime()));
	        callableStatement.setInt(11, trabajadorExistente.getIdJornadaLaboral());

	        valor = callableStatement.executeUpdate();
	        
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
	    
	    return valor;
	}

	@Override
	public void eliminarTrabajador(int idTrabajador) {
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "DELETE FROM Trabajador WHERE id_trabajador = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idTrabajador);
	        preparedStatement.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	        	
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	            
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	}

	/*============================ TABLA CARGO ============================*/
	@Override
	public void crearCargo(Cargo nuevoCargo) {
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "INSERT INTO Cargo (nombre_cargo) VALUES (?)";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, nuevoCargo.getNombreCargo());
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	        	
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	            
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	}

	@Override
	public Cargo encontrarCargo(int idCargo) {
	    Cargo cargo = null;
	    
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;

	    try {
	    	
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "SELECT * FROM Cargo WHERE id_cargo = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idCargo);
	        resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	            cargo = new Cargo();
	            cargo.setIdCargo(resultSet.getInt("id_cargo"));
	            cargo.setNombreCargo(resultSet.getString("nombre_cargo"));
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	        	
	            if (resultSet != null) { resultSet.close(); }
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	            
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }

	    return cargo;
	}

	@Override
	public List<Cargo> listarCargos() {
		List<Cargo> listadoCargos = new ArrayList<Cargo>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Cargo";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				Cargo cargoAux = new Cargo();
				cargoAux.setIdCargo(resultSet.getInt("id_cargo"));
				cargoAux.setNombreCargo(resultSet.getString("nombre_cargo"));
				listadoCargos.add(cargoAux);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if (resultSet != null) { resultSet.close(); }
				if (preparedStatement != null) { preparedStatement.close(); }
				if (connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return listadoCargos;
	}

	@Override
	public void actualizarCargo(Cargo cargoExistente) {
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "UPDATE Cargo SET nombre_cargo = ? WHERE id_cargo = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, cargoExistente.getNombreCargo());
	        preparedStatement.setInt(2, cargoExistente.getIdCargo());
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	}

	@Override
	public void eliminarCargo(int idCargo) {
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "DELETE FROM Cargo WHERE id_cargo = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idCargo);
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	}

	/*============================ TABLA JORNADA LABORAL ============================*/
	@Override
	public void crearJornadaLaboral(JornadaLaboral nuevaJornadaLaboral) {
		
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "INSERT INTO Jornada_Laboral (nombre_jornada_laboral) VALUES (?)";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, nuevaJornadaLaboral.getNombreJornadaLaboral());
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    
	}

	@Override
	public JornadaLaboral encontrarJornadaLaboral(int idJornadaLaboral) {
	    JornadaLaboral jornadaLaboral = null;
	    
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "SELECT * FROM Jornada_Laboral WHERE id_jornada_laboral = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idJornadaLaboral);
	        resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	            jornadaLaboral = new JornadaLaboral();
	            jornadaLaboral.setIdJornadaLaboral(resultSet.getInt("id_jornada_laboral"));
	            jornadaLaboral.setNombreJornadaLaboral(resultSet.getString("nombre_jornada_laboral"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) { resultSet.close(); }
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }

	    return jornadaLaboral;
	}

	@Override
	public List<JornadaLaboral> listarJornadaLaboral() {
		List<JornadaLaboral> listadoJornadaLaboral = new ArrayList<JornadaLaboral>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "SELECT * FROM Jornada_Laboral";
			preparedStatement = connection.prepareStatement(sentenciaSQL);
			resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				JornadaLaboral jornadaLaboralAux = new JornadaLaboral();
				jornadaLaboralAux.setIdJornadaLaboral(resultSet.getInt("id_jornada_laboral"));
				jornadaLaboralAux.setNombreJornadaLaboral(resultSet.getString("nombre_jornada_laboral"));
				listadoJornadaLaboral.add(jornadaLaboralAux);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if (resultSet != null) { resultSet.close(); }
				if (preparedStatement != null) { preparedStatement.close(); }
				if (connection != null) { connection.close(); }
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return listadoJornadaLaboral;
	}

	@Override
	public void actualizarJornadaLaboral(JornadaLaboral jornadaLaboralExistente) {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "UPDATE Jornada_Laboral SET nombre_jornada_laboral = ? WHERE id_jornada_laboral = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setString(1, jornadaLaboralExistente.getNombreJornadaLaboral());
	        preparedStatement.setInt(2, jornadaLaboralExistente.getIdJornadaLaboral());
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public void eliminarJornadaLaboral(int idJornadaLaboral) {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        connection = MySQLConnection.getConection();
	        String sentenciaSQL = "DELETE FROM Jornada_Laboral WHERE id_jornada_laboral = ?";
	        preparedStatement = connection.prepareStatement(sentenciaSQL);
	        preparedStatement.setInt(1, idJornadaLaboral);
	        preparedStatement.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null) { preparedStatement.close(); }
	            if (connection != null) { connection.close(); }
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	@Override
	public int contarTrabajadoresPorJornadaLaboral(int idJornadaLaboral) {
	    Connection connection = null;
	    CallableStatement callableStatement = null;
	    int cantidad = 0;

	    try {
	        connection = MySQLConnection.getConection();

	        String sentenciaSQL = "{CALL sp_contarTrabajadoresPorJornadaLaboral(?, ?)}";
	        callableStatement = connection.prepareCall(sentenciaSQL);

	        callableStatement.setInt(1, idJornadaLaboral);
	        callableStatement.registerOutParameter(2, Types.INTEGER);

	        callableStatement.execute();

	        cantidad = callableStatement.getInt(2);
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
	    return cantidad;
	}

	@Override
	public List<Trabajador> TrabajadoresConMasVentas() {
		List<Trabajador> listaTrabajadoresVentas = new ArrayList<Trabajador>();

		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try{
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{ call sp_trabajadoresMasVentas() }";
			callableStatement = connection.prepareCall(sentenciaSQL);
			
			resultSet = callableStatement.executeQuery();
			
			while(resultSet != null && resultSet.next()) {
				Trabajador trabajadorVentas = new Trabajador();
				trabajadorVentas.setNombresTrabajador(resultSet.getString("nombres"));
				trabajadorVentas.setVentasTrabajador(resultSet.getInt("total_ventas"));
				listaTrabajadoresVentas.add(trabajadorVentas);
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
		
		return listaTrabajadoresVentas;
	}

}
