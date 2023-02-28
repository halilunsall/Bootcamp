CREATE DATABASE Manufacturer

USE Manufacturer

CREATE SCHEMA charlie


CREATE TABLE charlie.product(
	product_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	product_name VARCHAR(50) NULL,
	product_quantity INT NOT NULL);


CREATE TABLE charlie.component(
	component_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	component_name VARCHAR(50) NOT NULL,
	component_desc VARCHAR(50) NOT NULL,
	component_quantity INT NOT NULL);


CREATE TABLE charlie.supplier(
	supplier_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	supplier_name VARCHAR(50) NOT NULL,
	supplier_location VARCHAR(50) NOT NULL,
	supplier_country VARCHAR(50) NOT NULL,
	action_status BIT NOT NULL);


CREATE TABLE charlie.product_comp(
	CONSTRAINT FK_key1 FOREIGN KEY (product_id) REFERENCES charlie.product,
	product_id INT NOT NULL,
	CONSTRAINT FK_key2 FOREIGN KEY (comp_id) REFERENCES charlie.component,
	comp_id INT NOT NULL,
	comp_quantity INT NOT NULL);


CREATE TABLE charlie.component_sup(
	CONSTRAINT FK_key3 FOREIGN KEY (supplier_id) REFERENCES charlie.supplier,
	supplier_id INT NOT NULL,
	CONSTRAINT FK_key4 FOREIGN KEY (comp_id) REFERENCES charlie.component,
	comp_id INT NOT NULL,
	order_date DATE NOT NULL,
	order_quantity INT NOT NULL);