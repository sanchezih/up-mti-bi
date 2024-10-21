--  1. Productos más vendidos  --
SELECT 
    pb.nombre AS producto,
    SUM(ifac.cantidad) AS total_vendido,
    SUM(ifac.cantidad * ifac.precio_unitario) AS total_ingresos
FROM 
    producto_base pb
INNER JOIN 
    item_factura ifac ON pb.id_producto = ifac.id_producto_base
GROUP BY 
    pb.nombre
ORDER BY 
    total_vendido DESC;


--  2. Cantidad de eventos con más entradas vendidas --
SELECT 
    e.descripcion AS evento,
    COUNT(te.id_ticket_evento) AS entradas_vendidas
FROM 
    evento e
INNER JOIN 
    ticket_evento te ON e.id_evento = te.id_evento
GROUP BY 
    e.descripcion
ORDER BY 
    entradas_vendidas DESC;

-- 3. Clientes con más compras (cantidad de facturas) --
SELECT 
    c.nombre,
    c.apellido,
    COUNT(f.id_factura) AS total_compras
FROM 
    cliente c
LEFT JOIN 
    factura f ON c.id_cliente = f.id_cliente
GROUP BY 
    c.nombre, c.apellido
ORDER BY 
    total_compras DESC;
    
-- 4. Ingresos totales por cliente --
SELECT 
    c.nombre,
    c.apellido,
    SUM(f.total) AS total_gastado
FROM 
    cliente c
INNER JOIN 
    factura f ON c.id_cliente = f.id_cliente
GROUP BY 
    c.nombre, c.apellido
ORDER BY 
    total_gastado DESC;

-- 5. Total de entradas vendidas por sector --
SELECT 
    l.id_localidad AS localidad,
    l.sector_localidad AS sector,
    COUNT(te.id_ticket_evento) AS entradas_vendidas
FROM 
    localidad l
INNER JOIN 
    ticket_evento te ON l.id_localidad = te.id_localidad
GROUP BY 
    l.sector_localidad, l.id_localidad
ORDER BY 
    entradas_vendidas DESC;

-- 6. Eventos con mayor recaudación --
SELECT 
    e.descripcion AS evento,
    SUM(IFNULL(ifac.cantidad, 0) * ifac.precio_unitario) AS total_recaudado
FROM 
    evento e
INNER JOIN 
    ticket_evento te ON e.id_evento = te.id_evento
INNER JOIN 
    factura f ON te.id_ticket_evento = f.id_factura
LEFT JOIN 
    item_factura ifac ON f.id_factura = ifac.id_factura
GROUP BY 
    e.descripcion
ORDER BY 
    total_recaudado DESC;
