--Crear base de datos
CREATE DATABASE db_grupo56DS

--Crear tablas
CREATE TABLE fac_visitasweb (
    id_visitas INTEGER PRIMARY KEY,
    url TEXT,
    hora VARCHAR(5),
    dia INTEGER,
    direccion_ip TEXT,
    duracion_seg REAL
)

CREATE TABLE cat_ip (
    ip TEXT PRIMARY KEY,
    pais TEXT
)

CREATE TABLE cat_url (
    url TEXT PRIMARY KEY,
    categoria TEXT,
    categoria_blog TEXT
)

CREATE TABLE cat_empleados (
    id_empleado INTEGER PRIMARY KEY,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    pais VARCHAR(255),
    email VARCHAR(255),
    salario INTEGER,
    incremento REAL,
    antiguedad DATE,
    departamento VARCHAR(255),
    contrato_permanente BOOLEAN,
    ultimo_ingreso TIMESTAMP 
)

--DROP TABLE cat_empleados

SELECT * FROM fac_visitasweb

--Llenar las tablas con informacion
COPY fac_visitasweb
FROM 'C:\Users\Public\Documents\web_visits.csv'
CSV
HEADER
DELIMITER ','

SELECT * FROM fac_visitasweb

COPY cat_url
FROM 'C:\Users\Public\Documents\cat_url.csv'
CSV
HEADER
DELIMITER ','

COPY cat_ip
FROM 'C:\Users\Public\Documents\cat_ip.csv'
CSV
HEADER
DELIMITER ','

SELECT * FROM cat_ip LIMIT 5 --.head()

--Entendimiento de los datos
SELECT * FROM fac_visitasweb 

SELECT * FROM cat_ip 

SELECT * FROM cat_url 

--Llenar la tabla con información manual
INSERT INTO cat_empleados VALUES
(1, 'Raul', 'Martinez', 'MX', 'raul.martinez@hml.com', 25000, 0.15, DATE '2015/01/01', 'Recursos Humanos', TRUE, TIMESTAMP '2023/03/01 9:00:15'),
(2, 'Ana', 'Sosa', 'MX', 'ana.sosa@hml.com', 35000, 0.10, DATE '2021/11/01', 'Recursos Humanos', TRUE, TIMESTAMP '2023/03/01 9:05:22'),
(3, 'Fernanda', 'Gomez', 'AR', 'fernanda.gomez@hml.com', 28000, 0.12, DATE '2018/10/15', 'Recursos Humanos', TRUE, TIMESTAMP '2023/03/01 8:45:22'),
(4, 'Omar', 'Diaz', 'PE', 'omar.diaz@hml.com', 20000, 0.10, DATE '2022/03/01', 'Recursos Humanos', FALSE, TIMESTAMP '2023/03/01 8:34:15'),
(5, 'Sara', 'Klein', 'CR', 'sara.klein@hml.com', 40000, 0.15, DATE '2021/09/01', 'Recursos Humanos', TRUE, TIMESTAMP '2023/03/01 10:23:58'),
(6, 'Karla', 'Maxwell', 'CO', 'karla.maxwell@hml.com', 38000, 0.12, DATE '2010/09/15', 'Recursos Humanos', TRUE, TIMESTAMP '2023/03/01 8:57:34'),
(7, 'Rodolfo', 'Sanchez', 'MX', 'ana.sosa@hml.com', 45000, 0.10, DATE '2005/11/01', 'Finanzas', TRUE, TIMESTAMP '2023/02/01 9:05:22'),
(8, 'Maria Luisa', 'Dominguez', 'CH', 'ana.sosa@hml.com', 29000, 0.08, DATE '2009/11/01', 'Finanzas', TRUE, TIMESTAMP '2023/02/01 9:02:29'),
(9, 'Carlos', 'Ruiz', 'CO', 'carlos.ruiz@hml.com', 35000, 0.10, DATE '2016/10/15', 'Comercial', TRUE, TIMESTAMP '2023/02/01 11:12:20'),
(10, 'Ana Maria', 'Castro', 'PE', 'ana.castro@hml.com', 60000, 0.20, DATE '2017/11/01', 'Comercial', TRUE, TIMESTAMP '2023/02/22 9:14:22'),
(11, 'Eduardo', 'Martinez', 'AR', 'eduardo.martinez@hml.com', 15000, 0.15, DATE '2023/02/01', 'Comercial', FALSE, TIMESTAMP '2023/02/25 9:05:22'),
(12, 'Veronica', 'Beristain', 'CO', 'veronica.beristain@hml.com', 22000, 0.10, DATE '2024/02/01', 'Comercial', TRUE, TIMESTAMP '2023/02/21 9:05:22'),
(13, 'Tracy', 'Powell', 'MX', 'tracy.powell@hml.com', 30000, 0.10, DATE '2011/11/15', 'Comercial', FALSE, TIMESTAMP '2023/03/01 9:05:22'),
(14, 'Carlos', 'Chavez', 'CH', 'carlos.chavez@hml.com', 35000, 0.12, DATE '2014/11/15', 'Comercial', TRUE, TIMESTAMP '2023/02/24 9:05:22'),
(15, 'Miguel', 'Barbosa', 'AR', 'miguel.barbosa@hml.com', 25000, 0.07, DATE '2018/03/01', 'Comercial', FALSE, TIMESTAMP '2023/02/25 9:05:22')

