-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Little_Lemon_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Little_Lemon_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Little_Lemon_DB` DEFAULT CHARACTER SET utf8 ;
USE `Little_Lemon_DB` ;

-- -----------------------------------------------------
-- Table `Little_Lemon_DB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon_DB`.`Customer` (
  `CustomerID` INT NOT NULL,
  `CustomerFullName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `ContactNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon_DB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon_DB`.`Staff` (
  `StaffID` INT NOT NULL,
  `StafffullName` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon_DB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon_DB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `BookingCustomerID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  `BookingSlot` DATETIME NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomerID_idx` (`BookingCustomerID` ASC) VISIBLE,
  INDEX `StaffID_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `BookingCustomerID`
    FOREIGN KEY (`BookingCustomerID`)
    REFERENCES `Little_Lemon_DB`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `Little_Lemon_DB`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon_DB`.`OrderStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon_DB`.`OrderStatus` (
  `StatusID` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`StatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon_DB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon_DB`.`Menu` (
  `MenuID` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon_DB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon_DB`.`Orders` (
  `OrderID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `StatusID` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL(5,2) NOT NULL,
  `OrderCustomerID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `BookingID_idx` (`BookingID` ASC) VISIBLE,
  INDEX `StatusID_idx` (`StatusID` ASC) VISIBLE,
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `OrderCustomerID_idx` (`OrderCustomerID` ASC) VISIBLE,
  CONSTRAINT `BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `Little_Lemon_DB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `StatusID`
    FOREIGN KEY (`StatusID`)
    REFERENCES `Little_Lemon_DB`.`OrderStatus` (`StatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `Little_Lemon_DB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OrderCustomerID`
    FOREIGN KEY (`OrderCustomerID`)
    REFERENCES `Little_Lemon_DB`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
