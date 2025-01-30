-- Вставка данных в таблицу "owner"
INSERT INTO "owner" (first_name, last_name, phone_number)
VALUES
('John', 'Doe', '+79123456789'),
('Jane', 'Smith', '+79123456780'),
('Alice', 'Johnson', '+79123456781'),
('Bob', 'Brown', '+79123456782'),
('Charlie', 'Davis', '+79123456783'),
('David', 'Wilson', '+79123456784'),
('Eva', 'Martinez', '+79123456785'),
('Frank', 'Taylor', '+79123456786');

-- Вставка данных в таблицу "country"
INSERT INTO country (country_name)
VALUES
('Russia'),
('USA'),
('Germany'),
('France'),
('Japan'),
('Canada');

-- Вставка данных в таблицу "city"
INSERT INTO city (city_name, country_id)
VALUES
('Moscow', (SELECT country_id FROM country WHERE country_name = 'Russia')),
('New York', (SELECT country_id FROM country WHERE country_name = 'USA')),
('Berlin', (SELECT country_id FROM country WHERE country_name = 'Germany')),
('Paris', (SELECT country_id FROM country WHERE country_name = 'France')),
('Tokyo', (SELECT country_id FROM country WHERE country_name = 'Japan')),
('Tokyo', (SELECT country_id FROM country WHERE country_name = 'Canada')),
('Toronto', (SELECT country_id FROM country WHERE country_name = 'Canada'));

