<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.producto.Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.trabajador.Trabajador" %>
<%@ page import="entity.venta.VentasDiarias" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="entity.cliente.Cliente" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="css/Menu.css">
	<title>Reportes</title>
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
			<div class="col-xl-11 bg-ligth d-flex flex-column align-items-center justify-content-center mt-5 mb-5">
				<h1 class="mb-5">Reportes Generales</h1>
				<div class="container">
			        <div class="row">
			            <div class="col-md-6 col-12 mb-4">
			                <div id="chartProductosMasVendidos" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4">
			                <div id="chartVentasTrabajador" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4">
			                <div id="chartVentasDiarias" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4">
			                <div id="chartClientesMasUnidadesCompra" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4">
			                <div id="chartClientesMasDineorGastado" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			        </div>
    			</div>
			</div>
			
		</div>
	</div>
	
</body>
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	<script type="text/javascript">	
	var options = {
	          series: [
	          {
	            data: [
	            <%
					List<Producto> listadoProductos = (List<Producto>) session.getAttribute("listaProductosVendidos");
										
					if(listadoProductos != null) {
						for(Producto item: listadoProductos) {
				%>
	              {
	                x: '<%=item.getNombreProducto()%>',
	                y: <%=item.getCantidadesVendidas()%>
	              },
	              <%
						}
					}
				%>

	              //termina el array
	              ]
	          }
	        ],
	          legend: {
	          show: false
	        },
	        chart: {
	          height: 500,
	          type: 'treemap'
	        },
	        title: {
	          text: 'Los 10 productos más vendidos.'
	        },
	        dataLabels: {
	          enabled: true,
	          style: {
	            fontSize: '12px',
	          },
	          formatter: function(text, op) {
	            return [text, op.value]
	          },
	          offsetY: -4
	        },
	        plotOptions: {
	          treemap: {
	            enableShades: true,
	            shadeIntensity: 0.5,
	            reverseNegativeShade: true,
	            colorScale: {
	              ranges: [
	                {
	                  from: -6,
	                  to: 0,
	                  color: '#CD363A'
	                },
	                {
	                  from: 0.001,
	                  to: 6,
	                  color: '#52B12C'
	                }
	              ]
	            }
	          }
	        }
	        };

	        var chart = new ApexCharts(document.querySelector("#chartProductosMasVendidos"), options);
	        chart.render();
	      
	</script>
	<script type="text/javascript">
	 var options = {
	          series: [{
		      name: "Cantidades vendidas",
	          data: [
	        	  <%
					List<Trabajador> listaTrabajadorVentas = (List<Trabajador>) session.getAttribute("listaTrabajadorMasVenta");
										
					if(listaTrabajadorVentas != null) {
						for(Trabajador item: listaTrabajadorVentas) {
				  %>
	        	  <%=item.getVentasTrabajador()%>,
	        	  <%
						}
					}
	        	  %>
	        	  ]
	          
	        }],
	          chart: {
	          type: 'bar',
	          height: 350
	        },
	        title : {
	        	text: 'Los 10 vendedores con más ventas.'
	        },
	        plotOptions: {
	          bar: {
	            borderRadius: 4,
	            borderRadiusApplication: 'end',
	            horizontal: true,
	          }
	        },
	        dataLabels: {
	          enabled: false
	        },
	        xaxis: {
	          categories: [
	        	  <%
	        	  	if(listaTrabajadorVentas != null){
	        	  		for(Trabajador item: listaTrabajadorVentas){	
	        	  %>
	        	  '<%=item.getNombresTrabajador()%>',
	        	  <%
	        	  		}
	        	  	}
	        	  %>
	          ],
	        }
	        };

	        var chart = new ApexCharts(document.querySelector("#chartVentasTrabajador"), options);
	        chart.render();
	</script>
	<script type="text/javascript">
	var options = {
	          series: [{
	            name: "Unidades vendidas",
	            data: [
	            <%
	            	List<VentasDiarias> listaVentasDiarias = (List<VentasDiarias>) session.getAttribute("listaVentasDiarias");
	            
	            	if(listaVentasDiarias != null){
 						for(VentasDiarias item:listaVentasDiarias){
	            %>
	           
	            	<%=item.getCantidadTotal()%>,
	            <%
 					}
 				}
	            %>
	            	]
	            
	        }],
	          chart: {
	          width: 500,
	          height: 350,
	          type: 'line',
	          zoom: {
	            enabled: false
	          }
	        },
	        dataLabels: {
	          enabled: false
	        },
	        stroke: {
	          curve: 'straight'
	        },
	        title: {
	          text: 'Unidades vendidas de los últimos 10 dias.',
	          align: 'left'
	        },
	        grid: {
	          row: {
	            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
	            opacity: 0.5
	          },
	        },
	        xaxis: {
	          categories: [
	        	  <%
	        	  if(listaVentasDiarias != null){
						for(VentasDiarias item:listaVentasDiarias){
	        	  %>
	        	  '<%=item.getFechaVenta()%>',
	        	  <%
						}
					}
	        	  %>
	        	  ],
	        }
	        };

	        var chart = new ApexCharts(document.querySelector("#chartVentasDiarias"), options);
	        chart.render();
	      
	
	</script>
	<script type="text/javascript">
	const colors = ['#FF5733', '#33FF57', '#3357FF']; 

		var options = {
	          series: [{
		      name: "Unidades",
	          data: [
	        	  <%
	        	  	List<Cliente> listaMasCompras = (List<Cliente>) session.getAttribute("listaClientesMasCompras");
	        	  	if(listaMasCompras!=null){
	        	  		for(Cliente item:listaMasCompras){
	        	  %>
	        	  <%=item.getTotalUnidadesCompra()%>,
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
	              // console.log(chart, w, e)
	            }
	          }
	        },
	        title: {
		          text: 'Los 10 primeros clientes con más unidades compradas.',
		          align: 'left'
		        },
	        colors: colors,
	        plotOptions: {
	          bar: {
	            columnWidth: '45%',
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
	        	  if(listaMasCompras!=null){
	        	  		for(Cliente item:listaMasCompras){
	        	  %>
	            ['<%=item.getNombreCliente()%>','<%=item.getApellidoCliente()%>'],
	            <%
	            	}
	        	  }%> 
	          ],
	          labels: {
	            style: {
	              colors: colors,
	              fontSize: '12px'
	            }
	          }
	        }
	        };
	        var chart = new ApexCharts(document.querySelector("#chartClientesMasUnidadesCompra"), options);
	        chart.render();
	</script>
	<script type="text/javascript">
	var options = {
	          series: [{
	        name :"Dinero Gastado S/",
	          data: [
	        	  <%
	        	  	if(listaMasCompras!=null){
	        	  		for(Cliente item:listaMasCompras){
	        	  %>
	        	  '<%=item.getTotalDineroGastado()%>',
	        	  <%
	        	  		}
	        	  	}
	        	  %>
	        	  ]
	        }],
	          chart: {
	          type: 'bar',
	          width: 500,
	          height: 350
	          
	        },
	        title: {
		          text: 'Los 10 primeros clientes que más gastaron en productos.',
		          align: 'left'
		        },
	        plotOptions: {
	          bar: {
	            borderRadius: 4,
	            borderRadiusApplication: 'end',
	            horizontal: true,
	          }
	        },
	        dataLabels: {
	          enabled: false
	        },
	        xaxis: {
	          categories: [
	        	  <%
	        	  if(listaMasCompras!=null){
	        	  		for(Cliente item:listaMasCompras){
	        	  %>
	            ['<%=item.getNombreCliente()%>','<%=item.getApellidoCliente()%>'],
	            <%
	            	}
	        	  }%> 
	          ],
	        }
	        };

	        var chart = new ApexCharts(document.querySelector("#chartClientesMasDineorGastado"), options);
	        chart.render();
	      
	</script>

</html>