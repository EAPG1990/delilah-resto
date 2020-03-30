DROP DATABASE DELILAH;
CREATE DATABASE DELILAH;

USE DELILAH;

DROP TABLE IF EXISTS CUSTOMERS;
DROP TABLE IF EXISTS PRODUCTS;
DROP TABLE IF EXISTS ORDERS;
DROP TABLE IF EXISTS ORDERS_PRODUCTS;

CREATE TABLE CUSTOMERS(
    idCustomer INT PRIMARY KEY AUTO_INCREMENT,
    user VARCHAR (255) NOT NULL,
    fullname VARCHAR (255) NOT NULL,
    email VARCHAR (255) NOT NULL,
    phone VARCHAR (255) NOT NULL,
    shipping_address VARCHAR (255) NOT NULL,
    password VARCHAR (255) NOT NULL,
    rol SET('NO_ADMIN','ADMIN') NOT NULL DEFAULT 'NO_ADMIN'
);

CREATE TABLE PRODUCTS(
    idProduct INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (255) NOT NULL,
    description VARCHAR (255) NULL,
    cost DOUBLE NOT NULL,
    url VARCHAR (255) NULL
);

CREATE TABLE ORDERS(
    idOrder INT PRIMARY KEY AUTO_INCREMENT,
    idCustomer INT,
    state SET ('NUEVO', 'CONFIRMADO', 'PREPARANDO', 'ENVIANDO', 'CANCELADO', 'ENTREGADO') NOT NULL DEFAULT 'NUEVO',
    time TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR (255) NOT NULL,
    payment SET ('EFECTIVO','TARJETA') NOT NULL DEFAULT 'EFECTIVO',
    total DOUBLE NOT NULL,
    FOREIGN KEY (idCustomer) REFERENCES CUSTOMERS(idCustomer)
);

CREATE TABLE ORDERS_PRODUCTS(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idOrder INT,
    idProduct INT,
    amount INT NOT NULL,
    FOREIGN KEY (idOrder) REFERENCES ORDERS (idOrder),
    FOREIGN KEY (idProduct) REFERENCES PRODUCTS (idProduct)
);
INSERT INTO CUSTOMERS (user, fullname, email, phone, shipping_address, password, rol) VALUES ("emma", "Emmanuel Pineda", "emma@gmail.com", "+54 911 24731156", "CABA, Argentina", "1234", "ADMIN");
INSERT INTO CUSTOMERS (user, fullname, email, phone, shipping_address, password) VALUES ("queen", "Freddie Mercury", "freddiemercury@gmail.com", "+44 7712345678", "1 Logan PIKensington, London W8 6DE, UK", "1234");

INSERT INTO PRODUCTS VALUES (NULL, "Bagel de salmón", "pan con agujero en el medio acompañado con salmon ahumado, queso cremoso y tomates cherry", 425, "https://i.pinimg.com/originals/13/41/33/13413344fc4ca16f5e8e1b0051424dc5.jpg");
INSERT INTO PRODUCTS VALUES (NULL, "Hamburguesa clásica", "hamburguesa con carne, tomate,queso cheddar,  lechuga y salsa", 350, "https://i.pinimg.com/originals/2a/98/29/2a9829bc1d609148cabc1f9464b4372d.jpg");
INSERT INTO PRODUCTS VALUES (NULL, "Sandwich veggie", "sandwich de vegetales", 310, "https://i.pinimg.com/564x/2d/b1/3c/2db13cdff40ca5bc8a66aab145968a84.jpg");
INSERT INTO PRODUCTS VALUES (NULL, "Ensalada veggie", "ensalada de vegetales", 340, "https://i.pinimg.com/564x/39/19/3b/39193b6c2fa1786ddadf24936ec7a0b1.jpg");
INSERT INTO PRODUCTS VALUES (NULL, "Focaccia", " pan plano cubierto con hierbas", 300, "https://i.pinimg.com/564x/1d/05/2c/1d052c96ec59598730822cc9a58d9b7a.jpg");
INSERT INTO PRODUCTS VALUES (NULL, "Sandwich Focaccia", "Sandwich Focaccia con albahaca", 440, "https://i.pinimg.com/564x/de/b9/25/deb92530dd76b3434515848bc6df2d43.jpg");