-- Вставка данных в таблицу "street"
INSERT INTO street (street_name, city_id)
VALUES
('Lenin St', (SELECT city_id FROM city WHERE city_name = 'Moscow' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Russia'))),
('Broadway', (SELECT city_id FROM city WHERE city_name = 'New York' AND country_id = (SELECT country_id FROM country WHERE country_name = 'USA'))),
('Unter den Linden', (SELECT city_id FROM city WHERE city_name = 'Berlin' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Germany'))),
('Champs-Élysées', (SELECT city_id FROM city WHERE city_name = 'Paris' AND country_id = (SELECT country_id FROM country WHERE country_name = 'France'))),
('Ginza', (SELECT city_id FROM city WHERE city_name = 'Tokyo' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Japan'))),
('Yonge St', (SELECT city_id FROM city WHERE city_name = 'Toronto' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Canada'))),
('Tverskaya St', (SELECT city_id FROM city WHERE city_name = 'Moscow' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Russia'))),
('5th Avenue', (SELECT city_id FROM city WHERE city_name = 'New York' AND country_id = (SELECT country_id FROM country WHERE country_name = 'USA'))),
('Kurfürstendamm', (SELECT city_id FROM city WHERE city_name = 'Berlin' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Germany'))),
('Rue de Rivoli', (SELECT city_id FROM city WHERE city_name = 'Paris' AND country_id = (SELECT country_id FROM country WHERE country_name = 'France'))),
('Shibuya', (SELECT city_id FROM city WHERE city_name = 'Tokyo' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Japan'))),
('Bloor St', (SELECT city_id FROM city WHERE city_name = 'Toronto' AND country_id = (SELECT country_id FROM country WHERE country_name = 'Canada')));

-- Вставка данных в таблицу "fabric"
INSERT INTO fabric (owner_id, fabric_name, area, year_opened, street_id)
VALUES
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'John' AND last_name = 'Doe'),
    'Fabric A',
    1000,
    2020,
    (SELECT street_id FROM street WHERE street_name = 'Lenin St')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'Jane' AND last_name = 'Smith'),
    'Fabric B',
    200,
    2019,
    (SELECT street_id FROM street WHERE street_name = 'Broadway')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'David' AND last_name = 'Wilson'),
    'Fabric C',
    150,
    2021,
    (SELECT street_id FROM street WHERE street_name = 'Unter den Linden')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'Bob' AND last_name = 'Brown'),
    'Fabric D',
    300,
    1990,
    (SELECT street_id FROM street WHERE street_name = 'Champs-Élysées')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'David' AND last_name = 'Wilson'),
    'Fabric E',
    250,
    2022,
    (SELECT street_id FROM street WHERE street_name = 'Ginza')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'David' AND last_name = 'Wilson'),
    'Fabric F',
    220,
    2023,
    (SELECT street_id FROM street WHERE street_name = 'Yonge St')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'Eva' AND last_name = 'Martinez'),
    'Fabric G',
    180,
    2007,
    (SELECT street_id FROM street WHERE street_name = 'Lenin St')
),
(
    (SELECT owner_id FROM "owner" WHERE first_name = 'Frank' AND last_name = 'Taylor'),
    'Fabric H',
    280,
    2025,
    (SELECT street_id FROM street WHERE street_name = '5th Avenue')
);

-- Вставка данных в таблицу "ingredient"
INSERT INTO ingredient (name)
VALUES
('Шоколадная мука'),
('Сахарный песок'),
('Яйцо дракона'),
('Молоко феи'),
('Сливочное масло эльфа'),
('Шоколадные бобы'),
('Ванильный экстракт'),
('Солнечная соль'),
('Кофе волшебника'),
('Чай фей');

-- Вставка данных в таблицу "storage"
INSERT INTO storage (fabric_id, storage_name, street_id)
VALUES
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric A'),
    'Storage A',
    (SELECT street_id FROM street WHERE street_name = 'Lenin St')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric B'),
    'Storage B',
    (SELECT street_id FROM street WHERE street_name = 'Broadway')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric C'),
    'Storage C',
    (SELECT street_id FROM street WHERE street_name = 'Unter den Linden')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric D'),
    'Storage D',
    (SELECT street_id FROM street WHERE street_name = 'Champs-Élysées')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric E'),
    'Storage E',
    (SELECT street_id FROM street WHERE street_name = 'Ginza')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric F'),
    'Storage F',
    (SELECT street_id FROM street WHERE street_name = 'Yonge St')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric A'),
    'Storage G',
    (SELECT street_id FROM street WHERE street_name = 'Tverskaya St')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric H'),
    'Storage H',
    (SELECT street_id FROM street WHERE street_name = '5th Avenue')
);

-- Вставка данных в таблицу "storage_ingredient"
INSERT INTO storage_ingredient (ingredient_id, storage_id)
VALUES
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадная мука'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage A')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадная мука'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage B')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Солнечная соль'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage C')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Кофе волшебника'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage D')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Ванильный экстракт'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage E')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Молоко феи'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage F')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Ванильный экстракт'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage G')
),
(
    (SELECT ingredient_id FROM ingredient WHERE name = 'Яйцо дракона'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage H')
);

-- Вставка данных в таблицу "producer"
INSERT INTO producer (producer_name, inn, phone_number, email, street_id)
VALUES
('Producer‘s name', '1234567890', '+72623456784', 'producerA@example.com', (SELECT street_id FROM street WHERE street_name = 'Lenin St')),
('Producer B Шоколадные бобы', '0987654321', '+79123456785', 'producerB@example.com', (SELECT street_id FROM street WHERE street_name = 'Broadway')),
('Producer C', '1111111111', '+79123456786', 'producerC@example.com', (SELECT street_id FROM street WHERE street_name = 'Unter den Linden')),
('Producer D', '2222222222', '+79123456787', 'producerD@example.com', (SELECT street_id FROM street WHERE street_name = 'Champs-Élysées')),
('Producer‘s name2', '3333333333', '+72323456788', 'producerE@example.com', (SELECT street_id FROM street WHERE street_name = 'Ginza')),
('Producer F', '4444444444', '+79123456789', 'producerF@example.com', (SELECT street_id FROM street WHERE street_name = 'Yonge St')),
('Producer‘s name3', '5555555555', '+79123456790', 'producerG@example.com', (SELECT street_id FROM street WHERE street_name = 'Tverskaya St')),
('Producer H', '6666666666', '+79123456791', 'producerH@example.com', (SELECT street_id FROM street WHERE street_name = '5th Avenue'));

-- Вставка данных в таблицу "deliveryType"
INSERT INTO deliveryType (name)
VALUES
('delivery point'),
('at home');

-- Вставка данных в таблицу "order"
INSERT INTO "order" (producer_id, storage_id, type_id, order_date, order_cost)
VALUES
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage A'),
    (SELECT type_id FROM deliveryType WHERE name = 'delivery point'),
    '2023-01-01',
    1000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage B'),
    (SELECT type_id FROM deliveryType WHERE name = 'delivery point'),
    '2023-01-01',
    1000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage C'),
    (SELECT type_id FROM deliveryType WHERE name = 'delivery point'),
    '2024-01-01',
    1000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage D'),
    (SELECT type_id FROM deliveryType WHERE name = 'delivery point'),
    '2024-01-01',
    1000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer B Шоколадные бобы'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage G'),
    (SELECT type_id FROM deliveryType WHERE name = 'delivery point'),
    '2024-01-02',
    1500
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer C'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage C'),
    (SELECT type_id FROM deliveryType WHERE name = 'at home'),
    '2024-01-03',
    2000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer B Шоколадные бобы'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage C'),
    NULL,
    '2024-01-04',
    2500
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage E'),
    NULL,
    '2024-01-05',
    3000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage F'),
    NULL,
    '2024-01-06',
    3500
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name3'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage G'),
    NULL,
    '2024-01-07',
    4000
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer H'),
    (SELECT storage_id FROM storage WHERE storage_name = 'Storage H'),
    NULL,
    '2024-01-08',
    4500
);

