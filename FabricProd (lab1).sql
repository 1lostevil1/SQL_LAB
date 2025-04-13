
DROP TABLE IF EXISTS client_delivery_place;
DROP TABLE IF EXISTS client_order_product;
DROP TABLE IF EXISTS client_order;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS delivery_place;
DROP TABLE IF EXISTS time_table;
DROP TABLE IF EXISTS week_day;
DROP TABLE IF EXISTS order_ing;
DROP TABLE IF EXISTS producer_ing_cost;
DROP TABLE IF EXISTS workshop_position;
DROP TABLE IF EXISTS workshop_equipment;
DROP TABLE IF EXISTS workshop_product;
DROP TABLE IF EXISTS "comment";
DROP TABLE IF EXISTS workshop;
DROP TABLE IF EXISTS measure CASCADE;
DROP TABLE IF EXISTS product_type CASCADE;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS "position";
DROP TABLE IF EXISTS "order";
DROP TABLE IF EXISTS deliveryType;
DROP TABLE IF EXISTS producer;


--


DROP TABLE IF EXISTS storage_ingredient;
DROP TABLE IF EXISTS "storage";
DROP TABLE IF EXISTS fabric;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS "owner";
DROP TABLE IF EXISTS street;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;

CREATE TABLE "owner" (
    owner_id SERIAL NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    PRIMARY KEY (owner_id)
);

CREATE TABLE country (
    country_id SERIAL NOT NULL,
    country_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (country_id)
);

CREATE TABLE city (
    city_id SERIAL,
    city_name VARCHAR(100) NOT NULL,
    country_id INTEGER NOT NULL,
    PRIMARY KEY (city_id)
);

CREATE TABLE street (
    street_id SERIAL,
    street_name VARCHAR(100) NOT NULL,
    city_id INTEGER NOT NULL,
    PRIMARY KEY (street_id)
);

CREATE TABLE fabric (
    fabric_id SERIAL NOT NULL,
    owner_id INTEGER NOT NULL,
    fabric_name VARCHAR(100) NOT NULL,
    area SMALLINT NOT NULL,
    year_opened SMALLINT NOT NULL,
    street_id INTEGER NOT NULL,
    PRIMARY KEY (fabric_id)
);

CREATE TABLE "storage" (
    storage_id SERIAL NOT NULL,
    fabric_id INTEGER NOT NULL,
    storage_name VARCHAR(100) NOT NULL,
    street_id INTEGER NOT NULL,
    PRIMARY KEY (storage_id)
);

CREATE TABLE ingredient (
    ingredient_id SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (ingredient_id)
);

CREATE TABLE storage_ingredient (
    ingredient_id INTEGER NOT NULL,
    storage_id INTEGER NOT NULL,
    PRIMARY KEY (ingredient_id, storage_id)
);

CREATE TABLE producer (
    producer_id SERIAL NOT NULL,
    producer_name VARCHAR(100) NOT NULL,
    inn CHAR(10) NOT NULL,
    phone_number VARCHAR(13) NOT NULL,
    email VARCHAR(100) NOT NULL,
    street_id INTEGER NOT NULL,
    PRIMARY KEY (producer_id)
);

