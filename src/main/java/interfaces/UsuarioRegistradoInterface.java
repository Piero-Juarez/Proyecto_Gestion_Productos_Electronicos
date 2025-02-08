package interfaces;

import entity.usuarioRegistrado.UsuarioRegistrado;

public interface UsuarioRegistradoInterface {

	public UsuarioRegistrado validarInicioSesion(String dniTrabajador, String correoTrabajador);
	
}