-- Вставка данных в таблицу "order_ing"
INSERT INTO order_ing (order_id, ingredient_id)
VALUES
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage A')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадная мука')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage B')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Сахарный песок')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage C')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Яйцо дракона')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage D')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Молоко феи')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer B Шоколадные бобы') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage G')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадные бобы')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer C') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage C')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Ванильный экстракт')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer B Шоколадные бобы') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage C')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Солнечная соль')
),
(
    (SELECT order_id FROM "order" WHERE producer_id = (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name') AND storage_id = (SELECT storage_id FROM storage WHERE storage_name = 'Storage F')),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Кофе волшебника')
);

-- Вставка данных в таблицу "workshop"
INSERT INTO workshop (fabric_id, temperature, workshop_name, street_id)
VALUES
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric A'),
    25,
    'Workshop A',
    (SELECT street_id FROM street WHERE street_name = 'Lenin St')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric A'),
    22,
    'Workshop B',
    (SELECT street_id FROM street WHERE street_name = 'Broadway')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric E'),
    28,
    'Workshop C',
    (SELECT street_id FROM street WHERE street_name = 'Unter den Linden')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric A'),
    24,
    'Workshop D',
    (SELECT street_id FROM street WHERE street_name = 'Champs-Élysées')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric E'),
    26,
    'Workshop E',
    (SELECT street_id FROM street WHERE street_name = 'Ginza')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric F'),
    23,
    'Workshop F',
    (SELECT street_id FROM street WHERE street_name = 'Yonge St')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric G'),
    27,
    'Workshop G',
    (SELECT street_id FROM street WHERE street_name = 'Tverskaya St')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric G'),
    29,
    'Workshop H',
    (SELECT street_id FROM street WHERE street_name = '5th Avenue')
),
(
    (SELECT fabric_id FROM fabric WHERE fabric_name = 'Fabric G'),
    30,
    'Workshop Z',
    (SELECT street_id FROM street WHERE street_name = 'Yonge St')
);

-- Вставка данных в таблицу "comment"
INSERT INTO "comment" (workshop_id, comment_text, comment_date)
VALUES
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop A'),
    'Great_workshop%-!',
    '2024-01-01'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop A'),
    'Very_good_experience%-.',
    '2024-01-02'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop C'),
    'Excellent service.',
    '2024-01-03'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop C'),
    'Highly recommended.',
    '2024-01-04'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop C'),
    'Fantastic!',
    '2024-01-05'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop F'),
    'Amazing!',
    '2024-01-06'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop G'),
    'Best ever.',
    '2024-01-07'
),
(
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop H'),
    'Incredible.',
    '2024-01-08'
);

-- Вставка данных в таблицу "product_type"
INSERT INTO product_type (parent_id, type_name)
VALUES
(
    NULL,  -- Родительский тип отсутствует (корневой тип)
    'Шоколад'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад'),  -- Родительский тип - Шоколад
    'Молочный шоколад'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад'),  -- Родительский тип - Шоколад
    'Темный шоколад'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Молочный шоколад'),  -- Родительский тип - Молочный шоколад
    'Шоколад с орехами'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Молочный шоколад'),  -- Родительский тип - Молочный шоколад
    'Шоколад с карамелью'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Темный шоколад'),  -- Родительский тип - Темный шоколад
    'Шоколад с кофе'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Темный шоколад'),  -- Родительский тип - Темный шоколад
    'Шоколад с цитрусом'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад'),  -- Родительский тип - Шоколад
    'Белоснежный шоколад'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Белоснежный шоколад'),  -- Родительский тип - Белоснежный шоколад
    'Шоколад с клубникой'
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Белоснежный шоколад'),  -- Родительский тип - Белоснежный шоколад
    'Шоколад с бергамотом'
);

INSERT INTO measure (measure_name)
VALUES ('kg'),
       ('liter'),
       ('piece'),
       ('gramm');

