/*Elimina si existe la base de datos superheroes*/
DROP DATABASE IF EXISTS superhéroes;

/*Crea la base si no existe una base supereheroes*/
CREATE DATABASE IF NOT EXISTS superhéroes CHARACTER SET utf8mb4;

USE superhéroes;
/*Crear tabla de creador y personajes*/
CREATE TABLE creador (
id_creador INT UNSIGNED AUTO_INCREMENT ,
 nombre VARCHAR(20) NOT NULL,
 PRIMARY KEY(id_creador)
 );

CREATE TABLE personajes(
id_personaje INT UNSIGNED AUTO_INCREMENT, 
nombre_real VARCHAR(20) NOT NULL, 
personaje VARCHAR(20) NOT NULL,
inteligencia INT NOT NULL,
fuerza VARCHAR(20) NOT NULL,
velocidad INT NOT NULL,
poder INT NOT NULL,
aparicion INT NOT NULL,
ocupacion VARCHAR(30) NOT NULL,
id_creador INT UNSIGNED NOT NULL,
PRIMARY KEY (id_personaje),
FOREIGN KEY (id_creador) REFERENCES creador(id_creador)
);
/*Ver tablas de superheroes*/
SHOW TABLES;

/*Ver columnas de las tabla*/
SHOW COLUMNS FROM creador;
SHOW COLUMNS FROM personajes;

/*a)Insertar en las tablas creadas los siguientes datos:*/

/*Insertamos datos a la TABLA DE CREADOR*/
INSERT INTO creador VALUES (1,'Marvel');
INSERT INTO creador VALUES(2, 'DC Comics');

/*Insertamos datos a la TABLA DE PERSONAJES*/
INSERT IGNORE INTO personajes VALUES(1, 'Bruce Banner', 'Hulk', 160, '600mil', 75, 98, 1962, 'Fisico Nuclear', 1),
(2, 'Tony Stark', 'Iron Man', 170, '200mil', 70, 123, 1963, 'Inventor Industrial', 1),
(3, 'Thor Odinson', 'Thor', 145, 'infinita', 100, 235, 1962, 'Rey de Asgard', 1),
(4, 'Wanda Maximoff', 'Bruja Escarlata', 170, '100mil', 90, 345, 1964, 'Bruja', 1),
(5, 'Carol Danvers', 'Capitana Marvel', 157, '250mil', 85, 128, 1968, 'Oficial de inteligencia', 1),
(6, 'Thanos', 'Thanos', 170, 'infinita', 40, 306, 1973, 'Adorador de la muerte', 1),
(7, 'Peter Parker', 'Spiderman', 165, '25mil', 80, 74, 1962, 'Fotógrafo', 1),
(8, 'Steve Rogers', 'Capitan America', 145, '600', 45, 60, 1941, 'Oficial Federal', 1),
(9, 'Bobby Drake', 'Ice Man', 140, '2mil', 64, 122, 1963, 'Contador', 1),
(10, 'Barry Allen', 'Flash', 160, '10mil', 120, 168, 1956, 'Cientifico forense', 2),
(11, 'Bruce Wayne', 'Batman', 170, '500', 32, 47, 1939, 'Hombre de negocios', 2),
(12, 'Clarck Kent', 'Superman', 165, 'infinita', 120, 182, 1948, 'Reportero', 2),
(13, 'Diana Prince', 'Mujer Maravilla', 160, 'infinita', 95, 127, 1949, 'Princesa Guerrera', 2);

/*b) Cambiar en la tabla personajes el año de aparición a 1938 del personaje Superman. A continuación,
realizar un listado de toda la tabla para verificar que el personaje haya sido actualizado.*/
UPDATE personajes SET aparacion = 1938 WHERE id_personaje=12;

/*c) El registro que contiene al personaje Flash. A continuación, mostrar toda la tabla para verificar que
el registro haya sido eliminado.*/
DELETE FROM personajes WHERE id_personaje=10;
SELECT * FROM personajes;

/*d) Eliminar la base de datos superhéroes.*/
DROP DATABASE superhéroes;
