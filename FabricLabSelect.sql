--1. Выбрать все данные о владельцах фабрики
SELECT * 
FROM owner;
--comment
--2. Выбрать название цеха, температуру и комментарий. Результат отсортировать по названию в порядке обратном лексикографическому. 
SELECT w.workshop_name, w.temperature, c.comment_text
FROM workshop w
LEFT JOIN "comment" c ON w.workshop_id = c.workshop_id
ORDER BY w.workshop_name DESC;

--3. Выбрать все данные о заказчиках, для которых id_заказчика = 2. 
SELECT  * 
FROM client 
WHERE client_id = 2;

--4. Вывести названия улиц, состоящие из двух и более слов. Результат отсортировать по длине названия
SELECT address
FROM fabric
WHERE address LIKE '% %'
ORDER BY LENGTH(address);

--5. Выбрать данные о заказах, для которых не определен способ доставки. 
SELECT *
FROM "order"
WHERE type_id IS NULL

/*6. Выбрать данные о поставщиках, первые две цифры телефона которых лежат в диапазоне от 22 до 78 и в названии которых
есть символ «‘». Результат отсортировать по названию в лексикографическом порядке. */
SELECT	*
FROM 	producer
WHERE	SUBSTRING(phone_number, 3, 2) BETWEEN '22' AND '78'  
	  	AND producer_name LIKE '%‘%'
ORDER BY producer_name;

/*7. Выбрать все данные о фабриках, открытых в 1990, 1998,
1996, 2003, 2007 годах. Результат отсортировать по году открытия
по возрастанию, по площади по убыванию.*/
SELECT *
FROM fabric
WHERE year_opened IN (1990, 1998, 1996, 2003, 2007)
ORDER BY year_opened ASC, 
		 area DESC;

--8. Выбрать данные о цехах, в комментариях к которым есть символы «_», «-», «\» и «%».
SELECT w.* , c.comment_text
FROM workshop w
JOIN "comment" c ON w.workshop_id = c.workshop_id
WHERE c.comment_text LIKE '%@_%' escape '@'
AND c.comment_text LIKE '%-%'
AND c.comment_text LIKE '%@%%' escape '@'
AND c.comment_text LIKE '%@\%' escape '@';

--9. Найти общее количество заказов
SELECT COUNT(*) AS total_orders 
FROM "order";

--10. Найти максимальную и минимальную цену продуктов
SELECT MAX(price) AS max_price, 
	   MIN(price) AS min_price 
FROM product;

--11. Найти среднюю площадь фабрик. 
SELECT AVG(area) AS average_area 
FROM fabric;

--12. Найти суммарную стоимость поставки с id = 2. 
SELECT SUM(order_cost) AS total_cost
FROM "order"
WHERE order_id = 2;

