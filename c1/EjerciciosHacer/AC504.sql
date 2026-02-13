-- ==========================================================
-- 1. TABLA FABRICANTE (Requisito previo para la Clave Ajena)
-- Definida con las modificaciones finales del ejercicio AC503
-- ==========================================================
CREATE TABLE FABRICANTE (
    codFabricante INT AUTO_INCREMENT,
    nombre VARCHAR(32) NOT NULL,
    provincia VARCHAR(32),          -- Añadido según AC503
    pais VARCHAR(32) DEFAULT 'España', -- Valor por defecto según AC503
    CONSTRAINT PK_FABRICANTE PRIMARY KEY (codFabricante)
);

-- ==========================================================
-- 2. TABLA PIEZA (Instrucción CREATE TABLE solicitada)
-- Incluye FK con reglas de borrado/actualización y checks de precios
-- ==========================================================
CREATE TABLE PIEZA (
    codigo VARCHAR(32),
    codFabricante INT,
    peso DECIMAL(10,2),
    categoria VARCHAR(16),
    precioVenta DECIMAL(10,2),
    precioCompra DECIMAL(10,2),
    existencias INT UNSIGNED,

    -- Clave Primaria Compuesta
    CONSTRAINT PK_PIEZA PRIMARY KEY (codigo, codFabricante, peso, categoria),

    -- Clave Ajena con reglas estrictas (AC504)
    -- ON DELETE RESTRICT: Prohíbe borrar fabricante si tiene piezas
    -- ON UPDATE CASCADE: Si cambia el código del fabricante, se actualiza aquí
    CONSTRAINT FK_PIEZA_FABRICANTE FOREIGN KEY (codFabricante) 
        REFERENCES FABRICANTE(codFabricante)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,

    -- Restricción de valores permitidos para categoría
    CONSTRAINT CK_CATEGORIA_VALIOS CHECK (categoria IN ('primera', 'segunda', 'tercera')),

    -- Restricciones de precios positivos
    CONSTRAINT CK_PRECIO_VENTA_POS CHECK (precioVenta > 0),
    CONSTRAINT CK_PRECIO_COMPRA_POS CHECK (precioCompra > 0)
);

-- ==========================================================
-- 3. MODIFICACIONES POSTERIORES (Instrucciones ALTER TABLE solicitadas)
-- ==========================================================

-- A. La columna categoria no puede admitir valores nulos
ALTER TABLE PIEZA MODIFY categoria VARCHAR(16) NOT NULL;

-- B. El peso debe ser superior o igual a 1.00
ALTER TABLE PIEZA ADD CONSTRAINT CK_PESO_MINIMO CHECK (peso >= 1.00);