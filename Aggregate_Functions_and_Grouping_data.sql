-- Create products_inventory table with PK which is autoincremented and the following structure (all fields are mandatory)

CREATE TABLE products_inventory (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR (255) NOT NULL,
available_quantity INT NOT NULL,
product_type VARCHAR (255) NOT NULL,
price_no_VAT DECIMAL NOT NULL,
price_VAT_added DECIMAL NOT NULL,
is_product_in_stock BOOLEAN NOT NULL,
warehouse_name VARCHAR NOT NULL
);

-- Inserting data to the products_inventory table

INSERT INTO products_inventory 
VALUES (1, 'bread', 50, 'food', 1.5,  1.8, TRUE, 'Sofia'),
	(2, 'chocolate', 150, 'food', 2,  2.12, TRUE, 'Sliven'),
	(3, 'milk', 37, 'food', 2.2,  2.64, TRUE, 'Karlovo'),
	(4, 'fish', 12, 'food', 5.2,  6.24, TRUE, 'Burgas'),
	(5, 'fish', 0, 'food', 5.2,  6.24, FALSE, 'Varna'),
	(6, 'cheese', 84, 'food', 9.8,  11.76, TRUE, 'Burgas'),
	(7, 'cheese', 0, 'food', 9.8,  11.76, FALSE, 'Velingrad'),
	(8, 'whater', 135, 'drink', 1,  1.25, TRUE, 'Devin'),
	(9, 'whater', 150, 'drink', 1.2,  1.44, TRUE, 'Velingrad'),
	(10, 'Marble Land', 49, 'wine', 27,  32.40, TRUE, 'Ivailovgrad'),
	(11, 'Vino Reserve Ivaylovgrad', 49, 'wine', 18,  21.60, TRUE, 'Ivailovgrad'),
	(12, 'Merlot Grand Reserve', 62, 'wine', 15,  18, TRUE, 'Ivailovgrad'),
	(13, 'Villa Armira Merlot', 59, 'wine', 7,  8.40, TRUE, 'Ivailovgrad'),
	(14, 'Roses Yamantievs', 0, 'wine', 12,  14.40, FALSE, 'Sofia'),
	(15, 'Roses Yamantievs', 89, 'wine', 12,  14.40, TRUE, 'Ivailovgrad'),
	(16, 'fresh orange', 3, 'drink', 5.2,  6.24, TRUE, 'Sofia'),
	(17, 'apple', 67, 'fruit', 2.3,  2.76, TRUE, 'Karlovo'),
	(18, 'strawberries', 0, 'fruit', 5.2,  6.24, FALSE, 'Sofia'),
	(19, 'strawberries', 65, 'fruit', 5.2,  6.24, TRUE, 'Ivailovgrad'),
	(20, 'banana', 0, 'fruit', 5.2,  6.24, FALSE, 'Vidin');
	
-- Get the count of all available products in stock

SELECT COUNT (product_name)
FROM products_inventory 
WHERE is_product_in_stock = TRUE;

-- Get the average product price with VAT for all categories

SELECT AVG(price_VAT_added)
FROM products_inventory;

-- Get the total amount of all available items in stock (use price with VAT and available qty.)

SELECT SUM (price_VAT_added)
FROM products_inventory 
WHERE is_product_in_stock = TRUE;

-- Find the most and least expensive item from the table (VAT added)

SELECT MAX(price_no_VAT)
FROM products_inventory;

SELECT MIN(price_no_VAT)
FROM products_inventory;

-- Find the most and least expensive item from the table (no VAT added)

SELECT MAX(price_VAT_added)
FROM products_inventory;

SELECT MIN(price_VAT_added)
FROM products_inventory;

-- Find the most expensive item in each warehouse

SELECT MAX(price_VAT_added),warehouse_name
FROM products_inventory
GROUP BY warehouse_name;

-- Get the count of all products for each category
SELECT COUNT(product_name),product_type
FROM products_inventory
GROUP BY product_type;

-- Get the count of all products for each category in stock
SELECT COUNT(product_name),product_type
FROM products_inventory
WHERE is_product_in_stock = TRUE
GROUP BY product_type;

-- Get the count of all products for each category out of stock
SELECT COUNT(product_name),product_type
FROM products_inventory
WHERE is_product_in_stock = FALSE
GROUP BY product_type;

-- Get the count of all products for each category where the products count is more than 3
SELECT COUNT(product_name),product_type
FROM products_inventory
GROUP BY product_type
HAVING COUNT(product_name)>3;

-- Get the inventory amount for each warehouse

-- amount with VAT
SELECT SUM(price_VAT_added),warehouse_name 
FROM products_inventory
WHERE is_product_in_stock = TRUE
GROUP BY warehouse_name;

-- amount without VAT
SELECT SUM(price_no_VAT),warehouse_name 
FROM products_inventory
WHERE is_product_in_stock = TRUE
GROUP BY warehouse_name;

-- Get all product categories stored by each warehouse
SELECT warehouse_name,product_type
FROM products_inventory
GROUP BY warehouse_name,product_type
ORDER BY warehouse_name;

-- Get the average product categories hold by the warehouses
SELECT warehouse_name ,AVG(DISTINCT available_quantity) AS average_product_category 
FROM products_inventory 
GROUP BY warehouse_name;
