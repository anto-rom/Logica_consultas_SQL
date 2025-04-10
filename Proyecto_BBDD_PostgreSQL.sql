-- 
Lógica consultas SQL

-- 2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.

	SELECT "title", "rating"
	FROM "film"
	WHERE "rating" = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.

	SELECT "actor_id", CONCAT ("first_name", ' ', "last_name") as Actor_Name
	FROM "actor"
	WHERE "actor_id" BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT f.title, f.language_id, f.original_language_id
	FROM film f
	WHERE f.language_id = f.original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
SELECT "title", "length"
	FROM "film" as f
	ORDER BY  "length" ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.

	SELECT "actor_id", "first_name", "last_name"
	FROM "actor"
	WHERE "last_name" = 'Allen';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.

	SELECT "rating", COUNT("rating") as Film_total
	FROM "film"
	GROUP BY "rating";

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.

	SELECT "title", "rating", "length"
	FROM "film"
	WHERE"rating" = 'PG-13' OR "length" > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
a. Si quiero calcular la posibilidad de dispersión de los resultados

	SELECT VARIANCE("replacement_cost") AS variabilidad
	FROM "film";

	b. Si quiero calcular la diferencia entre el valor máximo y el mínimo

	SELECT MAX("replacement_cost") - MIN ("replacement_cost")
	FROM "film";

	C. Si quiero calcular la desviación estándar de los gastos de reemplazo

	SELECT STDDEV ("replacement_cost")
	FROM "film";

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MAX("length") as "Mayor_duración", MIN("length") as "Menor_duración"
	FROM "film";

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT r.rental_id, r.rental_date
	FROM rental r
	ORDER BY r.rental_date DESC
	OFFSET 2 LIMIT 1;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
SELECT "title", "rating"
	FROM "film"
	WHERE "rating" != 'NC-17' AND "rating" != 'G';

-- 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.

	SELECT "rating", AVG("length")
	FROM "film"
	GROUP BY "rating";

-- 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.


	SELECT "title", "length"
	FROM "film"
	WHERE "length" > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM("amount")
	FROM "payment";

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT "customer_id"
	FROM "customer"
	ORDER BY "customer_id" desc
	LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’

	SELECT CONCAT("first_name", ' ', "last_name") AS "full_name", actor."actor_id", film."title"
	FROM "actor"
	INNER JOIN "film_actor"
		ON film_actor."actor_id" = actor."actor_id"
	INNER JOIN "film"
		ON film."film_id" = film_actor."film_id"
	WHERE film."title" = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT title FROM film;

-- 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.

	SELECT category."category_id", "name", film_category."film_id", film."title"
	FROM "category"
	INNER JOIN "film_category"
		ON category."category_id" = film_category."category_id"
	INNER JOIN "film"
		ON film_category."film_id" = film."film_id"
	WHERE "name" = 'Comedy' and "length" > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.

	SELECT c."name", AVG(f."length") AS "average_length"
	FROM "category" AS c
	INNER JOIN "film_category" AS fc 
		ON fc."category_id" = c."category_id"
	INNER JOIN "film" AS f 
		ON fc."film_id" = f."film_id"
	GROUP BY c."name"
	HAVING AVG(f."length") > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG("rental_duration")
	FROM "film";

-- 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.

	SELECT CONCAT("first_name", ' ', "last_name") AS "nombre_actores"
	FROM "actor";

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.

	SELECT DATE("rental_date") AS "dia", COUNT(*) AS "recuento"
	FROM "rental"
	GROUP BY "dia"
	ORDER BY "recuento" DESC;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT "film_id", "title", "length"
	FROM "film"
	WHERE "length" > (SELECT AVG("length") FROM "film");

-- 25. Averigua el número de alquileres registrados por mes.
SELECT DATE_TRUNC('month', "rental_date") AS mes,
       	       COUNT(*) AS total
	FROM "rental"
	GROUP BY mes
	ORDER BY mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.

	a) el promedio:
		
		SELECT AVG("rental_rate") AS "promedio_alquiler"
		from "film";

	b) la desviación estándar
	
		SELECT STDDEV("rental_rate") AS "desviacion_alquiler" 
		FROM "film";

	c) la varianza

		SELECT VARIANCE ("rental_rate") AS "varianza_alquiler" 
		FROM "film";

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT "title", "rental_rate"
	FROM "film"
	WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film")

