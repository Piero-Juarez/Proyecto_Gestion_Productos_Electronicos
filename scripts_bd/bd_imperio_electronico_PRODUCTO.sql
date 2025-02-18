create database db_imperio_electronico;
use db_imperio_electronico;

-- Crear tabla Categoría
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(35) NOT NULL
);

-- Crear tabla Marca
CREATE TABLE Marca (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre_marca VARCHAR(35) NOT NULL
);

-- Crear tabla Proveedor
CREATE TABLE Proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(50) NOT NULL
);

-- Crear tabla Estado Producto
CREATE TABLE Estado_Producto (
    id_estado_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado_producto VARCHAR(35) NOT NULL
);

-- Crear tabla Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) DEFAULT 'N/A',
    sku CHAR(12) NOT NULL,
    color_producto VARCHAR(35) NOT NULL,
    detalles VARCHAR(1000) DEFAULT 'Sin detalles por el momento.',
    precio DECIMAL(8,2) NOT NULL,
    stock INT NOT NULL,
    stock_minimo INT NOT NULL,
    peso DECIMAL(6,2) NOT NULL,
    dimensiones VARCHAR(35) DEFAULT 'N/A',
    garantia VARCHAR(15) DEFAULT 'N/A',
    fecha_incorporacion DATE NOT NULL,
    imagen_producto TEXT NOT NULL,
    id_categoria INT,
    id_marca INT,
    id_proveedor INT,
    id_estado_producto INT,
    constraint fk_Categoria foreign key (id_categoria) references Categoria(id_categoria),
    constraint fk_Marca foreign key (id_marca) references Marca(id_marca),
    constraint fk_Proveedor foreign key (id_proveedor) references Proveedor(id_proveedor),
    constraint fk_Estado_Producto foreign key (id_estado_producto) references Estado_Producto(id_estado_producto)
);

-- Añadir un nuevo producto
DELIMITER //
CREATE PROCEDURE sp_agregarNuevoProducto(
		IN p_nombre_producto VARCHAR(50),
		IN p_modelo VARCHAR(50),
		IN p_sku CHAR(12),
		IN p_id_categoria INT,
		IN p_id_marca INT,
		IN p_detalles VARCHAR(1000),
		IN p_precio DECIMAL(8,2),
		IN p_stock INT,
		IN p_stock_minimo INT,
		IN p_id_proveedor INT,
		IN p_peso DECIMAL(6,2),
		IN p_dimensiones VARCHAR(35),
		IN p_garantia VARCHAR(15),
		IN p_id_estado_producto INT,
		IN p_fecha_incorporacion DATE,
		IN p_color_producto VARCHAR(35),
		IN p_imagen_producto TEXT
    )
BEGIN
	INSERT INTO Producto(
		nombre_producto, modelo, sku, id_categoria, id_marca, detalles, precio,
		stock, stock_minimo, id_proveedor, peso, dimensiones, garantia,
        id_estado_producto, fecha_incorporacion, color_producto, imagen_producto
    ) VALUES (
		p_nombre_producto, p_modelo, p_sku, p_id_categoria, p_id_marca, p_detalles, p_precio,
        p_stock, p_stock_minimo, p_id_proveedor, p_peso, p_dimensiones, p_garantia,
        p_id_estado_producto, p_fecha_incorporacion, p_color_producto, p_imagen_producto
	);
END //
DELIMITER ;

-- Llamado de todos los productos
DELIMITER //
CREATE PROCEDURE sp_listadoProductos()
BEGIN
    SELECT
		T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
        
    FROM Producto T1
    
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto;
END //
DELIMITER ;

-- Encontrar un producto por id
DELIMITER //
CREATE PROCEDURE sp_encontrarProductoPorId(IN p_id_producto INT)
BEGIN
    SELECT
		T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
        
    FROM Producto T1
    
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    
    WHERE T1.id_producto = p_id_producto;
END //
DELIMITER ;

-- Actualizar un producto por id
DELIMITER //
CREATE PROCEDURE sp_actualizarProducto(
    IN p_id_producto INT,
    IN p_nombre_producto VARCHAR(50),
    IN p_modelo VARCHAR(50),
    IN p_sku CHAR(12),
    IN p_id_categoria INT,
    IN p_id_marca INT,
    IN p_detalles VARCHAR(1000),
    IN p_precio DECIMAL(8,2),
    IN p_stock INT,
    IN p_stock_minimo INT,
    IN p_id_proveedor INT,
    IN p_peso DECIMAL(6,2),
    IN p_dimensiones VARCHAR(35),
    IN p_garantia VARCHAR(15),
    IN p_id_estado_producto INT,
    IN p_fecha_incorporacion DATE,
    IN p_color_producto VARCHAR(35),
    IN p_imagen_producto TEXT
)
BEGIN
    UPDATE Producto
    
    SET 
        nombre_producto = p_nombre_producto,
        modelo = p_modelo,
        sku = p_sku,
        id_categoria = p_id_categoria,
        id_marca = p_id_marca,
        detalles = p_detalles,
        precio = p_precio,
        stock = p_stock,
        stock_minimo = p_stock_minimo,
        id_proveedor = p_id_proveedor,
        peso = p_peso,
        dimensiones = p_dimensiones,
        garantia = p_garantia,
        id_estado_producto = p_id_estado_producto,
        fecha_incorporacion = p_fecha_incorporacion,
        color_producto = p_color_producto,
        imagen_producto = p_imagen_producto
        
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