/*13. Для каждого поставщика вывести количество совершенных в этом году поставок. Результат отсортировать по количеству
в порядке убывания.*/
SELECT p.producer_name, COUNT(o.order_id) AS order_count
FROM "order" o
JOIN producer p ON o.producer_id = p.producer_id
WHERE EXTRACT(YEAR FROM o.order_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY p.producer_name
ORDER BY order_count DESC;

--14. Выбрать название продукта, цену, название единиц измерения.
SELECT P.product_name,P.price, M.measure_name
FROM product P INNER JOIN measure M ON P.measure_id = M.measure_id;

/*15. Выбрать название продукта, его цену, название единиц
измерения, id_заказа, дату заказа, количество продукта в заказе и
пункт доставки*/
SELECT P.product_name, P.price, M.measure_name, CO.order_id, CO.acceptance_date, COUNT(CO_P.product_id) AS quantity, DP.place_id
FROM product P
INNER JOIN measure M ON P.measure_id = M.measure_id
INNER JOIN client_order_product CO_P ON P.product_id = CO_P.product_id
INNER JOIN client_order CO ON CO_P.order_id = CO.order_id
INNER JOIN client_delivery_place CDP ON CO.client_id = CDP.client_id
INNER JOIN delivery_place DP ON CDP.place_id = DP.place_id
GROUP BY P.product_name, P.price, M.measure_name, CO.order_id, CO.acceptance_date, DP.place_id;

/*16. Для каждого заказа вывести количество различных продуктов, в него входящих. В результат включить только те заказы,
в которых более одного продукта.*/
SELECT CO.order_id, COUNT(DISTINCT CO_P.product_id) AS product_count
FROM client_order CO
INNER JOIN client_order_product CO_P ON CO.order_id = CO_P.order_id
GROUP BY CO.order_id
HAVING COUNT(DISTINCT CO_P.product_id) > 1;

/*17. Для каждого цеха каждой фабрики вывести количество
различных продуктов, им производимых. Результат отсортировать
по убыванию количества*/
SELECT F.fabric_name, W.workshop_name, COUNT(WP.product_id) as product_count
FROM fabric F 
INNER JOIN workshop W ON F.fabric_id = W.fabric_id
INNER JOIN workshop_product WP ON WP.workshop_id = W.workshop_id
GROUP BY F.fabric_name, W.workshop_name
ORDER BY product_count DESC;

	
/*18. Для фабрик, открытых за последние 10 лет, вывести количество цехов. В результат включить только фабрики с площадью большей какого-то конкретного значения и количество цехов
в которых более 3. */
SELECT fabric_name, COUNT(W.workshop_id) AS workshop_count
FROM fabric F
INNER JOIN workshop W ON F.fabric_id = W.fabric_id
WHERE F.year_opened >= EXTRACT(YEAR FROM CURRENT_DATE) - 10
AND F.area > 100
GROUP BY F.fabric_name
HAVING COUNT(W.workshop_id) > 3;

/*19. Выбрать все даты поставок. В первом столбце вывести
дату в формате: число, название месяца, четыре цифры года, во
втором – название дня недели, в третьем – для суббот и воскресений – «выходной», а для остальных дней – «рабочий день». */
SELECT
    CONCAT(EXTRACT(DAY FROM order_date), ' ', EXTRACT(MONTH FROM order_date), ' ', EXTRACT(YEAR FROM order_date)) AS formatted_date,
    TO_CHAR(order_date, 'Day') AS day_of_week,
    CASE
        WHEN EXTRACT(DOW FROM order_date) IN (0, 6) THEN 'выходной'
        ELSE 'рабочий день'
    END AS work_status
FROM "order";


/*20. Для каждого года посчитать количество заказов по временам года, в которые входит продукт с id = 2. В результирующей
таблице должно быть 4 столбца по временам года.*/
SELECT
    EXTRACT(YEAR FROM o.completion_date) AS year,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.completion_date) IN (12, 1, 2) THEN 1 ELSE 0 END) AS winter,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.completion_date) IN (3, 4, 5) THEN 1 ELSE 0 END) AS spring,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.completion_date) IN (6, 7, 8) THEN 1 ELSE 0 END) AS summer,
    SUM(CASE WHEN EXTRACT(MONTH FROM o.completion_date) IN (9, 10, 11) THEN 1 ELSE 0 END) AS autumn
FROM
    client_order_product p
    JOIN client_order o ON p.order_id = o.order_id
WHERE
    p.product_id = 2
GROUP BY
    EXTRACT(YEAR FROM o.completion_date)
ORDER BY
    year;


--21. Выбрать все данные о фабриках, которые имеют только один склад.
-- в груп бай столбцы все
SELECT F.*
FROM fabric F RIGHT JOIN "storage" S ON F.fabric_id = S.fabric_id 
GROUP BY F.fabric_id
HAVING COUNT(s.storage_id) = 1;


--22. Выбрать id_заказов, которые включают более половины продуктов из имеющихся в базе.
SELECT order_id
FROM client_order_product
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) > (SELECT COUNT(*) FROM product) / 2;


--23. Выбрать данные о поставщиках, которые сделали более трех поставок за текущий месяц. 
--текущий
SELECT P.*
FROM producer P INNER JOIN "order" O ON P.producer_id = O.producer_id
GROUP BY P.producer_id 
HAVING COUNT(O.producer_id) > 3;


--24. Выбрать названия продуктов, которые измеряются в литрах и которые производят только на одной фабрике. 
SELECT p.product_name
FROM product p
JOIN measure m ON p.measure_id = m.measure_id
JOIN workshop_product wp ON p.product_id = wp.product_id
WHERE m.measure_name = 'liter'
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT wp.workshop_id) = 1;


--25. Найти заказы, у которых дата доставки позже даты принятия заказа на месяц

SELECT *
FROM client_order
WHERE completion_date > acceptance_date + INTERVAL '1 month';

--26. Выбрать название и id поставщиков, чье название включает название продукта, ими поставляемого. 
SELECT p.producer_id, p.producer_name
FROM producer p
JOIN "order" o ON p.producer_id = o.producer_id
JOIN order_ing oi ON o.order_id = oi.order_id
JOIN ingredient i ON oi.ingredient_id = i.ingredient_id
WHERE p.producer_name ILIKE CONCAT('%', i.name, '%');


