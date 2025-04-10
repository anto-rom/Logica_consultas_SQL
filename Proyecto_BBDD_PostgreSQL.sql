-- Consulta 1
Lógica consultas SQL

-- Consulta 2
1. Crea el esquema de la BBDD.
2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.

-- Consulta 3
SELECT "title", "rating"
	FROM "film"
	WHERE "rating" = 'R';

-- Consulta 4
3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.

-- Consulta 5
SELECT "actor_id", CONCAT ("first_name", ' ', "last_name") as Actor_Name
	FROM "actor"
	WHERE "actor_id" BETWEEN 30 AND 40;

-- Consulta 6
4. Obtén las películas cuyo idioma coincide con el idioma original.

-- Consulta 7
SELECT f.title, f.language_id, f.original_language_id
	FROM film f
	WHERE f.language_id = f.original_language_id;

-- Consulta 8
5. Ordena las películas por duración de forma ascendente.

-- Consulta 9
SELECT "title", "length"
	FROM "film" as f
	ORDER BY  "length" ASC;

-- Consulta 10
6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.

-- Consulta 11
SELECT "actor_id", "first_name", "last_name"
	FROM "actor"
	WHERE "last_name" = 'Allen';

-- Consulta 12
7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.

-- Consulta 13
SELECT "rating", COUNT("rating") as Film_total
	FROM "film"
	GROUP BY "rating";

-- Consulta 14
8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.

-- Consulta 15
SELECT "title", "rating", "length"
	FROM "film"
	WHERE"rating" = 'PG-13' OR "length" > 180;

-- Consulta 16


-- Consulta 17
9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

-- Consulta 18
a. Si quiero calcular la posibilidad de dispersión de los resultados

-- Consulta 19
SELECT VARIANCE("replacement_cost") AS variabilidad
	FROM "film";

-- Consulta 20
b. Si quiero calcular la diferencia entre el valor máximo y el mínimo

-- Consulta 21
SELECT MAX("replacement_cost") - MIN ("replacement_cost")
	FROM "film";

-- Consulta 22
C. Si quiero calcular la desviación estándar de los gastos de reemplazo

-- Consulta 23
SELECT STDDEV ("replacement_cost")
	FROM "film";

-- Consulta 24


-- Consulta 25
10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

-- Consulta 26
SELECT MAX("length") as "Mayor_duración", MIN("length") as "Menor_duración"
	FROM "film";

-- Consulta 27
11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

-- Consulta 28
SELECT r.rental_id, r.rental_date
	FROM rental r
	ORDER BY r.rental_date DESC
	OFFSET 2 LIMIT 1;

-- Consulta 29
12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.

-- Consulta 30
SELECT "title", "rating"
	FROM "film"
	WHERE "rating" != 'NC-17' AND "rating" != 'G';

-- Consulta 31


-- Consulta 32
13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.

-- Consulta 33
SELECT "rating", AVG("length")
	FROM "film"
	GROUP BY "rating";

-- Consulta 34
14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.

-- Consulta 35
SELECT "title", "length"
	FROM "film"
	WHERE "length" > 180;

-- Consulta 36
15. ¿Cuánto dinero ha generado en total la empresa?

-- Consulta 37
SELECT SUM("amount")
	FROM "payment";

-- Consulta 38


-- Consulta 39
16. Muestra los 10 clientes con mayor valor de id.

-- Consulta 40
SELECT "customer_id"
	FROM "customer"
	ORDER BY "customer_id" desc
	LIMIT 10;

-- Consulta 41


-- Consulta 42
17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’

-- Consulta 43
SELECT CONCAT("first_name", ' ', "last_name") AS "full_name", actor."actor_id", film."title"
	FROM "actor"
	INNER JOIN "film_actor"
		ON film_actor."actor_id" = actor."actor_id"
	INNER JOIN "film"
		ON film."film_id" = film_actor."film_id"
	WHERE film."title" = 'EGG IGBY';

-- Consulta 44
18. Selecciona todos los nombres de las películas únicos.

-- Consulta 45
SELECT DISTINCT title FROM film;

-- Consulta 46


-- Consulta 47
19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.

-- Consulta 48
SELECT category."category_id", "name", film_category."film_id", film."title"
	FROM "category"
	INNER JOIN "film_category"
		ON category."category_id" = film_category."category_id"
	INNER JOIN "film"
		ON film_category."film_id" = film."film_id"
	WHERE "name" = 'Comedy' and "length" > 180;

-- Consulta 49
20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.

