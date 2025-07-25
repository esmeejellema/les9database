--DE TABELLEN

DROP TABLE IF EXISTS Products;

CREATE TABLE Products
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	brand VARCHAR(255) NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
	current_stock INT,
	sold INT,
	date_sold DATE,
	type VARCHAR(100)
);

DROP TABLE IF EXISTS Televisions;

CREATE TABLE Televisions
(
   id INT PRIMARY KEY, 
   height DECIMAL(10, 2),
   width DECIMAL(10, 2),
   screen_quality VARCHAR(100),
   wifi BOOLEAN,
   voice_control BOOLEAN,
   HDR BOOLEAN,
   CONSTRAINT fk_tv_product FOREIGN KEY (id) REFERENCES Products(id)
);

DROP TABLE IF EXISTS RemoteControllers;

CREATE TABLE RemoteControllers
(
   id INT PRIMARY KEY,
   smart BOOLEAN,
   battery_type VARCHAR(100),
   CONSTRAINT fk_remotecontroller_product FOREIGN KEY (id) REFERENCES Products (id)
);

DROP TABLE IF EXISTS CIModule;

CREATE TABLE CIModules
(
   id INT PRIMARY KEY,
   provider VARCHAR(100),
   encoding VARCHAR(100),
   CONSTRAINT fk_cimodule_product FOREIGN KEY (id) REFERENCES Products (id)
);

DROP TABLE IF EXISTS WallBrackets;

CREATE TABLE WallBrackets
(
	id INT PRIMARY KEY,
	adjustable BOOLEAN,
	attachmentmethod VARCHAR(100),
	height DECIMAL(10, 2),
	width DECIMAL(10, 2),
	CONSTRAINT fk_wallbracket_product FOREIGN KEY (id) REFERENCES Products (id)
);

DROP TABLE IF EXISTS Users;

CREATE TABLE Users
(
	id SERIAL PRIMARY KEY,
	username VARCHAR(255),
	password VARCHAR(255),
	address VARCHAR(255),
	role VARCHAR(255),
	pay_scale INT,
	vacation_days INT
);

--RELATIES TUSSEN SUBTABELLEN

--De many-to-many relatie tussen televisions en wallbrackets kan het best in een eigen apart tabel.

DROP IF TABLE EXISTS Television_Wallbracket;

CREATE TABLE Television_WallBracket
(	
	television_id INT NOT NULL,
    wallbracket_id INT NOT NULL,
    PRIMARY KEY (television_id, wallbracket_id),
    FOREIGN KEY (television_id) REFERENCES Products(id),
    FOREIGN KEY (wallbracket_id) REFERENCES Products(id)
);

--De 1 to 1 relatie tussen TV en RemoteController kan eenmalig worden genoteerd in 1 van de twee tabellen omdat er natuurlijk maar 1 van elk aan elkaar gekoppeld kan worden.

ALTER TABLE Televisions
ADD COLUMN remotecontroller_id INT UNIQUE NOT NULL,
ADD CONSTRAINT fk_tv_remote
FOREIGN KEY (remotecontroller_id) REFERENCES RemoteControllers(id);

--De many-to-1 relatie gaat staan bij de many-kant dus in dit geval kan cimodule gekoppeld worden aan meerdere tv's maar tv kan maar aan 1 cimodule gekoppeld worden.

ALTER TABLE Televisions
ADD COLUMN cimodule_id INT,
ADD CONSTRAINT fk_tv_cimodule
FOREIGN KEY (cimodule_id) REFERENCES CIModules(id);

--DATA INVOER

--Products

INSERT INTO Products (Name, Brand, Price, Stock, Sold, Date_Sold, Type) VALUES
('LG OLED 55"', 'LG', 899.99, 10, 3, '2025-06-15', 'television'),
('Samsung QLED 65"', 'Samsung', 1099.00, 7, 2, '2025-07-01', 'television'),
('Sony Bravia 50"', 'Sony', 749.50, 5, 1, '2025-07-10', 'television'),
('Philips Slim Remote', 'Philips', 39.95, 20, 4, '2025-07-05', 'remotecontroller'),
('Samsung Smart Remote', 'Samsung', 49.99, 15, 6, '2025-07-08', 'remotecontroller'),
('Ziggo CAM Module', 'Ziggo', 59.99, 8, 2, '2025-06-25', 'cimodule'),
('Canal+ CAM Module', 'Canal+', 79.99, 6, 1, '2025-07-12', 'cimodule'),
('Vogel''s Wall Bracket M', 'Vogel''s', 39.99, 12, 3, '2025-06-30', 'wallbracket'),
('Hama Fixed Wall Mount', 'Hama', 29.95, 9, 2, '2025-07-09', 'wallbracket');

--Televisions

INSERT INTO Televisions (id, height, width, screen_quality, wifi, voice_control, HDR) VALUES 
(1, 70.0, 122.0, '4K OLED', true, true, true),
(2, 80.0, 144.0, 'QLED 4K', true, false, true),
(3, 65.0, 110.5, 'Full HD', false, false, false);

--RemoteControllers

INSERT INTO RemoteControllers (id, smart, battery type) VALUES 
(4, true, AAA),
(5, false, AA);

--CIModules

INSERT INTO CIModules (id, provider, encoding) VALUES 
(6, Ziggo, Conax), 
(7, canal+, Irdeto);

--WallBrackets

INSERT INTO WallBrackets (id adjustable, attachmentmethod, height, width) VALUES 
(8, true, 'screws', 30, 60)
(9, false, 'click-mount', 35, 70);










