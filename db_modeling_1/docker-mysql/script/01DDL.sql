CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    phone_number VARCHAR(15)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price INT,
    is_set BOOLEAN
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    is_paid BOOLEAN,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE options (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    option_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (option_id) REFERENCES options(id)
);



