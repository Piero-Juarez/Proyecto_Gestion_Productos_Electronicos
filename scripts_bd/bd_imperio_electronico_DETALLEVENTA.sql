-- Tabla Detalle_Venta
CREATE TABLE Detalle_Venta (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad MEDIUMINT NOT NULL,
    precio_unitario DECIMAL(9,2) NOT NULL,
    igv DECIMAL(9,2) NOT NULL,
    subtotal DECIMAL(9,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- CREAR UN DETALLE VENTA
DELIMITER //
CREATE PROCEDURE crearDetalleVenta(
    IN p_id_venta INT,
    IN p_id_producto INT,
    IN p_cantidad MEDIUMINT,
    IN p_precio_unitario DECIMAL(9,2),
    IN p_igv DECIMAL(9,2),
    IN p_subtotal DECIMAL(9,2)
)
BEGIN
    INSERT INTO Detalle_Venta (id_venta, id_producto, cantidad, precio_unitario, igv, subtotal)
    VALUES (p_id_venta, p_id_producto, p_cantidad, p_precio_unitario, p_igv, p_subtotal);
END//
DELIMITER ;

-- LISTAR TODOS LOS DETALLES VENTAS
DELIMITER //
CREATE PROCEDURE listarDetalleVenta()
BEGIN
    SELECT * FROM Detalle_Venta;
END//
DELIMITER ;

-- LISTAR DETALLES POR ID VENTA
DELIMITER //
CREATE PROCEDURE listarDetalleVentaPorIdVenta(
    IN p_id_venta INT
)
BEGIN
    SELECT * 
    FROM Detalle_Venta 
    WHERE id_venta = p_id_venta;
END//
DELIMITER ;

-- ENCONTRAT DETALLE VENTA POR ID
DELIMITER //
CREATE PROCEDURE encontrarDetalleVentaPorId(
    IN p_id_detalle_venta INT
)
BEGIN
    SELECT * 
    FROM Detalle_Venta 
    WHERE id_detalle_venta = p_id_detalle_venta;
END//
DELIMITER ;

-- ACTUALIZAR DETALLE VENTA
DELIMITER //
CREATE PROCEDURE actualizarDetalleVenta(
    IN p_id_detalle_venta INT,
    IN p_id_venta INT,
    IN p_id_producto INT,
    IN p_cantidad MEDIUMINT,
    IN p_precio_unitario DECIMAL(9,2),
    IN p_igv DECIMAL(9,2),
    IN p_subtotal DECIMAL(9,2)
)
BEGIN
    UPDATE Detalle_Venta
    SET 
        id_venta = p_id_venta,
        id_producto = p_id_producto,
        cantidad = p_cantidad,
        precio_unitario = p_precio_unitario,
        igv = p_igv,
        subtotal = p_subtotal
    WHERE id_detalle_venta = p_id_detalle_venta;
END//
DELIMITER ;

-- ELIMINAR DETALLE VENTA POR ID
DELIMITER //
CREATE PROCEDURE eliminarDetalleVenta(
    IN p_id_detalle_venta INT
)
BEGIN
    DELETE FROM Detalle_Venta 
    WHERE id_detalle_venta = p_id_detalle_venta;
END//
DELIMITER ;

-- Ventas segun la categoria
DELIMITER //
CREATE PROCEDURE sp_productos_vendidos_categoria()
BEGIN
	SELECT 
    C.nombre_categoria,
    SUM(DV.cantidad) AS suma_total
    FROM Detalle_Venta DV
    INNER JOIN Producto P ON P.id_producto = DV.id_producto 
    INNER JOIN Categoria C ON C.id_categoria = P.id_categoria
    GROUP BY C.nombre_categoria;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_productos_generan_mas_ingresos()
BEGIN
	SELECT 
		P.nombre_producto,
        SUM(dv.cantidad * dv.precio_unitario) AS monto_total
    FROM Detalle_Venta dv 
    INNER JOIN Producto P ON P.id_producto = dv.id_producto
    GROUP BY P.nombre_producto;
END //
DELIMITER ;
