# Proyecto Gestión de Productos Electrónicos
## Descripción

Aplicación web para la gestión y ventas de productos electrónicos implementado con Jakarta EE y MySQL,
que permite administrar todo el ciclo de vida de productos, clientes y trabajadores mediante operaciones CRUD.
Las ventas se registran en Boleta o Factura, con la capacidad de generar y exportar el ticket de venta en PDF.
El sistema incluye un módulo de transacciones para listar ventas realizadas, también un módulo de paneles de gráficos estadísticos para métricas clave.
Opciones para exportar tablas de productos, clientes, trabajadores, transacciones y gráficos a Excel o PDF.
Además, cuenta con un módulo de configuración para gestionar categorías, proveedores, marcas y estados de productos.

## Tecnologías Utilizadas
| Tecnología  | Descripción |
|---------|-------------|
| Jakarta EE | Back-End, lógica de negocio |
| MySQL | Base de datos principal |
| HTML5 | Maquetación |
| CSS3 | Estilos |
| Javascript | Interactividad con el usuario y con los datos utilizados |

## Frameworks utilizados
- DataTable: [Enlace a su web oficial](https://datatables.net/)
- APEXCHARTS.JS [Enlace a su web oficial](https://apexcharts.com/)
- Isotope [Enlace a su web oficial](https://isotope.metafizzy.co/)

## Probar la aplicación
1. Clonar el repositorio:  
   ```bash
   git clone https://github.com/Piero-Juarez/Proyecto_Gestion_Productos_Electronicos.git

2. Instalar dependencias:  
   ```bash
   npm install
   
3. Ejecutar la aplicación
   ```bash
   npm start

## Credenciales de prueba
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

