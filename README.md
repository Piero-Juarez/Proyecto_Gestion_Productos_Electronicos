# Proyecto - Gestión de Productos Electrónicos
![Página de inicio](https://i.imgur.com/NdhkOED.png)

## Descripción

Aplicación web para la gestión, administración y venta de productos electrónicos implementado con Jakarta EE y MySQL, que permite administrar todo el ciclo de vida de productos, clientes y trabajadores mediante operaciones CRUD.

Características destacadas:
- Las ventas se registran en Boleta o Factura, con la capacidad de generar y exportar el ticket de venta en PDF.
- Módulo de transacciones para listar ventas realizadas.
- Módulo de paneles de gráficos estadísticos para métricas clave.
- Opciones para exportar tablas de productos, clientes, trabajadores, transacciones y gráficos a Excel o PDF.
- Módulo de configuración para gestionar categorías, proveedores, marcas y estados de productos.

## Tecnologías Utilizadas
| Tecnología  | Descripción |
|---------|-------------|
| Jakarta EE | Framework para el desarrollo del back-end, gestión de lógica de negocio, controladores, y manejo de solicitudes HTTP en la aplicación. |
| MySQL | Sistema de gestión de bases de datos relacional utilizado para almacenar y administrar la información de productos, trabajadores, clientes y transacciones. |
| HTML5 | Lenguaje de marcado utilizado para estructurar la interfaz de usuario y definir los elementos visuales de la aplicación. |
| CSS3 | Hojas de estilo utilizadas para mejorar la apariencia visual de la aplicación. |
| Javascript | Lenguaje de programación utilizado en el front-end para manejar la interactividad del usuario. |

## Librerías utilizadas
- DataTable: [Enlace a su web oficial](https://datatables.net/)
- ApexCharts.JS: [Enlace a su web oficial](https://apexcharts.com/)
- Isotope: [Enlace a su web oficial](https://isotope.metafizzy.co/)

## Probar la aplicación
1. Clonar el repositorio:  
   ```bash
   git clone https://github.com/Piero-Juarez/Proyecto_Gestion_Productos_Electronicos.git

2. Abrir el proyecto en Eclipse:
   - Abrir Eclipse IDE for Enterprise Java Developers.
   - Ir a File (Archivo) → Import (Importar).
   - Seleccionar "Existing Projects into Workspace" dentro de la categoría General.
   - Hacer clic en Next y seleccionar la carpeta donde está el repositorio clonado.
   - Finalizar la importación.

3. Configurar la base de datos MySQL:
   - Asegurarse de que MySQL Server esté en ejecución.
   - Crear la base de datos si no está creada, ejecutando el script SQL proporcionado.

4. Ejecutar la aplicación:
   - Si usas Tomcat, desplegar el proyecto en el servidor.
   - Si es un .jar ejecutable, correr el comando:
      ```bash
      java -jar nombre-del-archivo.jar

## Credenciales de prueba
Si decides probar la aplicación, estas son las credenciales por defecto para ingresar al sistema.

- Rol Administrador (Acceso a todo)<br />
  correo: admin<br />
  contraseña: admin

- Rol Supervisor (Acceso algo limitado)<br />
  correo: juarezpiero@gmail.com<br />
  contraseña: 72304812

- Rol Vendedor (Acceso limitado)<br />
  correo: lucinaMarte@outlook.com<br />
  contraseña: 43012981

>[!NOTE]
>
>Ejecutar los script SQL incluidos en el repositorio para el funcionamiento de las credenciales.

---
***Proyecto hecho con mucho entusiasmo y diversión. 🚀✨***  
