<%@page import="entity.producto.EstadoProducto"%>
<%@page import="entity.producto.Proveedor"%>
<%@page import="entity.producto.Marca"%>
<%@page import="entity.producto.Categoria"%>
<%@page import="entity.trabajador.JornadaLaboral"%>
<%@page import="entity.trabajador.Cargo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<title>Configuraciones</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="css/Menu.css">

	<!-- DATATABLE -->
	<link href="https://cdn.datatables.net/v/bs5/jszip-3.10.1/dt-2.1.8/b-3.2.0/b-html5-3.2.0/b-print-3.2.0/datatables.min.css" rel="stylesheet">

	<style type="text/css">
		.page-item.active .page-link{
			background-color: #212529 !important;
			color: azure !important;
		}
		
		.page-link{
			color: black !important;
		}
		
		label.error {
		    color: red;
		    font-size: 0.9em;
		    margin-top: 5px;
		    display: block;
		}
	</style>
</head>

<body>

	<%
		if (
				session.getAttribute("listadoCargos") == null ||
				session.getAttribute("listadoJornadaLaboral") == null ||
				session.getAttribute("listadoCategoria") == null ||
				session.getAttribute("listadoMarca") == null ||
				session.getAttribute("listadoProveedor") == null ||
				session.getAttribute("listadoEstadoProducto") == null
			) {
	%>
		<script type="text/javascript">
			window.location.href="${pageContext.request.contextPath}/ConfigurationServlet?type=obtenerListas";
		</script>
	<%
		}
	%>

	<div class="container-fluid vh-100 d-flex flex-column" data-barba="container" data-barba-namespace="home">
        <div class="row flex-grow-1">

			<!-- MENÚ -->
			<div class="col-0 col-xl-1 text-white bg-dark d-flex flex-column align-items-center justify-content-center estilos-nav">
				<div id="contenido-nav">
					<%@ include file = "Menu.jsp" %>
				</div>
			</div>
			
			<!-- CONTENIDO -->
			<div class="col-xl-11 bg-ligth d-flex flex-column align-items-center justify-content-center mt-5 mb-5">
				<h1 class="mb-5">Configuración Por Secciones</h1>
				
				<!-- SECCION TRABAJADOR -->
				<div class="w-100 container">
					<h2>Sección Trabajador</h2>
					
					<div class="mt-4">
						<form id="form-add-jornadalaboral" action="${pageContext.request.contextPath}/ConfigurationServlet" method="post">
							<label for="nombreJornadaLaboral" class="form-label">Agregar Nueva Jornada Laboral</label>
							<div class="d-flex gap-3">
								<input type="text" class="form-control" id="nombreJornadaLaboral" name="txtJornadaLaboral" placeholder="Nombre de la jornada laboral" style="max-width: 320px; width: 100%;" />
								<button class="btn btn-dark"
									formaction="${pageContext.request.contextPath}/ConfigurationServlet?type=agregarEntidad&data-clave=jornadaLaboralTrabajador">
									Agregar Jornada Laboral <i class="bi bi-plus-lg ps-1"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="table-responsive mt-4">
						<table id="" class="w-100 display table table-bordered table-hover text-center">
							<thead class="table-dark">
								<tr>
									<td>ID</td>
									<td>NOMBRE</td>
									<td>ACCIONES</td>
								</tr>
							</thead>
									
							<tbody>
								<%
									List<JornadaLaboral> listadoJornadaLaboral = (List<JornadaLaboral>) session.getAttribute("listadoJornadaLaboral");
									
									if(listadoJornadaLaboral != null) {
										for(JornadaLaboral item: listadoJornadaLaboral) {
								%>
								
								<tr>
									<td><%= item.getIdJornadaLaboral() %></td>
									<td><%= item.getNombreJornadaLaboral() %></td>
									<td>
										<button class="btn btn-dark btn-modificar"
												data-id="<%= item.getIdJornadaLaboral() %>"
												data-value="<%= item.getNombreJornadaLaboral() %>"
												data-clave="jornadaLaboralTrabajador"
												data-bs-toggle="modal"
												data-bs-target="#modalModificar">
											Modificar <i class="bi bi-pencil-square ps-1"></i>
										</button>
										<button class="btn btn-dark btn-eliminar"
												data-id="<%= item.getIdJornadaLaboral() %>"
												data-clave="jornadaLaboralTrabajador"
												data-bs-toggle="modal"
												data-bs-target="#modalEliminar">
											Eliminar <i class="bi bi-trash-fill ps-1"></i>
										</button>
									</td>
								</tr>
																
								<%
										}
									}
								%>
							</tbody>
						</table>
					</div>					
				</div>
				
				<hr />
				
				<!-- SECCION PRODUCTO -->
				<div class="w-100 container mt-5">
					<h2>Sección Producto</h2>
					<div class="mt-4">
						<form id="form-add-categoria" action="${pageContext.request.contextPath}/ConfigurationServlet" method="post">
							<label for="nombreCategoria" class="form-label">Agregar Nueva Categoría</label>
							<div class="d-flex gap-3">
								<input type="text" class="form-control" id="nombreCategoria" name="txtnombreCategoria" placeholder="Nombre de la categoría" style="max-width: 320px; width: 100%;" />
								<button class="btn btn-dark"
									formaction="${pageContext.request.contextPath}/ConfigurationServlet?type=agregarEntidad&data-clave=categoriaProducto">
									Agregar Categoría <i class="bi bi-plus-lg ps-1"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="table-responsive mt-4">
						<table id="" class="w-100 display table table-bordered table-hover text-center">
							<thead class="table-dark">
								<tr>
									<td>ID</td>
									<td>NOMBRE</td>
									<td>ACCIONES</td>
								</tr>
							</thead>
									
							<tbody>
								<%
									List<Categoria> listadoCategorias = (List<Categoria>) session.getAttribute("listadoCategoria");
									
									if (listadoCategorias != null) {
										for(Categoria item: listadoCategorias) {
								%>
								
									<tr>
										<td><%= item.getIdCategoria() %></td>
										<td><%= item.getNombreCategoria() %></td>
										<td>
											<button class="btn btn-dark btn-modificar"
												data-id="<%= item.getIdCategoria() %>"
												data-value="<%= item.getNombreCategoria() %>"
												data-clave="categoriaProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalModificar">
												Modificar <i class="bi bi-pencil-square ps-1"></i>
											</button>
											<button class="btn btn-dark btn-eliminar"
												data-id="<%= item.getIdCategoria() %>"
												data-clave="categoriaProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalEliminar">
												Eliminar <i class="bi bi-trash-fill ps-1"></i>
											</button>
										</td>
									</tr>
									
								<%
										}
									}
								%>
							</tbody>
						</table>
					</div>
					
					<div class="mt-5">
						<form id="form-add-marca" action="${pageContext.request.contextPath}/ConfigurationServlet" method="post">
							<label for="nombreMarca" class="form-label">Agregar Nueva Marca</label>
							<div class="d-flex gap-3">
								<input type="text" class="form-control" id="nombreMarca" name="txtNombreMarca" placeholder="Nombre de la marca" style="max-width: 320px; width: 100%;" />
								<button class="btn btn-dark"
									formaction="${pageContext.request.contextPath}/ConfigurationServlet?type=agregarEntidad&data-clave=marcaProducto">
									Agregar Marca <i class="bi bi-plus-lg ps-1"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="table-responsive mt-4">
						<table id="" class="w-100 display table table-bordered table-hover text-center">
							<thead class="table-dark">
								<tr>
									<td>ID</td>
									<td>NOMBRE</td>
									<td>ACCIONES</td>
								</tr>
							</thead>
									
							<tbody>
								<%
									List<Marca> listadoMarcas = (List<Marca>) session.getAttribute("listadoMarca");
									
									if (listadoMarcas != null) {
										for(Marca item: listadoMarcas) {
								%>
								
									<tr>
										<td><%= item.getIdMarca() %></td>
										<td><%= item.getNombreMarca() %></td>
										<td>
											<button class="btn btn-dark btn-modificar"
												data-id="<%= item.getIdMarca() %>"
												data-value="<%= item.getNombreMarca() %>"
												data-clave="marcaProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalModificar">
												Modificar <i class="bi bi-pencil-square ps-1"></i>
											</button>
											<button class="btn btn-dark btn-eliminar"
												data-id="<%= item.getIdMarca() %>"
												data-clave="marcaProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalEliminar">
												Eliminar <i class="bi bi-trash-fill ps-1"></i>
											</button>
										</td>
									</tr>
									
								<%
										}
									}
								%>
							</tbody>
						</table>
					</div>
					
					<div class="mt-5">
						<form id="form-add-proveedor" action="${pageContext.request.contextPath}/ConfigurationServlet" method="post">
							<label for="nombreProveedor" class="form-label">Agregar Nuevo Proveedor</label>
							<div class="d-flex gap-3">
								<input type="text" class="form-control" id="nombreProveedor" name="txtNombreProveedor" placeholder="Nombre del proveedor" style="max-width: 320px; width: 100%;" />
								<button class="btn btn-dark"
									formaction="${pageContext.request.contextPath}/ConfigurationServlet?type=agregarEntidad&data-clave=proveedorProducto">
									Agregar Proveedor <i class="bi bi-plus-lg ps-1"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="table-responsive mt-4">
						<table id="" class="w-100 display table table-bordered table-hover text-center">
							<thead class="table-dark">
								<tr>
									<td>ID</td>
									<td>NOMBRE</td>
									<td>ACCIONES</td>
								</tr>
							</thead>
									
							<tbody>
								<%
									List<Proveedor> listadoProveedor = (List<Proveedor>) session.getAttribute("listadoProveedor");
									
									if (listadoProveedor != null) {
										for(Proveedor item: listadoProveedor) {
								%>
								
									<tr>
										<td><%= item.getIdProveedor() %></td>
										<td><%= item.getNombreProveedor() %></td>
										<td>
											<button class="btn btn-dark btn-modificar"
												data-id="<%= item.getIdProveedor() %>"
												data-value="<%= item.getNombreProveedor() %>"
												data-clave="proveedorProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalModificar">
												Modificar <i class="bi bi-pencil-square ps-1"></i>
											</button>
											<button class="btn btn-dark btn-eliminar"
												data-id="<%= item.getIdProveedor() %>"
												data-clave="proveedorProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalEliminar">
												Eliminar <i class="bi bi-trash-fill ps-1"></i>
											</button>
										</td>
									</tr>
									
								<%
										}
									}
								%>
							</tbody>
						</table>
					</div>
					
					<div class="mt-5">
						<form id="form-add-estado-producto" action="${pageContext.request.contextPath}/ConfigurationServlet" method="post">
							<label for="nombreEstadoProducto" class="form-label">Agregar Nuevo Estado de Producto</label>
							<div class="d-flex gap-3">
								<input type="text" class="form-control" id="nombreEstadoProducto" name="txtNombreEstadoProducto" placeholder="Nombre del estado" style="max-width: 320px; width: 100%;" />
								<button class="btn btn-dark"
									formaction="${pageContext.request.contextPath}/ConfigurationServlet?type=agregarEntidad&data-clave=estadoProducto">
									Agregar Estado <i class="bi bi-plus-lg ps-1"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="table-responsive mt-4">
						<table id="" class="w-100 display table table-bordered table-hover text-center">
							<thead class="table-dark">
								<tr>
									<td>ID</td>
									<td>NOMBRE</td>
									<td>ACCIONES</td>
								</tr>
							</thead>
									
							<tbody>
								<%
									List<EstadoProducto> listadoEstadoProducto = (List<EstadoProducto>) session.getAttribute("listadoEstadoProducto");
									
									if (listadoEstadoProducto != null) {
										for(EstadoProducto item: listadoEstadoProducto) {
								%>
								
									<tr>
										<td><%= item.getIdEstadoProducto() %></td>
										<td><%= item.getNombreEstadoProducto() %></td>
										<td>
											<button class="btn btn-dark btn-modificar"
												data-id="<%= item.getIdEstadoProducto() %>"
												data-value="<%= item.getNombreEstadoProducto() %>"
												data-clave="estadoProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalModificar">
												Modificar <i class="bi bi-pencil-square ps-1"></i>
											</button>
											<button class="btn btn-dark btn-eliminar"
												data-id="<%= item.getIdEstadoProducto() %>"
												data-clave="estadoProducto"
												data-bs-toggle="modal"
												data-bs-target="#modalEliminar">
												Eliminar <i class="bi bi-trash-fill ps-1"></i>
											</button>
										</td>
									</tr>
									
								<%
										}
									}
								%>
							</tbody>
						</table>
					</div>				
				</div>
				
				<hr />
				
				<!-- Modal MODIFICAR reutilizable -->
				<div class="modal fade" id="modalModificar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalModificarLabel" aria-hidden="true">
				    <div class="modal-dialog modal-dialog-centered">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title" id="modalModificarLabel">Modificar Información</h5>
				                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				            </div>
				            <div class="modal-body">
				                <form id="formModificar" action="${pageContext.request.contextPath}/ConfigurationServlet?type=modificarEntidad" method="post">
				                    <input type="hidden" id="inputIdModificar" name="txtId">
				                    <input type="hidden" id="inputClaveModificar" name="txtClave">
				                    <div class="mb-3">
				                        <label for="inputValor" class="form-label">Ingrese la modificación:</label>
				                        <input type="text" class="form-control" id="inputValorModificar" name="txtNuevoValor">
				                    </div>
				                </form>
				            </div>
				            <div class="modal-footer">
				            	<button type="submit" form="formModificar" class="btn btn-dark">
				            		Guardar cambios <i class="bi bi-pencil-square ps-1"></i>
				            	</button>
				            </div>
				        </div>
				    </div>
				</div>
				
				<!-- Modal ELIMINAR reutilizable -->
				<div class="modal fade" id="modalEliminar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="modalEliminarLabel">Eliminar Elemento</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>¿Estás seguro de eliminar el elemento seleccionado?</p>
								<p>Esta acción no se podrá deshacer.</p>
								<form id="formEliminar" action="${pageContext.request.contextPath}/ConfigurationServlet?type=eliminarEntidad" method="post">
									<input type="hidden" id="inputIdEliminar" name="txtId">
									<input type="hidden" id="inputClaveEliminar" name="txtClave">
								</form>
							</div>
				      		<div class="modal-footer">
				        		<button type="submit" form="formEliminar" class="btn btn-dark">
				        			Eliminar <i class="bi bi-trash-fill ps-1"></i>
				        		</button>
				      		</div>
				    	</div>
					</div>
				</div>
				
				<!-- Modal ADVERTENCIA NO ELIMINAR -->
				<div class="modal fade" id="modalAdvertenciaEliminar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalAdvertenciaEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="modalAdvertenciaEliminarLabel">Advertencia Sobre la Eliminación del Elemento</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>
									<%= request.getAttribute("mensajeNoEliminacion") != null ? request.getAttribute("mensajeNoEliminacion") : "" %>
								</p>
							</div>
				    	</div>
					</div>
				</div>
				
				<!-- FIN CONTENIDO -->
			</div>
			
		</div>
	</div>

