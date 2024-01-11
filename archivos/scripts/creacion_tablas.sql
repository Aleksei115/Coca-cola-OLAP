
CREATE TABLE public.dim_cliente (
    id_cliente character varying NOT NULL,
    nombre_cliente character varying,
    rfc_cliente character varying,
    nivel integer
);



CREATE TABLE public.dim_geografia (
    id_geo character varying NOT NULL,
    nombre_estado character varying,
    nombre_ciudad character varying,
    region character varying,
    pais character varying,
    nivel integer
);


CREATE TABLE public.dim_producto (
    id_producto character varying NOT NULL,
    nombre_producto character varying,
    desc_producto character varying,
    es_gaseoso boolean,
    precio_unitario numeric(8,2),
    mililitros integer,
    precio_venta numeric(8,2),
    nivel integer
);


CREATE TABLE public.dim_tiempo (
    id_tiempo character varying NOT NULL,
    fecha date,
    dia_semana character varying,
    dia integer,
    semana integer,
    mes integer,
    nombre_mes character varying,
    anio integer,
    nivel integer
);


CREATE TABLE public.dim_vendedor (
    id_vendedor character varying NOT NULL,
    nombre_vendedor character varying,
    rfc_vendedor character varying,
    cuota integer,
    nivel integer
);



CREATE TABLE public.ventas (
    id_vendedor character varying NOT NULL,
    id_cliente character varying NOT NULL,
    id_geo character varying NOT NULL,
    id_tiempo character varying NOT NULL,
    id_producto character varying NOT NULL,
    cantidad integer,
    descuento numeric(4,2),
    total numeric(10,2),
    ganancia numeric(10,2)
);


