<%@page import="interfaces.DetalleVentaInterface"%>
<%@page import="entity.detalleVenta.DetalleVenta"%>
<%@page import="entity.venta.MetodoPago"%>
<%@page import="interfaces.VentaInterface"%>
<%@page import="entity.venta.ComprobantePago"%>
<%@page import="entity.trabajador.Trabajador"%>
<%@page import="interfaces.TrabajadorInterface"%>
<%@page import="entity.cliente.Cliente"%>
<%@page import="interfaces.ClienteInterface"%>
<%@page import="dao.DAOFactory"%>
<%@page import="entity.venta.Venta"%>
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
	<title>Transacciones</title>
	
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
		DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
		ClienteInterface daoCliente = daoFactory.getClienteDAO();
		TrabajadorInterface daoTrabajador = daoFactory.getTrabajadorDAO();
		VentaInterface daoVenta = daoFactory.getVentaDAO();
		DetalleVentaInterface daoDetalleVenta = daoFactory.getDetalleVentaDAO();
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
				<% if (session.getAttribute("textoFechaInicio") != null && session.getAttribute("textoFechaFin") != null) { %>
					<h1 class="mb-5">Transacciones del (<%= session.getAttribute("textoFechaInicio") %>) hasta el (<%= session.getAttribute("textoFechaFin") %>)</h1>
				<% } else { %>
					<h1 class="mb-5">Todas las Transacciones</h1>
				<% } %>
				<div class="container d-flex w-100 justify-content-between align-items-center">
				  	<!-- Contenedor para los botones -->
				 	<div class="d-flex gap-2">
				    	<button class="btn btn-dark btn-lg" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight2" aria-controls="offcanvasRight">Descargar Información <i class="bi bi-clipboard2-fill ms-1"></i></button>
				    	
				    	<div class="dropdown">
						  <button type="button" class="btn btn-dark btn-lg dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
						    Filtrar por Fecha <i class="bi bi-calendar-fill ms-1"></i>
						  </button>
						  <form class="dropdown-menu p-4" method="post" action="${pageContext.request.contextPath}/TransactionsServlet?service=filtrarPorFecha">
						    <div class="mb-3">
						      <label for="fehaInicioFiltro" class="form-label">Fecha Inicio</label>
						      <input type="date" class="form-control" id="fehaInicioFiltro" name="fehaInicioFiltro" required="required" />
						    </div>
						    <div class="mb-3">
						      <label for="fechaFinFiltro" class="form-label">Fecha Fin</label>
						      <input type="date" class="form-control" id="fechaFinFiltro" name="fechaFinFiltro" required="required" />
						    </div>
						    <button type="submit" class="btn btn-dark">Buscar <i class="bi bi-search ms-1"></i></button>
						  </form>
						</div>
						
						<% if (session.getAttribute("mensajeBorrarFiltro") != null) { %>
							<button onclick="window.location.href='${pageContext.request.contextPath}/TransactionsServlet?service=listarVentas'" class="btn btn-dark btn-lg"><%= session.getAttribute("mensajeBorrarFiltro") %> <i class="bi bi-x-circle-fill ms-1"></i></button>
				  		<% } %>
				  	</div>
				</div>
				
				<div class="table-responsive container w-100 mt-4">
					<table class="table table-bordered table-hover text-center" id="tablaVentas">
						<thead class="table-dark">
					    	<tr>
					        	<th class="px-4">ID</th>
					        	<th class="px-4">TIPO DE VENTA</th>
					        	<th class="px-4">FECHA</th>
					        	<th class="px-4">HORA</th>
					        	<th class="px-4">CLIENTE</th>
					        	<th class="px-4">TRABAJADOR</th>
					        	<th class="px-4">INFORME COMPLETO</th>
					      	</tr>
					    </thead>
					    <tbody>
					    	<%
								List<Venta> listadoVentas = (List<Venta>) session.getAttribute("listaVentas");
									
								if(listadoVentas != null) {
									for(Venta item: listadoVentas) {
							%>
							
								<%
									Cliente objetoCliente = daoCliente.encontrarCliente(item.getIdCliente());
									Trabajador objetoTrabajador = daoTrabajador.encontrarTrabajador(item.getIdTrabajador());
									ComprobantePago objetoComprobantePago = daoVenta.encontrarComprobantePago(item.getIdComprobantePago());
								%>
							
								<tr>
									<td><%= item.getIdVenta() %></td>
									<td><%= objetoComprobantePago.getNombreComprobantePago() %></td>
							        <td><%= item.getFecha() %></td>
							        <td><%= item.getHora() %></td>
							        <td><%= objetoCliente.getNombreCliente() + " " + objetoCliente.getApellidoCliente() %></td>
							        <td><%= objetoTrabajador.getNombresTrabajador() %></td>
							        <td>
							        	<button onclick="window.location.href='${pageContext.request.contextPath}/TransactionsServlet?service=detalleVenta&idVenta=<%= item.getIdVenta() %>'" class="btn btn-dark justify-content-center align-items-center">
							        		Ver Más <i class="bi bi-eye-fill ps-1"></i>
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
		$('#tablaVentas').DataTable({
			columnDefs: [
				{ className: "text-center align-middle", targets: [0, 1, 2, 3, 4, 5, 6]},
				{ orderable: false, targets: [6]},
				{ searchable: false, targets: [6] }
			],
			pageLength: 20,
			language:{
				lengthMenu: "Mostrar _MENU_ ventas por página",
				zeroRecords: "No se encontro ninguna venta",
				info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
				infoEmpty:"Ninguna venta encontrada",
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
	
<% if(listadoVentas != null) { %>
    $(document).ready(function () {
        // Datos obtenidos desde Scriptlet en JSP
        var data = [
            ["ID", "Tipo de Venta", "Fecha", "Hora", "Trabajador", "Cargo", "Cliente", "DNI", "RUC", "Monto Total", "Método de Pago", "Dinero Cliente", "Vuelto Cliente", "Productos Adquiridos"], // Encabezados
            <% for (Venta ven : listadoVentas) { %>
				<%
					Cliente objetoCliente = daoCliente.encontrarCliente(ven.getIdCliente());
					Trabajador objetoTrabajador = daoTrabajador.encontrarTrabajador(ven.getIdTrabajador());
					ComprobantePago objetoComprobantePago = daoVenta.encontrarComprobantePago(ven.getIdComprobantePago());
					MetodoPago objetoMetodoPago = daoVenta.encontrarMetodoPago(ven.getIdMetodoPago());
					List<DetalleVenta> listaDetalleVenta = daoDetalleVenta.listarPorIdVenta(ven.getIdVenta());
				%>
                ["<%= ven.getIdVenta() %>",
                	"<%= objetoComprobantePago.getNombreComprobantePago() %>",
                	"<%= ven.getFecha() %>",
                	"<%= ven.getHora() %>",	
                	"<%= objetoTrabajador.getNombresTrabajador() %>",
                	"<%= objetoTrabajador.getNombreCargo() %>",
                	"<%= objetoCliente.getNombreCliente() + " " + objetoCliente.getApellidoCliente() %>",
                	"<%= objetoCliente.getDniCliente() %>",
                	"<%= objetoCliente.getRucCliente() %>",
                	<%= ven.getMontoTotal() %>,
                	"<%= objetoMetodoPago.getNombreMetodoPago() %>",
                	<%= ven.getDineroCliente() %>,
                	<%= ven.getVueltoEfectivo() %>,
                	<%= listaDetalleVenta.size() %>],

            <% } %>
        ];

        // Exportar a Excel
        $('#exportExcel').on('click', function () {
            const ws = XLSX.utils.aoa_to_sheet(data);
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "Transacciones Exportadas");
            XLSX.writeFile(wb, "informe_excel_transacciones_<%= java.time.LocalDate.now() %>.xlsx");
        });

        // Exportar a PDF
        $('#exportPDF').on('click', function () {
            const docDefinition = {
                    // Orientación horizontal y tamaño de página A4
                    pageOrientation: 'landscape',
                    pageSize: 'A4',
                    content: [
                        { text: 'Reporte de todas las Transacciones', style: 'header' },
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

            pdfMake.createPdf(docDefinition).download("lista_pdf_transacciones_<%= java.time.LocalDate.now() %>.pdf");
        });
        
    });
<% } %>
</script>

<script>
  const today = new Date().toISOString().split("T")[0];

  document.getElementById("fehaInicioFiltro").setAttribute("max", today);
  document.getElementById("fechaFinFiltro").setAttribute("max", today);
</script>

</html>