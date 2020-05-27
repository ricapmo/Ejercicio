-- 1. Averiguar cuántos premios ha obtenido cada jugador junto a su ID y su nombre.
SELECT PR.id_jugador, JU.nombre, COUNT(*)
FROM PREMIO PR, JUGADOR JU
WHERE PR.id_jugador = JU.id_jugador
GROUP BY PR.id_jugador, JU.nombre
ORDER BY JU.nombre;
	
-- 2. Averiguar el precio medio de las copias vendidas que sean edición normal. Sacar solo 2 decimales.
SELECT CAST(AVG(precio) AS DECIMAL(4,2)) AS PRECIO_MEDIO
FROM VENDER
WHERE id_copia LIKE '%N';
	
--3. Lista de jugadores que más veces han participado en torneos.
SELECT JU.nombre, COUNT(*) AS PARTICIPACIONES
FROM JUGADOR JU, PARTICIPAR PA
WHERE JU.id_jugador = PA.id_jugador
GROUP BY JU.nombre
HAVING COUNT(*) = ( 
	SELECT MAX(PARTICIPACIONES) 
	FROM (SELECT PARTICIPAR.id_jugador, COUNT(*) AS PARTICIPACIONES 
		FROM PARTICIPAR 
		GROUP BY PARTICIPAR.id_jugador) AS MAX_PART
);
	
--4. Lista de jugadores que han ganado premios con valor por encima de la media y sus valores.
SELECT PR.valor, JU.nombre
FROM PREMIO PR, JUGADOR JU
WHERE JU.id_jugador = PR.id_jugador
AND valor >= (
	SELECT AVG(valor)
	FROM PREMIO
)
ORDER BY PR.valor;
	
--5. El id de jugadores masculinos que han ganado premios en torneos y que hayan comprado una edición coleccionista.
(SELECT id_jugador
FROM JUGADOR
WHERE sexo = 'H'

INTERSECT

SELECT id_jugador
FROM PREMIO)

INTERSECT

SELECT id_jugador
FROM VENDER
WHERE id_copia LIKE '%C';
	
--6. El nombre de torneos con 'UK' en el nombre, junto con torneos realizados en 2019 y torneos con un precio de entrada de '10' euros.
(SELECT nombre
 FROM TORNEO
 WHERE nombre LIKE '%UK%'

 UNION

 SELECT nombre
 FROM TORNEO
 WHERE TO_CHAR(fecha, 'YYYY') = '2019')

 UNION

 SELECT nombre
 FROM TORNEO
 WHERE precio_entrada = 10;