DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

#1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;
#2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre,precio FROM producto;
#3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;
#4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, round(precio) FROM producto;
#5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo_fabricante FROM producto;
#10. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT codigo_fabricante FROM producto GROUP BY codigo_fabricante ;
#11. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
#12. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
#13. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;
#14. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
#15. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
#16. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre FROM producto WHERE precio <= 120;
#17. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN '60' AND '200';
#18. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);
#23. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';
# 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo, p.nombre, p.codigo_fabricante , f.nombre AS NOMBRE_FABRICANTE FROM producto p, fabricante f;
#2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre, p.precio , f.nombre AS NOMBRE_FABRICANTE FROM producto p, fabricante f ORDER BY f.nombre ASC;
#3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f ORDER BY p.precio ASC LIMIT 1;
#4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * FROM producto p, fabricante f WHERE f.nombre LIKE 'Lenovo';
#5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * FROM producto p, fabricante f WHERE f.nombre LIKE 'Crucial' AND p.precio>200;
#6. Devuelve un listado con todos los productos de los fabricantes Asus, HewlettPackard. Utilizando el operador IN.
SELECT * FROM producto p, fabricante f WHERE f.nombre IN ('Asus','HewlettPackard');
#7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.precio>=180 AND f.codigo = p.codigo_fabricante ORDER BY p.precio DESC, p.nombre ASC;
/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que
no tienen productos asociados.*/
SELECT * FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
#2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT * FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo_fabricante IS NULL;
/*Subconsultas (En la cláusula WHERE)
Con operadores básicos de comparación
1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN)*/
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante where nombre = 'lenovo' ) ;
# 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN)
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE producto.codigo_fabricante = ( SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
# 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT producto.nombre FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Lenovo' AND producto.precio = ( SELECT MAX(precio) FROM fabricante INNER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Lenovo');
# 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Asus' AND producto.precio > (SELECT AVG(precio)FROM fabricante INNER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre = 'Asus');
/*Subconsultas con IN y NOT IN
1. Devuelve los nombres de los fabricantes que tienen productos asociados.
(Utilizando IN o NOT IN).*/
SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);
# 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);
/*Subconsultas (En la cláusula HAVING)
1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de
productos que el fabricante Lenovo.*/
SELECT fabricante.nombre, COUNT(producto.codigo) AS 'Mismo numero de fabricante lenovo = 2' FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante GROUP BY fabricante.codigo HAVING COUNT(producto.codigo) >= (
SELECT COUNT(producto.codigo) FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Lenovo');
