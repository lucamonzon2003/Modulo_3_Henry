USE `henry_m3`;

-- 1.
SELECT 	MIN(fecha_alta),
		MAX(fecha_alta),
        MIN(fecha_ultima_modificacion),
        MAX(fecha_ultima_modificacion)
FROM clientes;

-- No, la ultima actualicion de la tabla clientes se hizo en el 2015.

SELECT 	MIN(fecha),
		MAX(fecha)
FROM ventas;

-- En la tabla ventas la ultima actualizacion se hizo en el 2020

-- 2.

SELECT 	* FROM ventas WHERE precio = "";
SELECT 	* FROM ventas WHERE cantidad = "";
SELECT 	* FROM proveedores WHERE nombre = "";

-- No estan completos los datos

-- 3.

-- Si
-- La tabla de puntos de venta propios, un Excel frecuentemente utilizado para contactar a cada sucursal, actualizada en 2021.
-- La tabla de empleados, un Excel mantenido por el personal administrativo de RRHH.
-- La tabla de proveedores, un Excel mantenido por un analista de otra dirección que ya no esta en la empresa.
-- La tabla de clientes, alojada en el CRM de la empresa.
-- La tabla de productos, un Excel mantenido por otro analista.
-- Las tablas de ventas, gastos y compras, tres archivos CSV generados a partir del sistema transaccional de la empresa.

-- 4.

-- si, es prudente

-- 5.

-- si, aunque hay algunas que tienen problemas para relacionarlas
-- las tablas de hechos son las de ventas, compras y gastos, el resto son tablas dimensionales
-- si
-- si, en la tabla empleados
-- Datos Cualitativos: Representan categorías o cualidades que describen atributos o características.
-- Datos Cuantitativos: Representan cantidades y se pueden medir numéricamente en una escala.
-- en las cuantitativas se pueden aplicar funciones como: MAX, MIN, SUM, etc. mientras que en las cualitativas
-- a lo mucho se puede usar un COUNT().A

-- 6.

SELECT 	IdEmpleado,
        COUNT(*) cant
FROM empleados
GROUP BY 1
HAVING COUNT(*) > 1
LIMIT 9999;

SELECT 	e.Nombre,
		e.Apellido,
        e.Sucursal,
        e.IdEmpleado,
        COUNT(*)
FROM ventas v
	JOIN sucursales s
		ON v.IdSucursal = s.ID
	JOIN empleados e
		ON v.IdEmpleado = e.IdEmpleado
        AND s.Sucursal = e.Sucursal
GROUP BY 1, 2, 3, 4;

UPDATE ventas
SET IdEmpleado =
    CASE
        WHEN IdSucursal = 1 THEN CONCAT(IdEmpleado, 'CBL')
        WHEN IdSucursal = 2 THEN CONCAT(IdEmpleado, 'P1')
        WHEN IdSucursal = 3 THEN CONCAT(IdEmpleado, 'P2')
        WHEN IdSucursal = 4 THEN CONCAT(IdEmpleado, 'CRN')
        WHEN IdSucursal = 5 THEN CONCAT(IdEmpleado, 'ALM')
        WHEN IdSucursal = 6 THEN CONCAT(IdEmpleado, 'CBLT')
        WHEN IdSucursal = 7 THEN CONCAT(IdEmpleado, 'FLR')
        WHEN IdSucursal = 8 THEN CONCAT(IdEmpleado, 'ALB')
        WHEN IdSucursal = 9 THEN CONCAT(IdEmpleado, 'DPT')
        WHEN IdSucursal = 10 THEN CONCAT(IdEmpleado, 'VLZ')
        WHEN IdSucursal = 11 THEN CONCAT(IdEmpleado, 'VLO')
        WHEN IdSucursal = 12 THEN CONCAT(IdEmpleado, 'SIS')
        WHEN IdSucursal = 13 THEN CONCAT(IdEmpleado, 'CSE')
        WHEN IdSucursal = 14 THEN CONCAT(IdEmpleado, 'MRN')
        WHEN IdSucursal = 15 THEN CONCAT(IdEmpleado, 'CST')
        WHEN IdSucursal = 16 THEN CONCAT(IdEmpleado, 'SJO')
        WHEN IdSucursal = 17 THEN CONCAT(IdEmpleado, 'LNS')
        WHEN IdSucursal = 18 THEN CONCAT(IdEmpleado, 'AVL')
        WHEN IdSucursal = 19 THEN CONCAT(IdEmpleado, 'QLM')
        WHEN IdSucursal = 20 THEN CONCAT(IdEmpleado, 'LPL')
        WHEN IdSucursal = 21 THEN CONCAT(IdEmpleado, 'MDQ1')
        WHEN IdSucursal = 22 THEN CONCAT(IdEmpleado, 'MDQ2')
        WHEN IdSucursal = 23 THEN CONCAT(IdEmpleado, 'RSR1')
        WHEN IdSucursal = 24 THEN CONCAT(IdEmpleado, 'RSR2')
        WHEN IdSucursal = 25 THEN CONCAT(IdEmpleado, 'CRC')
        WHEN IdSucursal = 26 THEN CONCAT(IdEmpleado, 'CRQ')
        WHEN IdSucursal = 27 THEN CONCAT(IdEmpleado, 'CDLR')
        WHEN IdSucursal = 28 THEN CONCAT(IdEmpleado, 'TCM') 
        WHEN IdSucursal = 29 THEN CONCAT(IdEmpleado, 'MDZ1')
        WHEN IdSucursal = 30 THEN CONCAT(IdEmpleado, 'MDZ2')
        WHEN IdSucursal = 31 THEN CONCAT(IdEmpleado, 'BRC')
        ELSE IdEmpleado
    END;

