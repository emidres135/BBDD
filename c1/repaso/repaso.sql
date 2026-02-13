
--Eliminar base si existe
DROP DATABASE IF EXISTS vehiculos;

--Crear base de datos
CREATE DATABASE vehiculos;
CHARACTER SET utf8mb4 
COLLATE utf8mb4_general_ci;

--Accedemos a la base de datos
USE vehiculos;

--Crear tabla 
CREATE TABLE PROYECTO (
    codigo INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(20),
    CONSTRAINT pk_proyecto PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO (
    id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(20),
    dni CHAR(9),
    jefe INT UNSIGNED,
    CONSTRAINT pk_empleado PRIMARY KEY (id)
);
CREATE TABLE VEHICULO (
    matricula CHAR(7),
    marca VARCHAR(12) NOT NULL,
    modelo VARCHAR(12) NOT NULL,
    persona INT UNSIGNED,
    CONSTRAINT pk_vehiculo PRIMARY KEY (matricula),
    CONSTRAINT fk_vehiculo_empleado FOREIGN KEY (persona) REFERENCES EMPLEADO(id)
);

CREATE TABLE ASIGNACION (
    id_emp INT UNSIGNED,
    cod_proy INT UNSIGNED,
    CONSTRAINT pk_asignacion PRIMARY KEY (id_emp, cod_proy),
    CONSTRAINT fk_asig_emp FOREIGN KEY (id_emp) REFERENCES EMPLEADO(id)
        );

--alternar
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado_jefe FOREIGN KEY (jefe)
    REFERENCES EMPLEADO(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

    -- instertar datos en las tablas
    /* proyecto empleado -vehiculo asignacion */
    INSERT INTO EMPLEADO (id, nombre, dni, jefe) VALUES
    (10, 'ANA MARTIN', '1111A', NULL),
    (15, 'JUAN LOPEZ', '2222B', 10),
    (20, 'CARMEN DIAZ', '3333C', 10),
    (25, 'ERNESTO GOMEZ', '4444D', 20),
    (30, 'SILVIA GONZALEZ', '5555E', 15),
    (35, 'FERNANDO SIERRA', '7777F', 15);

    INSERT INTO VEHICULO (matricula, marca, modelo, persona) VALUES
    ('2345AAA', 'Seat', 'Altea', NULL),
    ('1234BBB', 'Opel', 'Astra', 15),
    ('5555CCC', 'Seat', 'Ibiza', NULL),
    ('9876DDD', 'Lexus', 'LC', 10),
    ('1111FFF', 'Seat', 'Ibiza', NULL),
    ('2222GGG', 'Opel', 'Astra', 20);

    INSERT INTO PROYECTO (codigo, nombre) VALUES
    (101, 'GRIS');

    INSERT INTO PROYECTO (nombre) VALUES
    ('BLANCO'),
    ('Negro'),
    ('Verde');

    INSERT INTO ASIGNACION (id_emp, cod_proy) VALUES
    (10, 101),
    (15, 101),
    (20, 101),
    (10, 102),
    (15, 102),
    (30, 102),
    (35, 102),
    (20, 103);




