<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.trabajador.Trabajador" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.trabajador.Cargo" %>
<%@ page import="entity.trabajador.JornadaLaboral" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="css/Menu.css">
	<!-- CAMBIAR COLOR A LOS BOTONES -->
	<style type="text/css">
		.page-item.active .page-link{
			background-color: #212529 !important;
			color: azure !important;
		}
		
		.page-link{
			color: black !important;
		}
		
		.section-title {
            font-weight: 600;
            font-size: 1.3rem;
            color: #343a40;
            border-bottom: 2px solid #212529;
            display: inline-block;
            margin-bottom: 10px;
        }
		
		span {
            font-weight: 500;
            color: #212529;
        }
	</style>
<title>Detalle del Trabajador</title>
</head>
<body>
	<div class="container-fluid vh-100 d-flex flex-column" data-barba="container" data-barba-namespace="home">
        <div class="row flex-grow-1">

            <!-- MENÚ -->
            <div class="col-0 col-xl-1 text-white bg-dark d-flex flex-column align-items-center justify-content-center estilos-nav">
                <div id="contenido-nav">
                    <%@ include file = "Menu.jsp" %>
                </div>
            </div>

            <!-- CONTENIDO -->
            <div class="col-xl-11 d-flex flex-column align-items-center justify-content-center mt-5 mb-5">

                <div class="container py-5">
                    <!-- Título -->
                    <h1 class="text-center mb-5">Detalles del Trabajador</h1>

                    <!-- Contenedor Principal -->
                    <div class="row align-items-start justify-content-center">

                        <!-- Ícono del Cliente -->
                        <div class="col-lg-4 mb-4 mb-lg-0 text-center">
							<svg xmlns="http://www.w3.org/2000/svg" width="250" height="250" fill="currentColor" class="bi bi-file-person-fill" viewBox="0 0 16 16">
							  <path d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2m-1 7a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-3 4c2.623 0 4.146.826 5 1.755V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1v-1.245C3.854 11.825 5.377 11 8 11"/>
							</svg>
                        </div>
						
                        <!-- Información del Cliente -->
                        <div class="col-lg-8">
                            <!-- Sección: Información Básica -->
                            <div class="client-section mb-4">
                                <h2 class="section-title mb-4">Información Básica</h2>
                                <div class="row client-info">
                                <%
								
									Trabajador trabajadorForm=(Trabajador) session.getAttribute("detalleTrabajador");
									
								%>
								
                                    <div class="col-md-6">
                                        <p>ID Trabajador : <span><%=trabajadorForm.getIdtrabajador() %></span></p>
                                        <p>Nombre : <span><%=trabajadorForm.getNombresTrabajador() %></span></p>
                                        <p>Apellido : <span><%=trabajadorForm.getApellidosTrabajador() %></span></p>
                                        <p>DNI : <span><%=trabajadorForm.getDni() %></span></p>
                                        <p>Correo Electronico : <span><%=trabajadorForm.getCorreoElectronicoTrabajador() %></span></p>
                                        <p>Número : <span><%= trabajadorForm.getNumeroTelefonoTrabajador() %></span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p>Dirección trabajador : <span><%=trabajadorForm.getDireccionTrabajador() %></span></p>
                                        <p>Cargo : <span><%=trabajadorForm.getNombreCargo() %></span></p>
                                        <p>Fecha Contratacion : <span><%=trabajadorForm.getFechaContratacionTrabajador() %></span></p>
										<p>Jornada Laboral : <span><%=trabajadorForm.getNombreJornadaLaboral() %></span></p>                                    
                                    	<p>Salario : <span>S/<%= trabajadorForm.getSalarioTrabajador() %></span></p>
                                    </div>
                                </div>
                               
                            </div>
							
                        </div>
                    </div>

                    <!-- Botones -->
                    <div class="text-center mt-4">
                        <button onclick="window.location.href='jsp/Register.jsp'" class="btn btn-dark px-5 mx-2">
                            Regresar <i class="bi bi-box-arrow-left ps-1"></i>
                        </button>
                        <button class="btn btn-dark px-5 mx-2" data-bs-toggle="modal" data-bs-target="#editarTrabajador">
                            Editar Trabajador <i class="bi bi-pencil-square ps-1"></i>
                        </button>
                        <button class="btn btn-dark px-5 mx-2"data-bs-toggle="modal" data-bs-target="#eliminarTrabajador">
                            Eliminar Trabajador <i class="bi bi-trash-fill ps-1"></i>
                        </button>
                    </div>
                    	
                    <!-- Modal Editar Trabajador-->
					<div class="modal fade" id="editarTrabajador" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					    <!-- Encabezado -->
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">Editar Trabajador</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
						<!-- Editar trabajador -->
					      <div class="modal-body">
					       	<form id="form" action="${pageContext.request.contextPath}/RegisterServlet?type=actualizar" class="form-group" method="post">
					       	
					       		<input type="hidden" value="<%= trabajadorForm.getIdtrabajador() %>" name="txtIdTrabajador">
					       		
							  	<div class="form-group">
							  		<label>Nombres del trabajador</label>
							  		<input class="form-control" type="text" name="txtNombreTrabajador" value="<%=trabajadorForm.getNombresTrabajador() %>" >
							  	</div>
							  	<div class="form-group">
							  		<label>Apellidos del trabajador</label>
									<input class="form-control" type="text" name="txtApellidoTrabajador" value="<%=trabajadorForm.getApellidosTrabajador() %>">
							  	</div>
							  	<div class="form-group">
							  		<label>DNI</label>
									<input class="form-control" type="text" name="txtDniTrabajador" value="<%=trabajadorForm.getDni() %>">
							  	</div>
							  	<div class="form-group">
							  		<label>Correo Electronico</label>
									<input class="form-control" type="email" name="txtCorreoTrabajador" value="<%=trabajadorForm.getCorreoElectronicoTrabajador() %>">
							  	</div>
							  	<div class="form-group">
							  		<label>Numero de telefono</label>
									<input class="form-control" type="text" name="txtNumeroTrabajador" value="<%= trabajadorForm.getNumeroTelefonoTrabajador() %>">
							  	</div>
							  	<div class="form-group">
							  		<label>Direccion del trabajador</label>
									<input class="form-control" type="text" name="txtDireccionTrabajador" value="<%=trabajadorForm.getDireccionTrabajador() %>">
							  	</div>	
							  	<div class="form-group">
							  		<label>Jornada Laboral</label>
									<select class="form-select" aria-label="Default select example" name="cboJornadaLaboral">
										<option value="<%= trabajadorForm.getIdJornadaLaboral()%>"> <%= trabajadorForm.getNombreJornadaLaboral() %></option>
									<% List<JornadaLaboral> jornadaLaboral = (List<JornadaLaboral>) session.getAttribute("jornadaLaboral"); 
									if(jornadaLaboral!=null){
											for(JornadaLaboral item:jornadaLaboral){
												if(trabajadorForm.getIdJornadaLaboral()!=item.getIdJornadaLaboral()){
												
									%>
										
										  <option value="<%= item.getIdJornadaLaboral()%>"><%=item.getNombreJornadaLaboral() %></option>
									<%
											
												}
											}
										}
									%>
									</select>
							  	</div>
							  	<div class="form-group">
							  		<label>Fecha de Contratacion</label>
									<input class="form-control" type="date" name="txtFechaContratacion" value="<%=trabajadorForm.getFechaContratacionTrabajador() %>">
							  	</div>
						  		<div class="form-group">
							  		<label>Cargo</label>
									<select class="form-select" aria-label="Default select example" name="cboCargo">
										<option value="<%= trabajadorForm.getIdCargo()%>"> <%= trabajadorForm.getNombreCargo() %></option>
										
									<% List<Cargo> cargoTrabajador = (List<Cargo>) session.getAttribute("cargoTrabajador");
									if(cargoTrabajador!=null){
										for(Cargo item:cargoTrabajador){
										if(trabajadorForm.getIdCargo()!= item.getIdCargo()){
									%>
										  <option value="<%= item.getIdCargo()%>"><%= item.getNombreCargo() %></option>
									<%
										 }
									   }
									}
									%>
									</select>
						  		</div>
							  	<div class="form-group">
							  		<label>Salario</label>
									<input class="form-control" type="text" name="txtSalario" value="<%= trabajadorForm.getSalarioTrabajador() %>">
							  	</div>	
							  	<!-- Botonoes -->
							     <div class="modal-footer">
							        <button type="submit" class="btn btn-dark">Guardar Cambios</button> 
							     </div>			  		
				    		</form>
					      </div>
					    
					      
					    </div>
					  </div>
					</div>
					<!-- Modal Eliminar Trabajador -->
					<div class="modal fade" id="eliminarTrabajador" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					    <!-- Encabezado -->
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar Producto</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
						<!-- Eliminar Trabajador -->
					      <div class="modal-body">
					        <p>¿Estas seguro de eliminar al trabajador seleccionado?</p><br>
					        <p>Esta accion no se podra deshacer	</p>
					        <form id="formEliminar" action="${pageContext.request.contextPath}/RegisterServlet?type=eliminar" method="post">
					        	<input type="hidden" value="<%= trabajadorForm.getIdtrabajador() %>" name="txtIdTrabajador"/>
					        </form>
					      </div>
					    <!-- Botonoes -->

					      <div class="modal-footer">
					      	<button type="submit" form="formEliminar" class="btn btn-dark" data-bs-dismiss="modal">Eliminar</button>
					      </div>
					      
					    </div>
					  </div>
					</div>
                </div>

            </div>

        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
	<script type="text/javascript">
	
	const myModal = document.getElementById('myModal')
	const myInput = document.getElementById('myInput')

	myModal.addEventListener('shown.bs.modal', () => {
	  myInput.focus()
	})
	</script>
	
	<script>
		$(document).ready(function(){
			 $.validator.addMethod("patron", function (value, element, patron) { 
			        return this.optional(element) || patron.test(value);
			    }, "Sólo se permiten letras y espacios");
			 $.validator.addMethod("patronSueldo",function(value,element,patron){
					return this.optional(element) || patron.test(value);	
				},"Sólo se permiten máximo hasta 2 decimales");
			$("form").validate({
				 rules: {
			            txtNombreTrabajador: {
			                required: true,
			                minlength: 3,
			                patron: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/
			            },
			            txtApellidoTrabajador: {
			                required: true,
			                minlength: 3,
			                patron: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/
			            },
			            txtDniTrabajador: {
			                required: true,
			                digits: true,
			                minlength: 8,
			                maxlength: 8
			            },
			            txtCorreoTrabajador: {
			                required: true,
			                email: true
			            },
			            txtNumeroTrabajador: {
			                required: true,
			                digits: true,
			                minlength: 9,
			                maxlength: 9
			            },
			            txtDireccionTrabajador: {
			                required: true
			            },
			            cboCargos: {
			                required: true
			            },
			            txtFechaContratacion: {
			                required: true,
			                date: true
			            },
			            cboJornadaLaboral: {
			                required: true
			            },
			            txtSalario: {
			                required: true,
			                number: true,
			                min: 0,
			                patronSueldo:/^\d+(\.\d{1,2})?$/
			            }
			        },
			        messages: {
			            txtNombreTrabajador: {
			                required: "Por favor, ingrese el nombre del trabajador.",
			                minlength: "El nombre debe tener al menos 3 caracteres."
			            },
			            txtApellidoTrabajador: {
			                required: "Por favor, ingrese el apellido del trabajador.",
			                minlength: "El apellido debe tener al menos 3 caracteres."
			            },
			            txtDniTrabajador: {
			                required: "Por favor, ingrese el DNI del trabajador.",
			                digits: "El DNI debe contener solo números.",
			                minlength: "El DNI debe tener 8 dígitos.",
			                maxlength: "El DNI debe tener 8 dígitos."
			            },
			            txtCorreoTrabajador: {
			                required: "Por favor, ingrese un correo electrónico.",
			                email: "Ingrese un correo válido."
			            },
			            txtNumeroTrabajador: {
			                required: "Por favor, ingrese el número de teléfono.",
			                digits: "El número debe contener solo números.",
			                minlength: "El número debe tener 9 dígitos.",
			                maxlength: "El número debe tener 9 dígitos."
			            },
			            txtDireccionTrabajador: {
			                required: "Por favor, ingrese la dirección del trabajador."
			            },
			            cboCargos: {
			                required: "Por favor, seleccione un cargo."
			            },
			            txtFechaContratacion: {
			                required: "Por favor, ingrese la fecha de contratación.",
			                date: "Ingrese una fecha válida."
			            },
			            cboJornadaLaboral: {
			                required: "Por favor, seleccione una jornada laboral."
			            },
			            txtSalario: {
			                required: "Por favor, ingrese el salario.",
			                number: "El salario debe ser un número válido.",
			                min: "El salario debe ser mayor o igual a 0."
			            }
			        },
				
			})
		})
	</script>
</body>
</html>