CREATE INDEX dim_producto_nombre on dim_producto(nombre_producto);

CREATE INDEX dim_tiempo_fecha on dim_tiempo(fecha);

CREATE INDEX dim_geografia_nombre_estado on dim_geografia(nombre_estado);
CREATE INDEX dim_geografia_nombre_ciudad on dim_geografia(nombre_ciudad);

CREATE INDEX dim_cliente_nombre_clte on dim_cliente(nombre_cliente);