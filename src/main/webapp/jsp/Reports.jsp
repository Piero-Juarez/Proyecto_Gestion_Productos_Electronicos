<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.producto.Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.trabajador.Trabajador" %>
<%@ page import="entity.venta.VentasDiarias" %>
<%@ page import="entity.venta.Venta" %>
<%@ page import="entity.cliente.ClienteDocumento" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="entity.cliente.Cliente" %>
<%@ page import="entity.venta.MetodoPagoPreferido" %>
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
				
					<div class="text-center mb-4">
				        <button class="btn btn-dark btn-lg filter-btn mx-2" data-filter="*">Todos</button>
				        <button class="btn btn-dark btn-lg filter-btn mx-2" data-filter=".Cliente">Clientes</button>
				        <button class="btn btn-dark btn-lg filter-btn mx-2" data-filter=".Productos">Productos</button>				     
				        <button class="btn btn-dark btn-lg filter-btn mx-2" data-filter=".Transacciones">Ventas</button>
				    </div>
				    
			        <div class="row graficos">
			            <div class="col-md-6 col-12 mb-4 Productos">
			                <div id="chartProductosMasVendidos" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Transacciones" >
			                <div id="chartVentasTrabajador" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Transacciones">
			                <div id="chartVentasDiarias" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Cliente">
			                <div id="chartClientesMasUnidadesCompra" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Cliente">
			                <div id="chartClientesMasDineorGastado" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Productos">
			                <div id="chartStockProductos" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Transacciones">
			                <div id="chartVentasCategoria" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Productos">
			                <div id="chartProductosMasIngresos" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Cliente">
			                <div id="charMetodoPreferidoCliente" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Transacciones">
			                <div id="charMontoTotalDiario" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Productos">
			                <div id="chartProductosPorCategoria" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			            <div class="col-md-6 col-12 mb-4 Cliente">
			                <div id="chartClienteSegunDocumento" class="border rounded p-3 shadow bg-white"></div>
			            </div>
			        </div>
			        
    			</div>
			</div>
			
		</div>
	</div>
	
</body>
	<script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	
	<script type="text/javascript">
    
		window.addEventListener('load', function() {
		    var $grid = document.querySelector('.graficos');
	
		    $grid.style.minHeight = $grid.offsetHeight + 'px';
	
		    var iso = new Isotope($grid, {
		        itemSelector: '.col-md-6',
		        layoutMode: 'fitRows'
		    });
	
		    iso.layout();
	
		    document.querySelectorAll('.filter-btn').forEach(button => {
		        button.addEventListener('click', function () {
		            let filterValue = this.getAttribute('data-filter');
		            iso.arrange({ filter: filterValue });
	
		            setTimeout(() => {
		                $grid.style.minHeight = $grid.scrollHeight + 'px';
		            }, 300);
		        });
		    });
		});

	</script>
	
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

