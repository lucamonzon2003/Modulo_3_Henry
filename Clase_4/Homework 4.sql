DROP DATABASE IF EXISTS Henry_M3;
CREATE DATABASE Henry_M3 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AÑADO LA TABLA CLIENTES Y LOS REGISTROS

CREATE TABLE IF NOT EXISTS clientes (
	ID					INTEGER,
	Provincia			VARCHAR(50),
	Nombre_y_Apellido	VARCHAR(80),
	Domicilio			VARCHAR(150),
	Telefono			VARCHAR(30),
	Edad				VARCHAR(5),
	Localidad			VARCHAR(80),
	X					VARCHAR(30),
	Y					VARCHAR(30),
    Fecha_Alta			DATE NOT NULL,
    Usuario_Alta		VARCHAR(20),
    Fecha_Ultima_Modificacion		DATE NOT NULL,
    Usuario_Ultima_Modificacion		VARCHAR(20),
    Marca_Baja			TINYINT,
	col10				VARCHAR(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Homework 4 Tablas M3\\Clientes.csv'
INTO TABLE clientes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


-- AÑADO LA TABLA VENTAS Y LOS REGISTROS

CREATE TABLE IF NOT EXISTS `ventas` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCanal`				INTEGER, 
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				VARCHAR(30),
  `Cantidad`			VARCHAR(30)
  -- `Precio`			DECIMAL(10,2),
  -- `Cantidad`			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Homework 4 Tablas M3\\Venta.csv' 
INTO TABLE `ventas` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- CAMBIO LA SEPARACION DE DECIMALES DE "," A "."

SET SQL_SAFE_UPDATES = 0;

UPDATE empleados
SET Salario = REPLACE(Salario, ',', '.');

UPDATE productos
SET Precio = REPLACE(Precio, ',', '.');

-- AÑADO CLAVES PRIMARIAS

ALTER TABLE clientes
ADD PRIMARY KEY (ID);

ALTER TABLE productos
ADD PRIMARY KEY (ID_PRODUCTO);

ALTER TABLE sucursales
RENAME COLUMN ï»¿ID TO IdSucursal,
ADD PRIMARY KEY (IdSucursal);

ALTER TABLE empleados
ADD PRIMARY KEY (ID_empleado);

ALTER TABLE canaldeventa
ADD PRIMARY KEY (CODIGO);

ALTER TABLE compra
ADD PRIMARY KEY (IdCompra);

ALTER TABLE gasto
ADD PRIMARY KEY (IdGasto);

ALTER TABLE tiposdegasto
ADD PRIMARY KEY (IdTipoGasto);

ALTER TABLE ventas
ADD PRIMARY KEY (IdVenta);

ALTER TABLE empleados
ADD PRIMARY KEY (IdEmpleado);

-- como no me deja ya que hay varios registros con la misma "ID_empleado" creo una nueva
-- columna que sea un primary key autoincremental

ALTER TABLE empleados
ADD COLUMN ID INT PRIMARY KEY AUTO_INCREMENT;

-- Establezco una primary key y arreglo nombres de columnas

ALTER TABLE proveedores
ADD PRIMARY KEY (IDProveedor),
RENAME COLUMN Address TO Direccion,
RENAME COLUMN City TO Ciudad,
RENAME COLUMN State TO Provincia,
RENAME COLUMN Country TO Pais,
RENAME COLUMN departamen TO Departamento;

-- AÑADO CLAVES FORANEAS

ALTER TABLE ventas
ADD CONSTRAINT fk_canal_ventas
FOREIGN KEY (IdCanal)
REFERENCES canaldeventa(CODIGO);

ALTER TABLE ventas
ADD CONSTRAINT fk_cliente
FOREIGN KEY (IdCliente)
REFERENCES clientes(ID);

ALTER TABLE ventas
ADD CONSTRAINT fk_sucursal
FOREIGN KEY (IdSucursal)
REFERENCES sucursales(IdSucursal);

ALTER TABLE ventas
ADD CONSTRAINT fk_producto
FOREIGN KEY (IdProducto)
REFERENCES productos(ID_PRODUCTO);

ALTER TABLE gasto
ADD CONSTRAINT fk_gasto_sucursal
FOREIGN KEY (IdSucursal)
REFERENCES sucursales(IdSucursal);

ALTER TABLE gasto
ADD CONSTRAINT fk_tipo_de_gasto
FOREIGN KEY (IdTipoGasto)
REFERENCES tiposdegasto(IdTipoGasto);

ALTER TABLE compra
ADD CONSTRAINT fk_compra_producto
FOREIGN KEY (IdProducto)
REFERENCES productos(ID_PRODUCTO);

ALTER TABLE compra
ADD CONSTRAINT fk_proveedor
FOREIGN KEY (IdProveedor)
REFERENCES proveedores(IDProveedor);

ALTER TABLE ventas
ADD CONSTRAINT fk_empleados
FOREIGN KEY (IdEmpleado)
REFERENCES empleados(IdEmpleado);

ALTER TABLE empleados
ADD CONSTRAINT fk_empleado_sucursal
FOREIGN KEY (IdSucursal)
REFERENCES sucursales(IdSucursal);
