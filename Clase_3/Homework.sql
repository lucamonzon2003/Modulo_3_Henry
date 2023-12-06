USE adventureworks;

-- 1.

-- query hecha con subconsultas
SELECT 
    YEAR(soh.OrderDate) AS año, 
    sm.Name AS metodo_envio,
    SUM(sod.OrderQty) AS cantidad,
    ROUND(SUM(sod.OrderQty) / t.CantidadTotalAño * 100, 2) AS PorcentajeTotalAño
FROM salesorderheader soh
JOIN shipmethod sm ON (sm.ShipMethodID = soh.ShipMethodID)
JOIN salesorderdetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN (SELECT 
YEAR(soh.OrderDate) año,
SUM(sod.OrderQty) CantidadTotalAño
FROM salesorderheader soh
JOIN salesorderdetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY 1) t 
ON (YEAR(soh.OrderDate) = t.año)
GROUP BY 1, 2, t.CantidadTotalAño
ORDER BY 1;

-- query hecha con funciones ventana
SELECT  año,
		metodo_envio,
        cantidad,
        CONCAT(ROUND(cantidad / SUM(cantidad) OVER (PARTITION BY año) * 100, 2), "%") porcentaje_anual
FROM (
SELECT
	YEAR(soh.OrderDate) AS año, 
    sm.Name AS metodo_envio,
    SUM(sod.OrderQty) AS cantidad
FROM salesorderheader soh
	JOIN shipmethod sm 
		ON (sm.ShipMethodID = soh.ShipMethodID)
	JOIN salesorderdetail sod 
		ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY 1, 2
ORDER BY 1, 2) AS V;

-- 2.

SELECT  nombre,
		categoria,
        CONCAT("$",precio_unit) precio_unit,
        cantidad_vendida,
        CONCAT("$",venta_total) venta_total,
		CONCAT(ROUND(subquery.venta_total / SUM(subquery.venta_total) OVER (PARTITION BY categoria) * 100, 4), "%") porcentaje_categoria
FROM (
SELECT  p.Name nombre,
		pc.Name categoria,
        sod.UnitPrice precio_unit,
        SUM(sod.OrderQty) cantidad_vendida,
		ROUND(SUM(sod.LineTotal), 2) venta_total
FROM salesorderdetail sod
	JOIN product p
		ON (sod.ProductID = p.ProductID)
	JOIN productsubcategory psc
		ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
	JOIN productcategory pc
		ON (psc.ProductCategoryID = pc.ProductCategoryID)
GROUP BY 1, 2, 3) subquery;

-- 3.

SELECT 	pais,
		nombre,
        cantidad_vendida,
        CONCAT(ROUND(cantidad_vendida / SUM(cantidad_vendida) OVER (PARTITION BY pais) * 100, 4), "%") cantidad_pais,
        CONCAT("$", ventas_totales) ventas_totales,
		CONCAT(ROUND(ventas_totales / SUM(ventas_totales) OVER (PARTITION BY pais) * 100, 4), "%") ventas_pais
FROM (
SELECT
		cr.Name pais,
        p.Name nombre,
		SUM(sod.OrderQty) cantidad_vendida,
		ROUND(SUM(sod.LineTotal), 2) ventas_totales
FROM salesorderheader soh 
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	JOIN product p
		ON (sod.ProductID = p.ProductID)
	JOIN address a
		ON (soh.ShipToAddressID = a.AddressID)
	JOIN stateprovince sp
		ON (a.StateProvinceID = sp.StateProvinceID)
	JOIN countryregion cr
		ON (sp.CountryRegionCode = cr.CountryRegionCode)
GROUP BY 1, 2) subquery;

-- 4.

-- intento
SELECT  sod.ProductID ProductID,
		SUM(sod.LineTotal) 
FROM salesorderheader soh 
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
GROUP BY 1;

-- resuelto
SELECT ProductID, AVG(LineTotal) AS Mediana_Producto, Cnt
FROM (
	SELECT	d.ProductID,
			d.LineTotal, 
			COUNT(*) OVER (PARTITION BY d.ProductID) AS Cnt,
			ROW_NUMBER() OVER (PARTITION BY d.ProductID ORDER BY d.LineTotal) AS RowNum
	FROM	salesorderheader h
		JOIN salesorderdetail d ON (h.SalesOrderID = d.SalesOrderID)) v
WHERE 	(FLOOR(Cnt/2) = CEILING(Cnt/2) AND (RowNum = FLOOR(Cnt/2) OR RowNum = FLOOR(Cnt/2) + 1))
	OR
		(FLOOR(Cnt/2) <> CEILING(Cnt/2) AND RowNum = CEILING(Cnt/2))
GROUP BY ProductID;