-- 28. Muestra el id de los actores que hayan participado en más de 40
películas.

	SELECT fa."actor_id"
	FROM "film_actor" AS fa
	GROUP BY fa."actor_id"
	HAVING COUNT(fa."film_id") > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.

	SELECT f.title, COUNT(i.inventory_id) AS disponibles
	FROM film f
	LEFT JOIN inventory i ON f.film_id = i.film_id
	LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
	WHERE r.rental_id IS NULL
	GROUP BY f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
SELECT CONCAT(a."first_name", ' ', a."last_name") AS "name", COUNT(f."title") AS "film_count"
	FROM "actor" AS a
	INNER JOIN "film_actor" 
		ON a."actor_id" = film_actor."actor_id"
	INNER JOIN "film" AS f 
		ON film_actor."film_id" = f."film_id"
	GROUP BY a."actor_id", a."first_name", a."last_name";

-- 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.

	SELECT f."title", CONCAT(a."first_name", ' ', a."last_name") AS "name"
	FROM "film" AS f
	LEFT JOIN "film_actor" AS fa 
		ON f."film_id" = fa."film_id"
	LEFT JOIN "actor" AS a 
		ON fa."actor_id" = a."actor_id";

-- 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.

	SELECT f."title", CONCAT(a."first_name", ' ', a."last_name") AS "name"
	FROM "actor" as a
	LEFT JOIN "film_actor" as fa
		ON a."actor_id" = fa."actor_id"
	LEFT JOIN "film" AS f 
		ON fa."film_id" = f."film_id";

-- 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.

	SELECT *
	FROM "film"
	cross join "rental";

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT CONCAT(customer."first_name", ' ', customer."last_name") AS "name", SUM(payment."amount") AS "total_amount"
	FROM "customer"
	INNER JOIN "payment" 
		ON customer."customer_id" = payment."customer_id"
	GROUP BY customer."customer_id", customer."first_name", customer."last_name"
	ORDER BY total_amount DESC
	LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT "first_name", "last_name"
	FROM "actor"
	WHERE "first_name" = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido

	SELECT "first_name" as "Nombre", "last_name" as "Apellido"
	FROM "actor"
	WHERE "first_name" = 'JOHNNY';

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
a) Más bajo

	SELECT MIN("actor_id") as "Mas_Bajo"
	FROM"actor";

      b) Más Alto

	SELECT MAX("actor_id") as "Mas_Alto"
	FROM "actor";

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
SELECT COUNT("actor_id") as "Total"
	FROM "actor";

-- 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.

	SELECT "first_name", "last_name"
	FROM "actor"
	ORDER BY "last_name" asc;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
SELECT "film_id", "title"
	FROM "film"
	ORDER BY "film_id" ASC
	LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?

	SELECT "first_name", COUNT("first_name") as "Count"
	FROM "actor"
	GROUP BY "first_name"
	ORDER BY "Count" desc
	LIMIT 1;

   El nombre más repetido es PENELOPE

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.

	SELECT "rental_id","rental_date", CONCAT(customer."first_name", ' ', "last_name") AS"name"
	FROM "rental"
	INNER JOIN "customer"
		ON customer."customer_id" = rental."customer_id";

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.

	SELECT CONCAT(customer."first_name", ' ', customer."last_name") AS "name", rental."rental_id"
	FROM "customer"
	LEFT JOIN "rental"
		ON customer."customer_id" = rental."customer_id";

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.

	SELECT *
	FROM "film"
	CROSS JOIN "category";

	Sirve para ver todas las posibles combinaciones entre dos tablas. No aporta demasiado valor
	en la mayoría del trabajo diario, ya que no relaciona columnas específicas, si no que las despliega todas.
	Aún así puede ser interesante su uso en problemas matemáticos de combinatoria, como ver 
	el producto cartesiano entre dos conjuntos.

-- 45. Encuentra los actores que han participado en películas de la categoría
'Action'.

	SELECT CONCAT(actor."first_name", ' ', actor."last_name") AS "Name", category."name" AS "category"
	FROM "actor"
	INNER JOIN "film_actor"
   		ON actor."actor_id" = film_actor."actor_id"
	INNER JOIN "film_category"
    		ON film_actor."film_id" = film_category."film_id"
	INNER JOIN "category"
    		ON category."category_id" = film_category."category_id"
	WHERE category."name" = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
SELECT CONCAT(actor."first_name", ' ', actor."last_name") AS "Name", film_actor."actor_id"
	FROM "actor"
	LEFT JOIN "film_actor"
   		ON actor."actor_id" = film_actor."actor_id"
	WHERE film_actor."actor_id" IS NULL;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.

	SELECT actor."first_name", actor."last_name", COUNT(film."film_id") AS "count"
	FROM "actor"
	JOIN "film_actor" ON actor."actor_id" = film_actor."actor_id"
	JOIN film ON film.film_id = film_actor.film_id
	GROUP BY actor."first_name", actor."last_name";

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.

	CREATE VIEW actor_num_peliculas AS (
		SELECT actor.first_name, actor.last_name, COUNT(film.film_id) AS count
		FROM actor
		JOIN film_actor ON actor.actor_id = film_actor.actor_id
		JOIN film ON film.film_id = film_actor.film_id
		GROUP BY actor.first_name, actor.last_name);

