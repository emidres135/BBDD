-- ======================================================================================
-- PASO 0: CREAR Y SELECCIONAR LA BASE DE DATOS
-- ======================================================================================
CREATE DATABASE IF NOT EXISTS AC510_DB;
USE AC510_DB;
-- ======================================================================================
-- PREPARACIÓN: LIMPIEZA DE ENTORNO
-- ======================================================================================
DROP TABLE IF EXISTS PIEZA;
DROP TABLE IF EXISTS PRODUCTO; 
DROP TABLE IF EXISTS ARTICULO;
DROP TABLE IF EXISTS FABRICANTE;

-- ======================================================================================
-- PARTE 1: ESTRUCTURA (AC503 + AC504)
-- ======================================================================================

-- 1.1. CREACIÓN DE LA TABLA FABRICANTE (Acumulado AC503)
CREATE TABLE FABRICANTE (
    codFabricante INT AUTO_INCREMENT,
    nombre VARCHAR(32) NOT NULL,
    provincia VARCHAR(32),
    pais VARCHAR(32) DEFAULT 'España',
    CONSTRAINT PK_FABRICANTE PRIMARY KEY (codFabricante)
);

-- 1.2. CREACIÓN DE LA TABLA PIEZA
-- Antigua tabla ARTICULO/PRODUCTO renombrada y con restricciones.
-- 1. Renombrar
CREATE TABLE ARTICULO (
    codigo VARCHAR(32),
    codFabricante INT,
    peso DECIMAL(10,2),
    categoria VARCHAR(16),
    precioVenta DECIMAL(10,2),
    precioCompra DECIMAL(10,2),
    existencias INT UNSIGNED,
    CONSTRAINT PK_ARTICULO PRIMARY KEY (codigo, codFabricante, peso, categoria),
    CONSTRAINT FK_ARTICULO_FABRICANTE FOREIGN KEY (codFabricante) REFERENCES FABRICANTE(codFabricante),
    CONSTRAINT CK_CATEGORIA CHECK (categoria IN ('primera', 'segunda', 'tercera'))
);

-- ==========================================================
-- TRANSFORMACIÓN A PIEZA (AC504) - USANDO ALTER TABLE
-- ==========================================================

-- 1. Renombrar
ALTER TABLE ARTICULO RENAME TO PIEZA;

-- 2. Cambiar FK para añadir reglas de borrado/actualización
ALTER TABLE PIEZA DROP FOREIGN KEY FK_ARTICULO_FABRICANTE;
ALTER TABLE PIEZA ADD CONSTRAINT FK_PIEZA_FABRICANTE 
    FOREIGN KEY (codFabricante) REFERENCES FABRICANTE(codFabricante)
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- 3. Restricciones de precios
ALTER TABLE PIEZA ADD CONSTRAINT CK_PRECIO_VENTA_POS CHECK (precioVenta > 0);
ALTER TABLE PIEZA ADD CONSTRAINT CK_PRECIO_COMPRA_POS CHECK (precioCompra > 0);

-- 4. Categoria NOT NULL
ALTER TABLE PIEZA MODIFY categoria VARCHAR(16) NOT NULL;

-- 5. Restricción de peso
ALTER TABLE PIEZA ADD CONSTRAINT CK_PESO_MINIMO CHECK (peso >= 1.00);



-- ======================================================================================
-- PARTE 2: OPERACIONES DEL EJERCICIO AC510
-- ======================================================================================

-- 2.1. MODIFICAR EL CHARSET
ALTER TABLE FABRICANTE CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Reiniciar autoincremental
ALTER TABLE FABRICANTE AUTO_INCREMENT = 1;

-- 2.4. RE-INSERCIÓN DE DATOS FINALES 
INSERT INTO FABRICANTE (codFabricante, nombre, provincia, pais) VALUES 
(1, 'Sony', 'Kantō', 'Japón'),
(2, 'Microsoft', 'Nuevo México', 'USA'),
(3, 'Nintendo', 'Kantō', 'Japón');

INSERT INTO PIEZA (codigo, codFabricante, peso, categoria, precioVenta, precioCompra, existencias) VALUES 
('PS5', 1, 4.5, 'primera', 500.00, 550.00, 123),
('PS4', 1, 2.8, 'primera', 300.00, 400.00, 234),
('XSX', 2, 4.4, 'primera', 500.00, 550.00, 345),
('NSW', 3, 1, 'segunda', 225.00, 330.00, 456);

-- ======================================================================================
-- COMPROBACIÓN FINAL
-- ======================================================================================
SELECT * FROM FABRICANTE;
SELECT * FROM PIEZA;