ALTER TABLE empleados
ADD COLUMN IdSucursal INT;

UPDATE empleados e
SET e.IdSucursal = (
    CASE
        WHEN e.Sucursal = 'Cabildo' THEN 1
        WHEN e.Sucursal = 'Palermo 1' THEN 2
        WHEN e.Sucursal = 'Palermo 2' THEN 3
        WHEN e.Sucursal = 'Corrientes' THEN 4
        WHEN e.Sucursal = 'Almagro' THEN 5
        WHEN e.Sucursal = 'Caballito' THEN 6
        WHEN e.Sucursal = 'Flores' THEN 7
        WHEN e.Sucursal = 'Alberdi' THEN 8
        WHEN e.Sucursal = 'Deposito' THEN 9
        WHEN e.Sucursal = 'Velez' THEN 10
        WHEN e.Sucursal = 'Vicente Lopez' THEN 11
        WHEN e.Sucursal = 'San Isidro' THEN 12
        WHEN e.Sucursal = 'Caseros' THEN 13
        WHEN e.Sucursal = 'Moron' THEN 14
        WHEN e.Sucursal = 'Castelar' THEN 15
        WHEN e.Sucursal = 'San Justo' THEN 16
        WHEN e.Sucursal = 'Lanus' THEN 17
        WHEN e.Sucursal = 'Avellaneda' THEN 18
        WHEN e.Sucursal = 'Quilmes' THEN 19
        WHEN e.Sucursal = 'La Plata' THEN 20
        WHEN e.Sucursal = 'MDQ1' THEN 21
        WHEN e.Sucursal = 'MDQ2' THEN 22
        WHEN e.Sucursal = 'Rosario1' THEN 23
        WHEN e.Sucursal = 'Rosario2' THEN 24
        WHEN e.Sucursal = 'CÃ³rdoba Centro' THEN 25
        WHEN e.Sucursal = 'Cordoba Quiroz' THEN 26
        WHEN e.Sucursal = 'Cerro de las Rosas' THEN 27
        WHEN e.Sucursal = 'TucumÃ¡n' THEN 28
        WHEN e.Sucursal = 'Mendoza 1' THEN 29
        WHEN e.Sucursal = 'Mendoza 2' THEN 30
        WHEN e.Sucursal = 'Bariloche' THEN 31
        ELSE NULL -- O asigna un valor predeterminado si no hay coincidencia
    END
);

ALTER TABLE empleados
DROP COLUMN Sucursal;



ALTER TABLE canaldeventa
CHANGE CODIGO IdCanal INT NOT NULL,
CHANGE DESCRIPCION Canal VARCHAR(50) NOT NULL;
-- renombrando columnas en el canal de ventas


ALTER TABLE clientes
 	ADD Latitud DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Y`, 
	ADD Longitud DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Latitud`;
UPDATE clientes SET Y = '0' WHERE Y = '';
UPDATE clientes SET X = '0' WHERE X = '';
UPDATE clientes SET Latitud = REPLACE(Y,',','.');
UPDATE clientes SET Longitud = REPLACE(X,',','.');
ALTER TABLE clientes DROP `Y`;
ALTER TABLE clientes DROP `X`;
ALTER TABLE clientes DROP `col10`;
-- cambiando latitud y longitud de cleintes y borrando col10


ALTER TABLE `empleados` 
ADD `Salario` DECIMAL(10,2) NOT NULL DEFAULT '0' AFTER `Salario2`;
UPDATE `empleados` SET salario2 = REPLACE(salario,',','.');
UPDATE `empleados` SET Salario = Salario2;
ALTER TABLE `empleados` DROP `Salario2`;