-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT c."first_name", c."last_name", COUNT(r."rental_id") AS "RentalCount"
	FROM "customer"
	INNER JOIN "rental" AS r
    		ON c."customer_id" = r."customer_id"
	GROUP BY c."first_name, c."last_name";

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT SUM(f."length") AS "Duración"
	FROM "film" AS "f"
	INNER JOIN "film_category" AS "fc"
    		ON f."film_id" = fc."film_id"
	INNER JOIN "category" AS "c"
    		ON c."category_id" = fc."category_id"
	WHERE c."name" = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.

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

	CREATE TEMPORARY TABLE cliente_rentas_temporal AS
	SELECT CONCAT(c."first_name", ' ', c."last_name") AS "Name", COUNT(r."rental_id") AS "RentalCount"
	FROM "customer" AS c
	INNER JOIN "rental" AS r ON c."customer_id" = r."customer_id"
	GROUP BY c."first_name", c."last_name";

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.


   a) Para obtener el resultado temporal de una consulta inmediata:

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

     b) Para crear una tabla temporar usando explicitamente CREATE TEMPORARY TABLE

	CREATE TEMPORARY TABLE peliculas_alquiladas AS
	SELECT f."title", COUNT(r."rental_id") AS "veces_alquiladas"
	FROM rental r
	INNER JOIN inventory i ON r."inventory_id" = i."inventory_id"
	INNER JOIN film f ON i."film_id" = f."film_id"
	GROUP BY f."title"
	HAVING COUNT(r."rental_id") >= 10;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.

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

-- 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.

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

-- 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.

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

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.

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

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.

	SELECT DISTINCT f."title"
	FROM "film" AS f
	INNER JOIN "inventory" AS i ON f."film_id" = i."film_id"
	INNER JOIN "rental" AS r ON r."inventory_id" = i."inventory_id"
	WHERE r."return_date" IS NOT NULL
  	AND (r."return_date" - r."rental_date") > INTERVAL '8 days';

-- 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.

SELECT f."title", c."name"
FROM "category" as c
INNER JOIN "film_category" AS"fc"
	ON fc."category_id" = c."category_id"
INNER JOIN "film" as f
	ON f."film_id" = fc.film_id
WHERE c."name" = 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.

	SELECT f."title", f."length"
	FROM "film" AS f
	WHERE f."length" = (
    		SELECT sub."length"
    		FROM "film" AS sub
    		WHERE sub."title" = 'DANCING FEVER'
	)
	ORDER BY f."title";

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.

	SELECT c."first_name", c."last_name", COUNT(DISTINCT i."film_id") AS film_count
	FROM "customer" AS "c"
	INNER JOIN "rental" AS "r" ON r."customer_id" = c."customer_id"
	INNER JOIN "inventory" AS "i" ON r."inventory_id" = i."inventory_id"
	GROUP BY c."customer_id", c."first_name", c."last_name"
	HAVING COUNT(DISTINCT i."film_id") >= 7
	ORDER BY c."last_name", c."first_name";

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.

	SELECT c.name, COUNT(r.rental_id)
	FROM category c
	JOIN film_category fc ON fc.category_id = c.category_id
	JOIN film f ON f.film_id = fc.film_id
	JOIN inventory i ON i.film_id = f.film_id
	JOIN rental r ON r.inventory_id = i.inventory_id
	GROUP BY c.name;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c."name", COUNT(f."film_id") AS count
	FROM "category" AS c
	INNER JOIN "film_category" AS fc ON fc."category_id" = c."category_id"
	INNER JOIN "film" AS f ON f."film_id" = fc."film_id"
	WHERE f."release_year" = 2006
	GROUP BY c."name"
	ORDER BY c."name";

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.

	SELECT *
	FROM "staff"
	CROSS JOIN "store";

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas

	SELECT c."customer_id", c."first_name", c."last_name", COUNT(r."rental_id") AS rental_count
	FROM "customer" AS c
	INNER JOIN "rental" AS r 
		ON r."customer_id" = c."customer_id"
	GROUP BY c."customer_id", c."first_name", c."last_name"
	ORDER BY rental_count DESC;
