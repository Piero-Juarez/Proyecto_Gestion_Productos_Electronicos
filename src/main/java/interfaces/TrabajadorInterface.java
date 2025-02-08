package interfaces;

import java.util.List;

import entity.trabajador.Cargo;
import entity.trabajador.JornadaLaboral;
import entity.trabajador.Trabajador;

public interface TrabajadorInterface {

	// CRUD TRABAJADOR
	public int crearTrabajador(Trabajador nuevoTrabajador);
	public Trabajador encontrarTrabajador(int idTrabajador);
	public List<Trabajador> listarTrabajadores();
	public int actualizarTrabajador(Trabajador trabajadorExistente);
	public void eliminarTrabajador(int idTrabajador);
	
	public List<Trabajador> TrabajadoresConMasVentas();
	
	// CRUD TABLA CARGO
	public void crearCargo(Cargo nuevoCargo);
	public Cargo encontrarCargo(int idCargo);
	public List<Cargo> listarCargos();
	public void actualizarCargo(Cargo cargoExistente);
	public void eliminarCargo(int idCargo);
	
	// CRUD TABLA JORNADA LABORAL
	public void crearJornadaLaboral(JornadaLaboral nuevaJornadaLaboral);
	public JornadaLaboral encontrarJornadaLaboral(int idJornadaLaboral);
	public List<JornadaLaboral> listarJornadaLaboral();
	public void actualizarJornadaLaboral(JornadaLaboral jornadaLaboralExistente);
	public void eliminarJornadaLaboral(int idJornadaLaboral);
	
	public int contarTrabajadoresPorJornadaLaboral(int idJornadaLaboral);
}
