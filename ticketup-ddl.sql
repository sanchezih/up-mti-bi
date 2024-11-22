DROP DATABASE IF EXISTS ticketup;
CREATE DATABASE ticketup;
USE ticketup;
/*----------------------------------------------------------------------------*/
CREATE TABLE `localidad` (
  `id_localidad` int NOT NULL AUTO_INCREMENT,
  `sector_localidad` char(1) NOT NULL,
  `fila_localidad` int NOT NULL,
  `numero_localidad` int NOT NULL,
  `nombre_localidad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_localidad`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
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
    apellido VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE KEY
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
    estado ENUM('Disponible', 'Reservada', 'Vendida', 'Escaneada OK', 'No Disponible') DEFAULT 'Disponible' NOT NULL,
    localia BOOLEAN,
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
/*----------------------------------------------------------------------------*/
CREATE TABLE `encuentro_deportivo` (
  `id_evento` int NOT NULL,
  `equipo_local` int NOT NULL,
  `equipo_visitante` int NOT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `equipo_local_idx` (`equipo_local`),
  KEY `equipo_visitante_idx` (`equipo_visitante`),
  CONSTRAINT `encuentro_deportivo_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`),
  CONSTRAINT `equipo_local` FOREIGN KEY (`equipo_local`) REFERENCES `equipo` (`id_equipo`),
  CONSTRAINT `equipo_visitante` FOREIGN KEY (`equipo_visitante`) REFERENCES `equipo` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*----------------------------------------------------------------------------*/
CREATE TABLE `ticketup`.`equipo` (
  `id_equipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id_equipo`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE);

/*----------------------------------------------------------------------------*/
  CREATE TABLE `ticketup`.`objetivos_equipo` (
  `equipo` INT NOT NULL,
  `mes_anio` VARCHAR(45) NOT NULL,
  `monto` DOUBLE NOT NULL,
  PRIMARY KEY (`equipo`, `mes_anio`),
  CONSTRAINT `equipo`
    FOREIGN KEY (`equipo`)
    REFERENCES `ticketup`.`equipo` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