CREATE TABLE "order" (
    order_id SERIAL NOT NULL,
    producer_id INTEGER NOT NULL,
    storage_id INTEGER NOT NULL,
    type_id INTEGER,
    order_date DATE NOT NULL,
    order_cost INTEGER NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_ing (
    order_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    PRIMARY KEY (order_id, ingredient_id)
);

CREATE TABLE deliveryType (
    type_id SERIAL NOT NULL,
    name VARCHAR(20),
    PRIMARY KEY (type_id)
);

CREATE TABLE workshop (
    workshop_id SERIAL NOT NULL,
    fabric_id INTEGER NOT NULL,
    temperature INTEGER NOT NULL,
    workshop_name VARCHAR(100) NOT NULL,
    street_id INTEGER NOT NULL,
    PRIMARY KEY (workshop_id)
);

CREATE TABLE "comment" (
    comment_id SERIAL,
    workshop_id INTEGER,
    comment_text TEXT NOT NULL,
    comment_date DATE NOT NULL,
    PRIMARY KEY (comment_id)
);

CREATE TABLE product (
    product_id SERIAL NOT NULL,
    type_id INTEGER NOT NULL,
    measure_id INTEGER NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    price INTEGER NOT NULL,
    PRIMARY KEY (product_id)
);

CREATE TABLE workshop_product (
    product_id INTEGER NOT NULL,
    workshop_id INTEGER NOT NULL,
    production_start DATE NOT NULL,
    production_end DATE NOT NULL,
    PRIMARY KEY (product_id, workshop_id)
);

CREATE TABLE equipment (
    equipment_id SERIAL NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (equipment_id)
);

CREATE TABLE workshop_equipment (
    workshop_id INTEGER NOT NULL,
    equipment_id INTEGER NOT NULL,
    PRIMARY KEY (workshop_id, equipment_id)
);

CREATE TABLE "position" (
    position_id SERIAL NOT NULL,
    position_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (position_id)
);

CREATE TABLE workshop_position (
    position_id INTEGER NOT NULL,
    workshop_id INTEGER NOT NULL,
    salary INTEGER NOT NULL,
    PRIMARY KEY (position_id, workshop_id)
);

CREATE TABLE product_type (
    type_id SERIAL NOT NULL,
    parent_id INTEGER,
    type_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (type_id)
);

CREATE TABLE measure (
    measure_id SERIAL NOT NULL,
    measure_name VARCHAR(10) NOT NULL,
    PRIMARY KEY (measure_id)
);

CREATE TABLE client (
    client_id SERIAL NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(12) NOT NULL,
    PRIMARY KEY (client_id)
);

CREATE TABLE client_order (
    order_id SERIAL NOT NULL,
    client_id SERIAL NOT NULL,
    acceptance_date DATE NOT NULL,
    completion_date DATE NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE client_order_product (
    product_id SERIAL NOT NULL,
    order_id SERIAL NOT NULL,
    count INTEGER NOT NULL,
    PRIMARY KEY (product_id, order_id)
);

CREATE TABLE delivery_place (
    place_id SERIAL NOT NULL,
    schedule_id INTEGER NOT NULL,
    PRIMARY KEY (place_id)
);

CREATE TABLE week_day (
    day_id SERIAL NOT NULL,
    week_day_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (day_id)
);

CREATE TABLE time_table (
    schedule_id SERIAL NOT NULL,
    day_id INTEGER NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    PRIMARY KEY (schedule_id)
);

CREATE TABLE client_delivery_place (
    client_id SERIAL NOT NULL,
    place_id SERIAL NOT NULL,
    PRIMARY KEY (client_id, place_id)
);

CREATE TABLE producer_ing_cost (
    producer_id SERIAL NOT NULL,
    ingredient_id SERIAL NOT NULL,
    current_cost INTEGER NOT NULL,
    PRIMARY KEY (producer_id, ingredient_id)
);

-- Добавление ограничений CHECK

ALTER TABLE "owner"
ADD CONSTRAINT check_phone1 CHECK(phone_number ~ '^\+7[0-9]{10}$');

ALTER TABLE client
ADD CONSTRAINT check_phone2 CHECK(phone_number ~ '^\+7[0-9]{10}$');

ALTER TABLE fabric
ADD CONSTRAINT check_area CHECK (area > 0),
ADD CONSTRAINT check_year_opened CHECK (year_opened > 0);

ALTER TABLE producer
ADD CONSTRAINT check_phone3 CHECK(phone_number ~ '^\+7[0-9]{10}$');

ALTER TABLE "order"
ADD CONSTRAINT check_cost CHECK (order_cost >= 0);

ALTER TABLE client_order
ADD CONSTRAINT check_order_time CHECK (acceptance_date <= completion_date);

ALTER TABLE workshop_position
ADD CONSTRAINT check_salary CHECK (salary >= 0);

ALTER TABLE time_table
ADD CONSTRAINT check_work_time CHECK (start_time < end_time);

ALTER TABLE producer_ing_cost
ADD CONSTRAINT check_cost2 CHECK (current_cost >= 0);

-- Добавление внешних ключей
ALTER TABLE fabric
ADD CONSTRAINT fk_fabric_owner FOREIGN KEY (owner_id) REFERENCES owner(owner_id);

ALTER TABLE fabric
ADD CONSTRAINT fk_fabric_street FOREIGN KEY (street_id) REFERENCES street(street_id);

ALTER TABLE street
ADD CONSTRAINT fk_street_city FOREIGN KEY (city_id) REFERENCES city(city_id);

ALTER TABLE city
ADD CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country(country_id);

ALTER TABLE "order"
ADD CONSTRAINT fk_order_type FOREIGN KEY (type_id) REFERENCES deliveryType(type_id);

ALTER TABLE order_ing
ADD CONSTRAINT fk_order_ing FOREIGN KEY (order_id) REFERENCES "order"(order_id);

ALTER TABLE order_ing
ADD CONSTRAINT fk_order_ing2 FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id);

ALTER TABLE time_table
ADD CONSTRAINT fk_table_day FOREIGN KEY (day_id) REFERENCES week_day(day_id);

ALTER TABLE storage
ADD CONSTRAINT fk_storage_fabric FOREIGN KEY (fabric_id) REFERENCES fabric(fabric_id);

ALTER TABLE storage
ADD CONSTRAINT fk_storage_street FOREIGN KEY (street_id) REFERENCES street(street_id);

ALTER TABLE product
ADD CONSTRAINT fk_product_product FOREIGN KEY (type_id) REFERENCES product_type(type_id);

ALTER TABLE product
ADD CONSTRAINT fk_product_measure FOREIGN KEY (measure_id) REFERENCES measure(measure_id);

ALTER TABLE "comment"
ADD CONSTRAINT fk_comment_workshop FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id);