--27. Выбрать продукты с одинаковым названием, но разной ценой и единицами измерения.
SELECT p1.product_name, p1.price, m1.measure_name, p2.price, m2.measure_name
FROM product p1
JOIN measure m1 ON p1.measure_id = m1.measure_id
JOIN product p2 ON p1.product_name = p2.product_name 
JOIN measure m2 ON p2.measure_id = m2.measure_id
WHERE p1.price <> p2.price AND m1.measure_name <> m2.measure_name AND p1.product_id <> p2.product_id;


--28. Выбрать количество продуктов с совпадающей ценой. 
SELECT p1.price, COUNT(*)
FROM product p1
JOIN product p2 ON p1.price = p2.price
GROUP BY p1.price
HAVING COUNT(*) > 1;

--29. Для каждой страны, имеющейся в базе, вывести количество фабрик. 
SELECT c.country_name, COUNT(f.fabric_id) AS fabric_count
FROM  country c
JOIN city ci ON c.country_id = ci.country_id
JOIN street s ON ci.city_id = s.city_id
JOIN fabric f ON s.street_id = f.street_id
GROUP BY c.country_name
ORDER BY c.country_name;

--30. Выбрать названия населенных пунктов разных стран с совпадающим названием.
SELECT
    c1.city_name,
    c1.country_id AS country_id1,
    c2.city_name,
    c2.country_id AS country_id2
FROM city c1
JOIN city c2 ON c1.city_name = c2.city_name AND c1.country_id < c2.country_id
ORDER BY c1.city_name;

--31. Выбрать количество населенных пунктов разных стран с совпадающим названием
SELECT city_name, COUNT(DISTINCT country_id) AS country_count
FROM city
GROUP BY city_name
HAVING COUNT(DISTINCT country_id) > 1;

--32. Выбрать название цеха, в котором ничего не производили в текущем году.
SELECT w.workshop_name
FROM workshop w
LEFT JOIN workshop_product wp ON w.workshop_id = wp.workshop_id
WHERE wp.workshop_id IS NULL
   OR EXTRACT (YEAR FROM wp.production_start) <> EXTRACT(YEAR FROM CURRENT_DATE);
	   
/*33. Вывести в одном столбце названия продуктов и названия
поставляемых ингредиентов. Результат отсортировать по названию в лексикографическом порядке. */
SELECT product_name AS item_name
FROM product
UNION ALL
SELECT name AS item_name
FROM ingredient
ORDER BY item_name;

--34. Выбрать названия продуктов и, если были заказы в текущем месяце на этот продукт, то суммарное количество заказанного продукта.
SELECT p.product_name, SUM(cop.count) AS total_ordered
FROM product p
LEFT JOIN client_order_product cop ON p.product_id = cop.product_id
LEFT JOIN client_order co ON cop.order_id = co.order_id
WHERE EXTRACT(MONTH FROM co.acceptance_date) = EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM co.acceptance_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY p.product_name;

--35. Выбрать улицу, на которой нет ни фабрик, ни поставщиков
SELECT s.street_name
FROM street s
LEFT JOIN fabric f ON s.street_id = f.street_id
LEFT JOIN producer p ON s.street_id = p.street_id
WHERE f.street_id IS NULL AND p.street_id IS NULL;

--36. Выбрать название цеха с самой высокой температурой
SELECT workshop_name
FROM workshop
WHERE temperature = (
    SELECT MAX(temperature)
    FROM workshop
);

--37. Выбрать название цеха с самой высокой и самой низкой температурами в одном столбце
SELECT workshop_name AS workshop_name
FROM workshop
WHERE temperature = (SELECT MAX(temperature) FROM workshop) OR
temperature = (SELECT MIN(temperature) FROM workshop) 

--38. Выбрать все данные складов, на которых хранятся поставляемые ингредиенты с одинаковым названием, но принадлежащие разным поставщикам. 
SELECT DISTINCT s.*
FROM storage s
JOIN storage_ingredient si ON s.storage_id = si.storage_id
JOIN ingredient i ON si.ingredient_id = i.ingredient_id
WHERE i.ingredient_id IN (
    SELECT i1.ingredient_id
    FROM ingredient i1
    JOIN producer_ing_cost pic ON i1.ingredient_id = pic.ingredient_id
    GROUP BY i1.ingredient_id
    HAVING COUNT(DISTINCT pic.producer_id) > 1
);

