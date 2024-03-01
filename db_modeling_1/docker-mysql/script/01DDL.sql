CREATE TABLE `customers` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `products` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `price` INT NOT NULL,
  `is_set` BOOLEAN NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `orders` (
  `id` INT PRIMARY KEY,
  `customer_id` INT NOT NULL,
  `order_amount` INT NOT NULL,
  `is_paid` BOOLEAN NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `options` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `order_details` (
  `id` INT PRIMARY KEY,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `option_id` INT,
  `quantity` INT NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

ALTER TABLE `orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`option_id`) REFERENCES `options` (`id`);
