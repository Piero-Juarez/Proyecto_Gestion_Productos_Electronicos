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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="css/Menu.css">
	<title>Informe Completo</title>
	
	<style>
        .section-title {
            font-weight: 600;
            font-size: 1.3rem;
            color: #343a40;
            border-bottom: 2px solid #212529;
            display: inline-block;
            margin-bottom: 10px;
        }
        .product-info {
            font-size: 1.1rem;
            color: #495057;
        }
        .product-info span {
            font-weight: 500;
            color: #212529;
        }
        .product-img {
            max-width: 100%;
            border-radius: 10px;
            object-fit: cover;
        }
    </style>
</head>

<body>

	<%
		Producto productoEncontrado = (Producto) session.getAttribute("productoEncontrado");
	%>

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
			window.location.href="${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=listarModificar";
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
				
				<div class="container py-5">
			        <!-- Título -->
			        <h1 class="text-center mb-5">Detalles del Producto</h1>
			
			        <!-- Contenedor Principal -->
			        <div class="row align-items-start">
			            <!-- Imagen del Producto -->
			            <div class="col-lg-4 mb-4 mb-lg-0 text-center text-lg-start">
			                <img src="${pageContext.request.contextPath}/<%= productoEncontrado.getImagenProducto() %>" alt="Foto del Producto" class="product-img" draggable="false">
			            </div>
			
			            <!-- Información del Producto -->
			            <div class="col-lg-8">
			                <!-- Sección: Información Básica -->
			                <div class="product-section mb-4">
			                    <h2 class="section-title">Información Básica</h2>
			                    <div class="row product-info">
			                        <div class="col-md-6">
			                            <p>Nombre: <span><%= productoEncontrado.getNombreProducto() %></span></p>
			                            <p>Modelo: <span><%= productoEncontrado.getModeloProducto() %></span></p>
			                            <p>SKU: <span><%= productoEncontrado.getSkuProducto() %></span></p>
			                        </div>
			                        <div class="col-md-6">
			                            <p>Categoría: <span><%= productoEncontrado.getNombreCategoria() %></span></p>
			                            <p>Marca: <span><%= productoEncontrado.getNombreMarca() %></span></p>
			                            <p>Proveedor: <span><%= productoEncontrado.getNombreProveedor() %></span></p>
			                        </div>
			                    </div>
			                </div>
			
			                <!-- Sección: Descripción -->
			                <div class="product-section mb-4">
			                    <h2 class="section-title">Descripción</h2>
			                    <div class="row product-info">
			                        <div class="col-12">
			                            <p><%= productoEncontrado.getDetallesProducto() %></p>
			                        </div>
			                    </div>
			                </div>
			
			                <!-- Sección: Detalles -->
			                <div class="product-section mb-4">
			                    <h2 class="section-title">Detalles</h2>
			                    <div class="row product-info">
			                        <div class="col-md-6">
			                            <p>Dimensiones: <span><%= productoEncontrado.getDimensionesProducto() %> (alto x largo x ancho)</span></p>
			                            <p>Peso: <span><%= productoEncontrado.getPesoProducto() %> kg</span></p>
			                            <p>Color: <span><%= productoEncontrado.getColorProducto() %></span></p>
			                        </div>
			                        <div class="col-md-6">
			                        	<p>Garantía: <span><%= productoEncontrado.getGarantiaProducto() %></span></p>
			                            <p>Estado del producto: <span><%= productoEncontrado.getNombreEstadoProducto() %></span></p>
			                            <p>Fecha de Incorporación: <span><%= productoEncontrado.getFechaIncorporacionProducto() %></span></p>
			                        </div>
			                    </div>
			                </div>
			
			                <!-- Sección: Stock y Precio -->
			                <div class="product-section">
			                    <h2 class="section-title">Inventario y Precio</h2>
			                    <div class="row product-info">
			                        <div class="col-md-6">
			                            <p>Stock Actual: <span><%= productoEncontrado.getStockProducto() %></span></p>
			                            <p>Stock Mínimo: <span><%= productoEncontrado.getStockMinimoProducto() %></span></p>
			                        </div>
			                        <div class="col-md-6">
			                            <p>Precio: <span>S/<%= productoEncontrado.getPrecioProducto() %></span></p>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
			
			        <!-- Botones -->
			        <div class="text-center mt-4">
			        	<button onclick="window.location.href='jsp/Products.jsp'" class="btn btn-dark px-5 mx-2">
			        		Regresar <i class="bi bi-box-arrow-left ps-1"></i>
			        	</button>
			            <button type="button" class="btn btn-dark px-5 mx-2" data-bs-toggle="modal" data-bs-target="#modalModificarProducto">
			            	Editar Producto <i class="bi bi-pencil-square ps-1"></i>
			            </button>
			            <button class="btn btn-dark px-5 mx-2" data-bs-toggle="modal" data-bs-target="#modalEliminarProducto">
			            	Eliminar Producto <i class="bi bi-trash-fill ps-1"></i>
			            </button>
			        </div>
			    </div>
				
				<!-- Modal MODIFICAR -->
				<div class="modal fade" id="modalModificarProducto" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalModificarLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="modalModificarLabel">Modificar Producto</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
					            
						        <form id="form-modificar-producto" action="${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=modificar" method="post" enctype="multipart/form-data">
									
									<input type="hidden" value="<%= productoEncontrado.getIdProducto() %>" name="txtIdProductoModificar">
									
									<div class="row">
									    <div class="col-md-6 mb-3">
									        <label for="nombreProducto" class="form-label"><strong>Nombre</strong></label>
									        <input type="text" value="<%= productoEncontrado.getNombreProducto() %>" class="form-control" id="nombreProducto" name="txtNombreProducto" placeholder="Ingrese el nombre del producto">
									    </div>
									    <div class="col-md-6 mb-3">
									        <label for="modeloProducto" class="form-label"><strong>Modelo</strong></label>
									        <input type="text" value="<%= productoEncontrado.getModeloProducto() %>" class="form-control" id="modeloProducto" name="txtModeloProducto" placeholder="Ingrese el modelo">
									    </div>
									</div>
										<div class="row">
										    <!-- SKU Producto -->
										    <div class="col-md-6 mb-3">
										        <label for="skuProducto" class="form-label"><strong>SKU</strong></label>
										        <input type="text" class="form-control" id="skuProducto" name="txtSkuProducto" readonly="readonly" value="<%= productoEncontrado.getSkuProducto() %>">
										    </div>
										
										    <!-- Color Producto -->
										    <div class="col-md-6 mb-3">
										        <label for="colorProducto" class="form-label"><strong>Color</strong></label>
										        <input type="text" value="<%= productoEncontrado.getColorProducto() %>" class="form-control" id="colorProducto" name="txtColorProducto" placeholder="Ingrese el color o los colores del producto">
										    </div>
										</div>
						            <!-- Categoría y Marca -->
									<div class="row">
										<div class="col-md-6 mb-3">
											<label for="idCategoria" class="form-label"><strong>Categoría</strong></label>
											<select class="form-select" id="idCategoria" name="cboCategoria">
												<option value="" disabled>Seleccione una categoría</option>
												<%
													List<Categoria> listadoCategoria = (List<Categoria>) session.getAttribute("listadoCategoria");
														
													int categoriaSeleccionada = productoEncontrado.getIdCategoria();
													
														if(listadoCategoria != null) {
															for(Categoria item: listadoCategoria) {
												%>
													<option value="<%= item.getIdCategoria()%>"
														<%= (item.getIdCategoria() == categoriaSeleccionada) ? "selected" : "" %>>
														<%= item.getNombreCategoria() %>
													</option>
												<%	
															}
														}
												%>
											</select>
										</div>
										<div class="col-md-6 mb-3">
											<label for="idMarca" class="form-label"><strong>Marca</strong></label>
											<select class="form-select" id="idMarca" name="cboMarca">
												<option value="" disabled>Seleccione una marca</option>
												<%
													List<Marca> listadoMarca = (List<Marca>) session.getAttribute("listadoMarca");
														
													int marcaSeleccionada = productoEncontrado.getIdMarca();
													
														if(listadoMarca != null) {
															for(Marca item: listadoMarca) {
												%>
													<option value="<%= item.getIdMarca()%>"
														<%= (item.getIdMarca() == marcaSeleccionada) ? "selected" : "" %>>
														<%= item.getNombreMarca() %>
													</option>
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
						                <textarea class="form-control" id="detallesProducto" name="txtDetallesProducto" rows="3" placeholder="Ingrese los detalles del producto"><%= productoEncontrado.getDetallesProducto() %></textarea>
						            </div>
						            <!-- Precio Producto -->
						            <div class="mb-3">
						                <label for="precioProducto" class="form-label"><strong>Precio (S/)</strong></label>
						                <input type="number" value="<%= productoEncontrado.getPrecioProducto() %>" class="form-control" id="precioProducto" name="txtPrecioProducto" placeholder="Ingrese el precio">
						            </div>
						            <!-- Stock -->
						            <div class="row">
						                <div class="col-md-6 mb-3">
						                    <label for="stockProducto" class="form-label"><strong>Stock</strong></label>
						                    <input type="number" value="<%= productoEncontrado.getStockProducto() %>" class="form-control" id="stockProducto" name="txtStockProducto" placeholder="Ingrese el stock">
						                </div>
						                <div class="col-md-6 mb-3">
						                    <label for="stockMinimoProducto" class="form-label"><strong>Stock Mínimo</strong></label>
						                    <input type="number" value="<%= productoEncontrado.getStockMinimoProducto() %>" class="form-control" id="stockMinimoProducto" name="txtStockMinimoProducto" placeholder="Ingrese el stock mínimo">
						                </div>
						            </div>
						            <!-- Proveedor -->
						            <div class="mb-3">
						                <label for="idProveedor" class="form-label"><strong>Proveedor</strong></label>
						                <select class="form-select" id="idProveedor" name="cboProveedor">
												<option value="" disabled>Seleccione un proveedor</option>
												<%
													List<Proveedor> listadoProveedor = (List<Proveedor>) session.getAttribute("listadoProveedor");
														
						                			int proveedorSeleccionado = productoEncontrado.getIdProveedor();
						                		
														if(listadoProveedor != null) {
															for(Proveedor item: listadoProveedor) {
												%>
													<option value="<%= item.getIdProveedor() %>"
														<%= (item.getIdProveedor() == proveedorSeleccionado) ? "selected" : "" %>>
														<%= item.getNombreProveedor() %>
													</option>
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
									        <input type="number" value="<%= productoEncontrado.getPesoProducto() %>" class="form-control" id="pesoProducto" name="txtPesoProducto" placeholder="Ingrese el peso" min="0">
									    </div>
									    <div class="col-md-6 mb-3">
									        <label for="dimensionesProducto" class="form-label"><strong>Dimensiones (cm)</strong></label>
									        <input type="text" value="<%= productoEncontrado.getDimensionesProducto() %>" class="form-control" id="dimensionesProducto" name="txtDimensionesProducto" placeholder="Ingrese las dimensiones del producto">
									    </div>
									</div>
									<!-- Garantía y Estado Producto -->
									<div class="row">
									    <div class="col-md-6 mb-3">
									        <label for="garantiaProducto" class="form-label"><strong>Garantía</strong></label>
									        <input type="text" value="<%= productoEncontrado.getGarantiaProducto() %>" class="form-control" id="garantiaProducto" name="txtGarantiaProducto" placeholder="Ingrese el periodo de garantía">
									    </div>
									    <div class="col-md-6 mb-3">
									        <label for="idEstadoProducto" class="form-label"><strong>Estado del producto</strong></label>
									        <select class="form-select" id="idEstadoProducto" name="cboEstadoProducto">
												<option value="" disabled>Seleccione un estado</option>
												<%
													List<EstadoProducto> listadoEstadoProducto = (List<EstadoProducto>) session.getAttribute("listadoEstadoProducto");
														
									        		int estadoProductoSeleccionado = productoEncontrado.getIdEstadoProducto();
									        		
														if(listadoEstadoProducto != null) {
															for(EstadoProducto item: listadoEstadoProducto) {
												%>
													<option value="<%= item.getIdEstadoProducto() %>"
														<%= (item.getIdEstadoProducto() == estadoProductoSeleccionado) ? "selected" : "" %>>
														<%= item.getNombreEstadoProducto() %>
													</option>
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
									        <input type="date" value="<%= productoEncontrado.getFechaIncorporacionProducto() %>" class="form-control" id="fechaIncorporacionProducto" name="txtFechaIncorporacionProducto">
									    </div>
									    <!-- Foto del Producto -->
									    <div class="col-md-6">
									    <label for="fotoProducto" class="form-label"><strong>Foto del Producto</strong></label>
										    <div class="text-center">
										        <!-- Muestra la imagen actual -->
										        <img src="${pageContext.request.contextPath}/<%= productoEncontrado.getImagenProducto() %>" 
										             alt="Imagen actual del producto" 
										             style="max-width: 150px; height: auto; margin-bottom: 10px;"
										             draggable="false" />
										    </div>
											<!-- Input para subir una nueva imagen -->
										    <input type="file" class="form-control" id="fotoProducto" name="txtFotoProducto">
										    <small class="text-muted">Deja este campo vacío si no deseas cambiar la imagen.</small>
									    </div>
									</div>
						        </form>
					                
							</div>
							<div class="modal-footer">
								<button type="submit" form="form-modificar-producto" class="btn btn-dark">
					            	Guardar cambios <i class="bi bi-pencil-square ps-1"></i>
								</button>
							</div>
						</div>
					</div>
				</div>

				<!-- Modal ELIMINAR -->
				<div class="modal fade" id="modalEliminarProducto" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="modalEliminarLabel">Eliminar Producto</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>¿Estás seguro de eliminar el producto seleccionado?</p>
								<p>Esta acción no se podrá deshacer.</p>
								<form id="form-liminar-producto" action="${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=eliminar" method="post">
									<input type="hidden" value="<%= productoEncontrado.getIdProducto() %>" id="inputIdEliminar" name="txtIdProductoEliminar">
								</form>
							</div>
				      		<div class="modal-footer">
				        		<button type="submit" form="form-liminar-producto" class="btn btn-dark">
				        			Eliminar <i class="bi bi-trash-fill ps-1"></i>
				        		</button>
				      		</div>
				    	</div>
					</div>
				</div>
				
			</div>

		</div>
	</div>

</body>

<!-- Boostrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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
	    	
	        if (value === "") { return true; }

	        const extension = value.split(".").pop().toLowerCase();
	        return param.includes(extension);
	        
	    }, "Seleccione un archivo con formato válido (.jpg, .png, .webp).")
	 	
		$("#form-modificar-producto").validate({
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
				}
			}
		});
	});
</script>

</html>