-- Eliminar producto por id
DELIMITER //
CREATE PROCEDURE sp_eliminarProductoPorId(IN p_id_producto INT)
BEGIN
	DELETE FROM Producto
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

-- Validación Categoría en uso con Producto
DELIMITER //
CREATE PROCEDURE sp_contarProductosPorCategoria(IN p_id_categoria INT, OUT cantidad INT)
BEGIN
	SELECT COUNT(*) INTO cantidad
    FROM Producto
    WHERE id_categoria = p_id_categoria;
END //
DELIMITER ;

-- Validación Marca en uso con Producto
DELIMITER //
CREATE PROCEDURE sp_contarProductosPorMarca(IN p_id_marca INT, OUT cantidad INT)
BEGIN
	SELECT COUNT(*) INTO cantidad
    FROM Producto
    WHERE id_marca = p_id_marca;
END //
DELIMITER ;

-- Validación Proveedor en uso con Producto
DELIMITER //
CREATE PROCEDURE sp_contarProductosPorProveedor(IN p_id_proveedor INT, OUT cantidad INT)
BEGIN
	SELECT COUNT(*) INTO cantidad
    FROM Producto
    WHERE id_proveedor = p_id_proveedor;
END //
DELIMITER ;

-- Validación Estado_Producto en uso con Producto
DELIMITER //
CREATE PROCEDURE sp_contarProductosPorEstadoProducto(IN p_id_estado_producto INT, OUT cantidad INT)
BEGIN
	SELECT COUNT(*) INTO cantidad
    FROM Producto
    WHERE id_estado_producto = p_id_estado_producto;
END //
DELIMITER ;

-- Devolver la cantidad del stock actual según id
DELIMITER //
CREATE PROCEDURE sp_obtenerStockPorId(IN p_id_producto INT, OUT p_stock INT)
BEGIN
    SELECT stock
    INTO p_stock
    FROM Producto
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

-- Actualizar el stock actual según id NO USADO
DELIMITER //
CREATE PROCEDURE sp_actualizarStockPorId(IN p_id_producto INT, IN p_nuevo_stock INT)
BEGIN
    UPDATE Producto
    SET stock = p_nuevo_stock
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

-- Actualizar el stock luego de una venta
DELIMITER //
CREATE PROCEDURE descontarStockPorId(
    IN p_id_producto INT,
    IN p_stock_descontado INT
)
BEGIN
    UPDATE Producto
    SET stock = stock - p_stock_descontado
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

-- Listado de productos en almacen
DELIMITER //
CREATE PROCEDURE sp_listarProductosDisponibles()
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.stock > 0;
END //
DELIMITER ;

-- Listado de productos con stock mínimo
DELIMITER //
CREATE PROCEDURE sp_listarProductosStockMinimo()
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.stock <= T1.stock_minimo;
END //
DELIMITER ;

-- Listado de productos sin stock
DELIMITER //
CREATE PROCEDURE sp_listarProductosSinStock()
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.stock = 0;
END //
DELIMITER ;

-- Listado de productos según ID Categoria
DELIMITER //
CREATE PROCEDURE sp_listarProductosPorIdCategoria(IN idCategoria INT)
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.id_categoria = idCategoria;
END //
DELIMITER ;

-- Listado de productos según ID Marca
DELIMITER //
CREATE PROCEDURE sp_listarProductosPorIdMarca(IN idMarca INT)
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.id_marca = idMarca;
END //
DELIMITER ;

-- Listado de productos según ID Proveedor
DELIMITER //
CREATE PROCEDURE sp_listarProductosPorIdProveedor(IN idProveedor INT)
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.id_proveedor = idProveedor;
END //
DELIMITER ;

-- Listado de productos según ID Estado Producto
DELIMITER //
CREATE PROCEDURE sp_listarProductosPorIdEstadoProducto(IN idEstadoProducto INT)
BEGIN
    SELECT
        T1.id_producto,
        T1.nombre_producto,
        T1.modelo,
        T1.sku,
        T1.id_categoria,
        T2.nombre_categoria,
        T1.id_marca,
        T3.nombre_marca,
        T1.detalles,
        T1.precio,
        T1.stock,
        T1.stock_minimo,
        T1.id_proveedor,
        T4.nombre_proveedor,
        T1.peso,
        T1.dimensiones,
        T1.garantia,
        T1.id_estado_producto,
        T5.nombre_estado_producto,
        T1.fecha_incorporacion,
        T1.color_producto,
        T1.imagen_producto
    FROM Producto T1
    INNER JOIN Categoria T2 ON T1.id_categoria = T2.id_categoria
    INNER JOIN Marca T3 ON T1.id_marca = T3.id_marca
    INNER JOIN Proveedor T4 ON T1.id_proveedor = T4.id_proveedor
    INNER JOIN Estado_Producto T5 ON T1.id_estado_producto = T5.id_estado_producto
    WHERE T1.id_estado_producto = idEstadoProducto;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_productos_stock()
BEGIN
	SELECT 
		P.nombre_producto,
		P.stock
    FROM Producto P;
END //
DELIMITER ;

-- ContarProductosPorCategoria
DELIMITER //
CREATE PROCEDURE sp_cantidad_productos_categoria()
BEGIN
	SELECT c.nombre_categoria,COUNT(p.id_categoria) AS Cantidad FROM producto p
    INNER JOIN Categoria c ON c.id_categoria = p.id_categoria
    GROUP BY c.nombre_categoria;
END // 
DELIMITER ;