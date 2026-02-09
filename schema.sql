CREATE DATABASE IF NOT EXISTS ecommerce_dio;
USE ecommerce_dio;

CREATE TABLE Clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(15),
    Minit CHAR(3),
    Lname VARCHAR(20),
    Address VARCHAR(255),
    CreateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Especialização PJ/PF
CREATE TABLE Client_PF (
    idClient INT PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

CREATE TABLE Client_PJ (
    idClient INT PRIMARY KEY,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    SocialName VARCHAR(255) NOT NULL,
    FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

CREATE TABLE Product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    Category VARCHAR(20) DEFAULT 'Eletrônico',
    Description VARCHAR(255),
    Price FLOAT NOT NULL
);

CREATE TABLE Payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    PaymentType ENUM('Boleto', 'Cartão', 'Pix'),
    CardHash VARCHAR(255),
    FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

CREATE TABLE Orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    OrderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    OrderDescription VARCHAR(255),
    Freight FLOAT DEFAULT 10,
    FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

CREATE TABLE Delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT,
    TrackingCode VARCHAR(20),
    Status ENUM('Em separação', 'Enviado', 'Entregue') DEFAULT 'Em separação',
    FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);

CREATE TABLE Supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Contact CHAR(11) NOT NULL
);

CREATE TABLE ProductStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    StorageLocation VARCHAR(255),
    Quantity INT DEFAULT 0
);

CREATE TABLE ProductSupplier (
    idPsSupplier INT,
    idPsProduct INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    FOREIGN KEY (idPsSupplier) REFERENCES Supplier(idSupplier),
    FOREIGN KEY (idPsProduct) REFERENCES Product(idProduct)
);

CREATE TABLE ProductOrder (
    idPOproduct INT,
    idPOorder INT,
    PoQuantity INT DEFAULT 1,
    PoStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    FOREIGN KEY (idPOproduct) REFERENCES Product(idProduct),
    FOREIGN KEY (idPOorder) REFERENCES Orders(idOrder)
);
