-- Tabla Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni CHAR(8) NOT NULL,
    razon_social VARCHAR(50) DEFAULT 'N/A',
    nombre_comercial VARCHAR(50) DEFAULT 'N/A',
    direccion_fiscal VARCHAR(50) DEFAULT 'N/A',
    ruc CHAR(11) DEFAULT 'N/A'
);

insert into Cliente (nombre, apellido, dni, razon_social, nombre_comercial, direccion_fiscal, ruc) values
('Piero', 'Juarez', '42109042', 'N/A', 'N/A', 'N/A', 'N/A'),
('Juan', 'Sanchez', '73200313', 'Galaxy Sanchez S.A.', 'Galaxy Phone', 'Jr. 23, Los Tulipanes - La Molina', '10732003138');

-- Agregar un nuevo cliente
DELIMITER //
CREATE PROCEDURE sp_agregarCliente(
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_dni CHAR(8),
    IN p_razon_social VARCHAR(50),
    IN p_nombre_comercial VARCHAR(50),
    IN p_direccion_fiscal VARCHAR(50),
    IN p_ruc CHAR(11)
)
BEGIN
    INSERT INTO Cliente (nombre, apellido, dni, razon_social, nombre_comercial, direccion_fiscal, ruc)
    VALUES (p_nombre, p_apellido, p_dni, p_razon_social, p_nombre_comercial, p_direccion_fiscal, p_ruc);
END //
DELIMITER ;

-- Encuentra a un cliente por su id
DELIMITER //
CREATE PROCEDURE sp_encontrarClientePorID(IN p_idCliente INT)
BEGIN
    SELECT id_cliente, nombre, apellido, dni, razon_social, nombre_comercial, direccion_fiscal, ruc
    FROM Cliente
    WHERE id_cliente = p_idCliente;
END //
DELIMITER ;

-- Actualiza un cliente por su id
DELIMITER //
CREATE PROCEDURE sp_actualizarCliente(
    IN p_idCliente INT,
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_dni CHAR(8),
    IN p_razon_social VARCHAR(50),
    IN p_nombre_comercial VARCHAR(50),
    IN p_direccion_fiscal VARCHAR(50),
    IN p_ruc CHAR(11)
)
BEGIN
    UPDATE Cliente
    SET 
        nombre = p_nombre,
        apellido = p_apellido,
        dni = p_dni,
        razon_social = p_razon_social,
        nombre_comercial = p_nombre_comercial,
        direccion_fiscal = p_direccion_fiscal,
        ruc = p_ruc
    WHERE id_cliente = p_idCliente;
END //
DELIMITER ;

/*ENCONTRAR CLIENTE POR DNI*/
DELIMITER //
CREATE PROCEDURE sp_encontrarClientePorDni(IN p_dni CHAR(8))
BEGIN
    SELECT 
        T1.id_cliente,
        T1.nombre,
        T1.apellido,
        T1.dni,
        T1.razon_social,
        T1.nombre_comercial,
        T1.direccion_fiscal,
        T1.ruc
    FROM Cliente T1
    WHERE T1.dni = p_dni;
END //
DELIMITER ;

/* ENCONTRAR CLIENTE POR RUC */
DELIMITER //
CREATE PROCEDURE sp_encontrarClientePorRuc(IN p_ruc CHAR(11))
BEGIN
    SELECT 
        T1.id_cliente,
        T1.nombre,
        T1.apellido,
        T1.dni,
        T1.razon_social,
        T1.nombre_comercial,
        T1.direccion_fiscal,
        T1.ruc
    FROM Cliente T1
    WHERE T1.ruc = p_ruc;
END //
DELIMITER ;

DELIMITER // 
CREATE PROCEDURE sp_comprasRealizadasCliente(in idCliente int)
BEGIN
	SELECT
    T4.nombre_producto,
    SUM(T3.cantidad) AS total_cantidad
FROM Cliente T1
INNER JOIN Venta T2 ON T1.id_cliente = T2.id_cliente     
INNER JOIN Detalle_Venta T3 ON T3.id_venta = T2.id_venta
INNER JOIN Producto T4 ON T4.id_producto = T3.id_producto
WHERE T1.id_cliente = idCliente
GROUP BY  T4.nombre_producto
LIMIT 10;  
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_clientesConMasCompras()
BEGIN
    SELECT 
        c.nombre, 
        c.apellido, 
        SUM(v.monto_total) AS total_compras,      
        SUM(dv.cantidad) AS total_productos       
    FROM 
        Cliente c
    JOIN 
        Venta v ON c.id_cliente = v.id_cliente
    JOIN 
        Detalle_Venta dv ON v.id_venta = dv.id_venta  
    GROUP BY 
        c.nombre, c.apellido
    ORDER BY 
        total_compras DESC
    LIMIT 10;  
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_distribucionClientesPorDocumento()
BEGIN
    SELECT 
        CASE 
            WHEN dni <> 'N/A' THEN 'DNI'
            WHEN ruc <> 'N/A' THEN 'RUC'
        END AS tipo_documento,
        COUNT(*) AS cantidad_clientes
    FROM CLIENTE
    WHERE dni <> 'N/A' OR ruc <> 'N/A'
    GROUP BY tipo_documento;
END //
DELIMITER ;