--Ejercicio Practica 1
--Creamos tabla medico

DROP TABLE IF EXISTS medico;
CREATE TABLE medico(
    codMed INT PRIMARY KEY, --clave primaria, INT tipo de variable entero
    nombre VARCHAR(50) NOT NULL, -- NOT NULL no puede estar vacio, VARCHAR tipo de variable cadena de caracteres que pueden camiar de longitud
    especialidad VARCHAR(50) --tipo de variable cadena de caracteres que pueden camiar de longitud
);

--Creamos tabla paciente

DROP TABLE IF EXISTS paciente;
CREATE TABLE paciente(
    codPac INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fechaNacimiento DATE,
);

--Creamos tabla constulta

DROP TABLE IF EXISTS consulta;
CREATE TABLE consulta(
    codMed INT, --clave foranea que referencia a la tabla medico
    codPac INT, --clave foranea que referencia a la tabla paciente
    fecha DATE, --tipo de variable fecha
    FOREIGN KEY (codMed) REFERENCES medico(codMed), --clave foranea que referencia a la tabla medico
    FOREIGN KEY (codPac) REFERENCES paciente(codPac), --clave foranea que referencia a la tabla paciente
    PRIMARY KEY (codMed, codPac, fecha) --clave primaria compuesta por codMed, codPac y fecha, los necesita para identificar de forma unica cada consulta
);



