-- Ejercicio 1

DELIMITER //
DROP PROCEDURE ObtenerCantidadOrdenesEnFecha;
CREATE PROCEDURE ObtenerCantidadOrdenesEnFecha(IN fecha_parametro DATE)
BEGIN
    DECLARE cantidad_ordenes INT;
    SELECT COUNT(*) INTO cantidad_ordenes 
		FROM salesorderheader
		WHERE DATE(OrderDate) = fecha_parametro;
    SELECT cantidad_ordenes AS 'Cantidad de Ordenes en la Fecha';
END //
DELIMITER ;
	-- Test
CALL ObtenerCantidadOrdenesEnFecha('2001-06-30');

-- Ejeccicio 2

DELIMITER $$
DROP FUNCTION margenBruto;
CREATE FUNCTION margenBruto(precio DECIMAL(15,2), margen DECIMAL(9,2)) RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE margenBruto DECIMAL(15,3);
    SET margenBruto = precio * margen;
    RETURN margenBruto;
END$$
DELIMITER ;

	-- Test
SELECT margenBruto(120,1.2);

-- Ejercicio 3

SELECT 
    Name AS Nombre_Producto,
	ROUND(ListPrice, 2) AS Precio_de_Lista,
	ROUND(StandardCost, 2) AS Costo_Estándar,
	ROUND(margenBruto(StandardCost, 0.20), 2) AS Nuevo_Valor_Con_Margen,
	ROUND(ListPrice - margenBruto(StandardCost, 0.20), 2) AS Diferencia
FROM product
ORDER BY Name ASC;

-- Ejercicio 4

	-- buscar columna en toda la DB
SELECT TABLE_NAME As "Encontrado_en:"
FROM information_schema.COLUMNS
WHERE COLUMN_NAME = 'Freight';

DELIMITER //
DROP PROCEDURE ObtenerTop10porCostoTransporte;
CREATE PROCEDURE ObtenerTop10porCostoTransporte(IN fecha_desde DATE, IN fecha_hasta DATE)
BEGIN
    SELECT
		CustomerID, 
		SUM(Freight) AS CostoTransporteTotal
	FROM salesorderheader
	WHERE OrderDate 
		BETWEEN fecha_desde 
		AND fecha_hasta 
	GROUP BY CustomerID
	ORDER BY CostoTransporteTotal DESC 
		LIMIT 10;
END //
DELIMITER ;

	-- Test
Call ObtenerTop10porCostoTransporte('2001-07-07','2001-08-10');

-- Ejercicio 5

DELIMITER //
DROP PROCEDURE InsertarShipMethod;
CREATE PROCEDURE InsertarShipMethod(
    IN p_Name VARCHAR(50),
    IN p_ShipBase DOUBLE,
    IN p_ShipRate DOUBLE
)
BEGIN
    INSERT INTO shipmethod (Name, ShipBase, ShipRate)
    VALUES (p_Name, p_ShipBase, p_ShipRate);
END //

DELIMITER ;

-- Test
CALL InsertarShipMethod('Envío Express', 5.0, 1.2);