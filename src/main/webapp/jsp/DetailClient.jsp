<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="entity.cliente.Cliente" %>
<%@ page import="entity.producto.Producto" %>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/Menu.css">
    <title>Detalles del Cliente</title>

    <style>
        .section-title {
            font-weight: 600;
            font-size: 1.3rem;
            color: #343a40;
            border-bottom: 2px solid #212529;
            display: inline-block;
            margin-bottom: 10px;
        }
        .client-info {
            font-size: 1.1rem;
            color: #495057;
        }
        .client-info span {
            font-weight: 500;
            color: #212529;
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

                <div class="container py-5">
                    <!-- Título -->
                    <h1 class="text-center mb-5">Detalles del Cliente</h1>

                    <!-- Contenedor Principal -->
                    <div class="row align-items-start justify-content-center">

                        <!-- Ícono del Cliente -->
                        <div class="col-lg-4 mb-4 mb-lg-0 text-center">
							<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" fill="currentColor" class="bi bi-file-person-fill" viewBox="0 0 16 16">
							  <path d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2m-1 7a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-3 4c2.623 0 4.146.826 5 1.755V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1v-1.245C3.854 11.825 5.377 11 8 11"/>
							</svg>
                        </div>

                        <!-- Información del Cliente -->
                        <div class="col-lg-8">
                            <!-- Sección: Información Básica -->
                            <div class="client-section mb-4">
                                <h2 class="section-title mb-4">Información Básica</h2>
                                <div class="row client-info">
                                    <div class="col-md-6">
                                    <% 
                                    Cliente clienteForm=(Cliente) session.getAttribute("detallesCliente");
                                    if(clienteForm == null){
                                    System.out.print(" id del cliente de detalle cliente es nulo ");
                                    }
                                    %>
                                    
                                        <p>ID Cliente: <span><%= clienteForm.getIdCliente() %></span></p>
                                        <p>Nombre: <span><%= clienteForm.getNombreCliente() %></span></p>
                                        <p>Apellido: <span><%= clienteForm.getApellidoCliente() %></span></p>
                                        <p>DNI: <span><%=clienteForm.getDniCliente() %></span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p>Razón Social: <span><%=clienteForm.getRazonSocialCliente() %></span></p>
                                        <p>Nombre Comercial: <span><%=clienteForm.getNombreComercialCliente() %></span></p>
                                        <p>Dirección Fiscal: <span><%=clienteForm.getDireccionFiscalCliente() %></span></p>
                                        <p>RUC: <span><%=clienteForm.getRucCliente() %></span></p>
                                        
                                    </div>
                                </div>
                            </div>
							<!-- Sección: Estadísticas Cliente -->
                            <div class="client-section mb-4">
                            <%        	List<Producto> listaDeCompras = (List<Producto>) session.getAttribute("listaCompras"); 
                            	if(listaDeCompras.size() > 0){
                            %>
                                <h2 class="section-title mb-4">Estadísticas</h2>
                                <div class="row client-info">
                               		<div id="chart"></div>     
                                </div>
                            <%
                            	}
                            	else{
                           	%>
                           	<h2 class="section-title mb-4">Información Básica</h2>
                           	<p><strong>Cliente aún no tiene compras.</strong></p>
                           	<%
                           		}
                            %>
                            </div>
                        </div>
                        
                    </div>
	
                    <!-- Botones -->
                    <div class="text-center mt-4">
                        <button onclick="window.location.href='jsp/Clients.jsp'" class="btn btn-dark px-5 mx-2">
                            Regresar <i class="bi bi-box-arrow-left ps-1"></i>
                        </button>
                        <button class="btn btn-dark px-5 mx-2" data-bs-toggle="modal" data-bs-target="#editarCliente">
                            Editar Cliente <i class="bi bi-pencil-square ps-1"></i>
                        </button>
                        <button class="btn btn-dark px-5 mx-2" data-bs-toggle="modal" data-bs-target="#eliminarCliente">
                            Eliminar Cliente <i class="bi bi-trash-fill ps-1"></i>
                        </button>
                    </div>
                    
                    <!-- Modal Editar Cliente-->
					<div class="modal fade" id="editarCliente" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					    <!-- Encabezado -->
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">Editar Cliente</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
						<!-- Editar cliente -->
					      <div class="modal-body">
					       	<form id="form" action="${pageContext.request.contextPath}/ClientsServlet?type=actualizar" class="form-group" method="post">
					       	
					       		<input type="hidden" value="<%= clienteForm.getIdCliente() %>" name="txtidCliente">
					       		
							  	<div class="form-group">
							  		<label>Nombres del Cliente</label>
							  		<input class="form-control" type="text" name="txtNombreCliente" value="<%=clienteForm.getNombreCliente() %>" >
							  	</div>
							  	<div class="form-group">
							  		<label>Apellidos del trabajador</label>
									<input class="form-control" type="text" name="txtApellidoCliente" value="<%=clienteForm.getApellidoCliente() %>">
							  	</div>

								  	<div class="form-group">
								  		<label>DNI</label>
										<input class="form-control" type="text" name="txtDniCliente" value="<%= clienteForm.getDniCliente()%> ">
								  	</div>

							  	<div class="form-group">
							  		<label>Razon Social</label>
									<input class="form-control" type="text" name="txtRazonSocial" value="<%=clienteForm.getRazonSocialCliente() %>">
							  	</div>
							  	<div class="form-group">
							  		<label>Nombre Comercial</label>
									<input class="form-control" type="text" name="txtNombreComercial" value="<%=clienteForm.getNombreComercialCliente() %>">
							  	</div>
							  	<div class="form-group">
							  		<label>Direccion Fiscal</label>
									<input class="form-control" type="text" name="txtDireccionFiscal" value="<%=clienteForm.getDireccionFiscalCliente() %>">
							  	</div>
							  	
								  	<div class="form-group">
								  		<label>RUC</label>
										<input class="form-control" type="text" name="txtRuc" value="<%=clienteForm.getRucCliente() %>">
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
					 <!-- Modal Eliminar Cliente-->
					<div class="modal fade" id="eliminarCliente" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					    <!-- Encabezado -->
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar Producto</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
						<!-- Eliminar cliente -->
					      <div class="modal-body">
					        <p>¿Estas seguro de eliminar al cliente seleccionado?</p><br>
					        <p>Esta accion no se podra deshacer	</p>
					        <form id="formEliminar" action="${pageContext.request.contextPath}/ClientsServlet?type=eliminar" method="post">
					        	<input type="hidden" value="<%= clienteForm.getIdCliente() %>" name="idClienteDelete"/>
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
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script>
const colors = ['#FF5733', '#33FF57', '#3357FF']; 

var options = {
        series: [{
        	
        data: [
        	<% if(listaDeCompras!=null){
        		for(Producto item: listaDeCompras){
        	%>
        	<%= item.getStockProducto()%>, 
        	<%
        		}
        	}
        	%>
        	]
      }],
        chart: {
        height: 350,
        type: 'bar',
        events: {
          click: function(chart, w, e) {
             //console.log(chart, w, e)
          }
        }
      },
      title : {
      	text: 'Productos adquiridos.'
      },
      colors: colors,
      plotOptions: {
        bar: {
          columnWidth: '20%',
          distributed: true,
        }
      },
      dataLabels: {
        enabled: false
      },
      legend: {
        show: false
      },
      xaxis: {
        categories: [
        	<%
        	
        		if(listaDeCompras != null){
        			for(Producto item: listaDeCompras){
        	%>
        	'<%=item.getNombreProducto()%>' ,
        	<% 
        			}
        		}
        	%>
          
        ],
        labels: {
          style: {
            colors: colors,
            fontSize: '12px'
          }
        }
      }
      };

      var chart = new ApexCharts(document.querySelector("#chart"), options);
      chart.render(); 	
   
</script>
</body>

</html>
