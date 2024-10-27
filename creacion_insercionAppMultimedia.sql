-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aplicacionMultimedia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aplicacionMultimedia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aplicacionMultimedia` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema aplicacionmultimedia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aplicacionmultimedia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aplicacionmultimedia` DEFAULT CHARACTER SET utf8mb3 ;
USE `aplicacionMultimedia` ;

-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `contrasena` VARCHAR(100) NOT NULL,
  `tipo_suscripcion` ENUM('basica', 'premium') NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Pelicula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Pelicula` (
  `idPelicula` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `anio_lanzamiento` INT(4) NULL,
  `duracion` INT NOT NULL,
  `url_imagen` VARCHAR(300) NULL,
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Serie` (
  `idSerie` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `anio_lanzamiento` INT(4) NULL,
  `num_temporadas` INT NOT NULL,
  `imagen_url` VARCHAR(100) NULL,
  PRIMARY KEY (`idSerie`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Temporada` (
  `idTemporada` INT NOT NULL AUTO_INCREMENT,
  `numero_temporada` INT NOT NULL,
  `numero_episodios` INT NOT NULL,
  `fecha_lanzamiento` DATE NULL,
  `IdSerie` INT NOT NULL,
  PRIMARY KEY (`idTemporada`),
  INDEX `fk_Temporada_Serie1_idx` (`IdSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Temporada_Serie1`
    FOREIGN KEY (`IdSerie`)
    REFERENCES `aplicacionMultimedia`.`Serie` (`idSerie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Episodio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Episodio` (
  `idEpisodio` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT NOT NULL,
  `fecha_lanzamiento` DATE NULL,
  `idTemporada` INT NOT NULL,
  PRIMARY KEY (`idEpisodio`),
  INDEX `fk_Episodio_Temporada1_idx` (`idTemporada` ASC) VISIBLE,
  CONSTRAINT `fk_Episodio_Temporada1`
    FOREIGN KEY (`idTemporada`)
    REFERENCES `aplicacionMultimedia`.`Temporada` (`idTemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Genero` (
  `idGenero` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Lista_de_vistos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Lista_de_vistos` (
  `idCalificacion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `tipo_contenido` ENUM('pelicula', 'serie') NOT NULL,
  `fecha_agregado` DATE NOT NULL,
  `estado` ENUM('por ver', 'en progreso', 'visto') NOT NULL,
  `idUsuario` INT NOT NULL,
  `idPelicula` INT,
  `idSerie` INT,
  PRIMARY KEY (`idCalificacion`),
  INDEX `fk_Lista_de_vistos_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Lista_de_vistos_Pelicula1_idx` (`idPelicula` ASC) VISIBLE,
  INDEX `fk_Lista_de_vistos_Serie1_idx` (`idSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Lista_de_vistos_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `aplicacionMultimedia`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lista_de_vistos_Pelicula1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `aplicacionMultimedia`.`Pelicula` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lista_de_vistos_Serie1`
    FOREIGN KEY (`idSerie`)
    REFERENCES `aplicacionMultimedia`.`Serie` (`idSerie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Actor` (
  `idActor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NULL,
  `nacionalidad` VARCHAR(100) NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Pelicula_Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Pelicula_Genero` (
  `idPelicula` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`idPelicula`, `idGenero`),
  INDEX `fk_Pelicula_has_Genero_Genero1_idx` (`idGenero` ASC) VISIBLE,
  INDEX `fk_Pelicula_has_Genero_Pelicula1_idx` (`idPelicula` ASC) VISIBLE,
  CONSTRAINT `fk_Pelicula_has_Genero_Pelicula1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `aplicacionMultimedia`.`Pelicula` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pelicula_has_Genero_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `aplicacionMultimedia`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Serie_Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Serie_Genero` (
  `idSerie` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`idSerie`, `idGenero`),
  INDEX `fk_Serie_has_Genero_Genero1_idx` (`idGenero` ASC) VISIBLE,
  INDEX `fk_Serie_has_Genero_Serie1_idx` (`idSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Serie_has_Genero_Serie1`
    FOREIGN KEY (`idSerie`)
    REFERENCES `aplicacionMultimedia`.`Serie` (`idSerie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serie_has_Genero_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `aplicacionMultimedia`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Serie_Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Serie_Actor` (
  `idSerie` INT NOT NULL,
  `idActor` INT NOT NULL,
  PRIMARY KEY (`idSerie`, `idActor`),
  INDEX `fk_Serie_has_Actor_Actor1_idx` (`idActor` ASC) VISIBLE,
  INDEX `fk_Serie_has_Actor_Serie1_idx` (`idSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Serie_has_Actor_Serie1`
    FOREIGN KEY (`idSerie`)
    REFERENCES `aplicacionMultimedia`.`Serie` (`idSerie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serie_has_Actor_Actor1`
    FOREIGN KEY (`idActor`)
    REFERENCES `aplicacionMultimedia`.`Actor` (`idActor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aplicacionMultimedia`.`Pelicula_Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionMultimedia`.`Pelicula_Actor` (
  `idPelicula` INT NOT NULL,
  `idActor` INT NOT NULL,
  PRIMARY KEY (`idPelicula`, `idActor`),
  INDEX `fk_Pelicula_has_Actor_Actor1_idx` (`idActor` ASC) VISIBLE,
  INDEX `fk_Pelicula_has_Actor_Pelicula1_idx` (`idPelicula` ASC) VISIBLE,
  CONSTRAINT `fk_Pelicula_has_Actor_Pelicula1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `aplicacionMultimedia`.`Pelicula` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pelicula_has_Actor_Actor1`
    FOREIGN KEY (`idActor`)
    REFERENCES `aplicacionMultimedia`.`Actor` (`idActor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `aplicacionmultimedia` ;

-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`actor` (
  `idActor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `nacionalidad` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`serie` (
  `idSerie` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `anio_lanzamiento` INT NULL DEFAULT NULL,
  `num_temporadas` INT NOT NULL,
  `imagen_url` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idSerie`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`temporada` (
  `idTemporada` INT NOT NULL AUTO_INCREMENT,
  `numero_temporada` INT NOT NULL,
  `numero_episodios` INT NOT NULL,
  `fecha_lanzamiento` DATE NULL DEFAULT NULL,
  `IdSerie` INT NOT NULL,
  PRIMARY KEY (`idTemporada`),
  INDEX `fk_Temporada_Serie1_idx` (`IdSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Temporada_Serie1`
    FOREIGN KEY (`IdSerie`)
    REFERENCES `aplicacionmultimedia`.`serie` (`idSerie`))
ENGINE = InnoDB
AUTO_INCREMENT = 117
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`episodio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`episodio` (
  `idEpisodio` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT NOT NULL,
  `fecha_lanzamiento` DATE NULL DEFAULT NULL,
  `idTemporada` INT NOT NULL,
  PRIMARY KEY (`idEpisodio`),
  INDEX `fk_Episodio_Temporada1_idx` (`idTemporada` ASC) VISIBLE,
  CONSTRAINT `fk_Episodio_Temporada1`
    FOREIGN KEY (`idTemporada`)
    REFERENCES `aplicacionmultimedia`.`temporada` (`idTemporada`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`genero` (
  `idGenero` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`pelicula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`pelicula` (
  `idPelicula` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `anio_lanzamiento` INT NULL DEFAULT NULL,
  `duracion` INT NOT NULL,
  `url_imagen` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `contrasena` VARCHAR(100) NOT NULL,
  `tipo_suscripcion` ENUM('basica', 'premium') NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`lista_de_vistos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`lista_de_vistos` (
  `idCalificacion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `tipo_contenido` ENUM('pelicula', 'serie') NOT NULL,
  `fecha_agregado` DATE NOT NULL,
  `estado` ENUM('por ver', 'en progreso', 'visto') NOT NULL,
  `idUsuario` INT NOT NULL,
  `idPelicula` INT NULL DEFAULT NULL,
  `idSerie` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idCalificacion`),
  INDEX `fk_Lista_de_vistos_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Lista_de_vistos_Pelicula1_idx` (`idPelicula` ASC) VISIBLE,
  INDEX `fk_Lista_de_vistos_Serie1_idx` (`idSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Lista_de_vistos_Pelicula1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `aplicacionmultimedia`.`pelicula` (`idPelicula`),
  CONSTRAINT `fk_Lista_de_vistos_Serie1`
    FOREIGN KEY (`idSerie`)
    REFERENCES `aplicacionmultimedia`.`serie` (`idSerie`),
  CONSTRAINT `fk_Lista_de_vistos_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `aplicacionmultimedia`.`usuario` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`pelicula_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`pelicula_actor` (
  `idPelicula` INT NOT NULL,
  `idActor` INT NOT NULL,
  PRIMARY KEY (`idPelicula`, `idActor`),
  INDEX `fk_Pelicula_has_Actor_Actor1_idx` (`idActor` ASC) VISIBLE,
  INDEX `fk_Pelicula_has_Actor_Pelicula1_idx` (`idPelicula` ASC) VISIBLE,
  CONSTRAINT `fk_Pelicula_has_Actor_Actor1`
    FOREIGN KEY (`idActor`)
    REFERENCES `aplicacionmultimedia`.`actor` (`idActor`),
  CONSTRAINT `fk_Pelicula_has_Actor_Pelicula1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `aplicacionmultimedia`.`pelicula` (`idPelicula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`pelicula_genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`pelicula_genero` (
  `idPelicula` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`idPelicula`, `idGenero`),
  INDEX `fk_Pelicula_has_Genero_Genero1_idx` (`idGenero` ASC) VISIBLE,
  INDEX `fk_Pelicula_has_Genero_Pelicula1_idx` (`idPelicula` ASC) VISIBLE,
  CONSTRAINT `fk_Pelicula_has_Genero_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `aplicacionmultimedia`.`genero` (`idGenero`),
  CONSTRAINT `fk_Pelicula_has_Genero_Pelicula1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `aplicacionmultimedia`.`pelicula` (`idPelicula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`serie_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`serie_actor` (
  `idSerie` INT NOT NULL,
  `idActor` INT NOT NULL,
  PRIMARY KEY (`idSerie`, `idActor`),
  INDEX `fk_Serie_has_Actor_Actor1_idx` (`idActor` ASC) VISIBLE,
  INDEX `fk_Serie_has_Actor_Serie1_idx` (`idSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Serie_has_Actor_Actor1`
    FOREIGN KEY (`idActor`)
    REFERENCES `aplicacionmultimedia`.`actor` (`idActor`),
  CONSTRAINT `fk_Serie_has_Actor_Serie1`
    FOREIGN KEY (`idSerie`)
    REFERENCES `aplicacionmultimedia`.`serie` (`idSerie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `aplicacionmultimedia`.`serie_genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicacionmultimedia`.`serie_genero` (
  `idSerie` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`idSerie`, `idGenero`),
  INDEX `fk_Serie_has_Genero_Genero1_idx` (`idGenero` ASC) VISIBLE,
  INDEX `fk_Serie_has_Genero_Serie1_idx` (`idSerie` ASC) VISIBLE,
  CONSTRAINT `fk_Serie_has_Genero_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `aplicacionmultimedia`.`genero` (`idGenero`),
  CONSTRAINT `fk_Serie_has_Genero_Serie1`
    FOREIGN KEY (`idSerie`)
    REFERENCES `aplicacionmultimedia`.`serie` (`idSerie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

ALTER TABLE `aplicacionmultimedia`.`lista_de_vistos` 
CHANGE COLUMN `idCalificacion` `idLista` INT NOT NULL AUTO_INCREMENT ;

/*
CREATE TABLE registro_usuarios_creados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_cambio DATETIME NOT NULL
);
*/
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



--  ------------------------------INSERCION DE DATOS ------------------------------
-- Insercion de datos
INSERT INTO `Usuario` (nombre, correo, contrasena, tipo_suscripcion) VALUES
('Juan Pérez', 'juan.perez@gmail.com', 'ContraseñaSegura123', 'premium'),
('Ana Gómez', 'ana.gomez@hotmail.com', 'MiContraseña456', 'basica'),
('Luis Martínez', 'luis.martinez@yahoo.com', 'Passw0rd!', 'premium'),
('María Rodríguez', 'maria.rodriguez@outlook.com', 'ContraseñaFuerte789', 'basica'),
('Carlos Fernández', 'carlos.fernandez@gmail.com', '12345Segura!', 'premium');


INSERT INTO `Pelicula` (titulo, anio_lanzamiento, duracion, url_imagen) VALUES
('Inception', 2010, 148, 'https://m.media-amazon.com/images/I/912AErFSBHL._AC_UF894,1000_QL80_.jpg'),
('The Godfather', 1972, 175, 'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg'),
('The Dark Knight', 2008, 152, 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg'),
('Pulp Fiction', 1994, 154, 'https://pics.filmaffinity.com/Pulp_Fiction-210382116-mmed.jpg'),
('El secreto de sus ojos', 2009, 129, 'https://pics.filmaffinity.com/El_secreto_de_sus_ojos-483213496-large.jpg');


INSERT INTO `Serie` (titulo, anio_lanzamiento, num_temporadas, imagen_url) VALUES
('Breaking Bad', 2008, 5, 'https://es.web.img3.acsta.net/pictures/18/04/04/22/52/3191575.jpg'),
('Game of Thrones', 2011, 8, 'https://m.media-amazon.com/images/I/91iY86ZIuOL._AC_UF894,1000_QL80_.jpg'),
('Stranger Things', 2016, 3, 'https://www.ecartelera.com/carteles-series/100/124/021_m.jpg'),
('The Crown', 2016, 4, 'https://pics.filmaffinity.com/The_Crown_Serie_de_TV-838357032-large.jpg'),
('The Office', 2005, 9, 'https://pics.filmaffinity.com/The_Office_Serie_de_TV-210023284-large.jpg');


INSERT INTO `Temporada` (numero_temporada, numero_episodios, fecha_lanzamiento, IdSerie) VALUES
-- Breaking Bad
(1, 7, '2008-01-20', 1),
(2, 13, '2009-03-08', 1),
(3, 13, '2010-04-25', 1),
(4, 13, '2011-07-17', 1),
(5, 16, '2012-07-15', 1),

-- Game of Thrones
(1, 10, '2011-04-17', 2),
(2, 10, '2012-04-01', 2),
(3, 10, '2013-03-31', 2),
(4, 10, '2014-04-06', 2),
(5, 10, '2015-04-12', 2),
(6, 10, '2016-04-24', 2),
(7, 7, '2017-07-16', 2),
(8, 6, '2019-04-14', 2),

-- Stranger Things
(1, 8, '2016-07-15', 3),
(2, 9, '2017-10-27', 3),
(3, 8, '2019-07-04', 3),

-- The Crown
(1, 10, '2016-11-04', 4),
(2, 10, '2017-12-08', 4),
(3, 10, '2019-11-17', 4),
(4, 10, '2020-11-15', 4),

-- The Office
(1, 6, '2005-03-24', 5),
(2, 22, '2005-09-20', 5),
(3, 25, '2006-09-21', 5),
(4, 14, '2007-09-27', 5),
(5, 28, '2008-09-25', 5),
(6, 26, '2009-09-17', 5),
(7, 22, '2010-09-23', 5),
(8, 24, '2011-09-22', 5),
(9, 23, '2012-09-20', 5);


INSERT INTO `Genero` (idGenero, nombre, descripcion) VALUES
(1, 'Acción', 'Películas de acción y aventura.'),
(2, 'Drama', 'Películas que exploran el drama humano.'),
(3, 'Comedia', 'Películas de comedia y entretenimiento.'),
(4, 'Ciencia Ficción', 'Películas que exploran lo desconocido.'),
(5, 'Terror', 'Películas de terror y suspenso.');


INSERT INTO `Lista_de_vistos` (titulo, tipo_contenido, fecha_agregado, estado, idUsuario, idPelicula, idSerie) VALUES
('Inception', 'pelicula', '2023-10-01', 'visto', 1, 1, NULL),
('Breaking Bad', 'serie', '2023-10-02', 'en progreso', 2, NULL, 1),
('The Godfather', 'pelicula', '2023-10-03', 'por ver', 3, 2, NULL),
('The Office', 'serie', '2023-10-04', 'visto', 4, NULL, 5),
('Stranger Things', 'serie', '2023-10-05', 'por ver', 5, NULL, 3),
('The Godfather', 'pelicula', '2023-10-03', 'por ver', 1, 2, NULL);


INSERT INTO `Actor` (nombre, fecha_nacimiento, nacionalidad) VALUES
('Leonardo DiCaprio', '1974-11-11', 'Estadounidense'),
('Bryan Cranston', '1956-03-07', 'Estadounidense'),
('Natalie Portman', '1981-06-09', 'Israeli'),
('Robert Downey Jr.', '1965-04-04', 'Estadounidense'),
('Kate Winslet', '1975-10-05', 'Britanica'),
('Aaron Paul', '1979-08-27', 'Estadounidense'),  
('Lena Headey', '1973-10-03', 'Británica'),      
('Finn Wolfhard', '2002-12-23', 'Canadiense'),   
('Matt Smith', '1982-10-28', 'Británico'),        
('Mindy Kaling', '1979-06-24', 'Estadounidense'); 

INSERT INTO `Pelicula_Genero` (idPelicula, idGenero) VALUES
(1, 1), -- Inception, Acción
(2, 2), -- The Godfather, Drama
(3, 1), -- The Dark Knight, Acción
(4, 2), -- Pulp Fiction, Drama
(5, 2); -- The Shawshank Redemption, Drama

INSERT INTO `Serie_Genero` (idSerie, idGenero) VALUES
(1, 2), -- Breaking Bad, Drama
(2, 4), -- Game of Thrones, Fantasía
(3, 4), -- Stranger Things, Ciencia Ficción
(4, 2), -- The Crown, Biográfica
(5, 3); -- The Office, Comedia

INSERT INTO serie_actor (idSerie, idActor) VALUES
(1, 2),  
(1, 6), 
(2, 7),  
(3, 8), 
(4, 9),  
(5, 10);  


INSERT INTO pelicula_actor (idPelicula, idActor) VALUES (1, 1); 