-- Consulta 50
SELECT c."name", AVG(f."length") AS "average_length"
	FROM "category" AS c
	INNER JOIN "film_category" AS fc 
		ON fc."category_id" = c."category_id"
	INNER JOIN "film" AS f 
		ON fc."film_id" = f."film_id"
	GROUP BY c."name"
	HAVING AVG(f."length") > 110;

-- Consulta 51


-- Consulta 52
21. ¿Cuál es la media de duración del alquiler de las películas?

-- Consulta 53
SELECT AVG("rental_duration")
	FROM "film";

-- Consulta 54
22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.

-- Consulta 55
SELECT CONCAT("first_name", ' ', "last_name") AS "nombre_actores"
	FROM "actor";

-- Consulta 56


-- Consulta 57
23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.

-- Consulta 58
SELECT DATE("rental_date") AS "dia", COUNT(*) AS "recuento"
	FROM "rental"
	GROUP BY "dia"
	ORDER BY "recuento" DESC;

-- Consulta 59
24. Encuentra las películas con una duración superior al promedio.

-- Consulta 60
SELECT "film_id", "title", "length"
	FROM "film"
	WHERE "length" > (SELECT AVG("length") FROM "film");

-- Consulta 61
25. Averigua el número de alquileres registrados por mes.

-- Consulta 62
SELECT DATE_TRUNC('month', "rental_date") AS mes,
       	       COUNT(*) AS total
	FROM "rental"
	GROUP BY mes
	ORDER BY mes;

-- Consulta 63
26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.

-- Consulta 64
a) el promedio:
		
		SELECT AVG("rental_rate") AS "promedio_alquiler"
		from "film";

-- Consulta 65
b) la desviación estándar
	
		SELECT STDDEV("rental_rate") AS "desviacion_alquiler" 
		FROM "film";

-- Consulta 66
c) la varianza

-- Consulta 67
SELECT VARIANCE ("rental_rate") AS "varianza_alquiler" 
		FROM "film";

-- Consulta 68
27. ¿Qué películas se alquilan por encima del precio medio?

-- Consulta 69
SELECT "title", "rental_rate"
	FROM "film"
	WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film")

-- Consulta 70


-- Consulta 71
28. Muestra el id de los actores que hayan participado en más de 40
películas.

-- Consulta 72
SELECT fa."actor_id"
	FROM "film_actor" AS fa
	GROUP BY fa."actor_id"
	HAVING COUNT(fa."film_id") > 40;

-- Consulta 73


-- Consulta 74
29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.

-- Consulta 75
SELECT f.title, COUNT(i.inventory_id) AS disponibles
	FROM film f
	LEFT JOIN inventory i ON f.film_id = i.film_id
	LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
	WHERE r.rental_id IS NULL
	GROUP BY f.title;

-- Consulta 76
30. Obtener los actores y el número de películas en las que ha actuado.

-- Consulta 77
SELECT CONCAT(a."first_name", ' ', a."last_name") AS "name", COUNT(f."title") AS "film_count"
	FROM "actor" AS a
	INNER JOIN "film_actor" 
		ON a."actor_id" = film_actor."actor_id"
	INNER JOIN "film" AS f 
		ON film_actor."film_id" = f."film_id"
	GROUP BY a."actor_id", a."first_name", a."last_name";

-- Consulta 78
31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.

-- Consulta 79
SELECT f."title", CONCAT(a."first_name", ' ', a."last_name") AS "name"
	FROM "film" AS f
	LEFT JOIN "film_actor" AS fa 
		ON f."film_id" = fa."film_id"
	LEFT JOIN "actor" AS a 
		ON fa."actor_id" = a."actor_id";

-- Consulta 80
32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.

-- Consulta 81
SELECT f."title", CONCAT(a."first_name", ' ', a."last_name") AS "name"
	FROM "actor" as a
	LEFT JOIN "film_actor" as fa
		ON a."actor_id" = fa."actor_id"
	LEFT JOIN "film" AS f 
		ON fa."film_id" = f."film_id";

-- Consulta 82
33. Obtener todas las películas que tenemos y todos los registros de
alquiler.

-- Consulta 83
SELECT *
	FROM "film"
	cross join "rental";

-- Consulta 84
34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

-- Consulta 85
SELECT CONCAT(customer."first_name", ' ', customer."last_name") AS "name", SUM(payment."amount") AS "total_amount"
	FROM "customer"
	INNER JOIN "payment" 
		ON customer."customer_id" = payment."customer_id"
	GROUP BY customer."customer_id", customer."first_name", customer."last_name"
	ORDER BY total_amount DESC
	LIMIT 5;

