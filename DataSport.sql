CREATE DATABASE datasport;
DROP DATABASE IF EXISTS datasport;
drop table if exists EstadoBien;
USE datasport;

INSERT INTO centro_deportivo (Id_Centro, Nombre,Direccion,Telefono,Email) VALUES (224, 'ChimboSport','Mi casa','2891282','chimbosport@gmail.com');

select * from centro_deportivo;
select * from Administrador;
select * from Empleado;
select * from bienes;
select * from BienIndividual;
select * from PAGO;
select * from VENTA;
select * from Inventario;

CREATE TABLE centro_deportivo (
    Id_Centro INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Administrador (
    Cedula_Admin BIGINT PRIMARY KEY,
    Nombres VARCHAR(120) NOT NULL,
    Apellidos VARCHAR(120) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Contraseña VARCHAR(100),
    Imagen text,
    Rol varchar(10),
    ID_Centro INT,
    CONSTRAINT FK_Centro_Administrador FOREIGN KEY (Id_Centro) REFERENCES centro_deportivo (Id_Centro)
);

CREATE TABLE Empleado (
    Cedula_Empleado BIGINT PRIMARY KEY,
    Nombres VARCHAR(120) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Contraseña VARCHAR(100),
    Imagen text,
    Rol varchar(10),
    Id_Centro INT,
    Estado enum ('Funcionamiento' , 'Despedido')NOT NULL,
    CONSTRAINT FK_Centro_Empleado FOREIGN KEY (Id_Centro) REFERENCES centro_deportivo (Id_Centro)
);

CREATE TABLE Usuario (
    Id_Usuario BIGINT PRIMARY KEY,
    Nombres VARCHAR(120) not null, 
    Apellidos VARCHAR(50),
    Email VARCHAR(100),
    Direccion VARCHAR(100),
    Telefono VARCHAR(15),
    Id_Centro INT,
    Estado enum ('Inactivo', 'Activo', 'Reportado')NOT NULL,
	Imagen text, 
    CONSTRAINT FK_Centro_Usuario FOREIGN KEY (Id_Centro) REFERENCES centro_deportivo (Id_Centro)
);

CREATE TABLE bienes (
    idBienes INT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Cantidad bigint NOT NULL,
    Precio  DECIMAL(10, 2) NOT NULL,
    Imagen text,
    Condicion ENUM ('Nuevo', 'Bien', 'Usado', 'Dañado')NOT NULL,
    ultimo_mantenimiento DATE,
    siguiente_mantenimiento DATE 
    );
    
CREATE TABLE BienIndividual (
    fecha_adquisición DATE,
    Estado ENUM('Activo', 'Inactivo')NOT NULL,
    Id_EstadoBien INT PRIMARY KEY,
    idBienes INT,
    Estado ENUM('Nuevo', 'Bien', 'Usado', 'Dañado'),
    Cantidad BIGINT NOT NULL,
    CONSTRAINT FK_Bien_Individual FOREIGN KEY (idBienes) REFERENCES bienes(idBienes)
);

CREATE TABLE Producto (
    Id_Producto INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion text,
    Estado enum ('En venta', 'Deshabilitado')NOT NULL,
    Stock INT Not null,
    Imagen text,
    Precio DECIMAL,
    Id_Centro INT,
    CONSTRAINT FK_Centro_Producto FOREIGN KEY (Id_Centro) REFERENCES centro_deportivo (Id_Centro)
);

/*CREATE TABLE Membresia (
    Id_Membresia INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('ACTIVO', 'INACTIVO') NOT NULL,
    Id_Usuario INT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    CONSTRAINT FK_Usuario_Membresia FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);*/

CREATE TABLE PAGO (
    Id_Pago INT PRIMARY KEY AUTO_INCREMENT,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha DATE NOT NULL,
    Id_Usuario bigint,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario (Id_Usuario)
);

CREATE TABLE HISTORIAL_PAGO (
    ID_Historial INT PRIMARY KEY AUTO_INCREMENT,
    Id_Usuario bigint,
    ID_Pago INT,
	CONSTRAINT HISTORIAL_PAGO_ibfk_1 FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
);

CREATE TABLE VENTA (
    ID_Venta INT PRIMARY KEY AUTO_INCREMENT,
    Fecha DATE NOT NULL,
    ID_Producto INT,
    Id_Usuario bigint,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario (Id_Usuario)
);

CREATE TABLE Inventario (
    ID_Inventario INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Cantidad bigint,
    Estado ENUM('Disponible', 'Prestado', 'Extraviado'),
    Id_Centro INT,
    FOREIGN KEY (Id_Centro) REFERENCES centro_deportivo (Id_Centro)
);