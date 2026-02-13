-- 1. CREACIÓN DE LA TABLA FABRICANTE
CREATE TABLE FABRICANTE (
    codFabricante INT AUTO_INCREMENT,
    nombre VARCHAR(32) NOT NULL,
    pais VARCHAR(32),
    CONSTRAINT PK_FABRICANTE PRIMARY KEY (codFabricante)
);

-- 2. CREACIÓN DE LA TABLA ARTICULO
-- Nota: Se asume DECIMAL(10,2) para los campos numéricos con dos decimales.
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

-- 3. MODIFICACIONES SOLICITADAS

-- A. Modificar el atributo pais para que el valor por defecto sea 'España'
ALTER TABLE FABRICANTE MODIFY pais VARCHAR(32) DEFAULT 'España';

-- B. Añadir una columna provincia ANTES de pais
-- En MariaDB usamos AFTER para colocarla después de 'nombre', que es la columna previa a 'pais'.
ALTER TABLE FABRICANTE ADD provincia VARCHAR(32) AFTER nombre;

-- C. Renombrar la tabla ARTICULO a PRODUCTO
ALTER TABLE ARTICULO RENAME TO PRODUCTO;