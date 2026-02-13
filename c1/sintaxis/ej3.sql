--Ejercicio 3: sistemas de vuelo
--Creamos tabla empleado

drop table if exists empleado;
create table empleado(
    DNI INT PRIMARY KEY,
    nombre VARCHAR(50),
    cargo VARCHAR(20),
    DNI_suprevisor INT,
    foreign key (DNI_suprevisor) references empleado(DNI) --relacion jerarquica entre empleados y supervisores
);
--Creamos tabla vuelo, relacion N:M (un vuelo puede tener muchos empleados y un empleado puede trabajar en muchos vuelos)
drop table if exists vuelo;
create table vuelo(
    idVuelo INT PRIMARY KEY,
    origen VARCHAR(30),
    destino VARCHAR(30),
);

--Creamos tabla tripulacion para la relacion N:M entre empleado y vuelo
drop table if exists tripulacion;
create table tripulacion(
    DNI_empleado INT,
    idVuelo INT,
    primary key (DNI_empleado, idVuelo),
    foreign key (DNI_empleado) references empleado(DNI),
    foreign key (idVuelo) references vuelo(idVuelo)
);