</body>

<!-- Boostrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JQUERY -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- VALIDACIÓN JQUERY -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>

<!-- DATATABLE -->
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.min.js"></script>

<script>
	
	$(document).ready(function(){
		$('table.display').DataTable({
			columnDefs: [
				{ className: "text-center align-middle", targets: [0, 1, 2]},
				{ orderable: false, targets: [0, 2]},
				{ searchable: false, targets: [2] }
			],
			pageLength: 5,
			language:{
				lengthMenu: "Mostrar _MENU_ clientes por página",
				zeroRecords: "No se encontro ningun cliente",
				info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
				infoEmpty:"Ningun cliente encontrado",
				infoFiltered: "(filtrados desde _MAX_ registros totales)",
				emptyTable: "No hay datos disponibles en la tabla",
				search: "Buscar :",
				loadingRecords: "Cargando...",
				paginate:{
					first:"Primero",
					last:"Ultimo",
					next: "Siguiente",
					previous: "Anterior"
				}
			}
		})
	});
</script>

<!-- SCRIPT MODAL MODIFICAR -->
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", () => {
		
	    // Selecciona todos los botones de modificar
	    const botonesModificar = document.querySelectorAll(".btn-modificar");
	
	    // Agrega un evento click a cada botón
	    botonesModificar.forEach((boton) => {
	    	
	        boton.addEventListener("click", () => {
	            // Obtiene los valores del botón
	            const id = boton.getAttribute("data-id");
	            const valor = boton.getAttribute("data-value");
	            const clave = boton.getAttribute("data-clave");
	
	            // Rellena los campos del modal
	            document.getElementById("inputIdModificar").value = id;
	            document.getElementById("inputValorModificar").value = valor;
	            document.getElementById("inputClaveModificar").value = clave;
	        });
	        
	    });
	    
	});
