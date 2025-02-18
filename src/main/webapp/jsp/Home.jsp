<%@page import="entity.producto.Producto"%>
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
	<link rel="stylesheet" href="css/Cards.css">
	<title>Inicio</title>
	
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
	
	<style type="text/css">
		.card-contadores {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 200px;
            height: 180px;
            text-align: center;
            overflow: hidden;
            transition: transform 0.2s;
            border: 2px black solid;
        }

        .card-contadores:hover {
            transform: translateY(-5px);
        }

        .card-contadores-header {
            background-color: #212529;
            color: #ffffff;
            padding: 15px;
            font-size: 18px;
            font-weight: bold;
        }

        .card-contadores-body {
            padding: 20px;
            font-size: 30px;
            font-weight: bold;
            color: #000000;
        }
	</style>
</head>

<body>

	<%
		List<Producto> listaProductosStockMinimo  = (List<Producto>) request.getAttribute("productosStockMinimo");
		List<Producto> listaProductosSinStock  = (List<Producto>) request.getAttribute("productosSinStock");
		
		int contadorProductosStockMinimo = listaProductosStockMinimo.size();
		int contadorProductosSinStock = listaProductosSinStock.size();
	%>

    <div class="container-fluid vh-100 d-flex flex-column">
        <div class="row flex-grow-1">

			<!-- MENÚ -->
			<div class="col-0 col-xl-1 text-white bg-dark d-flex flex-column align-items-center justify-content-center estilos-nav">
				<div id="contenido-nav">
					<%@ include file = "Menu.jsp" %>
				</div>
			</div>
			
			<!-- CONTENIDO -->
			<div class="col-xl-11 bg-ligth d-flex flex-column align-items-center justify-content-center mt-5 mb-5">
				<h1>Bienvenido(a) <%= usuarioRegistrado.getNombreUsuario() %></h1>
				<h2 class="mb-5"><<span><%= usuarioRegistrado.getRol() %>(a)</span>></h2>
				
				<h3>Notás Rápidas</h3>
				<div class="d-flex flex-wrap align-items-center cols justify-content-center mb-5">
                    <div id="card-container" class="d-flex flex-wrap justify-content-center"></div>
                    <button id="add-card" class="add-button p-1 d-flex align-items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                        </svg>
                    </button>
                </div>
                
                <div class="mt-5">
                    <h3 class="text-center mb-4">Contadores del Día</h3>
                    <div class="d-flex text-center gap-5">
                    	<button class="btn btn-white" onclick="window.location.href='${pageContext.request.contextPath}/ProductServlet?service=Product'">
		                    <div class="card-contadores">
						        <div class="card-contadores-header">
						            Productos en Almacén
						        </div>
						        <div class="card-contadores-body">
						            <%= request.getAttribute("numeroProductosDisponibles") %>
						        </div>
						    </div>
                    	</button>
					    <button class="btn btn-white" data-bs-toggle="modal" data-bs-target="#productosBajoStock">
		                    <div class="card-contadores">
						        <div class="card-contadores-header">
						            Productos con Bajo Stock
						        </div>
						        <div class="card-contadores-body">
						            <%= contadorProductosStockMinimo %>
						        </div>
						    </div>
					    </button>
					    <button class="btn btn-white" data-bs-toggle="modal" data-bs-target="#productosSinStock">
		                    <div class="card-contadores">
						        <div class="card-contadores-header p-3">
						            Productos sin Stock
						        </div>
						        <div class="card-contadores-body">
						            <%= contadorProductosSinStock %>
						        </div>
						    </div>
					    </button>
                    </div>
                </div>
			</div>
			
			<!-- MODAL PRODUCTOS BAJO STOCK -->
				<div class="modal fade" id="productosBajoStock" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">Seleccionar Producto</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      	<table class="table table-bordered table-hover text-center" id="tablaProductosBajoStock">
				      		<thead class="table-dark">
				      			<tr>
				      				<td>Imagen del producto</td>
				      				<td>Nombre</td>
				      				<td>Stock</td>
				      				<td>Stock Mínimo</td>
				      				<td>Acciones</td>
				      			</tr>
				      		</thead>
				      		
				      		<tbody>
				      			<%
									if(listaProductosStockMinimo != null) {
										for(Producto item: listaProductosStockMinimo) {
								%>
					      			<tr>
					      				<td>
					      					<img class="rounded" alt="Imagen Producto" src="${pageContext.request.contextPath}/<%= item.getImagenProducto() %>" width="100" height="100" draggable="false" />
					      				</td>
					      				<td><%= item.getNombreProducto()%></td>
					      				<td><span style="color: red;"><%= item.getStockProducto()%></span></td>
					      				<td><%= item.getStockMinimoProducto()%></td>
					      				<td>
					      					<button onclick="window.location.href='${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=obtener&idProducto=<%= item.getIdProducto() %>'" class="btn btn-dark">Seleccionar Producto</button>
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
			<!-- MODAL PRODUCTOS BAJO STOCK -->
			
			<!-- MODAL PRODUCTOS SIN STOCK -->
				<div class="modal fade" id="productosSinStock" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">Seleccionar Producto</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      	<table class="table table-bordered table-hover text-center" id="tablaProductosSinStock">
				      		<thead class="table-dark">
				      			<tr>
				      				<td>Imagen del producto</td>
				      				<td>Nombre</td>
				      				<td>Stock</td>
				      				<td>Stock Mínimo</td>
				      				<td>Acciones</td>
				      			</tr>
				      		</thead>
				      		
				      		<tbody>
				      			<%
									if(listaProductosSinStock != null) {
										for(Producto item: listaProductosSinStock) {
								%>
					      			<tr>
					      				<td>
					      					<img class="rounded" alt="Imagen Producto" src="${pageContext.request.contextPath}/<%= item.getImagenProducto() %>" width="100" height="100" draggable="false" />
					      				</td>
					      				<td><%= item.getNombreProducto()%></td>
					      				<td><span style="color: red;"><%= item.getStockProducto()%></span></td>
					      				<td><%= item.getStockMinimoProducto()%></td>
					      				<td>
					      					<button onclick="window.location.href='${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=obtener&idProducto=<%= item.getIdProducto() %>'" class="btn btn-dark">Seleccionar Producto</button>
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
			<!-- MODAL PRODUCTOS SIN STOCK -->
			
		</div>
	</div>
	
</body>

<script type="text/javascript" src="javascript/Cards.js"></script>

<!-- Boostrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JQUERY -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- DATATABLE -->
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$('#tablaProductosBajoStock').DataTable({
			columnDefs: [
				{ className: "text-center align-middle", targets: [0, 1, 2, 3, 4]},
				{ orderable: false, targets: [4]},
				{ searchable: false, targets: [4] }
			],
			pageLength: 20,
			language:{
				lengthMenu: "Mostrar _MENU_ productos por página",
				zeroRecords: "No se encontró ningún producto",
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
	
	$(document).ready(function(){
		$('#tablaProductosSinStock').DataTable({
			columnDefs: [
				{ className: "text-center align-middle", targets: [0, 1, 2, 3, 4]},
				{ orderable: false, targets: [4]},
				{ searchable: false, targets: [4] }
			],
			pageLength: 20,
			language:{
				lengthMenu: "Mostrar _MENU_ productos por página",
				zeroRecords: "No se encontró ningún producto",
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

</html>