<!-- Stock Productos -->
	<script type="text/javascript">
	let colors4 = ['#D2691E','#4682B4', '#800080'];
		var options = {
		          series: [{
		       	  name:"Unidades",
		          data: [
		        	  <%
		        	  List<Producto> ListaStock = (List<Producto>) session.getAttribute("listaStockProducto");
						
						if(ListaStock != null) {
							for(Producto item: ListaStock) {
					  %>
							
		        	  <%=item.getStockProducto()%>,
		        	  
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
		        colors:colors4,
		        title: {
			          text: 'Stock Actual de todos los productos.',
			          align: 'left'
			        },
		        plotOptions: {
		          bar: {
		            borderRadius: 4,
		            borderRadiusApplication: 'end',
		            horizontal: true,
		            distributed: true
		          }
		        },
		        dataLabels: {
		          enabled: false
		        },
		        xaxis: {
		          categories: [
		        	  <%
		        	  if(ListaStock != null) {
							for(Producto item: ListaStock) {
		        	  %>
		        	['<%=item.getNombreProducto()%>'],
		        	 <%
							}
						}
		        	 %>
		          ],
		        }
		        };
		        var chart = new ApexCharts(document.querySelector("#chartStockProductos"), options);
		        chart.render();
	</script>
	<!-- Ventas segun Categoria -->
	<script type="text/javascript">
		var options = {
	          series: [
	        	  <%
	        	  List<Producto> ventaCategoria = (List<Producto>) session.getAttribute("listaVentaCategoria");
	        	  if(ventaCategoria != null){
	        			for(Producto item:ventaCategoria){
	        				
	        	  %>
	        	  <%=item.getStockProducto()%>,
	        	  <%
	        			}
	        		}
	        	  %>
	        	  ],
	          chart: {
	          width: '100%',
	          height: '100%',
	          type: 'pie',
	        },
	        labels: [
	        	<%
	        		
	        		if(ventaCategoria != null){
	        			for(Producto item:ventaCategoria){
	        	%>
	          '<%=item.getNombreCategoria()%>',
	         
	          <%
	        		}
	        	}
	          %>
	        ],
	        theme: {
	          monochrome: {
	            enabled: true,
	          },
	        },
	        title: {
		          text: 'Venta de unidades según la categoría.',
		          align: 'left'
		        },
	        plotOptions: {
	          pie: {
	            dataLabels: {
	              offset: -5,
	            },
	          },
	        },
	        grid: {
	          padding: {
	            top: 0,
	            bottom: 0,
	            left: 0,
	            right: 0,
	          },
	        },
	        dataLabels: {
	          formatter(val, opts) {
	            const name = opts.w.globals.labels[opts.seriesIndex]
	            return [name, val.toFixed(1) + '%']
	          },
	        },
	        legend: {
	          show: false,
	        },
	        };

	        var chart = new ApexCharts(document.querySelector("#chartVentasCategoria"), options);
	        chart.render();
	</script>
	<!-- Productos con mayores ingresos -->
	<script type="text/javascript">
		let colors3 = ['#8B0000', '#00008B', '#228B22'];
		var options = {
	          series: [{
	  	      name :"Dinero S/",
	          data: [
	        	  <%
	        	  	List<Producto> listaProductoMasIngreso = (List<Producto>) session.getAttribute("listaProducosMasIngresos");
	        	  		if(listaProductoMasIngreso != null){
	        	  			for(Producto item:listaProductoMasIngreso){
	        	  %>
	        	  <%=item.getPrecioProducto()%>, 
	        	  
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
	        colors:colors3,
	        title: {
		          text: 'Los 10 Productos que más dinero generan.',
		          align: 'left'
		        },
	        plotOptions: {
	          bar: {
	            borderRadius: 4,
	            borderRadiusApplication: 'end',
	            horizontal: true,
	            distributed: true
	          }
	        },
	        dataLabels: {
	          enabled: false
	        },
	        xaxis: {
	          categories: [
	        	  <%
	        	  if(listaProductoMasIngreso != null){
      	  			for(Producto item:listaProductoMasIngreso){
	        	  %>
	        	  '<%=item.getNombreProducto()%>',
	            <%
      	  			}
      	  		}
	            %>
	          ],
	        }
	        };

	        var chart = new ApexCharts(document.querySelector("#chartProductosMasIngresos"), options);
	        chart.render();

	</script>
	<!-- Preferencias de Metodo de pago -->
	<script type="text/javascript">
	<%List<MetodoPagoPreferido> listaMetodoPreferido = (List<MetodoPagoPreferido>) session.getAttribute("listaMetodosPreferidos");%>
    var datosMetodoPago = [
        <% if(listaMetodoPreferido != null){ 
            for(MetodoPagoPreferido item : listaMetodoPreferido) { %>
                <%= item.getContadorMetodoPago() %>,
        <% } } %>
    ];

    var etiquetasMetodoPago = [
        <% if(listaMetodoPreferido != null){ 
            for(MetodoPagoPreferido item : listaMetodoPreferido) { %>
                '<%= item.getNombreMetodoPago() %>', 
        <% } } %>
    ];

    var options = {
        series: datosMetodoPago,
        chart: {
            width: 450,
            type: 'pie',
            animations: {
                enabled: true,
                easing: 'easeinout',
                speed: 1000
            }
        },
        labels: etiquetasMetodoPago,
        title: {
            text: 'Preferencia de Método de Pago de los Clientes.',
            align: 'center',
            style: {
                fontSize: '18px',
                fontWeight: 'bold',
                color: '#333'
            }
        },
        colors: ['#FF4560', '#008FFB', '#00E396', '#FEB019', '#775DD0'],
        legend: {
            position: 'right',
            fontSize: '14px',
            markers: {
                width: 12,
                height: 12
            }
        },
        tooltip: {
            enabled: true,
            y: {
                formatter: function(val) {
                    return val + " transacciones";
                }
            }
        },
        dataLabels: {
            enabled: true,
            style: {
                fontSize: '14px',
                fontWeight: 'bold'
            }
        },
        responsive: [{
            breakpoint: 480,
            options: {
                chart: {
                    width: 280
                },
                legend: {
                    position: 'bottom'
                }
            }
        }]
    };

    var chart = new ApexCharts(document.querySelector("#charMetodoPreferidoCliente"), options);
    chart.render();
	</script>
	<!-- Monto Total Diario-->
	<script type="text/javascript">
	<%
	List<Venta> listaMontoTotalDiario = (List<Venta>) session.getAttribute("listaMontoTotalDiario");
	%>
	var datosMontoTotal = [
        <% if(listaMontoTotalDiario != null){ 
            for(Venta item : listaMontoTotalDiario) { %>
                <%= item.getMontoTotal() %>,
        <% } } %>
    ];

    var fechas = [
        <% if(listaMontoTotalDiario != null){ 
            for(Venta item : listaMontoTotalDiario) { %>
                '<%= item.getFecha() %>',
        <% } } %>
    ];

    
    var options = {
        series: [{
            name: "Monto Total Diario",
            data: datosMontoTotal
        }],
        chart: {
            type: 'area',
            height: 350,
            zoom: { enabled: false }
        },
        dataLabels: { enabled: false },
        stroke: { curve: 'straight' },
        title: {
            text: 'Ventas Diarias',
            align: 'left'
        },
        subtitle: {
            text: 'Monto Total por Día',
            align: 'left'
        },
        labels: fechas, 
        xaxis: {
            type: 'datetime',
        },
        yaxis: {
            opposite: true
        },
        legend: {
            horizontalAlign: 'left'
        }
    };

    var chart = new ApexCharts(document.querySelector("#charMontoTotalDiario"), options);
    chart.render();
	</script>
	<!-- Producto Por Categoria -->
	<script type="text/javascript">
	
		//const colors = ['#FF5733', '#33FF57', '#3357FF']; 
	
		var options = {
	          series: [{
		      name: "Productos",
	          data: [
	        	  <%
	        		List<Producto> listaProductoPorCategoria = (List<Producto>) session.getAttribute("listaProductoPorCategoria");
	        	  	if(listaProductoPorCategoria!=null){
	        	  		for(Producto item:listaProductoPorCategoria){
	        	  %>
	        	  <%=item.getStockProducto()%>,
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
		          text: 'Cantidad de productos de cada categoría.',
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
	        	  if(listaProductoPorCategoria!=null){
	        	  		for(Producto item:listaProductoPorCategoria){
	        	  %>
	            ['<%=item.getNombreCategoria()%>'],
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
	        var chart = new ApexCharts(document.querySelector("#chartProductosPorCategoria"), options);
	        chart.render();
	</script>
	<!-- Clientes Ruc y DNI -->
	<script type="text/javascript">
		let colors2 = ["#00008B","#FF0000"]
		var options = {
		          series: [{
		          name : "Personas",
		          data: [
		        	  <%
		        	  List<ClienteDocumento> listaClienteDocumento = (List<ClienteDocumento>) session.getAttribute("listaClientePorDocumento");
		        	  if(listaClienteDocumento!=null){
		        	  		for(ClienteDocumento item:listaClienteDocumento){
		        	  %>
		        	  <%=item.getContadorClienteDocumento()%>,
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
		        colors: colors2,
		        title: {
			          text: 'Cantidad de clientes según el tipo de documento.',
			          align: 'left'
			        },
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
		        	  if(listaClienteDocumento!=null){
		        	  		for(ClienteDocumento item:listaClienteDocumento){
		        	  %>
		            ['<%=item.getTipoDocumento()%>'],
		            <%
		        	  		}
		        	  	}
		            %>
		          ],
		          labels: {
		            style: {
		              colors: colors2,
		              fontSize: '12px'
		            }
		          }
		        }
		        };

		        var chart = new ApexCharts(document.querySelector("#chartClienteSegunDocumento"), options);
		        chart.render();
		      
	</script>

</html>