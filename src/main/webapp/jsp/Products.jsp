<%@page import="java.util.List"%>
<%@page import="entity.producto.Producto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="css/Menu.css">
	<title>Productos</title>
	
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

	<%
		if (session.getAttribute("listadoProductos") == null) {
	%>
		<script type="text/javascript">
			window.location.href="${pageContext.request.contextPath}/ProductServlet?service=Product";
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
				<h1 class="mb-5">Todos los Productos</h1>
				
				<div class="container d-flex w-100 justify-content-between align-items-center">
				  	<!-- Contenedor para los botones -->
				 	<div class="d-flex gap-2">
				    	<!-- <button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight1" aria-controls="offcanvasRight">Filtros <i class="bi bi-funnel-fill"></i></button> -->
				    	<button class="btn btn-dark btn-lg" onclick="window.location.href='jsp/AddProduct.jsp'">Agregar Producto <i class="bi bi-bookmark-plus-fill"></i></button>
				    	<button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight2" aria-controls="offcanvasRight">Descargar Información <i class="bi bi-clipboard2-fill"></i></button>
				  	</div>
				
				  	<!-- Contenedor para el input de búsqueda
				  	<div class="d-flex" style="max-width: 320px; width: 100%;">
				    	<input type="text" class="form-control me-2" placeholder="Buscar por nombre" />
				    	<button class="btn btn-dark d-flex" type="submit">Buscar <i class="bi bi-search ps-2"></i></button>
				  	</div> -->
				</div> 
				
				<div class="table-responsive container w-100 mt-4">
					<table class="table table-bordered table-hover text-center" id="tablaProductos">
						<thead class="table-dark">
					    	<tr>
					        	<th class="px-4">SKU</th>
					        	<th class="px-4">NOMBRE</th>
					        	<th class="px-4">CATEGORÍA</th>
					        	<th class="px-4">MARCA</th>
					        	<th class="px-4">PRECIO</th>
					        	<th class="px-4">STOCK</th>
					        	<th class="px-4">ESTADO</th>
					        	<th class="px-4">INFORME COMPLETO</th>
					      	</tr>
					    </thead>
					    <tbody>
					    	<%
								List<Producto> listadoProductos = (List<Producto>) session.getAttribute("listadoProductos");
									
								if(listadoProductos != null) {
									for(Producto item: listadoProductos) {
							%>
							
								<tr>
							        <td><%= item.getSkuProducto() %></td>
							        <td><%= item.getNombreProducto() %></td>
							        <td><%= item.getNombreCategoria() %></td>
							        <td><%= item.getNombreMarca() %></td>
							        <td>S/<%= item.getPrecioProducto() %></td>
							        <td><%= item.getStockProducto() %></td>
							        <td><%= item.getNombreEstadoProducto() %></td>
							        <td>
							        	<button onclick="window.location.href='${pageContext.request.contextPath}/ProductServlet?service=AddProduct&serviceAdd=obtener&idProducto=<%= item.getIdProducto() %>'" class="btn btn-dark justify-content-center align-items-center">
							        		Ver más <i class="bi bi-eye-fill ps-1"></i>
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
			
			<!-- MENÚ FILTROS 
			<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight1" aria-labelledby="offcanvasRightLabel">
				<div class="offcanvas-header">
					<h2 class="offcanvas-title" id="offcanvasRightLabel">Lista de Filtros</h2>
			        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
			        <p class="mb-4">Seleccione una opción de las listas.</p>
			        <div class="dropdown">
						<button class="btn btn-dark dropdown-toggle mb-3 w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					    	Categorías
						</button>
						<ul class="dropdown-menu w-100">
					    	<li><a class="dropdown-item" href="#">Consolas y Videojuegos</a></li>
					    	<li><a class="dropdown-item" href="#">Smartphones</a></li>
					    	<li><a class="dropdown-item" href="#">Cables USB</a></li>
						</ul>
					</div>
			        <div class="dropdown">
						<button class="btn btn-dark dropdown-toggle w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					    	Marcas
						</button>
						<ul class="dropdown-menu w-100">
					    	<li><a class="dropdown-item" href="#">Sony</a></li>
					    	<li><a class="dropdown-item" href="#">Nintendo</a></li>
						</ul>
					</div>
				</div>
			</div> -->
			
			<!-- MENÚ REPORTES -->
			<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight2" aria-labelledby="offcanvasRightLabel">
				<div class="offcanvas-header">
					<h2 class="offcanvas-title" id="offcanvasRightLabel">Descargar Reporte</h2>
			        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<p class="mb-4">Seleccione su formato favorito.</p>
					<button class="btn btn-danger text-center w-100 mb-2" id="exportPDF">
			        	PDF <i class="bi bi-file-earmark-pdf-fill ps-1"></i>
			        </button>
			        <button class="btn btn-success text-center w-100 mb-2" id="exportExcel">
			        	EXCEL <i class="bi bi-file-earmark-spreadsheet-fill ps-1"></i>
			        </button>
				</div>
			</div>
			
		</div>
	</div>

</body>

<!-- Boostrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JQUERY -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- DATATABLE -->
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.min.js"></script>

<!-- CREACIÓN DE PDF Y EXCEL -->
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

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
					zeroRecords: "No se encontro ningún producto",
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
		
	<% if(listadoProductos != null) { %>
        $(document).ready(function () {
            // Datos obtenidos desde Scriptlet en JSP
            var data = [
                ["SKU", "Nombre", "Categoría", "Modelo", "Marca", "Precio", "Stock", "Proveedor", "Peso", "Dimensiones", "Estado", "Garantía", "Color", "Fecha de Incorporación"], // Encabezados
                <% for (Producto pro : listadoProductos) { %>
                    ["<%= pro.getSkuProducto() %>",
                    	"<%= pro.getNombreProducto() %>",
                    	"<%= pro.getNombreCategoria() %>",
                    	"<%= pro.getModeloProducto() %>",
                    	"<%= pro.getNombreMarca() %>",
                    	<%= pro.getPrecioProducto() %>,
                    	<%= pro.getStockProducto() %>,
                    	"<%= pro.getNombreProveedor() %>",
                    	<%= pro.getPesoProducto() %>,
                    	"<%= pro.getDimensionesProducto() %>",
                    	"<%= pro.getNombreEstadoProducto() %>",
                    	"<%= pro.getGarantiaProducto() %>",
                    	"<%= pro.getColorProducto() %>",
                    	"<%= pro.getFechaIncorporacionProducto() %>"],

                <% } %>
            ];

            // Exportar a Excel
            $('#exportExcel').on('click', function () {
                const ws = XLSX.utils.aoa_to_sheet(data);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "Productos Exportados");
                XLSX.writeFile(wb, "informe_excel_productos_<%= java.time.LocalDate.now() %>.xlsx");
            });

            // Exportar a PDF
            $('#exportPDF').on('click', function () {
                const docDefinition = {
                        // Orientación horizontal y tamaño de página A4
                        pageOrientation: 'landscape',
                        pageSize: 'A4',
                        content: [
                            { text: 'Reporte de todos los Productos', style: 'header' },
                            {
                                table: {
                                    headerRows: 1,
                                    // Establece anchos automáticos para cada columna
                                    widths: Array(data[0].length).fill('auto'),
                                    body: data
                                },
                                // Aplica un fondo al encabezado para resaltarlo
                                layout: {
                                    fillColor: function (rowIndex, node, columnIndex) {
                                        return rowIndex === 0 ? '#CCCCCC' : null;
                                    }
                                }
                            }
                        ],
                        styles: {
                            header: {
                                fontSize: 16,
                                bold: true,
                                margin: [0, 0, 0, 10]
                            }
                        },
                        // Ajusta el tamaño de fuente por defecto para que quepa más contenido
                        defaultStyle: {
                            fontSize: 8
                        }
                    };

                pdfMake.createPdf(docDefinition).download("lista_pdf_productos_<%= java.time.LocalDate.now() %>.pdf");
            });
            
        });
    <% } %>
    </script>

</html>