/* Ejemplo práctico de creación de una base de datos de un videoclub */



-- CREACIÓN DE BASE DE DATOS

-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS videoclub;

-- Crear base de datos
CREATE DATABASE videoclub;
CHARACTER SET utf8;
COLLATE utf8_spanish_ci;

-- Acceder a base de datos
USE videoclub;



-- CREACIÓN DE TABLAS

-- Crear tabla PELICULAS
CREATE TABLE peliculas(
    codigo INT(5) AUTO_INCREMENT NOT NULL,
    titulo VARCHAR(70) NOT NULL,
    director VARCHAR(75) DEFAULT 'DIRECTOR PRUEBA',
    estreno DATE,
    CONSTRAINT pk_peliculas PRIMARY KEY (codigo),
    CONSTRAINT uk_peliculas UNIQUE (titulo)
);

-- Crear tabla CLIENTES
CREATE TABLE clientes(
    dni CHAR(9) NOT NULL,
    nombre VARCHAR(35) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(30) UNIQUE,
    movil VARCHAR(15),
    saldo DECIMAL(7,2) DEFAULT 5.50, -- 7 en la parte entera, 2 decimales
    CONSTRAINT pk_clientes PRIMARY KEY(dni)
);

-- Crear tabla ALQUILERES
CREATE TABLE alquileres(
    codPeli INT(5) NOT NULL,
    dni CHAR(9) NOT NULL,
    fecha DATE NOT NULL,
    num_dias INT,
    total DECIMAL(7,2),
    CONSTRAINT pk_alquileres PRIMARY KEY(codPeli, dni, fecha),
    CONSTRAINT fk_alq_pel FOREIGN KEY(codPeli) REFERENCES peliculas(codigo)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT fk_alq_cli FOREIGN KEY(dni) REFERENCES clientes(dni)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE ALQUILERES(
    CODpELI INT (5) NOT NULL,
    dni
    fecha DATE NOT NULL,
    num_dias INT,
    total DECIMAL(7,2),
    CONSTRAINT pk_alquileres PRIMARY KEY(codPeli, dni, fecha),
);

ALTER TABLE clientes ADD direccion VARCHAR(70) AFTER movil;
ALTER TABLE clientes MODIFY direccion VARCHAR(50) NOT NULL;
ALTER TABLE clientes RENAME TO usuarios;
