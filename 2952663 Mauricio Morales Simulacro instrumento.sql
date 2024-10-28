create database Bases_de_Datos_Relacionales;
use Bases_de_Datos_Relacionales;
show tables;
describe Carros;
select * from Carros;

/*Instrumento de evaluación de Bases de Datos Relacionales con MySQL
Instrucciones:
A continuación, se le proporcionará un esquema de ventas de carros en Euros y un conjunto de datos insertados en dichas tablas.
Realizar las HH consultas solicitadas utilizando las funciones específicas de MySQL estudiadas.
Para cada consulta, escriba el código SQL correspondiente y explique brevemente qué hace la consulta y qué resultado se espera obtener.
Todas las respuestas deben ser escritas claramente, y los resultados deben estar bien justificados.*/

-- Tabla de Fabricantes.
CREATE TABLE Fabricantes (
    FabricanteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Pais VARCHAR(50),
    AnioFundacion INT
);

-- Tabla de Carros
CREATE TABLE Carros (
    CarroID INT PRIMARY KEY,
    Modelo VARCHAR(100),
    FabricanteID INT,
    Categoria VARCHAR(50),
    Precio DECIMAL(10, 2) COMMENT 'Valor en Euros',
    AnioModelo INT,
    FOREIGN KEY (FabricanteID) REFERENCES Fabricantes(FabricanteID)
);

-- Tabla de Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY,
    CarroID INT,
    FechaVenta DATE,
    PrecioVenta DECIMAL(10, 2) COMMENT 'Valor en Euros',
    FOREIGN KEY (CarroID) REFERENCES Carros(CarroID)
);

-- Insertar datos de fabricantes
INSERT INTO Fabricantes VALUES
(1, 'Toyota', 'Japón', 1937),
(2, 'Volkswagen', 'Alemania', 1937),
(3, 'Ford   ', 'Estados Unidos', 1903),
(4, '   Honda  ', 'Japón', 1948),
(5, 'Chevrolet', 'Estados Unidos', 1911);

INSERT INTO Carros VALUES
(1, 'Corolla', 1, 'Sedán', 20000.00, 2023),
(2, '  Golf ', 2, 'Hatchback', 25000.23, 2023),
(3, 'Mustang', 3, 'Deportivo', 35000.00, 2023),
(4, ' Civic', 4, 'Sedán', 22000.46, 2023),
(5, 'Camaro', 5, 'Deportivo', 33000.00, 2023),
(6, '      RAV4 ', 1, 'SUV', 28000.26, 2023),
(7, 'Tiguan', 2, 'SUV', 29000.00, 2023),
(8, 'F-150', 3, 'Camioneta', 40000.50, 2023),
(9, 'CR-V', 4, 'SUV', 27000.60, 2023),
(10, 'Silverado', 5, 'Camioneta', 38000.10, 2023);

INSERT INTO Ventas VALUES
(1, 1, '2023-01-15', 19500.50),
(2, 2, '2023-02-20', 24000.70),
(3, 3, '2023-03-10', 34000.90),
(4, 4, '2023-04-05', 21500.50),
(5, 5, '2023-05-12', 32000.30),
(6, 6, '2023-06-18', 27500.25),
(7, 7, '2023-07-22', 28500.40),
(8, 8, '2023-08-30', 39000.00),
(9, 9, '2023-09-14', 26500.25),
(10, 10, '2023-10-25', 37000.89),
(11, 1, '2023-11-05', 19800.00),
(12, 2, '2023-12-12', 24500.12),
(13, 3, '2024-01-03', 34500.00),
(14, 4, '2024-02-09', 21800.23),
(15, 5, '2024-03-17', 32500.00);

-- 1. Obtener los carros más vendidos (top 3) junto con el nombre de su fabricante.
-- Se seleccionan las columnas: modelo del carro, nombre del fabricante y el número de ventas por cada carro.
SELECT c.Modelo AS ModeloCarro,
	   f.Nombre AS NombreFabricante, 
       COUNT(v.VentaID) AS TotalVentas