SELECT * FROM cat_empleados

--Relacionar tablas fac_visitas_web con cat_ip
ALTER TABLE fac_visitasweb
ADD FOREIGN KEY (direccion_ip)
REFERENCES cat_ip (ip)

--Asociar fac_visitasweb con cat_url
ALTER TABLE fac_visitasweb
ADD FOREIGN KEY (url)
REFERENCES cat_url (url)

/* CONSULTAS MEDIANTE SQL */

-- Filtros

--Solo las url que son blogs
SELECT *
FROM cat_url
WHERE categoria = 'Blog'

--Las visitas que se hicieron el dia 10 y que duraron menos de 20 segundos
SELECT *
FROM fac_visitasweb
WHERE dia = 10 AND duracion_seg < 20

--Los nombres y apellidos de los empleados que sean de las areas Comercial o Finanzas
SELECT nombre, apellido
FROM cat_empleados
WHERE departamento = 'Finanzas' OR departamento = 'Comercial'

SELECT nombre, apellido
FROM cat_empleados
WHERE departamento IN ('Finanzas', 'Comercial')

--Calculos

--Cuantas visitas hay en los datos, cuantos usuarios, cuantos minutos de navagacion existieron y cuantos minutos por usuario existieron
SELECT
count(id_visitas) AS qvisitas,
count(distinct direccion_ip) AS qusuarios,
sum(duracion_seg) / 60 AS minutos,
(sum(duracion_seg) / 60) / (count(distinct direccion_ip)) AS min_x_usr
FROM fac_visitasweb

--Muestra el nombre completo de los empleados que pertenecen al área Comercial o de Finanzas. Asegúrate que el nombre completo tenga el nombre y apellido unido.
SELECT 
concat(nombre,' ',apellido) AS nombre_completo
FROM cat_empleados
WHERE 
departamento IN ('Comercial','Finanzas')

--Muestra el nombre completo, usuario de email y los años de antiguedad que tiene cada empleado.
SELECT
concat(nombre,' ',apellido) AS nombre_completo,
split_part(email,'@',1) AS usuario_email,
(CURRENT_DATE - antiguedad) / 365.0 AS tiempo_en_empresa
FROM cat_empleados

--Agrupaciones

--Has un listado de los usuarios web indicando además las visitas que tuvo cada uno y su tiempo total de navegación en minutos.
SELECT
direccion_ip,
count(id_visitas) AS qvisitas,
sum(duracion_seg) / 60 AS duracion_total 
FROM fac_visitasweb
GROUP BY direccion_ip

