CREATE DATABASE LibraryDB


USE LibraryDB

CREATE SCHEMA product
CREATE SCHEMA component


CREATE TABLE product.product(
	product_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	product_name NVARCHAR(100) NULL);


CREATE TABLE component.component(
	component_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	component_name NVARCHAR(100) NOT NULL,
	component_desc NVARCHAR(100) NOT NULL);


CREATE TABLE component.supplier(
	supplier_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	supplier_name NVARCHAR(100) NOT NULL,
	action_status NVARCHAR(50) NOT NULL);


CREATE TABLE product.inventory(
	CONSTRAINT FK_key1 FOREIGN KEY (product_id) REFERENCES product.product,
	product_id INT NOT NULL,
	product_quantity INT NOT NULL);


CREATE TABLE component.inventory(
	CONSTRAINT FK_key2 FOREIGN KEY (comp_id) REFERENCES component.component,
	comp_id INT NOT NULL,
	comp_quantity INT NOT NULL);


CREATE TABLE component.orders(
	CONSTRAINT FK_key3 FOREIGN KEY (comp_id) REFERENCES component.supplier,
	supplier_id INT NOT NULL,
	CONSTRAINT FK_key4 FOREIGN KEY (comp_id) REFERENCES component.component,
	comp_id INT NOT NULL,
	order_date DATE NOT NULL,
	order_quantity INT NOT NULL);























