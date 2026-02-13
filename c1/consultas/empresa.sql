CREATE DATABASE IF NOT EXISTS empresa DEFAULT 
CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

USE empresa;

DROP TABLE IF EXISTS  habilidad ;
CREATE TABLE  habilidad  (
   CodHab  CHAR(5) PRIMARY KEY ,
   DesHab  VARCHAR(30) UNIQUE
) ENGINE=InnoDB;


DROP TABLE IF EXISTS  centro ;
CREATE TABLE  centro  (
  CodCen CHAR(4)  PRIMARY KEY,
  CodEmpDir INT(10) ,
  NomCen VARCHAR(30) NOT NULL UNIQUE,
  DirCen VARCHAR(50) ,
  PobCen VARCHAR(15)
  ) ENGINE=InnoDB;


DROP TABLE IF EXISTS  departamento ;
CREATE TABLE  departamento  (
  CodDep CHAR(5) PRIMARY KEY,
  CodEmpDir INT(10),
  CodDepDep CHAR(5),
  CodCen CHAR(4),
  NomDep VARCHAR(40) NOT NULL UNIQUE,
  PreAnu DECIMAL(12,2),
  TiDir ENUM('F','P')
  ) ENGINE=InnoDB;


DROP TABLE IF EXISTS  empleado ;
CREATE TABLE  empleado  (
  CodEmp INT(10)  AUTO_INCREMENT PRIMARY KEY,
  CodDep CHAR(5),
  ExTelEmp VARCHAR(9),
  FecInEmp DATE,
  FecNaEmp DATE,
  NifEmp VARCHAR(9),
  NomEmp VARCHAR(40),
  NumHi INT(1) ,
  SalEmp DECIMAL(12,2)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS  habemp ;
CREATE TABLE  habemp  (
   CodHab  CHAR(5),
   CodEmp  INT(10) ,
   NivHab  TINYINT ,
   PRIMARY KEY ( CodEmp , CodHab )
) ENGINE=InnoDB;



DROP TABLE IF EXISTS  hijo;
CREATE TABLE  hijo  (
   CodEmp  INT(10)   ,
   NumHij  INT(1)   ,
   FecNaHi  DATE,
   NomHi  VARCHAR(40)  ,
   PRIMARY KEY  ( CodEmp , NumHij )
 ) ENGINE=InnoDB ;


ALTER TABLE departamento
ADD CONSTRAINT fk_dep_cen FOREIGN KEY (CodCen) REFERENCES centro(CodCen)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE departamento
ADD CONSTRAINT fk_dep_emp FOREIGN KEY (CodEmpDir) REFERENCES empleado(CodEmp)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE departamento
ADD CONSTRAINT fk_dep_dep FOREIGN KEY (CodDepDep) REFERENCES departamento(CodDep)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE empleado
ADD CONSTRAINT fk_emp_dep FOREIGN KEY (CodDep) REFERENCES departamento(CodDep)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE centro
ADD CONSTRAINT fk_cen_emp FOREIGN KEY (CodEmpDir) REFERENCES empleado(CodEmp)
ON DELETE NO ACTION ON UPDATE CASCADE;


ALTER TABLE hijo
ADD CONSTRAINT fk_hij_emp FOREIGN KEY (CodEmp) REFERENCES empleado(CodEmp)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE habemp
ADD CONSTRAINT fk_habemp_emp FOREIGN KEY (CodEmp) REFERENCES empleado(CodEmp)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE habemp
ADD CONSTRAINT fk_habemp_hab FOREIGN KEY (CodHab) REFERENCES habilidad(CodHab)
ON DELETE NO ACTION ON UPDATE CASCADE;


SET FOREIGN_KEY_CHECKS=0;


INSERT INTO  habilidad  ( CodHab , DesHab ) VALUES
 ('FONTA','Fontanería'),
 ('GEREN','Gerencia'),
 ('GESCO','Gestión Contable'),
 ('MARKE','Marketing'),
 ('MECAN','Mecanografía'),
 ('RELPU','Relaciones Públicas'),
 ('TELEF','Telefonista'),
 ('INFOR','INFORMATICA');

INSERT INTO  centro  ( CodCen , CodEmpDir , NomCen , DirCen , PobCen ) VALUES
 ('DIGE',1,'Dirección General','Av. Constitución 88','Murcia'),
 ('FAZS',6,'Fábrica Zona Sur','Pol. Ind. Gral. Bastarreche','Cartagena'),
 ('OFZS',5,'Oficinas Zona Sur','Pl. España 14','Cartagena');


INSERT INTO  departamento  ( CodDep , CodEmpDir , CodDepDep , CodCen , NomDep , PreAnu , TiDir ) VALUES
 ('ADMZS',5,NULL,'OFZS','Administración Zona Sur',14000000,'P'),
 ('DIRGE',1,NULL,'DIGE','Dirección General',26000000,'P'),
 ('IN&DI',2,'DIRGE','DIGE','Investigación y Diseño',25000000,'P'),
 ('JEFZS',6,NULL,'FAZS','Jefatura Fábrica Zona Sur',6200000,'F'),
 ('PROZS',9,'JEFZS','FAZS','Producción Zona Sur',108000000,'P'),
 ('VENZS',3,'ADMZS','OFZS','Ventas Zona Sur',13500000,'F');

INSERT INTO  empleado  ( CodEmp , CodDep , ExTelEmp , FecInEmp , FecNaEmp , NifEmp , NomEmp , NumHi , SalEmp ) VALUES
 (1,'DIRGE','1111','1972-07-01 ','1961-08-07','21451451V','Saladino Mandamás, Augusto',1,7200000),
 (2,'IN&DI','2233','1991-06-14 ','1970-06-08','21231347K','Manrique Bacterio, Luisa',0,4500000),
 (3,'VENZS','2133','1984-06-08 ','1965-12-07','23823930D','Monforte Cid, Roldán',1,5200000),
 (4,'VENZS','3838','1990-08-09 ','1975-02-21','38293923L','Topaz Illán, Carlos',0,3200000),
 (5,'ADMZS','1239','1976-08-07 ','1958-03-08','38223923T','Alada Veraz, Juana',1,6200000),
 (6,'JEFZS','23838','1991-08-01 ','1969-06-03','26454122D','Gozque Altanero, Cándido',1,5000000),
 (7,'PROZS',NULL,'1994-06-30 ','1975-08-07','47123132D','Forzado López, Galeote',0,1600000),
 (8,'PROZS',NULL,'1994-08-15 ','1976-06-15','32132154H','Mascullas Alto, Eloísa',1,1600000),
 (9,'PROZS','12124','1982-06-10 ','1968-07-19','11312121D','Mando Correa, Rosa',2,3100000),
 (10,'PROZS',NULL,'1993-11-02 ','1975-01-07','32939393D','Mosc Amuerta, Mario',0,1300000);

INSERT INTO  hijo  ( CodEmp , NumHij , FecNaHi , NomHi ) VALUES
 (1,1,'1989-06-07','Saladino Oropel, Flavia'),
 (3,1,'1990-09-12','Monforte Lemos, Jesús'),
 (5,1,'1982-03-06','Pastora Alada, Mateo'),
 (8,1,'1994-03-14','Fuerte Mascullas, Anacleto'),
 (9,1,'1988-02-28','León Mando, Elvira'),
 (9,2,'1990-07-18','León Mando, Plácido');

INSERT INTO  habemp  ( CodHab , CodEmp , NivHab ) VALUES
 ('GEREN',1,10),
 ('RELPU',1,9),
 ('MARKE',3,9),
 ('GESCO',5,9),
 ('RELPU',5,8),
 ('FONTA',8,7);

SET FOREIGN_KEY_CHECKS=1;

/* AC601. Consultas Básicas de Selección */

-- 1. Lista el nombre de todos los departamentos
SELECT NomDep FROM departamento;

-- 2. Lista los nombres y los presupuestos de todos los departamentos
SELECT NomDep, PreAnu FROM departamento;

-- 3. Lista todas las columnas de la tabla departamento
SELECT * FROM departamento;

-- 4. Lista el nombre de los empleados junto con su salario
SELECT NomEmp, SalEmp FROM empleado;

-- 5. Recupera todas las posibilidades de número de hijos que tienen los empleados (0, 1 y 2)
SELECT DISTINCT NumHi FROM empleado;

-- 6. Lista el nombre y el complemento familiar (= salario * nº hijos * 4 / 100)
SELECT NomEmp, (SalEmp * NumHi * 4 / 100) AS ComplementoFamiliar 
FROM empleado;

-- 7. Lista el nombre de los departamentos, el presupuesto en euros y en dólares (USD)
-- (Usando una tasa de conversión ejemplo de 1.08)
SELECT NomDep, PreAnu, (PreAnu * 1.08) AS PresupuestoUSD 
FROM departamento;

-- 8. Alias para las columnas: nombre de departamento, euros, dólares
SELECT NomDep AS 'nombre de departamento', 
       PreAnu AS euros, 
       (PreAnu * 1.08) AS dólares 
FROM departamento;
/* AC602. Consultas con funciones */

-- 1. Nombres y presupuestos convirtiendo nombres a mayúscula
SELECT UPPER(NomDep), PreAnu FROM departamento;

-- 2. Nombres y salarios convirtiendo nombres a minúsculas
SELECT LOWER(NomEmp), SalEmp FROM empleado;

-- 3. Nombre empleado y en mayúsculas los dos primeros caracteres del código del departamento
SELECT NomEmp, UPPER(LEFT(CodDep, 2)) AS PrefijoDep FROM empleado;

-- 4. Código empleado, departamento y código unido con extensión telefónica (XXXX si es NULL)
SELECT CodEmp, CodDep, 
       CONCAT(CodEmp, CodDep, IFNULL(ExTelEmp, 'XXXX')) AS CodigoCompleto 
FROM empleado;

-- 5. Nombre y apellidos por separado (Basado en el formato "Apellido, Nombre" del INSERT)
-- Extrae el nombre (después de la coma) y apellidos (antes de la coma)
SELECT NomEmp, 
       SUBSTRING_INDEX(NomEmp, ', ', -1) AS Nombre, 
       SUBSTRING_INDEX(NomEmp, ', ', 1) AS Apellidos 
FROM empleado;

-- 6. Salario incrementado un 12%, redondeado
SELECT NomEmp, SalEmp, ROUND(SalEmp * 1.12) AS SalarioRedondeado FROM empleado;

-- 7. Salario incrementado un 12%, truncado con un decimal
SELECT NomEmp, SalEmp, TRUNCATE(SalEmp * 1.12, 1) AS SalarioTruncado FROM empleado;

-- 8. Clasificación del tipo de familia según hijos
SELECT NomEmp, NumHi, 
    CASE 
        WHEN NumHi = 0 THEN 'Sin familia' 
        WHEN NumHi = 1 THEN 'Ordinaria' 
        WHEN NumHi = 2 THEN 'Semi-numerosa' 
        ELSE 'Numerosa' 
    END AS TipoFamilia 
FROM empleado;
/* AC603. Fechas y ordenación avanzada */

-- 1. Día, mes y año de nacimiento por separado
SELECT NomEmp, DAY(FecNaEmp) AS Dia, MONTH(FecNaEmp) AS Mes, YEAR(FecNaEmp) AS Anio 
FROM empleado;

-- 2. Listado de empleados con su nombre, fecha de nacimiento y edad
SELECT NomEmp, FecNaEmp, TIMESTAMPDIFF(YEAR, FecNaEmp, CURDATE()) AS Edad 
FROM empleado;

-- 3. Fecha de incorporación y días de vacaciones extra (1 día extra por cada 4 años en la empresa)
SELECT NomEmp, FecInEmp, 
       FLOOR(TIMESTAMPDIFF(YEAR, FecInEmp, CURDATE()) / 4) AS VacacionesExtra 
FROM empleado;

-- 4. Código departamento, número aleatorio (2 cifras) y código del centro
SELECT NomDep, 
       CONCAT(CodDep, FLOOR(RAND() * 90 + 10), CodCen) AS NuevoCodigo 
FROM departamento;

-- 5. Listado ordenado por tipo de director (TiDir) y presupuesto (PreAnu) ascendente
SELECT TiDir, CodDep, NomDep, PreAnu 
FROM departamento 
ORDER BY TiDir ASC, PreAnu ASC;

-- 6. Nombre y salario (formateado con separadores) ordenado por salario descendente
SELECT NomEmp, FORMAT(SalEmp, 2) AS SalarioFormateado 
FROM empleado 
ORDER BY SalEmp DESC;

-- 7. Los tres departamentos con menor presupuesto (ordenado por presupuesto y centro)
SELECT * FROM departamento 
ORDER BY PreAnu ASC, CodCen ASC 
LIMIT 3;

-- 8. Recupera el empleado que más cobra
SELECT * FROM empleado 
ORDER BY SalEmp DESC 
LIMIT 1;

/* AR604. Consultas Tienda de Informática */
-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

-- 4. Nombre, precio en euros y precio en dólares (USD) (Tasa ejemplo 1.08).
SELECT nombre, precio, (precio * 1.08) AS dolares FROM producto;

-- 5. Alias: nombre de producto, euros, dólares.
SELECT nombre AS 'nombre de producto', precio AS euros, (precio * 1.08) AS dolares FROM producto;

-- 6. Nombres y precios convirtiendo nombres a mayúscula.
SELECT UPPER(nombre), precio FROM producto;

-- 7. Nombres y precios convirtiendo nombres a minúscula.
SELECT LOWER(nombre), precio FROM producto;

-- 8. Nombre de fabricante y los dos primeros caracteres del nombre en mayúsculas.
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;

-- 9. Nombres y precios redondeando el valor del precio.
SELECT nombre, ROUND(precio) FROM producto;

-- 10. Nombres y precios truncando el valor del precio (sin decimales).
SELECT nombre, TRUNCATE(precio, 0) FROM producto;

-- 11. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo_fabricante FROM producto;

-- 12. Lista el código de los fabricantes con productos, sin repetidos.
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. Nombres de fabricantes ordenados ascendentemente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. Nombres de fabricantes ordenados descendentemente.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. Productos ordenados por nombre (ASC) y precio (DESC).
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. Devuelve las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;

-- 17. Devuelve 2 filas a partir de la cuarta fila de fabricante (incluyéndola).
SELECT * FROM fabricante LIMIT 3, 2;

-- 18. Nombre y precio del producto más barato (ORDER BY y LIMIT).
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. Nombre y precio del producto más caro (ORDER BY y LIMIT).
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

/* AP605. Consultas Gestión de Empleados */
-- 1. Lista el primer apellido de todos los empleados.
SELECT apellido1 FROM empleado;

-- 2. Lista el primer apellido de los empleados sin repetidos.
SELECT DISTINCT apellido1 FROM empleado;

-- 3. Lista todas las columnas de la tabla empleado.
SELECT * FROM empleado;

-- 4. Lista el nombre y los apellidos de todos los empleados.
SELECT nombre, apellido1, apellido2 FROM empleado;

-- 5. Lista el código de los departamentos de los empleados.
SELECT codigo_departamento FROM empleado;

-- 6. Lista el código de los departamentos de los empleados sin repetidos.
SELECT DISTINCT codigo_departamento FROM empleado;

-- 7. Nombre y apellidos en una única columna.
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) FROM empleado;

