Practice joins

(1)
    SELECT FROM invoice i JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

(2)
    SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i JOIN customer c ON i.customer_id = c.customer_id;

(3)
    SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c JOIN employee e ON c.support_rep_id = e.employee_id;

(4)
    SELECT al.title, ar.name
FROM album al JOIN artist ar ON al.artist_id = ar.artist_id

(5)
    SELECT pt.track_id 
FROM playlist_track pt JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

(6)
    SELECT t.name
FROM track t JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

(7)
    SELECT t.name, p.name
FROM track t JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

(8)
    SELECT t.name, a.title
FROM track t JOIN album a ON t.album_id = a.album_id JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

Practice nested queries
(1)
    SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 );

(2)
   SELECT *
FROM playlist_track
WHERE playlist_id IN ( SELECT playlist_id FROM playlist WHERE name = 'Music' ); 

(3)
    SELECT name
FROM track
WHERE track_id IN ( SELECT track_id FROM playlist_track WHERE playlist_id = 5 );

(4)
    SELECT *
FROM track
WHERE genre_id IN ( SELECT genre_id FROM genre WHERE name = 'Comedy' );

(5)
    SELECT *
FROM track
WHERE album_id IN ( SELECT album_id FROM album WHERE title = 'Fireball' );

(6)
    SELECT *
FROM track
WHERE album_id IN ( 
SELECT album_id FROM album WHERE artist_id IN ( 
SELECT artist_id FROM artist WHERE name = 'Queen'
  )
); 

Practice updating Rows
(1)
    UPDATE customer
SET fax = null
WHERE fax IS NOT null;

(2)
    UPDATE customer
SET company = 'Self'
WHERE company IS null;  

(3)
    UPDATE customer 
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';  

(4)
    UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

(5)
    UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

Group by
(1)
    SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

(2)
    SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

(3)
    SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

Use Distinct
(1)
    SELECT DISTINCT composer
FROM track;

(2)
    SELECT DISTINCT billing_postal_code
FROM invoice;

(3)
    SELECT DISTINCT company
FROM customer;

Delete Rows
(1)
    CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

(2)
    DELETE 
FROM practice_delete 
WHERE type = 'bronze';

(3)
    DELETE 
FROM practice_delete 
WHERE type = 'silver';

(4)
    DELETE 
FROM practice_delete 
WHERE value = 150;    



eCommerce Simulation

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(200)
);
CREATE TABLE product (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price INT
);
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  product_id INT,
  FOREIGN KEY(product_id) REFERENCES product(product_id)
)

INSERT INTO users (name, email)
VALUES ('Jamison', 'Jamison@donglemonger.com'),
('Josh', 'dongle4you@bendover.love'),
('David', 'totallyInnocent@didntdoit.net');
INSERT INTO product (name, price)
VALUES ('Large Dungle', 9.89),
('Medium Dongle', 8.98),
('Small Dongle', 5.55);
INSERT INTO orders (product_id)
VALUES (1),(1),(3)

SELECT * FROM orders
WHERE order_id = 1

SELECT * FROM orders

SELECT SUM(o.quantity * p.price) FROM orders AS o
INNER JOIN product AS p
ON o.product_id = p.product_id
WHERE order_id = 1

ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(order_id);
SELECT * FROM users

UPDATE users 
SET order_id = user_id;
SELECT * FROM users

SELECT * FROM users
WHERE order_id = 1

SELECT COUNT(*) FROM users
WHERE order_id = 1