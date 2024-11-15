CREATE TABLE `fact_table` (
  `Nombre Evento` varchar(255) NOT NULL,
  `equipo_local` varchar(45) DEFAULT NULL,
  `tipo_evento` varchar(45) DEFAULT NULL,
  `localidad_evento_estado` varchar(45) DEFAULT NULL,
  `nombre_apellido_cliente` varchar(45) DEFAULT NULL,
  `dni_cliente` varchar(45) DEFAULT NULL,
  `nombre_apellido_asistente` varchar(45) DEFAULT NULL,
  `dni_asistente` varchar(45) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `equipo_ticket` varchar(45) DEFAULT NULL,
  `fecha_id` varchar(6) DEFAULT NULL,
  KEY `fecha_id_idx` (`fecha_id`),
  CONSTRAINT `fecha_id` FOREIGN KEY (`fecha_id`) REFERENCES `fecha_dimension` (`fecha_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `fecha_dimension` (
  `mes_anio` date NOT NULL,
  `fecha_id` varchar(6) NOT NULL,
  PRIMARY KEY (`fecha_id`),
  UNIQUE KEY `fecha_id_UNIQUE` (`fecha_id`),
  UNIQUE KEY `mes_anio_UNIQUE` (`mes_anio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



CREATE TABLE `ticketup_dw`.`total_ventas_equipo_objetivos` (
  `idtotal_ventas_equipo_objetivos` INT NOT NULL,
  `nombre_equipo` VARCHAR(45) NOT NULL,
  `total_ventas_mes` DOUBLE NOT NULL,
  `objetivos_mes` DOUBLE NOT NULL,
  `fecha_id` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`idtotal_ventas_equipo_objetivos`),
  INDEX `mes_anio_idx` (`fecha_id` ASC) VISIBLE,
  CONSTRAINT `mes_anio`
    FOREIGN KEY (`fecha_id`)
    REFERENCES `ticketup_dw`.`fecha_dimension` (`fecha_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