ALTER TABLE `productos` 
ADD `Precio` DECIMAL(15,3) NOT NULL DEFAULT '0' AFTER `Precio2`;
UPDATE `productos` SET Precio = REPLACE(Precio2,',','.');
ALTER TABLE `productos` DROP `Precio2`;

ALTER TABLE `sucursales` 	
ADD `Latitud` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Longitud2`, 
ADD `Longitud` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Latitud`;
UPDATE `sucursales` SET Latitud = REPLACE(Latitud2,',','.');
UPDATE `sucursales` SET Longitud = REPLACE(Longitud2,',','.');
ALTER TABLE `sucursales` DROP `Latitud2`;
ALTER TABLE `sucursales` DROP `Longitud2`;

UPDATE `ventas` set `Precio` = 0 WHERE `Precio` = '';
ALTER TABLE `ventas` CHANGE `Precio` `Precio` DECIMAL(15,3) NOT NULL DEFAULT '0';

-- relleno nulos o ""
UPDATE `clientes` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `clientes` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);
UPDATE `clientes` SET Nombre_y_Apellido = 'Sin Dato' WHERE TRIM(Nombre_y_Apellido) = "" OR ISNULL(Nombre_y_Apellido);
UPDATE `clientes` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `empleados` SET Apellido = 'Sin Dato' WHERE TRIM(Apellido) = "" OR ISNULL(Apellido);
UPDATE `empleados` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `empleados` SET IdSucursal = 'Sin Dato' WHERE TRIM(IdSucursal) = "" OR ISNULL(IdSucursal);
UPDATE `empleados` SET Sector = 'Sin Dato' WHERE TRIM(Sector) = "" OR ISNULL(Sector);
UPDATE `empleados` SET Cargo = 'Sin Dato' WHERE TRIM(Cargo) = "" OR ISNULL(Cargo);

ALTER TABLE `productos`
CHANGE `ID_PRODUCTO` `IdProducto` INT(11) NOT NULL,
CHANGE `Concepto` `Producto` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL DEFAULT NULL;
UPDATE `productos` SET Producto = 'Sin Dato' WHERE TRIM(Producto) = "" OR ISNULL(Producto);
UPDATE `productos` SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);

ALTER TABLE `proveedores` CHANGE `IDProveedor` `IdProveedor` INT(11) NOT NULL;
UPDATE `proveedores` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `proveedores` SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = "" OR ISNULL(Direccion);
UPDATE `proveedores` SET Ciudad = 'Sin Dato' WHERE TRIM(Ciudad) = "" OR ISNULL(Ciudad);
UPDATE `proveedores` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `proveedores` SET Pais = 'Sin Dato' WHERE TRIM(Pais) = "" OR ISNULL(Pais);
UPDATE `proveedores` SET Departamento = 'Sin Dato' WHERE TRIM(Departamento) = "" OR ISNULL(Departamento);

UPDATE `sucursales` SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = "" OR ISNULL(Direccion);
UPDATE `sucursales` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `sucursales` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `sucursales` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);

-- normalizacion a letra capital
UPDATE clientes SET  Domicilio = UC_Words(TRIM(Domicilio)),
                    Nombre_y_Apellido = UC_Words(TRIM(Nombre_y_Apellido));
                    
UPDATE sucursales SET Direccion = UC_Words(TRIM(Direccion)),
                    Sucursal = UC_Words(TRIM(Sucursal));
                    
UPDATE proveedores SET Nombre = UC_Words(TRIM(Nombre)),
                    Direccion = UC_Words(TRIM(Direccion));

UPDATE productos SET Producto = UC_Words(TRIM(Producto));

UPDATE tipo_producto SET TipoProducto = UC_Words(TRIM(TipoProducto));
					
UPDATE empleados SET Nombre = UC_Words(TRIM(Nombre)),
                    Apellido = UC_Words(TRIM(Apellido));

-- limpieza y normalizacion

UPDATE ventas v JOIN productos p ON (v.IdProducto = p.IdProducto) 
SET v.Precio = p.Precio
WHERE v.Precio = 0;

DROP TABLE IF EXISTS `aux_ventas`;
CREATE TABLE IF NOT EXISTS `aux_ventas` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

UPDATE ventas SET Cantidad = REPLACE(Cantidad, '\r', '');

