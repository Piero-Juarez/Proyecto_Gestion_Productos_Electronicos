-- Tabla Comprobante_Pago
CREATE TABLE Comprobante_Pago (
    id_comprobante_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(35) NOT NULL
);

insert into Comprobante_Pago(nombre) values
('Boleta'),
('Factura');

select * from Comprobante_Pago;

-- Tabla Metodo_Pago
CREATE TABLE Metodo_Pago (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(35)
);

insert into Metodo_Pago(nombre) values
('Tarjeta de débito'),
('Tarjeta de crédito'),
('Pago en efectivo');

UPDATE Metodo_Pago
SET nombre = 'Tarjeta de crédito'
WHERE id_metodo_pago = 2;

select * from Metodo_Pago;

-- Tabla Venta
CREATE TABLE Venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    id_comprobante_pago INT,
    id_cliente INT,
    id_trabajador INT,
    monto_total DECIMAL(9,2),
    id_metodo_pago INT,
    dinero_cliente DECIMAL(9,2),
    vuelto_efectivo DECIMAL(9,2),
    FOREIGN KEY (id_comprobante_pago) REFERENCES Comprobante_Pago(id_comprobante_pago),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_trabajador) REFERENCES Trabajador(id_trabajador),
    FOREIGN KEY (id_metodo_pago) REFERENCES Metodo_Pago(id_metodo_pago)
);

-- Crear una venta
DELIMITER //
CREATE PROCEDURE sp_crearVenta (
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_comprobante_pago INT,
    IN p_id_cliente INT,
    IN p_id_trabajador INT,
    IN p_monto_total DECIMAL(9,2),
    IN p_id_metodo_pago INT,
    IN p_dinero_cliente DECIMAL(9,2),
    IN p_vuelto_efectivo DECIMAL(9,2)
)
BEGIN
    INSERT INTO Venta (fecha, hora, id_comprobante_pago, id_cliente, id_trabajador, monto_total, id_metodo_pago, dinero_cliente, vuelto_efectivo)
    VALUES (p_fecha, p_hora, p_id_comprobante_pago, p_id_cliente, p_id_trabajador, p_monto_total, p_id_metodo_pago, p_dinero_cliente, p_vuelto_efectivo);
END //
DELIMITER ;

-- Encontrar una venta por ID
DELIMITER //
CREATE PROCEDURE sp_encontrarVenta (
    IN p_id_venta INT
)
BEGIN
    SELECT * FROM Venta WHERE id_venta = p_id_venta;
END //
DELIMITER ;

-- Listar todas las ventas
DELIMITER //
CREATE PROCEDURE sp_listarVentas()
BEGIN
    SELECT * FROM Venta;
END //
DELIMITER ;

-- Actualizar una venta por ID
DELIMITER //
CREATE PROCEDURE sp_actualizarVenta (
    IN p_id_venta INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_comprobante_pago INT,
    IN p_id_cliente INT,
    IN p_id_trabajador INT,
    IN p_monto_total DECIMAL(9,2),
    IN p_id_metodo_pago INT,
    IN p_dinero_cliente DECIMAL(9,2),
    IN p_vuelto_efectivo DECIMAL(9,2)
)
BEGIN
    UPDATE Venta
    SET fecha = p_fecha,
        hora = p_hora,
        id_comprobante_pago = p_id_comprobante_pago,
        id_cliente = p_id_cliente,
        id_trabajador = p_id_trabajador,
        monto_total = p_monto_total,
        id_metodo_pago = p_id_metodo_pago,
        dinero_cliente = p_dinero_cliente,
        vuelto_efectivo = p_vuelto_efectivo
    WHERE id_venta = p_id_venta;
END //
DELIMITER ;

-- Eliminar una venta por ID
DELIMITER //
CREATE PROCEDURE sp_eliminarVenta (IN p_id_venta INT)
BEGIN
    DELETE FROM Venta WHERE id_venta = p_id_venta;
END //
DELIMITER ;

-- Encontrar ventas por ID cliente
DELIMITER //
CREATE PROCEDURE sp_encontrarVentasPorCliente(IN p_idCliente INT)
BEGIN
    SELECT 
        v.id_venta,
        v.fecha,
        v.hora,
        v.id_comprobante_pago,
        v.id_cliente,
        v.id_trabajador,
        v.monto_total,
        v.id_metodo_pago,
        v.dinero_cliente,
        v.vuelto_efectivo
    FROM Venta v
    WHERE v.id_cliente = p_idCliente;
END //
DELIMITER ;

-- Encontrar ventas por fecha inicio y fin
DELIMITER //
CREATE PROCEDURE sp_encontrarVentasPorFecha(IN p_fechaInicio DATE, IN p_fechaFin DATE)
BEGIN
    SELECT 
        v.id_venta,
        v.fecha,
        v.hora,
        v.id_comprobante_pago,
        v.id_cliente,
        v.id_trabajador,
        v.monto_total,
        v.id_metodo_pago,
        v.dinero_cliente,
        v.vuelto_efectivo
    FROM Venta v
    WHERE v.fecha BETWEEN p_fechaInicio AND p_fechaFin;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_ObtenerUltimoIdVenta(OUT ultimoId INT)
BEGIN
    SELECT MAX(id_venta) INTO ultimoId FROM Venta;
END //
DELIMITER ;

-- Obtener máximo número boleta
DELIMITER //
CREATE PROCEDURE sp_obtenerMaximoBoleta(OUT maxBoleta INT)
BEGIN
    SELECT MAX(v.id_venta)
    INTO maxBoleta
    FROM Venta v
    JOIN Comprobante_Pago cp ON v.id_comprobante_pago = cp.id_comprobante_pago
    WHERE cp.nombre = 'Boleta';
END //
DELIMITER ;

-- Obtener máximo número factura
DELIMITER //
CREATE PROCEDURE sp_obtenerMaximoFactura(OUT maxFactura INT)
BEGIN
    SELECT MAX(v.id_venta)
    INTO maxFactura
    FROM Venta v
    JOIN Comprobante_Pago cp ON v.id_comprobante_pago = cp.id_comprobante_pago
    WHERE cp.nombre = 'Factura';
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_ventasDiarias()
BEGIN
	SELECT 
    v.fecha,
    SUM(dv.cantidad) AS cantidad_total
    FROM 
    venta v
    JOIN detalle_venta dv ON dv.id_venta = v.id_venta
    GROUP BY 
		v.fecha
    LIMIT 10;
END //
DELIMITER ;

-- Preferencia de metodo de pago
DELIMITER //
CREATE PROCEDURE sp_preferencia_pago()
BEGIN
	SELECT 
    MP.nombre,
    COUNT(v.id_metodo_pago) AS metodo_pago  FROM venta V
    INNER JOIN metodo_pago MP ON MP.id_metodo_pago = v.id_metodo_pago 
    GROUP BY MP.nombre;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_monto_total_dia()
BEGIN
	SELECT v.fecha , SUM(v.monto_total) AS total_ventas
	FROM Venta V
	GROUP BY V.fecha
	ORDER BY fecha
	LIMIT 10;
END // 
DELIMITER ;