-- Вставка данных в таблицу "product"
INSERT INTO product (type_id, product_name, price, measure_id)
VALUES
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с орехами'),
    'Шоколад с орехами 1',
    100,
    (SELECT measure_id FROM measure WHERE measure_name = 'liter')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с орехами'),
    'Шоколад с орехами 1',
    199,
    (SELECT measure_id FROM measure WHERE measure_name = 'kg')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с орехами'),
    'Шоколад с орехами 2',
    100,
    (SELECT measure_id FROM measure WHERE measure_name = 'gramm')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с карамелью'),
    'Шоколад с карамелью 1',
    200,
    (SELECT measure_id FROM measure WHERE measure_name = 'kg')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с карамелью'),
    'Шоколад с карамелью 2',
    250,
    (SELECT measure_id FROM measure WHERE measure_name = 'piece')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с кофе'),
    'Шоколад с кофе 1',
    300,
    (SELECT measure_id FROM measure WHERE measure_name = 'gramm')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с кофе'),
    'Шоколад с кофе 2',
    350,
    (SELECT measure_id FROM measure WHERE measure_name = 'piece')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с цитрусом'),
    'Шоколад с цитрусом 1',
    400,
    (SELECT measure_id FROM measure WHERE measure_name = 'piece')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с цитрусом'),
    'Шоколад с цитрусом 2',
    450,
    (SELECT measure_id FROM measure WHERE measure_name = 'gramm')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с клубникой'),
    'Шоколад с клубникой 1',
    500,
    (SELECT measure_id FROM measure WHERE measure_name = 'kg')
),
(
    (SELECT type_id FROM product_type WHERE type_name = 'Шоколад с клубникой'),
    'Шоколад с клубникой 2',
    550,
    (SELECT measure_id FROM measure WHERE measure_name = 'kg')
);

-- Вставка данных в таблицу "workshop_product"
INSERT INTO workshop_product (product_id, workshop_id, production_start, production_end)
VALUES
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с орехами 1' AND price = 100),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop A'),
    '2024-01-01',
    '2024-01-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с карамелью 1'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop A'),
    '2024-02-01',
    '2024-02-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с кофе 1'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop C'),
    '2024-03-01',
    '2024-03-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с цитрусом 1'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop D'),
    '2024-04-01',
    '2024-04-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с клубникой 1'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop E'),
    '2024-05-01',
    '2024-05-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с орехами 2'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop F'),
    '2024-06-01',
    '2024-06-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с карамелью 2'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop G'),
    '2024-07-01',
    '2024-07-01'
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с цитрусом 2'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop H'),
    '2024-08-01',
    '2024-08-01'
);
-- Вставка данных в таблицу "position"
INSERT INTO position (position_name)
VALUES
('Manager'),
('Chef'),
('Baker'),
('Waiter'),
('Cashier'),
('Cleaner'),
('Delivery Person'),
('Barista');

-- Вставка данных в таблицу "workshop_position"
INSERT INTO workshop_position (position_id, workshop_id, salary)
VALUES
(
    (SELECT position_id FROM "position" WHERE position_name = 'Manager'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop A'),
    50000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Chef'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop B'),
    60000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Baker'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop C'),
    40000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Delivery Person'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop D'),
    30000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Cashier'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop E'),
    35000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Cleaner'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop F'),
    30000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Delivery Person'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop G'),
    35000
),
(
    (SELECT position_id FROM "position" WHERE position_name = 'Delivery Person'),
    (SELECT workshop_id FROM workshop WHERE workshop_name = 'Workshop H'),
    30000
);

-- Вставка данных в таблицу "client"
INSERT INTO client (email, phone_number)
VALUES
('client1@example.com', '+79123456789'),
('client2@example.com', '+79123456780'),
('client3@example.com', '+79123456781'),
('client4@example.com', '+79123456782'),
('client5@example.com', '+79123456783'),
('client6@example.com', '+79123456784'),
('client7@example.com', '+79123456785'),
('client8@example.com', '+79123456786');