-- se seleccionan de la tabla Carros.
FROM Carros c 
-- Se realizan dos uniones:
-- 1. se une Carros con Ventas para sacar las ventas por cada carro.
INNER JOIN Ventas v ON c.CarroID = v.CarroID 
-- 2. se une Carros con Fabricantes para sacar el nombre del fabricante de cada carro.
INNER JOIN Fabricantes f ON c.FabricanteID = f.FabricanteID
-- Se agrupan los resultados por carro (c.CarroID, c.Modelo) y por el fabricante (f.Nombre).
GROUP BY c.CarroID, c.Modelo, f.Nombre
-- Se ordenan los resultados de la columna TotalVentas en orden descendente.
ORDER BY TotalVentas DESC
-- Se limita el resultado a 3.
LIMIT 3;

-- 2. Se obtienen las ventas de cada carro y los agrupa por modelo. Se une con las tablas de Ventas y Fabricantes para obtener el nombre del fabricante. Se ordena el resultado por el número de ventas en orden descendente y se limita a los tres más vendidos.
-- Se seleccionan las columnas: modelo del carro, nombre del fabricante y el número de ventas por cada carro.
SELECT c.Modelo AS ModeloCarro,
	   f.Nombre AS NombreFabricante,
	   COUNT(v.VentaID) AS TotalVentas
-- se seleccionan de la tabla Carros.
FROM Carros c
-- Se realizan dos uniones:
-- 1. se une Carros con Ventas para sacar las ventas por cada carro.
INNER JOIN Ventas v ON c.CarroID = v.CarroID
-- 2. se une Carros con Fabricantes para sacar el nombre del fabricante de cada carro.
INNER JOIN Fabricantes f ON c.FabricanteID = f.FabricanteID
-- Se agrupan los resultados por carro (c.CarroID, c.Modelo) y por el fabricante (f.Nombre).
GROUP BY c.CarroID, c.Modelo, f.Nombre
-- Se ordenan los resultados de la columna TotalVentas en orden descendente.
ORDER BY TotalVentas DESC
-- Se limita el resultado a 3.
LIMIT 3;

-- 3. Calcular el promedio de precio de los carros por categoría.
-- Se seleccionan las columnas: Categoria y Precio Promedio.
SELECT Categoria, AVG(Precio) AS PrecioPromedio
-- se seleccionan de la tabla Carros.
FROM Carros
-- Se agrupan los resultados por Categoria.
GROUP BY Categoria
-- Se ordenan los resultados de la columna PrecioPromedio en orden descendente.
ORDER BY PrecioPromedio DESC;

-- 4. Encontrar / listar los fabricantes que tienen más de un modelo de carro en la base de datos.
-- Se seleccionan las columnas: Categoria y Precio Promedio.
SELECT f.FabricanteID,
	   f.Nombre AS FabricanteNombre,
       COUNT(c.CarroID) AS NumeroModelos
-- se seleccionan de la tabla Fabricantes.
FROM Fabricantes f
-- se une Fabricante con Carros para contar los modelos asociados a cada fabricante.
INNER JOIN Carros c ON f.FabricanteID = c.FabricanteID
-- Se agrupan los resultados por el identificador y nombre del fabricante.
GROUP BY f.FabricanteID, f.Nombre
-- Se filtran los grupos para mostrar los fabricantes que tienen más de un modelo de carro.
HAVING COUNT(c.CarroID) > 1;

-- 5. Calcular el porcentaje de ventas de cada carro respecto al total.
-- Se hace una expresión de tabla común (CTE) para calcular el total de ventas por cada carro.
WITH VentasPorCarro AS (
	-- Se seleccionan las columnas: identificador del carro, modelo del carro y la suma de ventas por cada carro.
    SELECT c.CarroID,
           c.Modelo,
           SUM(v.PrecioVenta) AS TotalVentasPorCarro
	-- se seleccionan de la tabla Carros.
    FROM Carros c
    -- Se une la tabla Carros con Ventas para obtener los datos de ventas.
    INNER JOIN Ventas v ON c.CarroID = v.CarroID
    -- Se agrupan los resultados por identificador del carro y Modelo del carro.
    GROUP BY c.CarroID, c.Modelo
),
-- Se hace otra CTE para calcular el total general de ventas.
TotalVentas AS (
	-- Se selecciona la suma de los valores de la columna TotalVentasPorCarro y se guarda como TotalGeneralVentas.
    SELECT SUM(TotalVentasPorCarro) AS TotalGeneralVentas
    -- se seleccionan de la tabla VentasPorCarro.
    FROM VentasPorCarro
)
-- Se seleccionan las columnas: identificador del carro, modelo del carro, el total de ventas por carro y se crea y guarda el porcentaje de ventas.
SELECT v.CarroID,
       v.Modelo,
       v.TotalVentasPorCarro,
       (v.TotalVentasPorCarro / t.TotalGeneralVentas) * 100 AS PorcentajeVentas