-- 8. Nombre y apellidos en una única columna en MAYÚSCULAS.
SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) FROM empleado;

-- 9. Nombre y apellidos en una única columna en minúsculas.
SELECT LOWER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) FROM empleado;

-- 10. Código de empleado y el primer carácter del nombre.
SELECT codigo, LEFT(nombre, 1) FROM empleado;

-- 11. Código de empleado y el último carácter del nombre.
SELECT codigo, RIGHT(nombre, 1) FROM empleado;

-- 12. Código de empleado y los tres primeros caracteres del nombre.
SELECT codigo, LEFT(nombre, 3) FROM empleado;

-- 13. Código de empleado y los tres últimos caracteres del nombre.
SELECT codigo, RIGHT(nombre, 3) FROM empleado;

-- 14. Código de los departamentos de los empleados sin repetidos.
SELECT DISTINCT codigo_departamento FROM empleado;

-- 15. Nombre de departamentos y presupuesto ordenado ascendentemente.
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto ASC;

-- 16. Nombre de todos los departamentos ordenados descendentemente.
SELECT nombre FROM departamento ORDER BY nombre DESC;

-- 17. Apellidos y nombre ordenados alfabéticamente.
SELECT apellido1, apellido2, nombre FROM empleado ORDER BY apellido1, apellido2, nombre;

