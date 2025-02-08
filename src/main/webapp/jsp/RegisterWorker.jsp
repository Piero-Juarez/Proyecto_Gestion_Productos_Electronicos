<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.trabajador.JornadaLaboral" %>
<%@ page import="entity.trabajador.Cargo" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="css/Menu.css">
	<title>Registrar Trabajador</title>
	
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
	
	

	<div class="container-fluid vh-100 d-flex flex-column" data-barba="container" data-barba-namespace="home">
        <div class="row flex-grow-1">

			<!-- MENÚ -->
			<div class="col-0 col-xl-1 text-white bg-dark d-flex flex-column align-items-center justify-content-center estilos-nav">
				<div id="contenido-nav">
					<%@ include file = "Menu.jsp" %>
				</div>
			</div>
			
			<!-- CONTENIDO -->
			<div class="col-xl-11 bg-ligth mt-5 mb-5  ">

					<div class="container">
						<h1 class="mb-5 text-center">Registrar Nuevo Trabajador</h1>
						
					    <form action="RegisterServlet" class="form-group" method="post">        
					        <input type="hidden" name="type" value="registrarTrabajador">
					        
					        <div class="row mb-3">
					            <div class="col">
					                <label for="txtNombreTrabajador" class="form-label">Nombres del trabajador</label>
					                <input class="form-control" type="text" name="txtNombreTrabajador" id="txtNombreTrabajador" placeholder="Ingrese nombres del trabajador">
					            </div>
					            <div class="col">
					                <label for="txtApellidoTrabajador" class="form-label">Apellidos del trabajador</label>
					                <input class="form-control" type="text" name="txtApellidoTrabajador" id="txtApellidoTrabajador" placeholder="Ingrese apellidos del trabajador">
					            </div>
					        </div>
					        
					        <div class="row mb-3">
					            <div class="col">
					                <label for="txtDniTrabajador" class="form-label">DNI</label>
					                <input class="form-control" type="text" name="txtDniTrabajador" id="txtDniTrabajador" placeholder="Ingrese DNI del trabajador">
					            </div>
					            <div class="col">
					                <label for="txtCorreoTrabajador" class="form-label">Correo Electrónico</label>
					                <input class="form-control" type="email" name="txtCorreoTrabajador" id="txtCorreoTrabajador" placeholder="Ingrese correo electrónico del trabajador">
					            </div>
					        </div>
					        
					        <div class="row mb-3">
					            <div class="col">
					                <label for="txtNumeroTrabajador" class="form-label">Numero de teléfono</label>
					                <input class="form-control" type="text" name="txtNumeroTrabajador" id="txtNumeroTrabajador" placeholder="Ingrese número de teléfono del trabajador">
					            </div>
					            <div class="col">
					                <label for="txtDireccionTrabajador" class="form-label">Dirección del trabajador</label>
					                <input class="form-control" type="text" name="txtDireccionTrabajador" id="txtDireccionTrabajador" placeholder="Ingrese dirección del trabajador">
					            </div>
					        </div>
					        
					        <div class="row mb-3">
					            <div class="col">
					                <label for="cboJornadaLaboral" class="form-label">Jornada Laboral</label>
					                <select class="form-select" name="cboJornadaLaboral" id="cboJornadaLaboral">
					                    <% List<JornadaLaboral> jornadaLaboral = (List<JornadaLaboral>) session.getAttribute("jornadaLaboral"); 
					                    if(jornadaLaboral!=null){
					                        for(JornadaLaboral item:jornadaLaboral){ %>
					                            <option value="<%= item.getIdJornadaLaboral()%>"><%=item.getNombreJornadaLaboral() %></option>
					                    <% } } %>
					                </select>
					            </div>
					            <div class="col">
					                <label for="txtFechaContratacion" class="form-label">Fecha de Contratacion</label>
					                <input class="form-control" type="date" name="txtFechaContratacion" id="txtFechaContratacion" placeholder="Ingrese fecha de contratación">
					            </div>
					        </div>
					        
					        <div class="row mb-3">
					            <div class="col">
					                <label for="cboCargo" class="form-label">Cargo</label>
					                <select class="form-select" name="cboCargo" id="cboCargo">
					                    <% List<Cargo> cargoTrabajador = (List<Cargo>) session.getAttribute("cargoTrabajador");
					                    if(cargoTrabajador!=null){
					                        for(Cargo item:cargoTrabajador){ %>
					                            <option value="<%= item.getIdCargo()%>"><%= item.getNombreCargo() %></option>
					                    <% } } %>
					                </select>
					            </div>
					            <div class="col">
					                <label for="txtSalario" class="form-label">Salario</label>
					                <input class="form-control" type="text" name="txtSalario" id="txtSalario" placeholder="Ingrese salario del trabajador">
					            </div>
					        </div>
					        
					        <div class="d-flex align-items-center justify-content-center mt-5">
					            <a class="btn btn-dark btn-lg mx-2" href="jsp/Register.jsp">
					            	Volver <i class="bi bi-box-arrow-left ps-1"></i>
					            </a>
					            <button class="btn btn-dark btn-lg mx-2" type="submit">
					            	Agregar Trabajador <i class="bi bi-plus-lg ps-1"></i>
					            </button>
					        </div>                          
					    </form>
					</div>

			</div>
		</div>
	</div>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
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