-- se seleccionan de las CTE VentasPorCarro y TotalVentas.
FROM VentasPorCarro v,
     TotalVentas t
-- Se ordenan los resultados de la columna PorcentajeVentas en orden descendente.
ORDER BY PorcentajeVentas DESC;

-- 6. Encontrar los carros del mismo año modelo que el Corolla.
-- Se seleccionan las columnas: identificador del carro, modelo del carro, categoria del carro, precio del carro y año del modelo del carro.
SELECT c.CarroID,
       c.Modelo,
       c.Categoria,
       c.Precio,
       c.AnioModelo
-- se seleccionan de la tabla Carros.
FROM Carros c
-- Se filtra la seleccion con una subconsulta con el año modelo del Corolla.
WHERE c.AnioModelo = (SELECT AnioModelo FROM Carros WHERE Modelo = 'Corolla');

-- 7. Clasificar los carros según el precio de venta: <10000 Barato, <20000 Familiar, mas de 20000 es Alta Gama.
-- Se seleccionan las columnas: identificador del carro, modelo del carro y precio del carro.
SELECT c.CarroID,
       c.Modelo,
       c.Precio,
-- Utilizamos el CASE para clasificar los carros según su precio y se guarda como CategoriaPrecio.
CASE 
	WHEN c.Precio < 10000 THEN 'Barato'
	WHEN c.Precio < 20000 THEN 'Familiar'
	ELSE 'Alta Gama'
    -- WHEN c.Precio > 19999 THEN 'Alta Gama' ELSE 'ERROR en la clasificacion por precio'
END AS CategoriaPrecio
-- se seleccionan de la tabla Carros.
FROM Carros c;

-- 8. Verificar si un carro fue vendido con descuento.
-- Se seleccionan las columnas: identificador del carro, modelo del carro, precio del carro y el precio de venta de Ventas.
SELECT 
    c.CarroID,
    c.Modelo,
    c.Precio AS PrecioOriginal,
    v.PrecioVenta,
-- Utilizamos el CASE para determinar si hubo descuento.
CASE 
	WHEN v.PrecioVenta < c.Precio THEN 'Con Descuento'
	ELSE 'Sin Descuento'
END AS EstadoDescuento
-- se seleccionan de la tabla Carros.
FROM Carros c
-- Se une la tabla de Carros con la tabla de Ventas para ver los precios de venta correspondientes a cada carro.
INNER JOIN Ventas v ON c.CarroID = v.CarroID;

-- 9. Comparar el precio de venta con el precio original para determinar si hubo un descuento.
-- Se seleccionan las columnas: identificador del carro, modelo del carro, precio del carro y el precio de venta de Ventas.
SELECT c.CarroID,
       c.Modelo,
       c.Precio AS PrecioOriginal,
       v.PrecioVenta,
-- Se utiliza el CASE para determinar si hubo descuento.
CASE 
	WHEN v.PrecioVenta < c.Precio THEN 'Con Descuento'
	ELSE 'Sin Descuento'
END AS EstadoDescuento,
-- Se utiliza el CASE para determinar de cuanto fue el descuento.
CASE 
	WHEN v.PrecioVenta < c.Precio THEN c.Precio - v.PrecioVenta
	ELSE 0
END AS MontoDescuento
-- se seleccionan de la tabla Carros.
FROM Carros c
-- Se une la tabla de Carros con la tabla de Ventas.
INNER JOIN Ventas v ON c.CarroID = v.CarroID;

-- 10. Clasifique los carros por si su fabricante es de Japón, Estados Unidos o Europa.
-- Se seleccionan las columnas: identificador del carro, modelo del carro, precio del carro, nombre del fabricante y pais del fabricante.
SELECT c.CarroID,
       c.Modelo,
       c.Precio,
       f.Nombre AS NombreFabricante,
       f.Pais,
