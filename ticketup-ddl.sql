DROP DATABASE IF EXISTS ticketup;
CREATE DATABASE ticketup;
USE ticketup;
/*----------------------------------------------------------------------------*/
CREATE TABLE localidad (
    id_localidad INT PRIMARY KEY AUTO_INCREMENT,
    sector_localidad CHAR(1) NOT NULL,
    fila_localidad INT NOT NULL,
    numero_localidad INT NOT NULL
);
/*----------------------------------------------------------------------------*/
CREATE TABLE evento (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL
);
/*----------------------------------------------------------------------------*/
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL
);
/*----------------------------------------------------------------------------*/
CREATE TABLE tipo_producto (
    id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(255) NOT NULL
);
/*----------------------------------------------------------------------------*/
CREATE TABLE producto_base (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10 , 2 ) NOT NULL,
    id_tipo_producto INT NOT NULL,
    FOREIGN KEY (id_tipo_producto)
        REFERENCES tipo_producto (id_tipo_producto)
);
/*----------------------------------------------------------------------------*/
CREATE TABLE localidad_evento (
    id_localidad INT NOT NULL,
    id_evento INT NOT NULL,
    estado ENUM('Disponible', 'Reservada', 'Vendida', 'Anualda') DEFAULT 'Disponible' NOT NULL,
    PRIMARY KEY (id_localidad , id_evento),
    FOREIGN KEY (id_evento)
        REFERENCES evento (id_evento),
    FOREIGN KEY (id_localidad)
        REFERENCES localidad (id_localidad)
);
/*----------------------------------------------------------------------------*/
CREATE TABLE ticket_evento (
    id_ticket_evento INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    id_localidad INT NOT NULL,
    id_evento INT NOT NULL,
    nombre_persona_ocupante VARCHAR(100) NOT NULL,
    dni_persona_ocupante VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_localidad)
        REFERENCES localidad (id_localidad),
    FOREIGN KEY (id_evento)
        REFERENCES evento (id_evento),
    FOREIGN KEY (id_producto)
        REFERENCES producto_base (id_producto)
);
/*----------------------------------------------------------------------------*/
CREATE TABLE factura (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    fecha TIMESTAMP NOT NULL,
    id_cliente INT,
    total DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
);
/*----------------------------------------------------------------------------*/
CREATE TABLE item_factura (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_factura INT,
    id_producto_base INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (id_factura)
        REFERENCES factura (id_factura),
    FOREIGN KEY (id_producto_base)
        REFERENCES producto_base (id_producto)
);
/*----------------------------------------------------------------------------*/
CREATE TABLE producto_merchandising (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    id_producto_base INT,
    stock INT NOT NULL,
    FOREIGN KEY (id_producto_base)
        REFERENCES producto_base (id_producto)
);
