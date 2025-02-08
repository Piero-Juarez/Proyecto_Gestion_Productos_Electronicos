<%@page import="java.util.InvalidPropertiesFormatException"%>
<%@page import="entity.DetalleTemporal"%>
<%@page import="entity.venta.MetodoPago"%>
<%@page import="entity.producto.Producto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="css/Menu.css">
	<title>Venta - Boleta</title>
	
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
			<div class="col-xl-11 d-flex flex-column align-items-center justify-content-center mt-5 mb-5">
				<h1 class="mb-2">${decisionUsuario} Nº B-${ultimoIdBoleta}</h1>
				<h2 class="mb-2">Vendedor: [<%= usuarioRegistrado.getNombreUsuario() %>]</h2>
			    <div class="row d-flex w-50 align-items-center mb-5 mt-2">
			    	<div class="col-12 col-lg-6 text-center">
			    		<h3>Fecha -> <%= java.time.LocalDate.now() %></h3>
			    	</div>
			        <div class="col-12 col-lg-6 text-center">
			        	<h3 id="hora">Hora -> 00:00:00</h3>
			        </div>
			    </div>
				<div class="container ">
				    <div class="row">
				        <div class="col-12 col-lg-6 mb-3 mb-lg-0">
				        
				        	<!-- <input type="hidden" value="${idComprobantePago}" id="txtIdComprobantePago"> -->
				        
				        	<!-- COMIENZO SECCIÓN CLIENTE -->
					        <div class="mb-5">
					        	<h3>Sección Cliente:</h3>
					        
					        	<!-- <input type="hidden" value="${idClienteObtenido}" id="txtIdClienteObtenido"> -->
					        	
						        <div class="row mb-3">
						            <div class="col">
						                <label>DNI</label>
						                <input class="form-control" id="txtDNICliente" type="text" name="txtDNICliente" value="${dniClienteObtenido}" placeholder="DNI del cliente">
						            </div>
						            <div class="col">
						            	<label>Buscar</label>
						                <button onclick="window.location.href='${pageContext.request.contextPath}/SalesServlet?service=encontrarClientePorDNI&dniCliente=' + document.getElementById('txtDNICliente').value" type="button" class="btn btn-dark w-100">
						                	Buscar Cliente
						                	<i class="bi bi-search ms-1"></i>
						                </button>
						            </div>
						        </div>
						        
						        <div class="row mb-3">
						        	<div class="col">
						                <label>Nombres</label>
						                <input class="form-control" type="text" name="txtNombresCliente" value="${nombreClienteObtenido}" placeholder="Esperando cliente..." readonly="readonly">
						            </div>
						            <div class="col">
						                <label>Apellidos</label>
						                <input class="form-control" type="text" name="txtApellidosCliente" value="${apellidosClienteObtenido}" placeholder="Esperando cliente..." readonly="readonly">
						            </div>
						        </div>
						    </div>
					        <!-- FIN SECCIÓN CLIENTE -->
					        
					        <!-- COMIENZO SECCIÓN PRODUCTO -->
					        <div class="mb-5">
					        	<h3>Sección Producto:</h3>
					        
					        	<input type="hidden" id="txtIdProducto" value="${idProductoObtenido}">
					        
						        <div class="row mb-3">
						            <div class="col">
						            	<label>Buscar</label>
						                <button type="button" class="btn btn-dark w-100" data-bs-toggle="modal" data-bs-target="#seleccionProductos">
						                	Buscar Producto
						                	<i class="bi bi-search ms-1"></i>
						                </button>
						            </div>
						            <div class="col">
						                <label>Nombre del producto</label>
						                <input class="form-control" type="text" name="txtNombreProducto" value="${nombreProductoObtenido}" placeholder="Esperando producto..." readonly="readonly">
						            </div>
						        </div>
						        
						        <div class="row mb-3">
						            <div class="col">
						                <label>Stock del producto</label>
						                <input class="form-control" type="text" name="txtStockProducto" value="${stockProductoObtenido}" placeholder="Esperando producto..." readonly="readonly">
						            </div>
						            <div class="col">
						                <label>Precio del producto</label>
						                <input class="form-control" type="text" name="txtPrecioProducto" value="${precioProductoObtenido}" placeholder="Esperando producto..." readonly="readonly">
						            </div>
						        </div>
						        
						        <div class="row mb-3">
						            <div class="col">
						                <label>Cantidad</label>
						                <input class="form-control" type="text" id="txtCantidadComparUsuario" name="txtCantidadComparUsuario" placeholder="Cantidad a adquirir">
						            </div>
						            <div class="col">
						                <label>Agregar</label>
						                <% if(session.getAttribute("idProductoObtenido") != null) { %>
						                	<button
						                	onclick="window.location.href='${pageContext.request.contextPath}/SalesServlet?service=postAgregarProducto&idProducto=' + document.getElementById('txtIdProducto').value + '&cantidadComprador=' + document.getElementById('txtCantidadComparUsuario').value"
						                	class="btn btn-dark w-100"
						                	id="btnAgregarProducto" disabled>
						                		Agregar Producto
						                		<i class="bi bi-plus-lg ms-1"></i>
						                	</button>
						                <% } else { %>
						                	<button class="btn btn-dark w-100" disabled>
						                		Agregar Producto
						                		<i class="bi bi-plus-lg ms-1"></i>
						                	</button>
						                <% } %>
						            </div>
						        </div>
						    </div>
					        <!-- FIN SECCIÓN PRODUCTO -->
					        
				        	<!-- COMIENZO SECCIÓN PAGO -->
					        <div class="mb-4">
					        	<h3>Sección Pago:</h3>
					        
						        <div class="row mb-3">
						            <div class="col">
						                <label>Método de pago</label>
						                <select class="form-select w-100" name="cboTipoPago" id="cboTipoPago">
						                	<option value="">Escoger método de pago</option>
						                	<%
												List<MetodoPago> listadoMetodoPago = (List<MetodoPago>) session.getAttribute("listadoMetodoPago");
													
												if(listadoMetodoPago != null) {
													for(MetodoPago item: listadoMetodoPago) {
											%>
							                	<option value="<%= item.getIdMetodoPago() %>"><%= item.getNombreMetodoPago() %></option>
							      			<%
													}
												}
											%>
						                </select>
						            </div>
						        </div>

								<input type="hidden" id="montoTotalHidden" value="${montoTotalCarrito != null ? montoTotalCarrito : 0}">

						        <div class="row mb-3" id="divEfectivoVuelto" style="display: none;">
						            <div class="col">
						                <label>Efectivo</label>
						                <input class="form-control" type="text" id="txtEfectivoCliente" name="txtEfectivoCliente" placeholder="Efectivo del cliente">
						            </div>
						            <div class="col">
						                <label>Vuelto</label>
						                <input class="form-control" type="text" id="txtVueltoCliente" name="txtVueltoCliente" placeholder="Vuelto para el cliente..." readonly="readonly">
						            </div>
						        </div>
						    </div>
					        <!-- FIN SECCIÓN PAGO -->
					        
				        </div>
				        
				        <!-- COMIENZO CUADRO DE PRODUCTOS -->
				        <div class="col-12 col-lg-6">
				            <div class="w-100 border d-flex flex-column" style="height: 650px; width: auto;">
				            	<div>
				            		<div class="text-center border">
				            			<h3 class="my-3"><strong>DETALLES DE LA VENTA</strong></h3>
				            		</div>
				            		<div class="d-flex text-center mt-3">
				            			<div class="col"><p><strong>Foto</strong></p></div>
				            			<div class="col"><p><strong>Nombre</strong></p></div>
				            			<div class="col"><p><strong>Precio</strong></p></div>
				            			<div class="col"><p><strong>Cantidad</strong></p></div>
				            			<div class="col"><p><strong>Eliminar</strong></p></div>
				            		</div>
				            		<%
				            			List<DetalleTemporal> listaCarrito = (List<DetalleTemporal>) session.getAttribute("listaCarrito");
				            			if (listaCarrito != null) {
				            				for (DetalleTemporal item : listaCarrito) {
				            		%>
						            	<div class="d-flex text-center align-items-center justify-content-center">
						            		<div class="col">
						            			<img alt="Imagen Producto" src="${pageContext.request.contextPath}/<%= item.getImagenProducto() %>" class="rounded" width="100" height="100" draggable="false">
						            		</div>
						            		<div class="col"><p class="m-0"><%= item.getNombreProducto() %></p></div>
						            		<div class="col"><p class="m-0">S/<%= item.getPrecioProducto() %></p></div>
						            		<div class="col"><p class="m-0"><%= item.getCantidadProducto() %> uds.</p></div>
						            		<div class="col">
						            			<a href="${pageContext.request.contextPath}/SalesServlet?service=eliminarProducto&idProducto=<%= item.getIdProducto() %>" class="btn btn-dark px-3">
						            				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash-fill" viewBox="0 0 16 16">
														<path d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5M8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5m3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0"/>
													</svg>
						            			</a>
						            		</div>
						            	</div>
					            	<%
				            				}
				            			}
					            	%>
				            	</div>
				            	<div class="mt-auto d-flex justify-content-evenly border">
				            		<p class="my-2"><strong>Subtotal: S/${subtotalCarrito}</strong></p>
					            	<p class="my-2"><strong>IGV (18%): S/${igvCarrito}</strong></p>
					            	<p class="my-2"><strong>Monto total: S/${montoTotalCarrito}</strong></p>
				            	</div>
				            </div>
				            <div class="row mt-4">
				            	<div class="col">
				            		<% if (listaCarrito != null && session.getAttribute("idClienteObtenido") != null) { %>
				            			<button
				            			class="btn btn-dark w-100"
				            			onclick="window.location.href='${pageContext.request.contextPath}/SalesServlet?service=realizarVenta&idComprobantePago=${idComprobantePago}&idCliente=${idClienteObtenido}&idTrabajador=<%= usuarioRegistrado.getIdUsuario() %>&montoTotal=${montoTotalCarrito}&idMetodoPago=' + document.getElementById('cboTipoPago').value + '&dineroCliente=' + document.getElementById('txtEfectivoCliente').value + '&vueltoCliente=' + document.getElementById('txtVueltoCliente').value"
				            			id="btnFinalizarVenta" disabled>
				            				Finalizar Venta
				            				<i class="bi bi-check2-square ms-1"></i>
				            			</button>
				            		<% } else { %>
				            			<button class="btn btn-dark w-100" disabled>
				            				Finalizar Venta
				            				<i class="bi bi-check2-square ms-1"></i>
				            			</button>
				            		<% } %>
				            	</div>
				            	<div class="col">
				            		<button onclick="window.location.href='${pageContext.request.contextPath}/jsp/Sales.jsp'" class="btn btn-dark w-100">
				            			Cancelar Venta
				            			<i class="bi bi-x-circle ms-1"></i>
				            		</button>
				            	</div>
				            </div>
				        </div>
				        <!-- FIN CUADRO -->
				        
				    </div>
				</div>
				
				<!-- MODAL SELECCIÓN DE PRODUCTOS -->
				<div class="modal fade" id="seleccionProductos" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">Seleccionar Producto</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      	<table class="table table-bordered table-hover text-center" id="tablaProductos">
				      		<thead class="table-dark">
				      			<tr>
				      				<td>Imagen del producto</td>
				      				<td>Nombre</td>
				      				<td>Stock</td>
				      				<td>Color</td>
				      				<td>Precio</td>
				      				<td>Estado</td>
				      				<td>Garantía</td>
				      				<td>Acciones</td>
				      			</tr>
				      		</thead>
				      		
				      		<tbody>
				      			<%
									List<Producto> listadoProductos = (List<Producto>) session.getAttribute("listadoProductos");
										
									if(listadoProductos != null) {
										for(Producto item: listadoProductos) {
								%>
					      			<tr>
					      				<td>
					      					<img class="rounded" alt="Imagen Producto" src="${pageContext.request.contextPath}/<%= item.getImagenProducto() %>" width="100" height="100" draggable="false" />
					      				</td>
					      				<td><%= item.getNombreProducto()%></td>
					      				<td><%= item.getStockProducto()%></td>
					      				<td><%= item.getColorProducto()%></td>
					      				<td>S/<%= item.getPrecioProducto()%></td>
					      				<td><%= item.getNombreEstadoProducto()%></td>
					      				<td><%= item.getGarantiaProducto()%></td>
					      				<td>
					      					<button onclick="window.location.href='${pageContext.request.contextPath}/SalesServlet?service=preAgregarProducto&idProducto=<%= item.getIdProducto() %>'" class="btn btn-dark">Seleccionar Producto</button>
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
				  </div>
				</div>
				<!-- FIN MODAL -->
				
				<!-- Modal ADVERTENCIA CLIENTE NO ENCONTRADO -->
				<div class="modal fade" id="modalAdvertenciaClienteNoEncontrado" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalAdvertenciaEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="modalAdvertenciaEliminarLabel">Advertencia</h1>
								<i class="bi bi-exclamation-triangle-fill ms-2"></i>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>
									<%= request.getAttribute("mensajeClienteNoEncontrado") != null ? request.getAttribute("mensajeClienteNoEncontrado") : "" %>
								</p>
							</div>
				    	</div>
					</div>
				</div>
				<!-- FIN Modal ADVERTENCIA CLIENTE NO ENCONTRADO -->
				
				<!-- Modal ADVERTENCIA STOCK EXCEDIDO -->
				<div class="modal fade" id="modalAdvertenciaStockExcedido" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalAdvertenciaEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="modalAdvertenciaEliminarLabel">Stock Excedido</h1>
								<i class="bi bi-exclamation-triangle-fill ms-2"></i>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>	
									<%= request.getAttribute("mensajeStockInvalido") != null ? request.getAttribute("mensajeStockInvalido") : "" %>
								</p>
							</div>
				    	</div>
					</div>
				</div>
				<!-- Modal ADVERTENCIA STOCK EXCEDIDO -->
				
				<!-- Modal VENTA FALLIDA -->
				<div class="modal fade" id="modalVentaFallida" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalAdvertenciaEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="modalAdvertenciaEliminarLabel">Venta Fallida</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>	
									<%= request.getAttribute("mensajeVentaFallida") != null ? request.getAttribute("mensajeVentaFallida") : "" %>
								</p>
							</div>
				    	</div>
					</div>
				</div>
				<!-- Modal VENTA FALLIDA -->
				
				<!-- Modal MENSAJE VENTA EXITOSA -->
				<div class="modal fade" id="modalVentaExitosa" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalAdvertenciaEliminarLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header text-center">
								<h1 class="modal-title fs-5" id="modalAdvertenciaEliminarLabel">¡Venta Exitosa!</h1>
								<i class="bi bi-check-circle-fill ms-1"></i>
							</div>
							<div class="modal-body">
								<p>	
									<%= request.getAttribute("ventaCompletado") != null ? request.getAttribute("ventaCompletado") : "" %>
								</p>
							</div>
							<div class="modal-footer">
								<a href="jsp/Sales.jsp" class="btn btn-dark">
									Continuar
									<i class="bi bi-box-arrow-left ms-1"></i>
								</a>
								<a href="<%= request.getAttribute("descargarPDF") %>" target="_blank" class="btn btn-dark">
									Descargar Boleta
									<i class="bi bi-receipt ms-1"></i>
								</a>
							</div>
				    	</div>
					</div>
				</div>
				<!-- Modal MENSAJE VENTA EXITOSA -->
				
			</div>
			
		</div>
	</div>

</body>

<!-- Boostrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Script para la fecha en tiempo real -->
<script>

    function displayTime() {
      var currentDate = new Date();
      var hours = currentDate.getHours();
      var minutes = currentDate.getMinutes();
      var seconds = currentDate.getSeconds();
      hours = hours < 10 ? "0" + hours : hours;
      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;
      var timeString = "Hora -> " + hours + ":" + minutes + ":" + seconds;
      document.getElementById("hora").innerHTML = timeString;
    }
    
    setInterval(displayTime, 1000);
    
</script>

<!-- JQUERY -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- DATATABLE -->
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.min.js"></script>

<script>
	$(document).ready(function(){
		$('#tablaProductos').DataTable({
			columnDefs: [
				{ className: "text-center align-middle", targets: [0, 1, 2, 3, 4, 5, 6, 7]},
				{ orderable: false, targets: [7]},
				{ searchable: false, targets: [7] }
			],
			pageLength: 20,
			language:{
				lengthMenu: "Mostrar _MENU_ productos por página",
				zeroRecords: "No se encontro ningun producto",
				info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
				infoEmpty:"Ningun producto encontrado",
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

<!-- SCRIPT MODALES -->
<script>
	const mensajeClienteNoEncontrado = '<%= request.getAttribute("mensajeClienteNoEncontrado") != null ? "true" : "false" %>';
	const mensajeStockExcedido = '<%= request.getAttribute("mensajeStockInvalido") != null ? "true" : "false" %>';
	const mensajeVentaFallida = '<%= request.getAttribute("mensajeVentaFallida") != null ? "true" : "false"%>';
	const mensajeVentaExitosa = '<%= request.getAttribute("ventaCompletado") != null ? "true" : "false"%>';
	  
	if (mensajeClienteNoEncontrado === "true") {
		const modal = new bootstrap.Modal(document.getElementById('modalAdvertenciaClienteNoEncontrado'));
		modal.show();
	}
	
	if (mensajeStockExcedido === "true") {
		const modal = new bootstrap.Modal(document.getElementById('modalAdvertenciaStockExcedido'));
		modal.show();
	}
	
	if (mensajeVentaFallida === "true") {
		const modal = new bootstrap.Modal(document.getElementById('modalVentaFallida'));
		modal.show();
	}
	
	if (mensajeVentaExitosa === "true") {
		const modal = new bootstrap.Modal(document.getElementById('modalVentaExitosa'));
		modal.show();
	}
</script>

<!-- SCRIPT VERIFICACIONES -->
<script>
	const cboTipoPago = document.getElementById('cboTipoPago');
	const divEfectivoVuelto = document.getElementById('divEfectivoVuelto');
    const txtEfectivoCliente = document.getElementById('txtEfectivoCliente');
    const txtVueltoCliente = document.getElementById('txtVueltoCliente');
    const montoTotalHidden = document.getElementById('montoTotalHidden');
    
    function onTipoPago() {
		if (cboTipoPago.options[cboTipoPago.selectedIndex].text === "Pago en efectivo") {
			divEfectivoVuelto.style.display = "flex";
		} else {
			divEfectivoVuelto.style.display = "none";
		}
	}
    
    function calcularVuelto() {
		const montoTotal = parseFloat(montoTotalHidden.value) || 0;
		const efectivoCliente = parseFloat(txtEfectivoCliente.value) || 0;
		const vuelto = efectivoCliente - montoTotal;
		
		txtVueltoCliente.value = vuelto < 0 ? "Efectivo inferior al monto total" : vuelto.toFixed(2);
	}
    
    cboTipoPago.addEventListener('change', onTipoPago);
    txtEfectivoCliente.addEventListener('input', calcularVuelto);
    
    onTipoPago();
</script>

<script>
    const inputCantidad = document.getElementById('txtCantidadComparUsuario');
    const btnAgregarProducto = document.getElementById('btnAgregarProducto');

    inputCantidad.addEventListener('input', () => {
        const valor = parseFloat(inputCantidad.value);
        if (!isNaN(valor) && valor > 0) {
            btnAgregarProducto.disabled = false;
        } else {
            btnAgregarProducto.disabled = true;
        }
    });
</script>

<script>
    const selectMetodoPago = document.getElementById('cboTipoPago');
    const btnFinalizarVenta = document.getElementById('btnFinalizarVenta');

    selectMetodoPago.addEventListener('change', () => {
        if (selectMetodoPago.value) {
            btnFinalizarVenta.disabled = false;
        } else {
            btnFinalizarVenta.disabled = true;
        }
    });
</script>

</html>