package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLConnection {

	public static Connection getConection() {
		Connection connection = null;
		try {
			// Registro del driver MySQL
			Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
			
			// Definimos los parámetros para la conexión a MySQL
			String url = "jdbc:mysql://localhost:3306/db_imperio_electronico?useSSL=false&useTimezone=true&serverTimezone=UTC";
			String user = "root";
			String password = "admin";
			
			connection = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("Error >> driver no instalado -> Mensaje: " + e.getMessage());
		} catch (SQLException e) {
			System.out.println("Error >> no hay conexión con la base de datos -> Mensaje: " + e.getMessage());
		} catch (Exception e) {
			System.out.println("Error >> tipo general -> Mensaje: " + e.getMessage());
		}
		return connection;
	}
	
	public static void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			System.out.println("Error >> problema al cerrar la conexión -> Mensaje: " + e.getMessage());
		}
	}
	
}