-- 18. Nombre y presupuesto de los 3 departamentos con mayor presupuesto.
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto DESC LIMIT 3;

-- 19. Nombre y presupuesto de los 3 departamentos con menor presupuesto.
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto ASC LIMIT 3;

-- 20. Nombre y presupuesto de departamentos con presupuesto >= 150.000€.
SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 150000;

/* AC606. Consultas sobre la base de datos Empresa */

-- 1. Nombre, salario y número de hijos del empleado con código 1.
SELECT NomEmp, SalEmp, NumHi FROM empleado WHERE CodEmp = 1;

-- 2. Código de departamentos con trabajadores incorporados antes del 1/1/92 (sin repetidos).
SELECT DISTINCT CodDep FROM empleado WHERE FecInEmp < '1992-01-01';

-- 3. Nombre de trabajadores que no tienen extensión telefónica.
SELECT NomEmp FROM empleado WHERE ExTelEmp IS NULL;

-- 4. Nombre y presupuesto de departamentos no ubicados en 'DIGE' o 'FAZS'.
SELECT NomDep, PreAnu FROM departamento WHERE CodCen NOT IN ('DIGE', 'FAZS');

-- 5. Nombre y salario de trabajadores con salario < 2M o > 5M.
SELECT NomEmp, SalEmp FROM empleado WHERE SalEmp < 2000000 OR SalEmp > 5000000;

