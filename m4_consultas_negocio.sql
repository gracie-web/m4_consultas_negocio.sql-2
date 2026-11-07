USE Ventas_Tech_DB;

GO



/* ============================================

   M4 - PRE-ENTREGA: CONSULTAS SQL DE NEGOCIO

   Proyecto: RetailPro

   Motor: SQL Server

   ============================================ */





/* --------------------------------------------

   CONSULTA 1: RESUMEN EJECUTIVO MENSUAL

   Total facturado, cantidad de pedidos y

   ticket promedio agrupados por mes.

   -------------------------------------------- */



SELECT

    MONTH(fecha_venta) AS Mes,

    SUM(cantidad * precio_unitario) AS Total_Facturado,

    COUNT(*) AS Cantidad_Pedidos,

    AVG(cantidad * precio_unitario) AS Ticket_Promedio

FROM ventas

GROUP BY MONTH(fecha_venta)

ORDER BY Mes;





/* --------------------------------------------

   CONSULTA 2: RANKING DE PRODUCTOS

   Top 5 productos por total facturado.

   -------------------------------------------- */



SELECT TOP 5

    id_producto AS ID_Producto,

    SUM(cantidad) AS Unidades_Vendidas,

    SUM(cantidad * precio_unitario) AS Total_Generado

FROM ventas

GROUP BY id_producto

ORDER BY Total_Generado DESC;





/* --------------------------------------------

   CONSULTA 3: CLIENTES RECURRENTES

   Clientes con más de un pedido.

   -------------------------------------------- */



SELECT

    id_cliente AS ID_Cliente,

    COUNT(*) AS Cantidad_Pedidos,

    SUM(cantidad * precio_unitario) AS Total_Gastado

FROM ventas

GROUP BY id_cliente

HAVING COUNT(*) > 1

ORDER BY Cantidad_Pedidos DESC;





/* --------------------------------------------

   CONSULTA 4: MESES POR ENCIMA O POR DEBAJO

   DEL PROMEDIO MENSUAL GENERAL.

   -------------------------------------------- */

WITH FacturacionPorProducto AS (
SELECT id_producto,
SUM (cantidad * precio_unitario) AS total_producto
FROM ventas
GROUP BY id_producto ),
PromedioGeneral AS (
SELECT AVG (total_producto) AS promedio_total
FROM FacturacionPorProducto )
SELECT f.id_producto,
f.total_producto,
CASE
WHEN f.total_producto > p.promedio_total THEN 'por encima'
ELSE 'por debajo'
END AS rendimiento
FROM FacturacionPorProducto f
CROSS JOIN PromedioGeneral p
ORDER BY f.total_producto DESC;







/* ============================================

   BLOQUE DE CIERRE: HALLAZGOS DEL NEGOCIO

   Completar luego de ejecutar las consultas

   y analizar los resultados reales.

   ============================================ */



-- Hallazgo 1: El mes con mayor facturación fue

-- marzo, con un total de $6444.00.



-- Hallazgo 2: El producto más vendido por

-- facturación fue el ID 1, con un

-- total generado de $3600.00.



-- Hallazgo 3: El cliente con mayor gasto fue

-- el ID 1, con un total de $2640.00.

