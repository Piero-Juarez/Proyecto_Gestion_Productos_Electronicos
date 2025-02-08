<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.cliente.Cliente" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="css/Menu.css">
	<!-- DATATABLE -->
	<link href="https://cdn.datatables.net/2.1.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
	<link href="https://cdn.datatables.net/v/bs5/jszip-3.10.1/dt-2.1.8/b-3.2.0/b-html5-3.2.0/b-print-3.2.0/datatables.min.css" rel="stylesheet">
	<!-- CAMBIAR COLOR A LOS BOTONES -->
	<style type="text/css">
		.page-item.active .page-link{
			background-color: #212529 !important;
			color: azure !important;
		}
		
		.page-link{
			color: black !important;
		}
	</style>
	<title>Clientes</title>
	
</head>

<body>
	
	<%if(session.getAttribute("listaClientes")==null){
	%>
		<script>
			window.location.href="${pageContext.request.contextPath}/ClientsServlet?type=listar";
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
				 <h1 class="mb-5">Listado de Clientes</h1>
				 
				<div class="container d-flex w-100 justify-content-between align-items-center">
				  	<!-- Contenedor para los botones -->
				 	<div class="d-flex gap-2">
				 		
				 		 <button class="btn btn-dark btn-lg" data-bs-toggle="modal" data-bs-target="#agregarCliente">
                            Agregar Cliente <i class="bi bi-bookmark-plus-fill"></i>
                        </button>
				    	<button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight2" aria-controls="offcanvasRight">Descargar Información <i class="bi bi-clipboard2-fill"></i></button>
				  	</div>
				</div>
				  <!-- TABLA CLIENTES -->
				  <div class="tab table-responsive container w-100 mt-4">
					  <table  class="display table table-bordered table-hover text-center" id="example">
							<thead class="table-dark">
								<tr>
									<th class="px-4" >DNI</th>
									<th class="px-4" >RUC</th>
									<th class="px-4" >NOMBRES</th>
									<th class="px-4" >APELLIDOS</th>
									<th class="px-4" >RAZON SOCIAL</th>
									<th class="px-4">INFORME COMPLETO</th>
								</tr>
							</thead>
							<tbody>
							<%
							List<Cliente> listaCliente=(List<Cliente>) session.getAttribute("listaClientes");
								if(listaCliente != null){
									for(Cliente item:listaCliente){		
							%>
								<tr>
									<td><%=item.getDniCliente() %></td>
									<td><%=item.getRucCliente() %></td>
									<td ><%=item.getNombreCliente() %></td>
									<td><%=item.getApellidoCliente() %></td>
									<td><%=item.getRazonSocialCliente() %></td>
									<td>
										<a href="ClientsServlet?type=detalleCliente&idCliente=<%=item.getIdCliente()%>" class="btn btn-dark justify-content-center align-items-center">
											Ver más <i class="bi bi-eye-fill ps-1"></i>
										</a>
										
									</td>
								</tr>
							<%
									}
								}		
							%>
							</tbody>
						</table>
			
			
			<!-- MENÚ REPORTES -->
			<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight2" aria-labelledby="offcanvasRightLabel">
				<div class="offcanvas-header">
					<h2 class="offcanvas-title" id="offcanvasRightLabel">Descargar Información</h2>
			        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<p class="mb-4">Seleccione su formato favorito.</p>
					<button class="btn btn-danger text-center w-100 mb-2" id="exportPDF">
			        	PDF <i class="bi bi-file-earmark-pdf-fill"></i>
			        </button>
			        <button class="btn btn-success text-center w-100 mb-2" id="exportExcel">
			        	EXCEL <i class="bi bi-file-earmark-spreadsheet-fill"></i>
			        </button>
				</div>
			</div>
			</div>
			
		</div>
		 <!-- Modal Agregar Cliente-->
					<div class="modal fade" id="agregarCliente" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content">
					    <!-- Encabezado -->
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">Tipo de Cliente</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
						<!-- TipoCliente cliente -->
					      <div class="modal-body">
					        <p class="m-0">Seleccione el documento con el que se registrará al cliente.</p><br>
					        <form action="${pageContext.request.contextPath}/ClientsServlet?type=registrarCliente" method="post">
					        	<button type="submit" class="btn btn-dark me-2" data-bs-dismiss="modal" value="ClienteDni" name="tipoCliente">DNI <i class="bi bi-person-vcard-fill ms-1"></i></button>
					        	<button type="submit" class="btn btn-dark ms-2" data-bs-dismiss="modal" value="ClienteRuc" name="tipoCliente">RUC <i class="bi bi-postcard-fill ms-1"></i></button>
					        </form>
					      </div>			      
					    </div>
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
	
$(document).ready(function () {
	  $('#example').DataTable({
		columnDefs: [
			{ className: "text-center align-middle", targets: [0, 1, 2, 3, 4, 5]},
			{ orderable: false, targets: [5]},
			{ searchable: false, targets: [5] }
		],
		pageLength: 10,
	    language: {
	      lengthMenu: "Mostrar _MENU_ clientes por página",
	      zeroRecords: "No se encontró ningún cliente",
	      info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
	      infoEmpty: "Ningún cliente encontrado",
	      emptyTable: "No hay datos disponibles en la tabla",
	      search: "Buscar:",
	      loadingRecords: "Cargando...",
	      paginate: {
	        first: "Primero",
	        last: "Último",
	        next: "Siguiente",
	        previous: "Anterior",
	      },
	    },
	   
	  });
	});

<% if(listaCliente != null) { %>

	$(document).ready(function () {
	    // Datos obtenidos desde Scriptlet en JSP
	    var data = [
	        ["Nombres", "Apellidos", "DNI", "RUC", "Razón Social", "Nombre Comercial", "Dirección Fiscal"], // Encabezados
	        <% for (Cliente cli : listaCliente) { %>
	            ["<%= cli.getNombreCliente() %>",
	            	"<%= cli.getApellidoCliente() %>",
	            	"<%= cli.getDniCliente() %>",
	            	"<%= cli.getRucCliente() %>",
	            	"<%= cli.getRazonSocialCliente() %>",
	            	"<%= cli.getNombreComercialCliente() %>",
	            	"<%= cli.getDireccionFiscalCliente() %>"],
	        <% } %>
	    ];
	
	    // Exportar a Excel
	    $('#exportExcel').on('click', function () {
	        const ws = XLSX.utils.aoa_to_sheet(data);
	        const wb = XLSX.utils.book_new();
	        XLSX.utils.book_append_sheet(wb, ws, "Clientes Exportados");
	        XLSX.writeFile(wb, "informe_excel_clientes_<%= java.time.LocalDate.now() %>.xlsx");
	    });
	
	    // Exportar a PDF
	    $('#exportPDF').on('click', function () {
	        const docDefinition = {
	                // Orientación horizontal y tamaño de página A4
	                pageOrientation: 'landscape',
	                pageSize: 'A4',
	                content: [
	                    { text: 'Reporte de todos los Clientes', style: 'header' },
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
	
	        pdfMake.createPdf(docDefinition).download("lista_pdf_clientes_<%= java.time.LocalDate.now() %>.pdf");
	    });
	    
	});

<% } %>
</script>

</html>