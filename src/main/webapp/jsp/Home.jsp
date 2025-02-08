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
	                    <div class="card-contadores">
					        <div class="card-contadores-header">
					            Productos en Almacén
					        </div>
					        <div class="card-contadores-body">
					            <%= request.getAttribute("numeroProductosDisponibles") %>
					        </div>
					    </div>
	                    <div class="card-contadores">
					        <div class="card-contadores-header">
					            Productos con Bajo Stock
					        </div>
					        <div class="card-contadores-body">
					            <%= request.getAttribute("numeroProductosStockMinimo") %>
					        </div>
					    </div>
	                    <div class="card-contadores">
					        <div class="card-contadores-header p-3">
					            Productos sin Stock
					        </div>
					        <div class="card-contadores-body">
					            <%= request.getAttribute("numeroProductosSinStock") %>
					        </div>
					    </div>
                    </div>
                </div>
			</div>
			
		</div>
	</div>
	
</body>

<script type="text/javascript" src="javascript/Cards.js"></script>

</html>