ALTER TABLE aux_ventas CHANGE IdEmpleado IdEmpleado VARCHAR(11) NOT NULL;
INSERT INTO aux_ventas (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM ventas WHERE Cantidad = '' or Cantidad is null;

UPDATE ventas SET Cantidad = '1' WHERE Cantidad = '' or Cantidad is null;
ALTER TABLE `ventas` CHANGE `Cantidad` `Cantidad` INTEGER NOT NULL DEFAULT '0';

-- controlamos si hay algun registro repetido o con el mismo id
SELECT IdCliente, COUNT(*) FROM clientes GROUP BY IdCliente HAVING COUNT(*) > 1;
SELECT IdSucursal, COUNT(*) FROM sucursales GROUP BY IdSucursal HAVING COUNT(*) > 1;
SELECT IdEmpleado, COUNT(*) FROM empleados GROUP BY IdEmpleado HAVING COUNT(*) > 1;
SELECT IdProveedor, COUNT(*) FROM proveedores GROUP BY IdProveedor HAVING COUNT(*) > 1;
SELECT IdProducto, COUNT(*) FROM productos GROUP BY IdProducto HAVING COUNT(*) > 1;

-- normalizacion de tabla empleados
DROP TABLE IF EXISTS `cargos`;
CREATE TABLE IF NOT EXISTS `cargos` (
  `IdCargo` integer NOT NULL AUTO_INCREMENT,
  `Cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`IdCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `sectores`;
CREATE TABLE IF NOT EXISTS `sectores` (
  `IdSector` integer NOT NULL AUTO_INCREMENT,
  `Sector` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO cargos (Cargo) SELECT DISTINCT Cargo FROM empleados ORDER BY 1;
INSERT INTO sectores (Sector) SELECT DISTINCT Sector FROM empleados ORDER BY 1;

ALTER TABLE `empleados` 	
ADD `IdSector` INT NOT NULL DEFAULT '0' AFTER `IdSucursal`, 
ADD `IdCargo` INT NOT NULL DEFAULT '0' AFTER `IdSector`;

ALTER TABLE empleados
MODIFY COLUMN Cargo VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
MODIFY COLUMN Sector VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

UPDATE empleados e 
	JOIN cargos c 
		ON (c.Cargo = e.Cargo) 
SET e.IdCargo = c.IdCargo;
UPDATE empleados e
	JOIN sectores s 
		ON (s.Sector = e.Sector) 
SET e.IdSector = s.IdSector;

ALTER TABLE `empleados` DROP `Cargo`;
ALTER TABLE `empleados` DROP `Sector`;

-- normalizacion de tabla producto
ALTER TABLE `productos` ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Precio`;

DROP TABLE IF EXISTS `tipo_producto`;
CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `IdTipoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `TipoProducto` varchar(50) NOT NULL,
  PRIMARY KEY (`IdTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


INSERT INTO tipo_producto (TipoProducto) SELECT DISTINCT Tipo FROM productos ORDER BY 1;

ALTER TABLE productos
MODIFY COLUMN tipo VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

UPDATE productos p 
	JOIN tipo_producto t 
		ON (p.Tipo = t.TipoProducto)
SET p.IdTipoProducto = t.IdTipoProducto;

ALTER TABLE `productos`
  DROP `Tipo`;
  
ALTER TABLE empleados
ADD CONSTRAINT fk_empleados_sector
FOREIGN KEY (IdSector)
REFERENCES sectores(IdSector);

ALTER TABLE empleados
ADD CONSTRAINT fk_empleado_cargos
FOREIGN KEY (IdCargo)
REFERENCES cargos(IdCargo);

ALTER TABLE productos
ADD CONSTRAINT fk_tipo_productos
FOREIGN KEY (IdTipoProducto)
REFERENCES tipo_producto(IdTipoProducto);















ALTER TABLE productos
MODIFY COLUMN Concepto VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
ALTER TABLE ventas
MODIFY COLUMN IdEmpleado VARCHAR(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `clientes` CHANGE `ID` `IdCliente` INT(11) NOT NULL;
ALTER TABLE `empleados` CHANGE `ID_empleado` `IdEmpleado` VARCHAR(11) NULL DEFAULT NULL;
ALTER TABLE `proveedor` CHANGE `IDProveedor` `IdProveedor` INT(11) NULL DEFAULT NULL;
ALTER TABLE `sucursal` CHANGE `ID` `IdSucursal` INT(11) NULL DEFAULT NULL;
ALTER TABLE `tipo_gasto` CHANGE `Descripcion` `Tipo_Gasto` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;
ALTER TABLE `producto` CHANGE `IDProducto` `IdProducto` INT(11) NULL DEFAULT NULL;
ALTER TABLE `producto` CHANGE `Concepto` `Producto` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL DEFAULT NULL;
ALTER TABLE `canaldeventa` CHANGE `CODIGO` `IdCanal` INT(11) NULL DEFAULT NULL;
ALTER TABLE `canaldeventa` CHANGE `DESCRIPCION` `Canal_Venta` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;
ALTER TABLE `producto` CHANGE `IDProducto` `IdProducto` DATE NULL DEFAULT NULL;
ALTER TABLE `ventas` CHANGE `IdEmpleado` `IdEmpleado` VARCHAR(11) NULL DEFAULT NULL;















