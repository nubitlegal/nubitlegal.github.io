-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema esvidal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema esvidal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `esvidal` DEFAULT CHARACTER SET latin1 ;
USE `esvidal` ;

-- -----------------------------------------------------
-- Table `esvidal`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`PERSONA` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aNombre01` VARCHAR(45) NOT NULL,
  `aNombre02` VARCHAR(45) NOT NULL,
  `aNombre03` VARCHAR(45) NOT NULL,
  `aApellido01` VARCHAR(45) NOT NULL,
  `aApellido02` VARCHAR(45) NOT NULL,
  `aEmail` VARCHAR(45) NOT NULL,
  `eTipo` VARCHAR(45) NOT NULL,
  `eEstado` VARCHAR(45) NOT NULL,
  `aCelular` VARCHAR(45) NOT NULL,
  `aFechaNacimiento` VARCHAR(45) NOT NULL,
  `aLugarNacimiento` VARCHAR(45) NOT NULL,
  `bHijos` TINYINT NOT NULL,
  `aFax` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`CLIENTE` (
  `clienteID` INT NOT NULL AUTO_INCREMENT,
  `idpersona` INT NOT NULL,
  `aTipoDocumento` VARCHAR(45) NOT NULL,
  `aNrDocumento` VARCHAR(45) NOT NULL,
  `aRazonSocial` VARCHAR(45) NULL,
  `aRUC` VARCHAR(45) NULL,
  `aWeb` VARCHAR(45) NULL,
  `eTipo` VARCHAR(45) NULL,
  PRIMARY KEY (`clienteID`),
  INDEX `fk_CLIENTE_PERSONA1_idx` (`idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTE_PERSONA1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `esvidal`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`CARGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`CARGO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aNombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`PROFESIONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`PROFESIONAL` (
  `profesionalID` INT NOT NULL AUTO_INCREMENT,
  `idpersona` INT NOT NULL,
  `idcargo` INT NOT NULL,
  `icoImagen` VARCHAR(45) NOT NULL,
  `url_linkedin` VARCHAR(45) NULL,
  `url_facebook` VARCHAR(45) NULL,
  `url_instagram` VARCHAR(45) NULL,
  PRIMARY KEY (`profesionalID`),
  INDEX `fk_PROFESIONAL_PERSONA1_idx` (`idpersona` ASC) VISIBLE,
  INDEX `fk_PROFESIONAL_CARGO1_idx` (`idcargo` ASC) VISIBLE,
  CONSTRAINT `fk_PROFESIONAL_PERSONA1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `esvidal`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROFESIONAL_CARGO1`
    FOREIGN KEY (`idcargo`)
    REFERENCES `esvidal`.`CARGO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`SERVICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`SERVICIO` (
  `servicioID` INT NOT NULL AUTO_INCREMENT,
  `aNombre` VARCHAR(45) NOT NULL,
  `icoImagen` VARCHAR(45) NOT NULL,
  `eTipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`servicioID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`TIPO_SERVICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`TIPO_SERVICIO` (
  `tipoServicioID` INT NOT NULL AUTO_INCREMENT,
  `idservicio` INT NOT NULL,
  `aNombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipoServicioID`),
  INDEX `fk_TIPO_SERVICIO_SERVICIO1_idx` (`idservicio` ASC) VISIBLE,
  CONSTRAINT `fk_TIPO_SERVICIO_SERVICIO1`
    FOREIGN KEY (`idservicio`)
    REFERENCES `esvidal`.`SERVICIO` (`servicioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`PROFESIONAL_SERVICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`PROFESIONAL_SERVICIO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idservicio` INT NOT NULL,
  `idprofesional` INT NOT NULL,
  INDEX `fk_SERVICIO_has_PROFESIONAL_PROFESIONAL1_idx` (`idprofesional` ASC) VISIBLE,
  INDEX `fk_SERVICIO_has_PROFESIONAL_SERVICIO1_idx` (`idservicio` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_SERVICIO_has_PROFESIONAL_SERVICIO1`
    FOREIGN KEY (`idservicio`)
    REFERENCES `esvidal`.`SERVICIO` (`servicioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SERVICIO_has_PROFESIONAL_PROFESIONAL1`
    FOREIGN KEY (`idprofesional`)
    REFERENCES `esvidal`.`PROFESIONAL` (`profesionalID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`CONTRASENIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`CONTRASENIA` (
  `contraseniaID` INT NOT NULL AUTO_INCREMENT,
  `aContrasenia` VARCHAR(45) NOT NULL,
  `personaID` INT NOT NULL,
  `eTipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`contraseniaID`),
  INDEX `fk_CONTRASENIA_PERSONA1_idx` (`personaID` ASC) VISIBLE,
  CONSTRAINT `fk_CONTRASENIA_PERSONA1`
    FOREIGN KEY (`personaID`)
    REFERENCES `esvidal`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`USER` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `CONTRASENIA_contraseniaID` INT NOT NULL,
  `login` INT NOT NULL,
  `dateLogin` DATETIME NULL,
  `dateUnlogin` DATETIME NULL,
  `dateUltimaConexion` DATETIME NULL,
  `bConectado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`),
  INDEX `fk_USER_CONTRASENIA1_idx` (`CONTRASENIA_contraseniaID` ASC) VISIBLE,
  CONSTRAINT `fk_USER_CONTRASENIA1`
    FOREIGN KEY (`CONTRASENIA_contraseniaID`)
    REFERENCES `esvidal`.`CONTRASENIA` (`contraseniaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`IDIOMA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`IDIOMA` (
  `idiomaID` INT NOT NULL AUTO_INCREMENT,
  `aNombre` VARCHAR(45) NOT NULL,
  `aISO639_2B` VARCHAR(3) NOT NULL,
  `bDefault` TINYINT NOT NULL,
  PRIMARY KEY (`idiomaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`PAIS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`PAIS` (
  `paisID` INT NOT NULL AUTO_INCREMENT,
  `aNombre` VARCHAR(45) NOT NULL,
  `aNombreING` VARCHAR(45) NOT NULL,
  `aPrefTelefonico` VARCHAR(45) NOT NULL,
  `aISO3166` VARCHAR(45) NOT NULL,
  `idiomaID` INT NOT NULL,
  PRIMARY KEY (`paisID`),
  INDEX `fk_PAIS_IDIOMA1_idx` (`idiomaID` ASC) VISIBLE,
  CONSTRAINT `fk_PAIS_IDIOMA1`
    FOREIGN KEY (`idiomaID`)
    REFERENCES `esvidal`.`IDIOMA` (`idiomaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`DIRECCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`DIRECCION` (
  `direccionID` INT NOT NULL AUTO_INCREMENT,
  `aCalle` VARCHAR(45) NOT NULL,
  `aCodigoPostal` VARCHAR(45) NOT NULL,
  `aCiudad` VARCHAR(45) NOT NULL,
  `aPais` VARCHAR(45) NOT NULL,
  `personaID` INT NOT NULL,
  `paisID` INT NOT NULL,
  PRIMARY KEY (`direccionID`),
  INDEX `fk_DIRECCION_PERSONA1_idx` (`personaID` ASC) VISIBLE,
  INDEX `fk_DIRECCION_PAIS1_idx` (`paisID` ASC) VISIBLE,
  CONSTRAINT `fk_DIRECCION_PERSONA1`
    FOREIGN KEY (`personaID`)
    REFERENCES `esvidal`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIRECCION_PAIS1`
    FOREIGN KEY (`paisID`)
    REFERENCES `esvidal`.`PAIS` (`paisID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`CONEXION_BANCARIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`CONEXION_BANCARIA` (
  `conexionBancariaID` INT NULL AUTO_INCREMENT,
  `aNumeroCuenta` VARCHAR(45) NOT NULL,
  `aIBAN` VARCHAR(45) NOT NULL,
  `aSWIFT` VARCHAR(45) NULL,
  `aComentario` VARCHAR(45) NULL,
  PRIMARY KEY (`conexionBancariaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`TITULO_ABREVIADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`TITULO_ABREVIADO` (
  `tituloAbreviadoID` INT NOT NULL AUTO_INCREMENT,
  `aTitulo` VARCHAR(45) NOT NULL,
  `bMostrar` VARCHAR(45) NOT NULL,
  `personaID` INT NOT NULL,
  PRIMARY KEY (`tituloAbreviadoID`),
  INDEX `fk_TITULO_ABREVIADO_PERSONA1_idx` (`personaID` ASC) VISIBLE,
  CONSTRAINT `fk_TITULO_ABREVIADO_PERSONA1`
    FOREIGN KEY (`personaID`)
    REFERENCES `esvidal`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`BANCOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`BANCOS` (
  `bancosID` INT NOT NULL AUTO_INCREMENT,
  `DIRECCION_direccionID` INT NOT NULL,
  `aBanco` VARCHAR(45) NOT NULL,
  `aTelefono` VARCHAR(45) NOT NULL,
  `aFax` VARCHAR(45) NOT NULL,
  `aEmail` VARCHAR(45) NOT NULL,
  `aWeb` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bancosID`),
  INDEX `fk_BANCOS_DIRECCION1_idx` (`DIRECCION_direccionID` ASC) VISIBLE,
  CONSTRAINT `fk_BANCOS_DIRECCION1`
    FOREIGN KEY (`DIRECCION_direccionID`)
    REFERENCES `esvidal`.`DIRECCION` (`direccionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`IMAGEN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`IMAGEN` (
  `imagenID` INT NOT NULL,
  `icoImagen` BLOB NOT NULL,
  `urlImagen` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`imagenID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`ARTICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`ARTICULO` (
  `articuloID` INT NOT NULL,
  `aNombre` VARCHAR(45) NOT NULL,
  `aDescripcion` TEXT NOT NULL,
  `aResumen` VARCHAR(250) NOT NULL,
  `datePublicacion` DATETIME NOT NULL,
  `imagenID` INT NOT NULL,
  `profesionalID` INT NOT NULL,
  PRIMARY KEY (`articuloID`),
  INDEX `fk_ARTICULO_IMAGEN1_idx` (`imagenID` ASC) VISIBLE,
  INDEX `fk_ARTICULO_PROFESIONAL1_idx` (`profesionalID` ASC) VISIBLE,
  CONSTRAINT `fk_ARTICULO_IMAGEN1`
    FOREIGN KEY (`imagenID`)
    REFERENCES `esvidal`.`IMAGEN` (`imagenID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTICULO_PROFESIONAL1`
    FOREIGN KEY (`profesionalID`)
    REFERENCES `esvidal`.`PROFESIONAL` (`profesionalID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`CATEGORIA` (
  `categoriaID` INT NOT NULL,
  `aNombre` VARCHAR(45) NOT NULL,
  `aDescripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`categoriaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`ARTICULO_CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`ARTICULO_CATEGORIA` (
  `articuloCategoriaID` INT NOT NULL,
  `ARTICULO_articuloID` INT NOT NULL,
  `CATEGORIA_categoriaID` INT NOT NULL,
  INDEX `fk_ARTICULO_has_CATEGORIA_CATEGORIA1_idx` (`CATEGORIA_categoriaID` ASC) VISIBLE,
  INDEX `fk_ARTICULO_has_CATEGORIA_ARTICULO1_idx` (`ARTICULO_articuloID` ASC) VISIBLE,
  PRIMARY KEY (`articuloCategoriaID`),
  CONSTRAINT `fk_ARTICULO_has_CATEGORIA_ARTICULO1`
    FOREIGN KEY (`ARTICULO_articuloID`)
    REFERENCES `esvidal`.`ARTICULO` (`articuloID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARTICULO_has_CATEGORIA_CATEGORIA1`
    FOREIGN KEY (`CATEGORIA_categoriaID`)
    REFERENCES `esvidal`.`CATEGORIA` (`categoriaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esvidal`.`PAG_POLITICAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esvidal`.`PAG_POLITICAS` (
  `pagPoliticasID` INT NOT NULL,
  `aNombre` VARCHAR(250) NOT NULL,
  `aContenido` TEXT NOT NULL,
  `dateLanzamiento` DATETIME NOT NULL,
  `profesionalID` INT NOT NULL,
  PRIMARY KEY (`pagPoliticasID`),
  INDEX `fk_PAG_POLITICAS_PROFESIONAL1_idx` (`profesionalID` ASC) VISIBLE,
  CONSTRAINT `fk_PAG_POLITICAS_PROFESIONAL1`
    FOREIGN KEY (`profesionalID`)
    REFERENCES `esvidal`.`PROFESIONAL` (`profesionalID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
