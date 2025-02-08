package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import database.MySQLConnection;
import entity.usuarioRegistrado.UsuarioRegistrado;
import interfaces.UsuarioRegistradoInterface;

public class UsuarioRegistradoModel implements UsuarioRegistradoInterface {

	@Override
	public UsuarioRegistrado validarInicioSesion(String dniTrabajador, String correoTrabajador) {
		UsuarioRegistrado validacionUsuario = null;
		
		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet resultSet = null;
		
		try {
		
			connection = MySQLConnection.getConection();
			String sentenciaSQL = "{CALL sp_loginUsuarioRegistrado(?, ?)}";
			callableStatement = connection.prepareCall(sentenciaSQL);
			callableStatement.setString(1, dniTrabajador);
			callableStatement.setString(2, correoTrabajador);
			resultSet = callableStatement.executeQuery();
			
			if (resultSet.next()) {
				validacionUsuario = new UsuarioRegistrado();
				validacionUsuario.setIdUsuario(resultSet.getInt("id_trabajador"));
				validacionUsuario.setNombreUsuario(resultSet.getString("nombres"));
				validacionUsuario.setRol(resultSet.getString("nombre_cargo"));
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
		
		return validacionUsuario;
	}

}
