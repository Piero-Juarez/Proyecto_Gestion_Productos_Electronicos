<%@page import="entity.producto.Producto"%>
<%@page import="entity.producto.EstadoProducto"%>
<%@page import="entity.producto.Proveedor"%>
<%@page import="entity.producto.Marca"%>
<%@page import="entity.producto.Categoria"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<title>Agregar Nuevo Producto</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="css/Menu.css">
	
	<style type="text/css">
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
			session.getAttribute("listadoCategoria") == null ||
			session.getAttribute("listadoMarca") == null ||
			session.getAttribute("listadoProveedor") == null ||
			session.getAttribute("listadoEstadoProducto") == null ||
			session.getAttribute("listadoProductos") == null
		) {
	%>
		<script type="text/javascript">
			window.location.href="${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=listar";
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
				<div class="container">
			        <h1 class="mb-5 text-center">Añadir Nuevo Producto</h1>
			        <form id="form-add-product" action="${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=agregar" method="post" enctype="multipart/form-data">
						<div class="row">
						    <div class="col-md-6 mb-3">
						        <label for="nombreProducto" class="form-label"><strong>Nombre</strong></label>
						        <input type="text" class="form-control" id="nombreProducto" name="txtNombreProducto" placeholder="Ingrese el nombre del producto">
						    </div>
						    <div class="col-md-6 mb-3">
						        <label for="modeloProducto" class="form-label"><strong>Modelo</strong></label>
						        <input type="text" class="form-control" id="modeloProducto" name="txtModeloProducto" placeholder="Ingrese el modelo">
						    </div>
						</div>
							<div class="row">
							    <!-- SKU Producto -->
							    <div class="col-md-6 mb-3">
							        <%
							            int contadorProductos;
							            List<Producto> listadoProductos = (List<Producto>) session.getAttribute("listadoProductos");
							            if (listadoProductos != null) {
							                contadorProductos = listadoProductos.size() + 1;
							            } else {
							                contadorProductos = 1;
							            }
							        %>
							        <label for="skuProducto" class="form-label"><strong>SKU (Automático)</strong></label>
							        <input type="text" class="form-control" id="skuProducto" name="txtSkuProducto" readonly="readonly" value="PRO-<%= contadorProductos %>">
							    </div>
							
							    <!-- Color Producto -->
							    <div class="col-md-6 mb-3">
							        <label for="colorProducto" class="form-label"><strong>Color</strong></label>
							        <input type="text" class="form-control" id="colorProducto" name="txtColorProducto" placeholder="Ingrese el color o los colores del producto">
							    </div>
							</div>
			            <!-- Categoría y Marca -->
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="idCategoria" class="form-label"><strong>Categoría</strong></label>
								<select class="form-select" id="idCategoria" name="cboCategoria">
									<option selected>Seleccione una categoría</option>
									<%
										List<Categoria> listadoCategoria = (List<Categoria>) session.getAttribute("listadoCategoria");
											
											if(listadoCategoria != null) {
												for(Categoria item: listadoCategoria) {
									%>
										<option value="<%= item.getIdCategoria()%>"><%= item.getNombreCategoria() %></option>
									<%	
												}
											}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="idMarca" class="form-label"><strong>Marca</strong></label>
								<select class="form-select" id="idMarca" name="cboMarca">
									<option selected>Seleccione una marca</option>
									<%
										List<Marca> listadoMarca = (List<Marca>) session.getAttribute("listadoMarca");
											
											if(listadoMarca != null) {
												for(Marca item: listadoMarca) {
									%>
										<option value="<%= item.getIdMarca()%>"><%= item.getNombreMarca() %></option>
									<%	
												}
											}
									%>
								</select>
							</div>
						</div>
			            <!-- Detalles Producto -->
			            <div class="mb-3">
			                <label for="detallesProducto" class="form-label"><strong>Detalles del Producto</strong></label>
			                <textarea class="form-control" id="detallesProducto" name="txtDetallesProducto" rows="3" placeholder="Ingrese los detalles del producto"></textarea>
			            </div>
			            <!-- Precio Producto -->
			            <div class="mb-3">
			                <label for="precioProducto" class="form-label"><strong>Precio (S/)</strong></label>
			                <input type="number" class="form-control" id="precioProducto" name="txtPrecioProducto" placeholder="Ingrese el precio">
			            </div>
			            <!-- Stock -->
			            <div class="row">
			                <div class="col-md-6 mb-3">
			                    <label for="stockProducto" class="form-label"><strong>Stock</strong></label>
			                    <input type="number" class="form-control" id="stockProducto" name="txtStockProducto" placeholder="Ingrese el stock">
			                </div>
			                <div class="col-md-6 mb-3">
			                    <label for="stockMinimoProducto" class="form-label"><strong>Stock Mínimo</strong></label>
			                    <input type="number" class="form-control" id="stockMinimoProducto" name="txtStockMinimoProducto" placeholder="Ingrese el stock mínimo">
			                </div>
			            </div>
			            <!-- Proveedor -->
			            <div class="mb-3">
			                <label for="idProveedor" class="form-label"><strong>Proveedor</strong></label>
			                <select class="form-select" id="idProveedor" name="cboProveedor">
									<option selected>Seleccione un proveedor</option>
									<%
										List<Proveedor> listadoProveedor = (List<Proveedor>) session.getAttribute("listadoProveedor");
											
											if(listadoProveedor != null) {
												for(Proveedor item: listadoProveedor) {
									%>
										<option value="<%= item.getIdProveedor() %>"><%= item.getNombreProveedor() %></option>
									<%	
												}
											}
									%>
			                </select>
			            </div>
			            <!-- Peso y Dimensiones -->
						<div class="row">
						    <div class="col-md-6 mb-3">
						        <label for="pesoProducto" class="form-label"><strong>Peso Producto (kg)</strong></label>
						        <input type="number" class="form-control" id="pesoProducto" name="txtPesoProducto" placeholder="Ingrese el peso" min="0">
						    </div>
						    <div class="col-md-6 mb-3">
						        <label for="dimensionesProducto" class="form-label"><strong>Dimensiones (cm)</strong></label>
						        <input type="text" class="form-control" id="dimensionesProducto" name="txtDimensionesProducto" placeholder="Ingrese las dimensiones del producto">
						    </div>
						</div>
						<!-- Garantía y Estado Producto -->
						<div class="row">
						    <div class="col-md-6 mb-3">
						        <label for="garantiaProducto" class="form-label"><strong>Garantía</strong></label>
						        <input type="text" class="form-control" id="garantiaProducto" name="txtGarantiaProducto" placeholder="Ingrese el periodo de garantía">
						    </div>
						    <div class="col-md-6 mb-3">
						        <label for="idEstadoProducto" class="form-label"><strong>Estado del producto</strong></label>
						        <select class="form-select" id="idEstadoProducto" name="cboEstadoProducto">
									<option selected>Seleccione un estado</option>
									<%
										List<EstadoProducto> listadoEstadoProducto = (List<EstadoProducto>) session.getAttribute("listadoEstadoProducto");
											
											if(listadoEstadoProducto != null) {
												for(EstadoProducto item: listadoEstadoProducto) {
									%>
										<option value="<%= item.getIdEstadoProducto() %>"><%= item.getNombreEstadoProducto() %></option>
									<%	
												}
											}
									%>
								</select>
						    </div>
						</div>
			            <!-- Fecha y Foto -->
						<div class="row">
						    <!-- Fecha de Incorporación -->
						    <div class="col-md-6">
						        <label for="fechaIncorporacionProducto" class="form-label"><strong>Fecha de Incorporación</strong></label>
						        <input type="date" class="form-control" id="fechaIncorporacionProducto" name="txtFechaIncorporacionProducto">
						    </div>
						    <!-- Foto del Producto -->
						    <div class="col-md-6">
						        <label for="fotoProducto" class="form-label"><strong>Foto del producto</strong></label>
						        <input type="file" class="form-control" id="fotoProducto" name="txtFotoProducto">
						    </div>
						</div>

			            <!-- Botón -->
			            <div class="text-center mt-5">
			            	<button onclick="window.location.href='jsp/Products.jsp'" type="button" class="btn btn-dark px-5 mx-2">
			            		Volver <i class="bi bi-box-arrow-left ps-1"></i>
			            	</button>
			                <button type="submit" class="btn btn-dark px-5 mx-2">
			                	Guardar Producto <i class="bi bi-plus-lg ps-1"></i>
			                </button>
			            </div>
			        </form>
			    </div>
			</div>
			
		</div>
	</div>
	
</body>

<!-- VALIDACIÓN JQUERY -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		// Regla personalizada para los selects
		$.validator.addMethod("selectVerificador", function(value, element){
			return value !== "Seleccione una categoría" &&
			value !== "Seleccione una marca" &&
			value !== "Seleccione un proveedor" &&
			value !== "Seleccione un estado";
		}, "Selecciona una opción válida.");
		
		// Regla personalizada para precios
		$.validator.addMethod("patronSueldo", function(value, element){
			return this.optional(element) || /^\d+(\.\d{1,2})?$/.test(value);
		}, "Sólo se permiten números con hasta dos decimales.");
		
		// Regla personalizada para validar enteros
	    $.validator.addMethod("soloNumerosEnteros", function (value, element) {
	        return this.optional(element) || /^[0-9]+$/.test(value);
	    }, "Ingrese un número entero válido.");
		
	 	// Regla personalizada para validar el formato de dimensiones
	    $.validator.addMethod("dimensionesFormato", function (value, element) {
	        return this.optional(element) || /^[0-9]+x[0-9]+x[0-9]+$/.test(value);
	    }, "Ingrese las dimensiones en el formato correcto: alto x largo x ancho (ej. 10x20x30).");
		
	    // Regla personalizada para validar el tipo de archivo
	    $.validator.addMethod("formatosPermitidos", function (value, element, param) {
	    	
	        if (value === "") { return false; }

	        const extension = value.split(".").pop().toLowerCase();
	        return param.includes(extension);
	        
	    }, "Seleccione un archivo con formato válido (.jpg, .png, .webp).")
	 	
		$("#form-add-product").validate({
			rules:{
				txtNombreProducto:{
					required: true,
					minlength: 3
				},
				txtModeloProducto:{
					required: true,
					minlength: 3
				},
				txtColorProducto:{
					required: true,
					minlength: 3
				},
				cboCategoria:{
					selectVerificador: true
				},
				cboMarca:{
					selectVerificador: true
				},
				txtDetallesProducto:{
					required: true,
					minlength: 3
				},
				txtPrecioProducto:{
					required: true,
					number: true,
					patronSueldo: true
				},
				txtStockProducto:{
					required: true,
					soloNumerosEnteros: true
				},
				txtStockMinimoProducto:{
					required: true,
					soloNumerosEnteros: true
				},
				cboProveedor:{
					selectVerificador: true
				},
				txtPesoProducto:{
					required: true,
					number: true,
					patronSueldo: true
				},
				txtDimensionesProducto:{
					required: true,
					dimensionesFormato: true
				},
				txtGarantiaProducto:{
					required: true,
					minlength: 3
				},
				cboEstadoProducto:{
					selectVerificador: true
				},
				txtFechaIncorporacionProducto:{
					required: true,
					date: true
				},
				txtFotoProducto:{
					required: true,
					formatosPermitidos: ["jpg", "png", "webp"]
				}
			},
			messages:{
				txtNombreProducto:{
					required: "Este campo es obligatorio.",
					minlength: "Introduce al menos 3 carácteres."
				},
				txtModeloProducto:{
					required: "Este campo es obligatorio.",
					minlength: "Introduce al menos 3 carácteres."
				},
				txtColorProducto:{
					required: "Este campo es obligatorio.",
					minlength: "Introduce al menos 3 carácteres."
				},
				cboCategoria:{
					selectVerificador: "Seleccione una opción válida."
				},
				cboMarca:{
					selectVerificador: "Seleccione una opción válida."
				},
				txtDetallesProducto:{
					required: "Este campo es obligatorio.",
					minlength: "Introduce al menos 3 carácteres."
				},
				txtPrecioProducto:{
					required: "Este campo es obligatorio.",
					number: "Digite un valor numérico válido."
				},
				txtStockProducto:{
					required: "Este campo es obligatorio.",
					soloNumerosEnteros: "Ingrese solo números enteros positivos (sin decimales)."
				},
				txtStockMinimoProducto:{
					required: "Este campo es obligatorio.",
					soloNumerosEnteros: "Ingrese solo números enteros positivos (sin decimales)."
				},
				cboProveedor:{
					selectVerificador: "Seleccione una opción válida."
				},
				txtPesoProducto:{
					required: "Este campo es obligatorio.",
					number: "Digite un valor numérico válido."
				},
		        txtDimensionesProducto: {
		            required: "Este campo es obligatorio."
		        },
				txtGarantiaProducto:{
					required: "Este campo es obligatorio.",
					minlength: "Introduce al menos 3 carácteres."
				},
				cboEstadoProducto:{
					selectVerificador: "Seleccione una opción válida."
				},
				txtFechaIncorporacionProducto:{
		            required: "Este campo es obligatorio.",
					date: "Ingrese una fecha válida."
				},
				txtFotoProducto:{
					required: "Este campo es obligatorio."
				}
			}
		});
	});
</script>

</html>