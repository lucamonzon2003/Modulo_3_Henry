USE adventureworks;

-- 1.
-- Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes", 
-- entre los años 2000 y 2003, cuyo método de envío sea "CARGO TRANSPORT 5".

SELECT DISTINCT c.LastName, c.FirstName
FROM salesorderheader soh 
	JOIN contact c
		ON (soh.ContactID = c.ContactID)
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	JOIN product p
		ON (sod.ProductID = p.ProductID)
	JOIN productsubcategory psc
		ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
	JOIN shipmethod sm
		ON 	(soh.ShipMethodID = sm.ShipMethodID)
WHERE YEAR(soh.OrderDate) BETWEEN 2000 AND 2003
	AND psc.Name = "Mountain Bikes"
	AND sm.Name = "CARGO TRANSPORT 5";
    
-- 2.
-- Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes", 
-- entre los años 2000 y 2003 con la cantidad de productos adquiridos y ordenado por este valor, 
-- de forma descendente.

SELECT c.LastName, c.FirstName, SUM(sod.OrderQty) Cantidad
FROM salesorderheader soh 
	JOIN contact c
		ON (soh.ContactID = c.ContactID)
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	JOIN product p
		ON (sod.ProductID = p.ProductID)
	JOIN productsubcategory psc
		ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
WHERE YEAR(soh.OrderDate) BETWEEN 2000 AND 2003
 	AND psc.Name = "Mountain Bikes"
GROUP BY c.LastName, c.FirstName
ORDER BY Cantidad ASC;

-- 3.
-- Obtener un listado de cual fue el volumen de compra (cantidad) por año y método de envío.

SELECT YEAR(soh.OrderDate) Año, sm.Name MetodoEnvio, SUM(sod.OrderQty) Cantidad
FROM salesorderheader soh 
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	JOIN shipmethod sm
		ON 	(soh.ShipMethodID = sm.ShipMethodID)
GROUP BY YEAR(soh.OrderDate), sm.Name
ORDER BY YEAR(soh.OrderDate), sm.Name;

-- 4.
-- Obtener un listado por categoría de productos, con el valor total de ventas y productos vendidos.

SELECT pc.Name Categoria, SUM(sod.LineTotal) ValorEnVentas, SUM(sod.OrderQty) ProductosVendidos
FROM salesorderheader soh 
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	JOIN product p
		ON (sod.ProductID = p.ProductID)
	JOIN productsubcategory psc
		ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
	JOIN productcategory pc
		ON (psc.ProductCategoryID = pc.ProductCategoryID)
GROUP BY pc.Name
ORDER BY pc.Name;

-- En resumen, GROUP BY te permite realizar operaciones agregadas en conjuntos de filas 
-- que comparten valores comunes en una o más columnas, proporcionando así un resumen 
-- de los datos en función de esos grupos.

-- 5.
-- Obtener un listado por país (según la dirección de envío), con el valor total de ventas y productos vendidos, 
-- sólo para aquellos países donde se enviaron más de 15 mil productos.

SELECT cr.Name Pais, SUM(sod.LineTotal) ValorEnVentas, SUM(sod.OrderQty) ProductosVendidos
FROM salesorderheader soh 
	JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	JOIN address a
		ON (soh.ShipToAddressID = a.AddressID)
	JOIN stateprovince sp
		ON (a.StateProvinceID = sp.StateProvinceID)
	JOIN countryregion cr
		ON (sp.CountryRegionCode = cr.CountryRegionCode)
GROUP BY cr.Name
HAVING SUM(sod.OrderQty) > 15000
ORDER BY cr.Name;

-- Es importante destacar que HAVING se utiliza específicamente con columnas resultantes 
-- de funciones de agregación. Si deseas filtrar resultados antes de la agregación, 
-- puedes utilizar la cláusula WHERE.

-- 6.
-- Obtener un listado de las cohortes que no tienen alumnos asignados, 
-- utilizando la base de datos henry, desarrollada en el módulo anterior.

USE henry_homework;

SELECT *
FROM cohorte as c
LEFT JOIN alumno as a ON (c.idCohorte=a.IdCohorte)
WHERE a.IdCohorte is null;

-- otra solucion
SELECT * 
FROM cohorte
WHERE IdCohorte NOT IN (SELECT DISTINCT IdCohorte FROM alumno);