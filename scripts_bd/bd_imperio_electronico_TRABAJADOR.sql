-- Tabla Cargo
CREATE TABLE Cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cargo VARCHAR(35) NOT NULL
);

insert into Cargo (nombre_cargo) values
('Administrador'),
('Supervidor'),
('Vendedor');

-- Tabla Jornada Laboral
CREATE TABLE Jornada_Laboral (
    id_jornada_laboral INT AUTO_INCREMENT PRIMARY KEY,
    nombre_jornada_laboral VARCHAR(35) NOT NULL
);

insert into Jornada_Laboral (nombre_jornada_laboral) values
('Part-Time'),
('Full-Time');

-- Tabla Trabajador
CREATE TABLE Trabajador (
    id_trabajador INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    dni CHAR(8) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    numero_telefono CHAR(9),
    direccion VARCHAR(50),
    id_cargo INT NOT NULL,
    fecha_contratacion DATE NOT NULL,
    id_jornada_laboral INT NOT NULL,
    salario DECIMAL(6, 2) NOT NULL,
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo),
    FOREIGN KEY (id_jornada_laboral) REFERENCES Jornada_Laboral(id_jornada_laboral)
);

insert into Trabajador (nombres, apellidos, dni, correo_electronico, numero_telefono, direccion, id_cargo, fecha_contratacion, id_jornada_laboral, salario) values
('Prueba', 'Admin Prueba', 'admin', 'admin', 'prueba', 'Los Pinos', 1, '2000-01-12', 1, 2351),
('Piero', 'Juarez Fernandez', '72304812', 'juarezpiero@gmail.com', '94022375', 'Los Pinos', 1, '2004-09-27', 1, 1056),
('Lucina', 'Martinez Martinez', '43012981', 'lucinaMarte@outlook.com', '942001248', 'Av. Los Eucaliptos - Miraflores', 3, '2023-10-02', 2, 525);

-- Validación Jornada_Laboral en uso con Trabajador
DELIMITER //
CREATE PROCEDURE sp_contarTrabajadoresPorJornadaLaboral(IN p_id_jornada_laboral INT, OUT cantidad INT)
BEGIN
	SELECT COUNT(*) INTO cantidad
    FROM Trabajador
    WHERE id_jornada_laboral = p_id_jornada_laboral;
END //
DELIMITER ;

-- Agrega un nuevo trabajador
DELIMITER //
CREATE PROCEDURE agregarTrabajador(
    IN nombres VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN dni CHAR(8),
    IN correo_electronico VARCHAR(100),
    IN numero_telefono VARCHAR(15),
    IN direccion VARCHAR(200),
    IN id_cargo INT,
    IN fecha_contratacion DATE,
    IN id_jornada_laboral INT,
    IN salario DECIMAL(10,2)
)
BEGIN
    INSERT INTO Trabajador (
        nombres, apellidos, dni, correo_electronico, 
        numero_telefono, direccion, id_cargo, 
        fecha_contratacion, id_jornada_laboral, salario
    ) 
    VALUES (
        nombres, apellidos, dni, correo_electronico, 
        numero_telefono, direccion, id_cargo, 
        fecha_contratacion, id_jornada_laboral, salario
    );
END //
DELIMITER ;

-- Lista a todos los trabajadores
DELIMITER //
CREATE PROCEDURE sp_listadoTrabajador()
BEGIN
    SELECT 
        T1.id_trabajador,
        T1.nombres, 
        T1.apellidos,
        T1.dni,                    
        T1.correo_electronico,                       
        T1.numero_telefono,                        
        T1.direccion,
        T1.id_cargo,
        T2.nombre_cargo,
        T1.salario,
        T1.fecha_contratacion,
        T1.id_jornada_laboral,
        T3.nombre_jornada_laboral
    FROM Trabajador T1 
    INNER JOIN Cargo T2 ON T1.id_cargo = T2.id_cargo
    INNER JOIN Jornada_Laboral T3 ON T1.id_jornada_laboral = T3.id_jornada_laboral;
 
END //
DELIMITER ;

-- Encuentra a un trabajador por su id
DELIMITER //
CREATE PROCEDURE sp_encontrarTrabajador(IN p_idTrabajador INT)
BEGIN
    SELECT 
        T1.id_trabajador,
        T1.nombres, 
        T1.apellidos,
        T1.dni,                    
        T1.correo_electronico,                       
        T1.numero_telefono,                        
        T1.direccion,
        T1.id_cargo,
        T2.nombre_cargo,
        T1.salario,
        T1.fecha_contratacion,
        T1.id_jornada_laboral,
        T3.nombre_jornada_laboral
    FROM Trabajador T1 
    INNER JOIN Cargo T2 ON T1.id_cargo = T2.id_cargo
    INNER JOIN Jornada_Laboral T3 ON T1.id_jornada_laboral = T3.id_jornada_laboral
	WHERE T1.id_trabajador = p_idTrabajador;
END //
DELIMITER ;

-- Actualiza a un trabajador por su id
DELIMITER //
CREATE PROCEDURE sp_actualizarTrabajador(
    IN p_idTrabajador INT,
    IN p_nombres VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_dni CHAR(8),
    IN p_correo_electronico VARCHAR(50),
    IN p_numero_telefono CHAR(9),
    IN p_direccion VARCHAR(50),
    IN p_id_cargo INT,
    IN p_salario DECIMAL(6, 2),
    IN p_fecha_contratacion DATE,
    IN p_id_jornada_laboral INT
)
BEGIN
    UPDATE Trabajador
    SET 
        nombres = p_nombres,
        apellidos = p_apellidos,
        dni = p_dni,
        correo_electronico = p_correo_electronico,
        numero_telefono = p_numero_telefono,
        direccion = p_direccion,
        id_cargo = p_id_cargo,
        salario = p_salario,
        fecha_contratacion = p_fecha_contratacion,
        id_jornada_laboral = p_id_jornada_laboral
    WHERE id_trabajador = p_idTrabajador;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_loginUsuarioRegistrado(IN p_dniTrabajador text, correoTrabajador text)
BEGIN
    SELECT T1.id_trabajador, T1.nombres, T2.nombre_cargo
    FROM Trabajador T1
    INNER JOIN Cargo T2 ON T1.id_cargo = T2.id_cargo
    WHERE T1.dni = p_dniTrabajador AND T1.correo_electronico = correoTrabajador;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_trabajadoresMasVentas()
BEGIN
    SELECT 
        T.nombres,
        COUNT(V.id_venta) AS total_ventas
    FROM 
        Trabajador T
    LEFT JOIN 
        Venta V ON V.id_trabajador = T.id_trabajador
    GROUP BY 
        T.id_trabajador
    ORDER BY 
        total_ventas DESC;
END //
DELIMITER ;
