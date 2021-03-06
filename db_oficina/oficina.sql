-- MySQL Script generated by MySQL Workbench
-- Tue Dec  7 19:52:15 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ERP - Serviços - Oficina Mecânica automotiva
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ERP - Serviços - Oficina Mecânica automotiva
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva` DEFAULT CHARACTER SET utf8 ;
USE `ERP - Serviços - Oficina Mecânica automotiva` ;

-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Endereco` (
  `id_endereco` INT NOT NULL,
  `cep` CHAR(8) NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `bairro_distrito` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_endereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Estoque` (
  `id_estoque` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `area_m²` DECIMAL NULL DEFAULT 0.00,
  `nome_estoque` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id_estoque`),
  INDEX `fk_Estoque_Endereco2_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_Endereco2`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Produto` (
  `id_produto` INT NOT NULL,
  `id_estoque` INT NOT NULL,
  `nome_produto` VARCHAR(75) NOT NULL,
  `desc_prod` VARCHAR(100) NULL,
  `qtd_produto` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_Produto_Estoque_idx` (`id_estoque` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Estoque`
    FOREIGN KEY (`id_estoque`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Estoque` (`id_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Fornecedor` (
  `id_fornecedor` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `localizacao` DOUBLE NULL,
  `nome_fornecedor` VARCHAR(75) NULL,
  PRIMARY KEY (`id_fornecedor`),
  INDEX `fk_Fornecedor_Endereco1_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_Endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Catalogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Catalogo` (
  `id_produto` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  PRIMARY KEY (`id_produto`, `id_fornecedor`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`id_fornecedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto1_idx` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Usuario` (
  `id_usuario` INT NOT NULL,
  `login` VARCHAR(8) NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Cliente` (
  `id_cliente` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `nome_cliente` VARCHAR(80) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `Usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  INDEX `fk_Cliente_Endereco1_idx` (`id_endereco` ASC) VISIBLE,
  INDEX `fk_Cliente_Usuario1_idx` (`Usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`Usuario_id_usuario`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`NotaFiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`NotaFiscal` (
  `id_nota_fiscal` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `data_nf` DATE NOT NULL,
  `numero` INT NOT NULL,
  `tipo` VARCHAR(7) NOT NULL,
  `hora` INT NOT NULL,
  PRIMARY KEY (`id_nota_fiscal`),
  INDEX `fk_NotaFiscal_Fornecedor1_idx` (`id_fornecedor` ASC) VISIBLE,
  INDEX `fk_NotaFiscal_Cliente1_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_NotaFiscal_Fornecedor1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotaFiscal_Cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`OrdemDeServiço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`OrdemDeServiço` (
  `id_ordem_de_serviço` INT NOT NULL,
  `hora` INT NOT NULL,
  `numero` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_ordem_de_serviço`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`HistoricoOds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`HistoricoOds` (
  `id_ordem_de_serviço` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_ordem_de_serviço`, `id_cliente`),
  INDEX `fk_OrdemDeServiço_has_Cliente_Cliente1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_OrdemDeServiço_has_Cliente_OrdemDeServiço1_idx` (`id_ordem_de_serviço` ASC) VISIBLE,
  UNIQUE INDEX `id_ordem_de_serviço_UNIQUE` (`id_ordem_de_serviço` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemDeServiço_has_Cliente_OrdemDeServiço1`
    FOREIGN KEY (`id_ordem_de_serviço`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`OrdemDeServiço` (`id_ordem_de_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemDeServiço_has_Cliente_Cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Execucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Execucao` (
  `id_usuario` INT NOT NULL,
  `id_ordem_de_serviço` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_ordem_de_serviço`),
  INDEX `fk_Usuario_has_OrdemDeServiço_OrdemDeServiço1_idx` (`id_ordem_de_serviço` ASC) VISIBLE,
  INDEX `fk_Usuario_has_OrdemDeServiço_Usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_OrdemDeServiço_Usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_OrdemDeServiço_OrdemDeServiço1`
    FOREIGN KEY (`id_ordem_de_serviço`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`OrdemDeServiço` (`id_ordem_de_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ERP - Serviços - Oficina Mecânica automotiva`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ERP - Serviços - Oficina Mecânica automotiva`.`Funcionario` (
  `matricula` INT NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `id_endereco` INT NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `data_nascimento` DATE NULL DEFAULT 01/01/1930,
  `tipo_funcionario` MULTILINESTRING NULL,
  `Usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`matricula`, `cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  INDEX `fk_Funcionario_Endereco1_idx` (`id_endereco` ASC) VISIBLE,
  INDEX `fk_Funcionario_Usuario1_idx` (`Usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_Usuario1`
    FOREIGN KEY (`Usuario_id_usuario`)
    REFERENCES `ERP - Serviços - Oficina Mecânica automotiva`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