-- Consulta 86
35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

-- Consulta 87
SELECT "first_name", "last_name"
	FROM "actor"
	-- WHERE "first_name" = 'JOHNNY'; -- Se comenta para mostrar todos

-- Consulta 88
36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido

-- Consulta 89
SELECT "first_name" as "Nombre", "last_name" as "Apellido"
	FROM "actor"
	-- WHERE "first_name" = 'JOHNNY'; -- Se comenta para mostrar todos

-- Consulta 90
37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
 
      a) Más bajo

-- Consulta 91
SELECT MIN("actor_id") as "Mas_Bajo"
	FROM"actor";

-- Consulta 92
b) Más Alto

-- Consulta 93
SELECT MAX("actor_id") as "Mas_Alto"
	FROM "actor";

-- Consulta 94


-- Consulta 95
38. Cuenta cuántos actores hay en la tabla “actor”.

-- Consulta 96
SELECT COUNT("actor_id") as "Total"
	FROM "actor";

-- Consulta 97
39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.

-- Consulta 98
SELECT "first_name", "last_name"
	FROM "actor"
	ORDER BY "last_name" asc;

-- Consulta 99
40. Selecciona las primeras 5 películas de la tabla “film”.

-- Consulta 100
SELECT "film_id", "title"
	FROM "film"
	ORDER BY "film_id" ASC
	LIMIT 5;

-- Consulta 101


-- Consulta 102
41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?

-- Consulta 103
SELECT "first_name", COUNT("first_name") as "Count"
	FROM "actor"
	GROUP BY "first_name"
	ORDER BY "Count" desc
	LIMIT 1;

-- Consulta 104
El nombre más repetido es PENELOPE

-- Consulta 105
42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.

-- Consulta 106
SELECT "rental_id","rental_date", CONCAT(customer."first_name", ' ', "last_name") AS"name"
	FROM "rental"
	INNER JOIN "customer"
		ON customer."customer_id" = rental."customer_id";

-- Consulta 107
43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.

-- Consulta 108
SELECT CONCAT(customer."first_name", ' ', customer."last_name") AS "name", rental."rental_id"
	FROM "customer"
	LEFT JOIN "rental"
		ON customer."customer_id" = rental."customer_id";

-- Consulta 109


-- Consulta 110
44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.

-- Consulta 111
SELECT *
	FROM "film"
	CROSS JOIN "category";

-- Consulta 112
Sirve para ver todas las posibles combinaciones entre dos tablas. No aporta demasiado valor
	en la mayoría del trabajo diario, ya que no relaciona columnas específicas, si no que las despliega todas.
	Aún así puede ser interesante su uso en problemas matemáticos de combinatoria, como ver 
	el producto cartesiano entre dos conjuntos.

-- Consulta 113
45. Encuentra los actores que han participado en películas de la categoría
'Action'.

-- Consulta 114
SELECT CONCAT(actor."first_name", ' ', actor."last_name") AS "Name", category."name" AS "category"
	FROM "actor"
	INNER JOIN "film_actor"
   		ON actor."actor_id" = film_actor."actor_id"
	INNER JOIN "film_category"
    		ON film_actor."film_id" = film_category."film_id"
	INNER JOIN "category"
    		ON category."category_id" = film_category."category_id"
	WHERE category."name" = 'Action';

-- Consulta 115
46. Encuentra todos los actores que no han participado en películas.

-- Consulta 116
SELECT CONCAT(actor."first_name", ' ', actor."last_name") AS "Name", film_actor."actor_id"
	FROM "actor"
	LEFT JOIN "film_actor"
   		ON actor."actor_id" = film_actor."actor_id"
	WHERE film_actor."actor_id" IS NULL;

-- Consulta 117


-- Consulta 118
47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.

-- Consulta 119
SELECT actor."first_name", actor."last_name", COUNT(film."film_id") AS "count"
	FROM "actor"
	JOIN "film_actor" ON actor."actor_id" = film_actor."actor_id"
	JOIN film ON film.film_id = film_actor.film_id
	GROUP BY actor."first_name", actor."last_name";

-- Consulta 120
48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.

-- Consulta 121
CREATE VIEW actor_num_peliculas AS (
		SELECT actor.first_name, actor.last_name, COUNT(film.film_id) AS count
		FROM actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film ON film.film_id = film_actor.film_id
		GROUP BY actor.first_name, actor.last_name);