</script>

<!-- SCRIPT MODAL ELIMINAR -->
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", () => {
		
	    // Selecciona todos los botones de modificar
	    const botonesEliminar = document.querySelectorAll(".btn-eliminar");
	
	    // Agrega un evento click a cada botón
	    botonesEliminar.forEach((boton) => {
	    	
	        boton.addEventListener("click", () => {
	            const id = boton.getAttribute("data-id");
	            const clave = boton.getAttribute("data-clave");
	
	            document.getElementById("inputIdEliminar").value = id;
	            document.getElementById("inputClaveEliminar").value = clave;
	        });
	        
	    });
	    
	});
</script>

<!-- SCRIPT ADVERTENCIA MODAL ELIMINAR -->
<script>
	const mensajeNoEliminacion = '<%= request.getAttribute("mensajeNoEliminacion") != null ? "true" : "false" %>';
	  
	if (mensajeNoEliminacion === "true") {
		const modal = new bootstrap.Modal(document.getElementById('modalAdvertenciaEliminar'));
		modal.show();
	}
</script>

<!-- SCRIPT VALIDACIÓN INPUTS -->
<script type="text/javascript">
	$(document).ready(function(){
		
        // Valida letras, caracteres especiales y puntos
        $.validator.addMethod("patronObligatorio", function(value, element) {
            return this.optional(element) || /^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s./]+$/.test(value);
        }, "Solo se permiten letras, espacios, diagonales y puntos.");

		$("#form-add-jornadalaboral").validate({
			rules:{
				txtJornadaLaboral:{
                    required: true,
                    patronObligatorio: true
				}
			},
			messages:{
				txtJornadaLaboral:{
                    required: "Este campo es obligatorio."
				}
			}
		});
        
		$("#form-add-categoria").validate({
			rules:{
				txtnombreCategoria:{
                    required: true,
                    patronObligatorio: true
				}
			},
			messages:{
				txtnombreCategoria:{
                    required: "Este campo es obligatorio."
				}
			}
		});
		
		$("#form-add-marca").validate({
			rules:{
				txtNombreMarca:{
                    required: true,
                    patronObligatorio: true
				}
			},
			messages:{
				txtNombreMarca:{
                    required: "Este campo es obligatorio."
				}
			}
		});
		
		$("#form-add-proveedor").validate({
			rules:{
				txtNombreProveedor:{
                    required: true,
                    patronObligatorio: true
				}
			},
			messages:{
				txtNombreProveedor:{
                    required: "Este campo es obligatorio."
				}
			}
		});
		
		$("#form-add-estado-producto").validate({
			rules:{
				txtNombreEstadoProducto:{
                    required: true,
                    patronObligatorio: true
				}
			},
			messages:{
				txtNombreEstadoProducto:{
                    required: "Este campo es obligatorio."
				}
			}
		});
		
		// INPUT MODAL MODIFICAR
		$("#formModificar").validate({
			rules:{
				txtNuevoValor:{
                    required: true,
                    patronObligatorio: true
				}
			},
			messages:{
				txtNuevoValor:{
                    required: "Este campo es obligatorio."
				}
			}
		});
		
	});
</script>

</html>