-- Se utiliza el CASE para determinar de donde es el fabricante del carro.
CASE 
	WHEN f.Pais = 'Japón' THEN 'Japón'
	WHEN f.Pais = 'Estados Unidos' THEN 'Estados Unidos'
	WHEN f.Pais IN ('Alemania', 'Francia', 'Italia', 'Reino Unido') THEN 'Europa'
	ELSE 'Otros'
END AS PaisFabricanteCarro
-- se seleccionan de la tabla Carros.
FROM Carros c
INNER JOIN Fabricantes f ON c.FabricanteID = f.FabricanteID;

-- 11. Clasificar a los fabricantes con más de 2 ventas como "Alta Demanda".
-- Se seleccionan las columnas: identificador del fabricante, nombre del fabricante y el numero de ventas para cada fabricante.
SELECT f.FabricanteID,
       f.Nombre AS NombreFabricante,
       COUNT(v.VentaID) AS NumeroVentas,
-- Se utiliza el CASE para determinar los fabricantes con mas de 2 ventas y guardarlos como alta demanda.
CASE 
	WHEN COUNT(v.VentaID) > 2 THEN 'Alta Demanda'
	ELSE 'Baja Demanda'
END AS ClasificacionDemanda
-- se seleccionan de la tabla Fabricantes.
FROM Fabricantes f
-- Se realizan dos uniones:
-- 1. se une Carros con Fabricantes para contar las ventas.
LEFT JOIN Carros c ON f.FabricanteID = c.FabricanteID
-- 2. se une Ventas con Carros.
LEFT JOIN Ventas v ON c.CarroID = v.CarroID
-- Se agrupan los resultados por el identificador y nombre del fabricante.
GROUP BY f.FabricanteID, f.Nombre;

-- 12. Usar `RAND` para obtener un carro aleatorio.
-- Se seleccionan las columnas: identificador del carro y modelo del carro.
SELECT c.CarroID,
       c.Modelo
-- se seleccionan de la tabla Carros.
FROM Carros c
-- se une Fabricantes con Carros.
INNER JOIN Fabricantes f ON c.FabricanteID = f.FabricanteID
-- Se usa `RAND` para obtener un carro aleatorio.
ORDER BY RAND()
-- Se limita a un resultado
LIMIT 1;

-- 13. Obtener el nombre del fabricante y la longitud del nombre del fabricante.
-- Se seleccionan las columnas: nombre del fabricante y la longitud nombre del fabricante se guarda como LongitudNombreFabricante
SELECT Nombre, 
	   LENGTH(Nombre) AS LongitudNombreFabricante
-- se seleccionan de la tabla Fabricantes.
FROM Fabricantes;

-- 14. Concatene el modelo completo con el año del carro separado por -.
-- Se seleccionan las columnas: identificador del carro y año del carro.
SELECT CarroID,
	   AnioModelo,
	   CONCAT(Modelo, ('-'), AnioModelo)
-- se seleccionan de la tabla Carros.
FROM Carros;

-- 15. Utilice `CONCAT_WS` para concatenar el nombre del fabricante con el país.
-- Se seleccionan las columnas: nombre del Facricante, pais del Facricante y la CONCAT_WS del nombre y el pais del Facricante se guarda como FabricanteYPais.
SELECT Nombre,
       Pais,
	   CONCAT_WS(',', Nombre, Pais) AS FabricanteYPais
-- se seleccionan de la tabla Fabricantes.
FROM Fabricantes;

-- 16. Obtenga los primeros 3 caracteres del nombre del carro.
-- Se seleccionan las columnas: modelo del carro y se sacan los primeros 3 caracteres del modelo del carro.
SELECT Modelo,
	   LEFT(Modelo, 3)
-- se seleccionan de la tabla Carros.
FROM Carros;

-- 17. Encontrar la posición de la letra 'o' en el nombre del fabricante.
-- Se seleccionan las columnas: nombre del fabricante y la posición de la letra 'o' en el nombre se guarda como PosicioNombreLetrao.
SELECT Nombre,
	   LOCATE('o', Nombre) AS PosicioNombreLetrao
-- se seleccionan de la tabla Fabricantes.
FROM Fabricantes;