-- Consulta 122


-- Consulta 123
49. Calcula el número total de alquileres realizados por cada cliente.

-- Consulta 124
SELECT c."first_name", c."last_name", COUNT(r."rental_id") AS "RentalCount"
	FROM "customer"
	INNER JOIN "rental" AS r
    		ON c."customer_id" = r."customer_id"
	GROUP BY c."first_name", c."last_name";

-- Consulta 125


-- Consulta 126
50. Calcula la duración total de las películas en la categoría 'Action'.

-- Consulta 127
SELECT SUM(f."length") AS "Duración"
	FROM "film" AS "f"
	INNER JOIN "film_category" AS "fc"
    		ON f."film_id" = fc."film_id"
	INNER JOIN "category" AS "c"
    		ON c."category_id" = fc."category_id"
	WHERE c."name" = 'Action';

-- Consulta 128
51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.

-- Consulta 129
a) Para obtener el resultado temporal de una consulta inmediata:
	WITH cliente_rentas_temporal AS (
    		SELECT CONCAT(c."first_name", ' ', c."last_name") AS "Name", COUNT(r."rental_id") AS "RentalCount"
    		FROM "customer" AS "c"
    		INNER JOIN "rental" AS "r"
        		ON c."customer_id" = r."customer_id"
    		GROUP BY "Name"
	)
	SELECT * FROM cliente_rentas_temporal;
 	
     b) Para crear una tabla temporar usando explicitamente CREATE TEMPORARY TABLE

-- Consulta 130
CREATE TEMPORARY TABLE cliente_rentas_temporal AS
	SELECT CONCAT(c."first_name", ' ', c."last_name") AS "Name", COUNT(r."rental_id") AS "RentalCount"
	FROM "customer" AS c
	INNER JOIN "rental" AS r ON c."customer_id" = r."customer_id"
	GROUP BY c."first_name", c."last_name";

-- Consulta 131


-- Consulta 132
52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.

-- Consulta 133
a) Para obtener el resultado temporal de una consulta inmediata:

-- Consulta 134
WITH peliculas_alquiladas AS (
    		SELECT f."title", COUNT(r."rental_id") AS "veces_alquiladas"
    	FROM rental r 
    	INNER JOIN "inventory" i
        	ON r."inventory_id" = i."inventory_id"
    	INNER JOIN "film" f
        	ON i."film_id" = f."film_id"
    	GROUP BY f."title"
	)
	SELECT *
	FROM peliculas_alquiladas
	WHERE "veces_alquiladas" >= 10;

-- Consulta 135
b) Para crear una tabla temporar usando explicitamente CREATE TEMPORARY TABLE

-- Consulta 136
CREATE TEMPORARY TABLE peliculas_alquiladas AS
	SELECT f."title", COUNT(r."rental_id") AS "veces_alquiladas"
	FROM rental r
	INNER JOIN inventory i ON r."inventory_id" = i."inventory_id"
	INNER JOIN film f ON i."film_id" = f."film_id"
	GROUP BY f."title"
	HAVING COUNT(r."rental_id") >= 10;

-- Consulta 137


-- Consulta 138
53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.

-- Consulta 139
SELECT CONCAT(c."first_name", ' ', c."last_name") AS "name", f."title"
	FROM "customer" AS c
	INNER JOIN "rental" AS r
    		ON c."customer_id" = r."customer_id"
	INNER JOIN "inventory" AS i
    		ON r."inventory_id" = i."inventory_id"
	INNER JOIN "film" AS f
    		ON i."film_id" = f."film_id"
	WHERE CONCAT(c."first_name", ' ', c."last_name") = 'TAMMY SANDERS' 
		AND r."return_date" IS NULL
	ORDER by f."title";

-- Consulta 140
54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.

-- Consulta 141
SELECT a."first_name", a."last_name", c."name"
	FROM "actor" AS a
	INNER JOIN "film_actor" AS fa
   		ON fa."actor_id" = a."actor_id"
	INNER JOIN "film" AS f
    		ON f."film_id" = fa."film_id"
	INNER JOIN "film_category" AS fc
    		ON fc."film_id" = f."film_id"
	INNER JOIN "category" AS c
    		ON c."category_id" = fc."category_id"
	WHERE c."name" = 'Sci-Fi'
	ORDER BY a."last_name";

-- Consulta 142
55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.

