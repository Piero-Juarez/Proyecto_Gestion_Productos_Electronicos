<%@page import="interfaces.ProductoInterface"%>
<%@page import="dao.DAOFactory"%>
<%@page import="entity.detalleVenta.DetalleVenta"%>
<%@page import="entity.producto.Producto"%>
<%@page import="entity.producto.EstadoProducto"%>
<%@page import="entity.producto.Proveedor"%>
<%@page import="entity.producto.Marca"%>
<%@page import="entity.producto.Categoria"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<base href="${pageContext.request.contextPath}/">
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		crossorigin="anonymous">
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="css/Menu.css">
	<title>Informe Transacción</title>
	
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
	</style>
</head>

<body>

	<div class="container-fluid vh-100 d-flex flex-column">
		<div class="row flex-grow-1">

			<!-- MENÚ -->
			<div
				class="col-0 col-xl-1 text-white bg-dark d-flex flex-column align-items-center justify-content-center estilos-nav">
				<div id="contenido-nav">
					<%@ include file="Menu.jsp"%>
				</div>
			</div>

			<!-- CONTENIDO -->
			<div
				class="col-xl-11 bg-ligth d-flex flex-column align-items-center justify-content-center mt-5 mb-5">

				<div class="container py-5">
					<!-- Título -->
					<h1 class="text-center mb-5">Detalles de Transacción</h1>

					<!-- Contenedor Principal -->
					<div class="row align-items-start">
						<!-- Imagen del Producto
			            <div class="col-lg-4 mb-4 mb-lg-0 text-center text-lg-start">
			                <img src="${pageContext.request.contextPath}/" alt="Foto del Producto" class="product-img" draggable="false">
			            </div> -->

						<!-- Sección: Venta -->
						<div class="col-6 product-section mb-4 text-center">
							<h2 class="section-title">Datos de la venta</h2>
							<div class="row product-info">
								<div class="col">
									<p>
										Tipo de venta: <span><%= request.getAttribute("comprobantePagoEnviado") %></span>
									</p>
									<p>
										Fecha: <span><%= request.getAttribute("fechaEnviada") %></span>
									</p>
									<p>
										Hora: <span><%= request.getAttribute("horaEnviada") %></span>
									</p>
									<p>
										Trabajador: <span><%= request.getAttribute("nombreTrabajadorEnviado") %></span>
									</p>
									<p>
										Cargo: <span><%= request.getAttribute("cargoTrabajadorEnviado") %></span>
									</p>
									<p>
										Monto total: <span>S/ <%= request.getAttribute("montoTotalEnviado") %></span>
									</p>
									<p>
										Método de Pago: <span><%= request.getAttribute("metodoPagoEnviado") %></span>
									</p>
									<p>
										Dinero recibido: <span><%= request.getAttribute("dineroClienteEnviado") %></span>
									</p>
									<p>
										Vuelto entregado: <span><%= request.getAttribute("vueltoClienteEnviado") %></span>
									</p>
								</div>
							</div>
						</div>

						<!-- Sección: Cliente -->
						<div class="col-6 product-section mb-4 text-center">
							<h2 class="section-title">Datos del cliente</h2>
							<div class="row product-info">
								<div class="col">
									<p>
										Nombres: <span><%= request.getAttribute("nombreClienteEnviado") %></span>
									</p>
									<p>
										Apellidos: <span><%= request.getAttribute("apellidoClienteEnviado") %></span>
									</p>
									<% if (String.valueOf(request.getAttribute("comprobantePagoEnviado")).equalsIgnoreCase("Boleta")) { %>
										<p>DNI: <span><%= request.getAttribute("dniClienteEnviado") %></span></p>
									<% } else { %>
										<p>RUC: <span><%= request.getAttribute("rucClienteClienteEnviado") %></span></p>
										<p>Razón social: <span><%= request.getAttribute("razonSocialClienteEnviado") %></span></p>
										<p>Nombre comercial: <span><%= request.getAttribute("nombreComercialClienteEnviado") %></span></p>
										<p>Dirección fiscal: <span><%= request.getAttribute("direccionFiscalClienteEnviado") %></span></p>
									<% } %>
								</div>
							</div>
						</div>

						<!-- Sección: Trabajador -->
						<div class="product-section text-center">
							<h2 class="section-title">Productos Adquiridos</h2>
							<div class="row product-info">
				            	<div class="d-flex text-center mt-3">
				            		<div class="col"><p><strong>Foto</strong></p></div>
				            		<div class="col"><p><strong>Nombre</strong></p></div>
				            		<div class="col"><p><strong>Categoría</strong></p></div>
				            		<div class="col"><p><strong>Cantidad</strong></p></div>
				            		<div class="col"><p><strong>Precio Unitario</strong></p></div>
				            		<div class="col"><p><strong>IGV</strong></p></div>
				            		<div class="col"><p><strong>Subtotal</strong></p></div>
				            	</div>
								<%
									List<DetalleVenta> listadoDetalleVenta = (List<DetalleVenta>) request.getAttribute("listadoDetalleVenta");
										
									if(listadoDetalleVenta != null) {
										for(DetalleVenta item: listadoDetalleVenta) {
								%>
								
									<%
										DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.MYSQL);
										ProductoInterface daoProducto = daoFactory.getProductoDAO();
										
										Producto productoEncontrado = daoProducto.encontrarProducto(item.getIdProducto());
									%>
								
									<div class="d-flex text-center align-items-center justify-content-center">
										<div class="col"><img src="${pageContext.request.contextPath}/<%= productoEncontrado.getImagenProducto() %>" alt="Foto del Producto" class="rounded" width="150" height="150" draggable="false"></div>
										<div class="col"><p class="m-0"><%= productoEncontrado.getNombreProducto() %></p></div>
										<div class="col"><p class="m-0"><%= productoEncontrado.getNombreCategoria() %></p></div>
										<div class="col"><p class="m-0"><%= item.getCantidad() %></p></div>
										<div class="col"><p class="m-0">S/<%= item.getPrecioUnitario() %></p></div>
										<div class="col"><p class="m-0">S/<%= item.getIgv() %></p></div>
										<div class="col"><p class="m-0">S/<%= item.getSubtotal() %></p></div>
									</div>
								<%
										}
									}
								%>
							</div>
						</div>
					</div>

					<!-- Botones -->
					<div class="text-center mt-4">
						<button onclick="window.location.href='jsp/Transactions.jsp'"
							class="btn btn-dark px-5 mx-2">
							Regresar <i class="bi bi-box-arrow-left ps-1"></i>
						</button>
					</div>
				</div>

			</div>

		</div>
	</div>

</body>

</html>