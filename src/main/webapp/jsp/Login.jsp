<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<title>Inicio de Sesión</title>
	
	<style>
        /* Estilos para los mensajes de error */
        .error {
            color: red;
            font-size: 0.875rem;
            margin-top: 5px;
        }

        /* Estilos para el logo */
        .bg-image {
            width: 150px;
            height: 150px;
        }
    </style>
</head>

<body>
	
	<main class="container-fluid d-flex flex-column justify-content-center align-items-center vh-100">
	
		<!-- Logo Compañia -->
        <div class="mb-3">
            <img src="/pf_lp1/images/logo-company.svg" class="bg-image" alt="Logo de la compañia.">
        </div>
        
        <!-- Título Principal -->
        <div class="mb-4">
            <h2>INGRESE SUS CREDENCIALES</h2>
        </div>
        
        <!-- Formulario -->
        <form action="${pageContext.request.contextPath}/LoginServlet?type=login" method="post">
            <div>
                <div> <label for="txtUserEmail">Correo Electrónico</label> </div>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" class="form-control form-control-lg" name="txtUsername" id="txtUsername" />
                </div>
            </div>

            <div class="mt-3">
                <div> <label for="txtPasswordUser">Contraseña</label> </div>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-pass-fill"></i></span>
                    <input type="password" class="form-control form-control-lg" name="txtPassUser" id="txtPassUser" />
                    <button class="btn btn-dark" type="button" id="togglePassword">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
            </div>

			<div>
				<p class="error">${loginFallido}</p>
			</div>

            <div class="mt-4 d-flex flex-column">
                <button type="submit" class="btn btn-dark btn-lg">
                    Iniciar Sesión <i class="bi bi-door-open"></i>
                </button>
            </div>
        </form>
        
        <!-- Copyrigth -->
        <div class="mt-5">
            <p>©2024 Imperio Electrónico</p>
        </div>
        
    </main>
	
</body>

<!-- Ocultar/Ver Contraseña -->
<script>

    const togglePassword = document.getElementById('togglePassword');
    const password = document.getElementById('txtPassUser');

    togglePassword.addEventListener('click', function() {

        const type = password.type === 'password' ? 'text' : 'password';
        password.type = type;

        this.innerHTML = type === 'password' ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>';
        
    });
</script>

</html>