--39. Выбрать поставщика, чью продукцию заказывают чаще других. 
SELECT  p.producer_id, p.producer_name, COUNT(o.order_id) AS order_count
FROM  producer p
JOIN "order" o ON p.producer_id = o.producer_id
GROUP BY  p.producer_id
HAVING COUNT(o.order_id) = (
        SELECT MAX(order_count)
        FROM (
            SELECT COUNT(o.order_id) AS order_count
            FROM producer p
            JOIN "order" o ON p.producer_id = o.producer_id
            GROUP BY p.producer_id
        ) AS sub
    );


--40. Вывести названия продуктов, которые не входят ни в один заказ.
SELECT p.product_name
FROM product p
LEFT JOIN client_order_product cop ON p.product_id = cop.product_id
WHERE cop.product_id IS NULL;

--41. Выбрать тройку фабрик с наименьшей площадью
SELECT fabric_id, fabric_name,area
FROM fabric
ORDER BY area ASC
LIMIT 3;
/*
иначе
SELECT
    f1.fabric_name AS fabric_name1,
    f1.area AS area1,
    f2.fabric_name AS fabric_name2,
    f2.area AS area2,
    f3.fabric_name AS fabric_name3,
    f3.area AS area3,
    (f1.area + f2.area + f3.area) AS total_area
FROM fabric f1
JOIN fabric f2 ON f1.fabric_id < f2.fabric_id
JOIN fabric f3 ON f2.fabric_id < f3.fabric_id
WHERE
    (f1.area + f2.area + f3.area) = (
        SELECT
            MIN(f1.area + f2.area + f3.area)
        FROM fabric f1
        JOIN fabric f2 ON f1.fabric_id < f2.fabric_id
        JOIN fabric f3 ON f2.fabric_id < f3.fabric_id
    );
*/


--42. Выбрать улицу, на которой расположены две фабрики по три цеха в каждой.
SELECT s.street_name
FROM street s
JOIN fabric f ON s.street_id = f.street_id
JOIN (
    SELECT w.fabric_id, COUNT(*) AS workshop_count
    FROM workshop w
    GROUP BY w.fabric_id
    HAVING COUNT(*) = 3
) wc ON f.fabric_id = wc.fabric_id
GROUP BY s.street_name
HAVING COUNT(DISTINCT f.fabric_id) = 2;


--43. Выбрать месяц прошлого года, в который было сделано наибольшее количество заказов. 
SELECT
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(order_id) AS order_count
FROM "order"
WHERE  EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY EXTRACT(MONTH FROM order_date)
HAVING  COUNT(order_id) = (
        SELECT  MAX(order_count)
        FROM (
            SELECT COUNT(order_id) AS order_count
            FROM "order"
            WHERE  EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
            GROUP BY EXTRACT(MONTH FROM order_date)
        ) AS sub
    );
	SELECT COUNT(*)
     FROM workshop w
	 WHERE w.fabric_id = 
/*45. Выбрать владельцев нескольких фабрик. Для каждого из
владельцев указать год открытия и площадь старейшей из его
фабрик и количество цехов на фабрике. Результат отсортировать
по году открытия фабрики от старейшей к новейшей и по имени
владельца в алфавитном порядке.*/
SELECT
    o.owner_id,
    o.first_name,
    o.last_name,
    f.year_opened,
    f.area,
    COUNT(w.*) AS workshop_count
FROM "owner" o
JOIN fabric f ON o.owner_id = f.owner_id
LEFT JOIN workshop w ON f.fabric_id = w.fabric_id
WHERE
    o.owner_id IN (
        SELECT owner_id
        FROM fabric
        GROUP BY owner_id
        HAVING COUNT(*) > 1
    )
    AND f.year_opened = (
        SELECT MIN(f2.year_opened)
        FROM fabric f2
        WHERE f2.owner_id = o.owner_id
    )
GROUP BY
    o.owner_id,
    o.first_name,
    o.last_name,
    f.year_opened,
    f.area,
	w.fabric_id
ORDER BY
    f.year_opened,
    o.first_name,
    o.last_name;


SELECT COUNT(W.*)
FROM "owner" o
JOIN fabric f ON o.owner_id = f.owner_id
LEFT JOIN workshop w ON f.fabric_id = w.fabric_id
GROUP BY w.fabric_id