-- 6. Código y nombre de empleados cuyo código NO sea 1, 4, 6, 8 ni 10.
SELECT CodEmp, NomEmp FROM empleado WHERE CodEmp NOT IN (1, 4, 6, 8, 10);

-- 7. Nombre y fecha de nacimiento de hijos con la secuencia "León" en su nombre.
SELECT NomHi, FecNaHi FROM hijo WHERE NomHi LIKE '%León%';

-- 8. Nombre y salario anual (SalEmp * 12) de empleados que ganan < 4M e ingresaron antes de 1985.
SELECT NomEmp, (SalEmp * 12) AS SalarioAnual 
FROM empleado 
WHERE SalEmp < 4000000 AND FecInEmp < '1985-01-01';

-- 9. Nombre y NIF de empleados con letra D o V en NIF, bajo condiciones de depto/salario o fecha.
SELECT NomEmp, NifEmp 
FROM empleado 
WHERE (NifEmp LIKE '%D%' OR NifEmp LIKE '%V%') 
  AND (
      (CodDep IN ('IN&DI', 'DIRGE') AND SalEmp > 5000000) 
      OR 
      (FecInEmp BETWEEN '1994-01-01' AND '1994-12-31')
  );


--Ejercicio de clase
  /*
codigo de empleado, nif de empleado, nombre de empleado, numero de hijos, salario , cuyo nombrecomience por M, qie tenga 1/2 hijos y su salario este entre 3000000 y 5000000 y en orden descendente
*/