-- Вставка данных в таблицу "client_order"
INSERT INTO client_order (client_id, acceptance_date, completion_date)
VALUES
(
    (SELECT client_id FROM client WHERE email = 'client1@example.com'),
    '2024-01-02',
    '2024-02-05'
),
(
    (SELECT client_id FROM client WHERE email = 'client2@example.com'),
    '2024-01-03',
    '2024-02-06'
),
(
    (SELECT client_id FROM client WHERE email = 'client3@example.com'),
    '2024-01-04',
    '2024-01-07'
),
(
    (SELECT client_id FROM client WHERE email = 'client4@example.com'),
    '2024-01-05',
    '2024-01-08'
),
(
    (SELECT client_id FROM client WHERE email = 'client5@example.com'),
    '2024-11-01',
    '2024-11-02'
),
(
    (SELECT client_id FROM client WHERE email = 'client6@example.com'),
    '2024-01-07',
    '2024-01-10'
),
(
    (SELECT client_id FROM client WHERE email = 'client7@example.com'),
    '2024-01-08',
    '2024-01-11'
),
(
    (SELECT client_id FROM client WHERE email = 'client8@example.com'),
    '2024-01-09',
    '2024-01-12'
),
(
    (SELECT client_id FROM client WHERE email = 'client8@example.com'),
    '2024-12-01',
    '2024-12-11'
);

-- Вставка данных в таблицу "client_order_product"
INSERT INTO client_order_product (product_id, order_id, count)
VALUES
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с орехами 1' AND price = 100),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    3
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с орехами 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    1
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с карамелью 1'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    5
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с карамелью 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    7
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с кофе 1'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    1
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с кофе 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    2
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с цитрусом 1'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    9
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с цитрусом 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client1@example.com')),
    3
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с орехами 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client3@example.com')),
    21
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с кофе 1'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client4@example.com')),
    100
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с клубникой 1'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client5@example.com')),
    3
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с орехами 1' AND price = 199),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client6@example.com')),
    31
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с карамелью 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client7@example.com')),
    28
),
(
    (SELECT product_id FROM product WHERE product_name = 'Шоколад с цитрусом 2'),
    (SELECT order_id FROM client_order WHERE client_id = (SELECT client_id FROM client WHERE email = 'client8@example.com')AND acceptance_date= '2024-12-01'),
    15
);

-- Вставка данных в таблицу "week_day"
INSERT INTO week_day (week_day_name)
VALUES
('Monday'),
('Tuesday'),
('Wednesday'),
('Thursday'),
('Friday'),
('Saturday'),
('Sunday');

-- Вставка данных в таблицу "time_table"
INSERT INTO time_table (day_id, start_time, end_time)
VALUES
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Monday'),
    '08:00:00',
    '17:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Tuesday'),
    '09:00:00',
    '18:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Wednesday'),
    '10:00:00',
    '19:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Thursday'),
    '11:00:00',
    '20:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Friday'),
    '12:00:00',
    '21:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Saturday'),
    '13:00:00',
    '22:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Sunday'),
    '14:00:00',
    '23:00:00'
),
(
    (SELECT day_id FROM week_day WHERE week_day_name = 'Monday'),
    '15:00:00',
    '23:59:00'
);

-- Вставка данных в таблицу "delivery_place"
INSERT INTO delivery_place (schedule_id)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- Вставка данных в таблицу "client_delivery_place"
INSERT INTO client_delivery_place (client_id, place_id)
VALUES
(
    (SELECT client_id FROM client WHERE email = 'client1@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 1)
),
(
    (SELECT client_id FROM client WHERE email = 'client2@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 2)
),
(
    (SELECT client_id FROM client WHERE email = 'client3@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 3)
),
(
    (SELECT client_id FROM client WHERE email = 'client4@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 4)
),
(
    (SELECT client_id FROM client WHERE email = 'client5@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 5)
),
(
    (SELECT client_id FROM client WHERE email = 'client6@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 6)
),
(
    (SELECT client_id FROM client WHERE email = 'client7@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 7)
),
(
    (SELECT client_id FROM client WHERE email = 'client8@example.com'),
    (SELECT place_id FROM delivery_place WHERE schedule_id = 8)
);

-- Вставка данных в таблицу "producer_ing_cost"
INSERT INTO producer_ing_cost (producer_id, ingredient_id, current_cost)
VALUES
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадная мука'),
    50
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer C'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадная мука'),
    60
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer B Шоколадные бобы'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Сахарный песок'),
    30
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer C'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Яйцо дракона'),
    20
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer D'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Молоко феи'),
    40
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name2'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Сливочное масло эльфа'),
    60
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer F'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Шоколадные бобы'),
    70
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name3'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Ванильный экстракт'),
    55
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer H'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Солнечная соль'),
    45
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer‘s name'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Кофе волшебника'),
    50
),
(
    (SELECT producer_id FROM producer WHERE producer_name = 'Producer B Шоколадные бобы'),
    (SELECT ingredient_id FROM ingredient WHERE name = 'Чай фей'),
    30
);