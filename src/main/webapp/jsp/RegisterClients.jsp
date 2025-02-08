<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<%
		String tipoCliente = (String) session.getAttribute("TipoCliente");
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
			<div class="col-xl-11 bg-ligth mt-5 mb-5  ">
					<div class="container">
						<h1 class="mb-5 text-center">Registrar Nuevo Cliente</h1>
						
					    <form action="${pageContext.request.contextPath}/ClientsServlet?type=registrarCliente" class="form-group" method="post">        
					        <input type="hidden" name="type" value="registrarTrabajador">
						        
					        
					        <div class="row mb-3">
					            <div class="col">
					                <label for="txtNombreCliente" class="form-label">Nombres del cliente</label>
					                <input class="form-control" type="text" name="txtNombreCliente" id="txtNombreCliente" placeholder="Ingrese nombres del cliente">
					            </div>
					            <div class="col">
					                <label for="txtApellidoCliente" class="form-label">Apellidos del cliente</label>
					                <input class="form-control" type="text" name="txtApellidoCliente" id="txtApellidoCliente" placeholder="Ingrese apellidos del cliente">
					            </div>
					        </div>
					        
					        <div class="row mb-3">
					        <% if(tipoCliente.equals("ClienteDni")){ %>
					            <div class="col">
					                <label for="txtDniCliente" class="form-label">DNI</label>
					                <input class="form-control" type="text" name="txtDniCliente" id="txtDniCliente" placeholder="Ingrese DNI del cliente" >
					            </div>
					        <% } else { %>
					        	<div class="col">
					                <label for="txtRuc" class="form-label">RUC</label>
					                <input class="form-control" type="text" name="txtRuc" id="txtRuc" placeholder="Ingrese RUC del cliente" >
					            </div>
					            
					           	<div class="col">
					                <label for="txtRazonSocial" class="form-label">Razon Social</label>
					                <input class="form-control" type="text" name="txtRazonSocial" id="txtRazonSocial" placeholder="Ingrese razón social del cliente">
					            </div>
					        <% } %>
					        </div>
					        
					        <% if(!tipoCliente.equals("ClienteDni")){ %>
					        <div class="row mb-3">
					            <div class="col">
					                <label for="txtNombreComercial" class="form-label">Nombre Comercial</label>
					                <input class="form-control" type="text" name="txtNombreComercial" id="txtNombreComercial" placeholder="Ingrese nombre comercial del cliente">
					            </div>
					            <div class="col">
					                <label for="txtDireccionFiscal" class="form-label">Direccion Fiscal</label>
					                <input class="form-control" type="text" name="txtDireccionFiscal" id="txtDireccionFiscal" placeholder="Ingrese dirección fiscal del cliente">
					            </div>
					        </div>
					        <% } %>
					        
					        				        
					        <div class="d-flex align-items-center justify-content-center mt-5">
					            <a class="btn btn-dark btn-lg mx-2" href="jsp/Clients.jsp">
					            	Volver <i class="bi bi-box-arrow-left ps-1"></i>
					            </a>
					            <button class="btn btn-dark btn-lg mx-2" type="submit">
					            	Agregar cliente <i class="bi bi-plus-lg ps-1"></i>
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
			 
			$("form").validate({
				 rules: {
					 	txtNombreCliente: {
			                required: true,
			                minlength: 3,
			                patron: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/
			            },
			            txtApellidoCliente: {
			                required: true,
			                minlength: 3,
			                patron: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/
			            },
			            txtDniCliente: {
			                required: true,
			                digits: true,
			                minlength: 8,
			                maxlength: 8
			            },
			            txtRazonSocial: {
			                required: true
			                
			            },
			            txtNombreComercial: {
			                required: true,
			                
			       
			            },
			            txtDireccionFiscal: {
			                required: true
			            },
			            txtRuc:{
			            	required: true
			            }
			        },
			        messages: {
			        	txtNombreCliente: {
			                required: "Por favor, ingrese el nombre del trabajador.",
			                minlength: "El nombre debe tener al menos 3 caracteres."
			            },
			            txtApellidoCliente: {
			                required: "Por favor, ingrese el apellido del trabajador.",
			                minlength: "El apellido debe tener al menos 3 caracteres."
			            },
			            txtDniCliente: {
			                required: "Por favor, ingrese el DNI del trabajador.",
			                digits: "El DNI debe contener solo números.",
			                minlength: "El DNI debe tener 8 dígitos.",
			                maxlength: "El DNI debe tener 8 dígitos."
			            },
			            txtRazonSocial: {
			                required: "Por favor, ingrese este campo."
			                
			            },
			            txtNombreComercial: {
			                required: "Por favor, ingrese el nombre comercial.",
			                
			            },
			            txtDireccionFiscal: {
			                required: "Por favor, ingrese la dirección del cliente."
			            },
			            txtRuc: {
			                required: "Por favor, ingrese el RUC."
			            }
			           
			            
			            
			        },
				
			})
		})
	</script>
</body>
</html>