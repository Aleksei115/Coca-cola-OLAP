-- //////////////// Consulta 1 ////////////////////////   
   
  -- Encontrar la ciudad con más ventas
with ciudades_con_mas_ventas as (
	WITH ventas_por_ciudad AS (
	    select
	    	v.id_geo,
	        dg.nombre_ciudad,
	        SUM(v.total) AS total_ventas
	    FROM
	        public.dim_geografia dg
	        JOIN ventas v ON dg.id_geo = v.id_geo
	        join dim_tiempo dt on dt.id_tiempo = v.id_tiempo 
	        join dim_producto dp on dp.id_producto = v.id_producto
	   	where
	   		dg.nivel = 1 and
	   		(anio = 2021 or anio = 2022)
	    GROUP BY v.id_geo,dg.nombre_ciudad
	)
	select 
		vpc.*
	from 
		ventas_por_ciudad vpc
	where 
		vpc.total_ventas = ( 
			select max(total_ventas) from ventas_por_ciudad
		)
)
,refresco_con_mas_ventas as (
	with ventas_por_refresco AS (
		select
			dg.nombre_ciudad,
		    dp.nombre_producto,
		    SUM(v.cantidad) AS unidades_vendidas
		FROM
		    ventas v
		    join public.dim_producto dp ON v.id_producto = dp.id_producto
		    join ciudades_con_mas_ventas ccv on ccv.id_geo = v.id_geo
		    join dim_geografia dg ON dg.id_geo = v.id_geo
			join dim_tiempo dt on dt.id_tiempo = v.id_tiempo
		WHERE
		    dp.es_gaseoso = true and
			(anio = 2021 or anio = 2022) and 
			dg.nivel = 1
		GROUP BY dg.nombre_ciudad,dp.nombre_producto
	)
	select
		dp.id_producto,
		vpr.*
	from 
		ventas_por_refresco vpr
		join dim_producto dp on dp.nombre_producto = vpr.nombre_producto
	where 
		vpr.unidades_vendidas = ( 
			select max(unidades_vendidas) from ventas_por_refresco
		) and
		dp.nivel = 1
	group by(dp.id_producto,vpr.nombre_ciudad,vpr.nombre_producto,vpr.unidades_vendidas)	
)
SELECT
	dv.nombre_vendedor,
	rmv.nombre_ciudad,
	rmv.nombre_producto,
    SUM(v.total) AS venta_total
FROM
    public.ventas v
    JOIN refresco_con_mas_ventas rmv ON rmv.id_producto = v.id_producto
    JOIN dim_vendedor dv ON dv.id_vendedor = v.id_vendedor
    JOIN dim_tiempo dt ON v.id_tiempo = dt.id_tiempo
    join ciudades_con_mas_ventas ccv on ccv.id_geo = v.id_geo
WHERE
    dv.nivel = 1 and
    (anio = 2021 or anio = 2022)
GROUP BY dv.nombre_vendedor,rmv.nombre_ciudad,rmv.nombre_producto
ORDER BY venta_total desc;


--  //////////////////// Consulta 2 /////////////////////

-- que ciudad tiene mas ordenes de compra y que cliente es el que mas compra

with ciudad_con_mas_ordenes as(
	with ordenes_por_ciudad AS (
	    select
	    	dg.id_geo,
	        dg.nombre_ciudad,
	        COUNT(v.*) AS ordenes,
	        RANK() OVER (ORDER BY COUNT(v.*) DESC) AS ranking
	    FROM
	        ventas v
	    	JOIN dim_geografia dg ON dg.id_geo = v.id_geo
	    	join dim_producto dp on dp.id_producto = v.id_producto
	    group by
	    	dg.id_geo,
	        dg.nombre_ciudad
	)
	select
		opc.*
	from 
		ordenes_por_ciudad opc
	where 
		opc.ordenes = ( 
			select max(ordenes) from ordenes_por_ciudad
		)
)
select
	dc.nombre_cliente,
	cco.nombre_ciudad,
	sum(v.cantidad) as unidades_compradas
FROM
    ventas v
    join ciudad_con_mas_ordenes cco on cco.id_geo = v.id_geo
	JOIN dim_geografia dg ON dg.id_geo = v.id_geo
	join dim_producto dp on dp.id_producto = v.id_producto
	join dim_cliente dc on dc.id_cliente = v.id_cliente
where 
	dp.es_gaseoso = true
group by
	dc.nombre_cliente,cco.nombre_ciudad
order by 
	unidades_compradas desc;


--  //////////////////// Consulta 3 /////////////////////

-- Se desea saber en que mes del año se vende mas refresco y en particupar que día del año se vende más refresco
with mes_con_mas_ventas as (
	with ventas_por_mes as (
		SELECT  
			dt.nombre_mes,
			avg(v.cantidad) as promedio
		from
			ventas v
			JOIN dim_tiempo dt ON dt.id_tiempo = v.id_tiempo
			join dim_producto dp on dp.id_producto = v.id_producto
		WHERE 
			dp.es_gaseoso = true and
			dt.nivel = 1
		GROUP BY 
			dt.nombre_mes
		ORDER BY 
			promedio desc 
	)
	select
		dt.id_tiempo,
		vpm.*
	from 
		ventas_por_mes vpm
		join dim_tiempo dt on dt.nombre_mes = vpm.nombre_mes
	where 
		vpm.promedio = ( 
			select max(promedio) from ventas_por_mes
		) and
		dt.nivel = 1
)
select 
	dt.dia,
	sum(v.cantidad) as total 
from 
	ventas v
	join mes_con_mas_ventas mmv on mmv.id_tiempo = v.id_tiempo 
	join dim_tiempo dt on dt.id_tiempo = v.id_tiempo
	join dim_producto dp on dp.id_producto = v.id_producto
where 
	dp.es_gaseoso = true and
	dt.nivel = 1
group by 
	dt.dia
order by
	total desc;

--  //////////////////// Consulta 4 /////////////////////


-- Para evitar producir refrescos que no generan ganancias, 
-- desea saber que refresco es el que menos se ha vendido en los ultimos dos años
-- Como nos pide en los últimos dos años, también es el promedio
SELECT AVG(q3.suma_actual), q3.nombre_producto
FROM  (
    SELECT SUM(v.total) as suma_actual, p.nombre_producto
            FROM ventas v
            JOIN dim_tiempo t ON t.id_tiempo = v.id_tiempo
            JOIN dim_producto p ON p.id_producto = v.id_producto
            WHERE t.anio >= (EXTRACT(YEAR FROM CURRENT_DATE) - 2)
            AND p.es_gaseoso = TRUE
            GROUP BY p.nombre_producto
)q3
GROUP BY q3.nombre_producto
HAVING AVG(q3.suma_actual) = (
    SELECT MIN(q1.promedio_total)
    FROM (
        SELECT AVG(q2.suma_total) as promedio_total
        FROM (
            SELECT SUM(v.total) as suma_total, p.nombre_producto
            FROM ventas v
            JOIN dim_tiempo t ON t.id_tiempo = v.id_tiempo
            JOIN dim_producto p ON p.id_producto = v.id_producto
            WHERE t.anio >= (EXTRACT(YEAR FROM CURRENT_DATE) - 2)
            AND p.es_gaseoso = TRUE
            GROUP BY p.nombre_producto
        )q2
        GROUP BY q2.nombre_producto
    )q1
);


select count(*) from dim_producto p where p.nivel=1; 