-- 18. Reemplazar en la consulta 'Sedán' con 'Coupé' en la categoría de carros (REPLACE).
-- Se seleccionan las columnas: modelo del carro y se reemplaza 'Sedán' con 'Coupé' con un REPLACE y se guarda como CategoriaModificada.
SELECT Modelo,
       Categoria,
       REPLACE(Categoria, 'Sedán', 'Coupé') AS CategoriaModificada
-- se seleccionan de la tabla Carros.
FROM Carros;

-- 19. Eliminar los espacios en blanco a la derecha del nombre del modelo.
-- Se seleccionan las columnas: modelo del carro y se eliminan los espacios en blanco de la derecha del nombre.
SELECT Modelo,
	   RTRIM(Modelo)
-- se seleccionan de la tabla Carros.
FROM Carros;

-- 20. Añadir 30 días a la fecha de venta.
-- Se seleccionan las columnas: Fecha de venta, se agregan 30 dias a la fecha de venta y se guarda como NuevaFechaVenta.
SELECT FechaVenta,
	   DATE_ADD(FechaVenta, INTERVAL 30 DAY) AS NuevaFechaVenta
-- se seleccionan de la tabla Ventas.
FROM Ventas;

-- 21. Listar los carros vendidos hasta la fecha actual NO escribir la fecha manualmente.
-- Se seleccionan las columnas: identificador de venta, identificador del carro, modelo del carro, fecha de venta y precio de venta.
SELECT v.VentaID,
       c.CarroID,
       c.Modelo,
       v.FechaVenta,
       v.PrecioVenta
-- se seleccionan de la tabla Ventas.
FROM Ventas v
-- Se une la tabla Ventas con la de Carros.
INNER JOIN Carros c ON v.CarroID = c.CarroID
-- Se filtran las ventas cuya fecha de venta es menor o igual a la fecha actual.
WHERE v.FechaVenta <= CURDATE();

-- 22. Mostrar la fecha de venta en formato 'día/mes/año'.
-- Se seleccionan las columnas: identificador de venta, identificador del carro, modelo del carro, se modifica el formato fecha de venta a 'día/mes/año' y se guarda como FechaVentaFormateada.
SELECT v.VentaID,
       c.CarroID,
       c.Modelo,
       DATE_FORMAT(v.FechaVenta, '%d/%m/%Y') AS FechaVentaFormateada
-- se seleccionan de la tabla Ventas.
FROM Ventas v
-- Se une la tabla Ventas con la de Carros.
INNER JOIN Carros c ON v.CarroID = c.CarroID;

-- 23. Obtener el numero del mes de la fecha de venta.
-- Se seleccionan las columnas: fecha de venta y el numero del mes de la fecha de venta se guarda como NumeroMes.
SELECT FechaVenta,
	   MONTH(FechaVenta) AS NumeroMes
-- se seleccionan de la tabla Ventas.
FROM Ventas;

-- 24. Obtener el nombre del mes de la fecha de venta.
-- Se seleccionan las columnas: fecha de venta y el nombre del mes de la fecha de venta se guarda como NombreMes.
SELECT FechaVenta,
	   MONTHNAME(FechaVenta) AS NombreMes
-- se seleccionan de la tabla Ventas.
FROM Ventas;

-- 25. Use el algoritmo MD5 para cifrar el nombre de los fabricantes.
-- Se seleccionan las columnas: nombre del fabricante, se le coloca cifrado al nombre del fabricante con MD5 y se guarda como NombreCifrado.
SELECT Nombre,
	   MD5(Nombre) AS NombreCifrado
-- se seleccionan de la tabla Fabricantes.
FROM Fabricantes;

-- 26.  En la tabla carros encripte el precio usando como contraseña el CarroID.
-- Se actualiza la tabla Carros
UPDATE Carros
-- Se utiliza AES_ENCRYPT() para encriptar el Precio usando CarroID como contraseña.
SET Precio = AES_ENCRYPT(Precio, CarroID);

-- Se seleccionan las columnas: identificador del carro, modelo del carro, se usa AES_DECRYPT() para desencriptar el precio y se guarda como PrecioDesencriptado.
SELECT CarroID,
       Modelo,
       AES_DECRYPT(Precio, CarroID) AS PrecioDesencriptado
-- se seleccionan de la tabla Carros.
FROM Carros;