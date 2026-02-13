--Ejercicio 2: cadena de hoteles

--Creamos tabla empleado

DROP TABLE IF EXISTS  hotel;
CRETE TABLE hotel(
    idHotel INT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    ciudad VARCHAR(20),
);

drop table if exxists habitacion;
create table habitacion(
    numHabitacion INT PRIMARY KEY,
    tipo ENUM('individual','doble','suite') NOT NULL,
    precio DECIMAL(6,2) NOT NULL, --6 numeros permitidos antes y despues de la coma, 2 despues de la coma "escala", donde se corta el decimal

    --Establecemos la relacion entre hotel y habitacion, haciendo que sea 1:N (un hotel puede tener muchas habitaciones)
    primary key (idHotel, numHabitacion),
    foreign key (idHotel) references hotel(idHotel)
);