-- Consulta 143
SELECT a."first_name", a."last_name"
	FROM "actor" AS a
	INNER JOIN "film_actor" AS fa
   		ON fa."actor_id" = a."actor_id"
	INNER JOIN "film" AS f
    		ON f."film_id" = fa."film_id"
	INNER JOIN "inventory" AS i
    		ON i."film_id" = f."film_id"
	INNER JOIN "rental" AS r
    		ON i."inventory_id" = r."inventory_id"
	WHERE r."rental_date" > (
    		SELECT MIN(r2."rental_date")
    		FROM "rental" AS r2
    		INNER JOIN "inventory" AS i2
        		ON r2."inventory_id" = i2."inventory_id"
    		INNER JOIN "film" AS f2
        		ON i2."film_id" = f2."film_id"
    		WHERE f2."title" = 'SPARTACUS CHEAPER'
		)
	ORDER BY a."last_name" ASC;

-- Consulta 144


-- Consulta 145
56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.

-- Consulta 146
SELECT a."first_name", a."last_name"
	FROM "actor" AS a
	WHERE a."actor_id" NOT IN (
    		SELECT fa."actor_id"
    		FROM "film_actor" AS fa
    		INNER JOIN "film" AS f
        		ON fa."film_id" = f."film_id"
    		INNER JOIN "film_category" AS fc
       			ON fc."film_id" = f."film_id"
    		INNER JOIN "category" AS c
        		ON c."category_id" = fc."category_id"
    		WHERE c."name" = 'Music'
	);

-- Consulta 147
57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.

-- Consulta 148
SELECT DISTINCT f."title"
	FROM "film" AS f
	INNER JOIN "inventory" AS i ON f."film_id" = i."film_id"
	INNER JOIN "rental" AS r ON r."inventory_id" = i."inventory_id"
	WHERE r."return_date" IS NOT NULL
  	AND EXTRACT(DAY FROM (r."return_date" - r."rental_date")) > 8;

-- Consulta 149
58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.

-- Consulta 150
SELECT f."title", c."name"
FROM "category" as c
INNER JOIN "film_category" AS"fc"
	ON fc."category_id" = c."category_id"
INNER JOIN "film" as f
	ON f."film_id" = fc.film_id
WHERE c."name" = 'Animation';

-- Consulta 151
59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.

-- Consulta 152
SELECT f."title", f."length"
	FROM "film" AS f
	WHERE f."length" = (
    		SELECT sub."length"
    		FROM "film" AS sub
    		WHERE sub."title" = 'DANCING FEVER'
	)
	ORDER BY f."title";

-- Consulta 153
60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.

-- Consulta 154
SELECT c."first_name", c."last_name", COUNT(DISTINCT i."film_id") AS film_count
	FROM "customer" AS "c"
	INNER JOIN "rental" AS "r" ON r."customer_id" = c."customer_id"
	INNER JOIN "inventory" AS "i" ON r."inventory_id" = i."inventory_id"
	GROUP BY c."customer_id", c."first_name", c."last_name"
	HAVING COUNT(DISTINCT i."film_id") >= 7
	ORDER BY c."last_name", c."first_name";

-- Consulta 155
61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.

-- Consulta 156
SELECT c.name, COUNT(r.rental_id)
	FROM category c
	JOIN film_category fc ON fc.category_id = c.category_id
	JOIN film f ON f.film_id = fc.film_id
	JOIN inventory i ON i.film_id = f.film_id
	JOIN rental r ON r.inventory_id = i.inventory_id
	GROUP BY c.name;

-- Consulta 157
62. Encuentra el número de películas por categoría estrenadas en 2006.

-- Consulta 158
SELECT c."name", COUNT(f."film_id") AS count
	FROM "category" AS c
	INNER JOIN "film_category" AS fc ON fc."category_id" = c."category_id"
	INNER JOIN "film" AS f ON f."film_id" = fc."film_id"
	WHERE f."release_year" = 2006
	GROUP BY c."name"
	ORDER BY c."name";

-- Consulta 159


-- Consulta 160
63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.

-- Consulta 161
SELECT *
	FROM "staff"
	CROSS JOIN "store";

-- Consulta 162


-- Consulta 163
64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas

-- Consulta 164
SELECT c."customer_id", c."first_name", c."last_name", COUNT(r."rental_id") AS rental_count
	FROM "customer" AS c
	INNER JOIN "rental" AS r 
		ON r."customer_id" = c."customer_id"
	GROUP BY c."customer_id", c."first_name", c."last_name"
	ORDER BY rental_count DESC;

-- Consulta 165


-- Consulta 166


-- Consulta 167


-- Consulta 168