ALTER TABLE product_type
ADD CONSTRAINT fk_product_type_product_type FOREIGN KEY (parent_id) REFERENCES product_type(type_id);

ALTER TABLE storage_ingredient
ADD CONSTRAINT fk_storage_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id),
ADD CONSTRAINT fk_storage_ingredient_storage FOREIGN KEY (storage_id) REFERENCES storage(storage_id);

ALTER TABLE "order"
ADD CONSTRAINT fk_order_producer FOREIGN KEY (producer_id) REFERENCES producer(producer_id),
ADD CONSTRAINT fk_order_storage FOREIGN KEY (storage_id) REFERENCES storage(storage_id);

ALTER TABLE workshop
ADD CONSTRAINT fk_workshop_fabric FOREIGN KEY (fabric_id) REFERENCES fabric(fabric_id);

ALTER TABLE workshop
ADD CONSTRAINT fk_workshop_street FOREIGN KEY (street_id) REFERENCES street(street_id);

ALTER TABLE workshop_product
ADD CONSTRAINT fk_workshop_product_product FOREIGN KEY (product_id) REFERENCES product(product_id),
ADD CONSTRAINT fk_workshop_product_workshop FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id);

ALTER TABLE workshop_equipment
ADD CONSTRAINT fk_workshop_equipment_workshop FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id),
ADD CONSTRAINT fk_workshop_equipment_equipment FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id);

ALTER TABLE workshop_position
ADD CONSTRAINT fk_workshop_position_employee FOREIGN KEY (position_id) REFERENCES "position"(position_id),
ADD CONSTRAINT fk_workshop_employee_workshop FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id);

ALTER TABLE client_order
ADD CONSTRAINT fk_client_order_client FOREIGN KEY (client_id) REFERENCES client(client_id);

ALTER TABLE client_order_product
ADD CONSTRAINT fk_client_order_product FOREIGN KEY (product_id) REFERENCES product(product_id),
ADD CONSTRAINT fk_client_order_product_order FOREIGN KEY (order_id) REFERENCES client_order(order_id);

ALTER TABLE delivery_place
ADD CONSTRAINT fk_delivery_place_table FOREIGN KEY (schedule_id) REFERENCES time_table(schedule_id);

ALTER TABLE client_delivery_place
ADD CONSTRAINT fk_client_delivery_place_client FOREIGN KEY (client_id) REFERENCES client(client_id),
ADD CONSTRAINT fk_client_delivery_place_place FOREIGN KEY (place_id) REFERENCES delivery_place(place_id);

ALTER TABLE producer_ing_cost
ADD CONSTRAINT fk_producer_ing_cost_producer FOREIGN KEY (producer_id) REFERENCES producer(producer_id),
ADD CONSTRAINT fk_producer_ing_cost_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id);

ALTER TABLE producer
ADD CONSTRAINT fk_producer_street FOREIGN KEY (street_id) REFERENCES street(street_id);
