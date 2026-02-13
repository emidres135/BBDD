--Ejercicio 4: biblioteca universitaria

--Entidad recurso

DROP TABLE IF EXISTS recurso;
CREATE TABLE recurso(
    idRecurso INT PRIMARY KEY,
    titulo varchar(30) NOT NULL,
    año INT,
);

--Libro
DROP TABLE IF EXISTS libro;
CREATE TABLE libro(
    idRecurso INT PRIMARY KEY,
    ISBN VARCHAR(13) NOT NULL UNIQUE,
    editorial VARCHAR(30),
    FOREIGN KEY (idRecurso) REFERENCES recurso(idRecurso)
);

--Revista
DROP TABLE IF EXISTS revista;
CREATE TABLE revista(
    idRecurso INT PRIMARY KEY,
    ISSN VARCHAR(8) NOT NULL UNIQUE,
    numero INT,
    FOREIGN KEY (idRecurso) REFERENCES recurso(idRecurso)
);

--usuario

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario(
    DNI INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
);

--prestamo

DROP TABLE IF EXISTS prestamo;
CREATE TABLE prestamo(
    DNI_usuario INT,
    idRecurso INT,
    fechaPrestamo DATE,
    fechaDevolucion DATE,
    PRIMARY KEY (DNI_usuario, idRecurso, fechaPrestamo),
    FOREIGN KEY (DNI_usuario) REFERENCES usuario(DNI),
    FOREIGN KEY (idRecurso) REFERENCES recurso(idRecurso)
    
);