SELECT CodEmp, NifEmp, NomEmp, NumHi, SalEmp FROM empleado
WHERE NomEmp LIKE 'M%'
  AND NumHi IN (1, 2)
  AND SalEmp BETWEEN 3000000 AND 5000000  
ORDER BY SalEmp DESC;

--AC610
SELECT d.NomDep, d.PreAnu, c.NomCen
FROM departamento d
JOIN centro c ON d.CodCen = c.CodCen;

SELECT d.NomDep, d.PreAnu, e.NomEmp
FROM departamento d
JOIN empleado e ON d.CodEmpDir = e.CodEmp;

SELECT d.NomDep, d.PreAnu, c.NomCen, e.NomEmp
FROM departamento d
JOIN centro c ON d.CodCen = c.CodCen
JOIN empleado e ON d.CodEmpDir = e.CodEmp;

SELECT d.NomDep, c.NomCen, e.NomEmp
FROM departamento d
JOIN centro c ON d.CodCen = c.CodCen
JOIN empleado e ON d.CodEmpDir = e.CodEmp
WHERE d.PreAnu = (SELECT MAX(PreAnu) FROM departamento);

SELECT e.*
FROM empleado e
JOIN departamento d ON e.CodDep = d.CodDep
JOIN centro c ON d.CodCen = c.CodCen
WHERE c.NomCen = 'Fábrica Zona Sur';

SELECT e.NomEmp, h.NomHi, h.FecNaHi
FROM empleado e
JOIN hijo h ON e.CodEmp = h.CodEmp
WHERE e.NumHi = 1
ORDER BY h.FecNaHi;

SELECT CodDep FROM departamento
INTERSECT
SELECT CodDep FROM empleado;

SELECT CodEmp FROM empleado
EXCEPT
(SELECT CodEmpDir FROM departamento UNION SELECT CodEmpDir FROM centro);

--usando los operadores de conjuntos, recupera: los empleados que no son directivos de nungun departamento (no aparecen en departamento.CodEmpDir)
SELECT CodEmp FROM empleado
EXCEPT
SELECT CodEmpDir FROM departamento;

-- los empleados que no son directivos de ningun centro ni de ningun departamento
SELECT CodEmp FROM empleado
EXCEPT 
(SELECT CodEmpDir FROM departamento UNION SELECT CodEmpDir FROM centro);

SELECT DISTINCT e.NomEmp
FROM empleado e
JOIN departamento d ON e.CodDep = d.CodDep
JOIN centro c ON d.CodCen = c.CodCen
WHERE c.NomCen = 'Oficinas Zona Sur' AND e.NumHi > 0;

SELECT DISTINCT d.NomDep
FROM departamento d
JOIN empleado e ON d.CodDep = e.CodDep
JOIN habemp he ON e.CodEmp = he.CodEmp
JOIN habilidad h ON he.CodHab = h.CodHab
WHERE h.DesHab = 'Fontanería';

--recupera todos los dempartamentos que dependa de un departamento secundario

SELECT d1.NomDep
FROM departamento d1
JOIN departamento d2 ON d1.CodDepDep = d2.CodDep;