--Modifica el código anterior para que solamente muestre aquellos usuarios que tuvieron más de 30 visitas pero menos de media hora de tiempo de navegacion.
select
    direccion_ip,
    count(id_visitas) AS qvisitas,
    sum(duracion_seg) / 60 AS duracion_total 
FROM fac_visitasweb
GROUP BY direccion_ip
HAVING 
    count(id_visitas) > 30
AND
    sum(duracion_seg) / 60 < 30;

--Cuenta cuántas urls hay por cada categoría y categoría de blog, y ordena el resultado de mayor a menor.
SELECT
categoria,
categoria_blog,
count(url) AS qurls
FROM cat_url
GROUP BY 
categoria,
categoria_blog
ORDER BY qurls DESC --Ya acepta el alias

--Muestra un top 5 de las urls más visitadas.
SELECT
url,
count(id_visitas) AS qvisitas
FROM fac_visitasweb
GROUP BY url
ORDER BY qvisitas DESC
LIMIT 5

-- Unión de tablas

--Has un listado del top 10 de países que más visitas web han mantenido.
SELECT
pais,
count(id_visitas) AS qvisitas
FROM fac_visitasweb
LEFT JOIN cat_ip
ON fac_visitasweb.direccion_ip = cat_ip.ip
--WHERE
GROUP BY pais
--HAVING
ORDER BY qvisitas DESC
LIMIT 10

--De los dos países de mayor cantidad de visitas encontrados en el ejercicio anterior, muestra el orden descendente de preferencia las categorías de urls.
SELECT
pais,
categoria, 
count(id_visitas) AS qvisitas
FROM fac_visitasweb AS l
LEFT JOIN cat_ip AS r1
ON l.direccion_ip = r1.ip
INNER JOIN cat_url AS r2
ON l.url = r2.url
GROUP BY
pais, categoria
HAVING pais = 'Estados Unidos' 
OR pais = 'Ecuador'
ORDER BY pais, qvisitas DESC

SELECT
categoria, 
count(case when pais = 'Ecuador' then 1 end) AS qvisitas_ec, --En excel a los conteo condicionados (COUNTIFS)
count(case when pais = 'Estados Unidos' then 1 end) AS qvisitas_us
FROM fac_visitasweb AS l
LEFT JOIN cat_ip AS r1
ON l.direccion_ip = r1.ip
INNER JOIN cat_url AS r2
ON l.url = r2.url
GROUP BY categoria
ORDER BY qvisitas_ec DESC

--Muestra una tabla que consolide la información de las tablas fac_visitasweb, cat_ip y cat_url.
SELECT 
*
FROM fac_visitasweb l
LEFT JOIN cat_ip r1 
ON l.direccion_ip = r1.ip
LEFT JOIN (
    SELECT
    url AS direccion_url,
    categoria,
    categoria_blog
    FROM cat_url
) r2
ON l.url = r2.direccion_url

/* CREACION DE VISTAS */


--Crear la vista de informacion consolidada
CREATE VIEW vw_consolidada AS (
    SELECT 
    *
    FROM fac_visitasweb l
    LEFT JOIN cat_ip r1 
    ON l.direccion_ip = r1.ip
    LEFT JOIN (
        SELECT
        url AS direccion_url,
        categoria,
        categoria_blog
        FROM cat_url
    ) r2
    ON l.url = r2.direccion_url
)

SELECT * FROM vw_consolidada

SELECT
categoria, 
count(case when pais = 'Ecuador' then 1 end) AS qvisitas_ec, --En excel a los conteo condicionados (COUNTIFS)
count(case when pais = 'Estados Unidos' then 1 end) AS qvisitas_us
FROM vw_consolidada
GROUP BY categoria
ORDER BY qvisitas_ec DESC

CREATE VIEW vw_empleados
AS (
    SELECT
    CONCAT(nombre,' ',apellido) AS nombre_completo,
    split_part(email,'@',1) AS usuario_email,
    departamento,
    salario,
    contrato_permanente,
    (CURRENT_DATE - antiguedad)/365 AS tiempo_en_empresa
    FROM cat_empleados
)

SELECT * FROM vw_empleados