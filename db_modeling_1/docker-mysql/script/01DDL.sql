CREATE TABLE `customers` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `products` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) UNIQUE NOT NULL,
  `is_set` BOOLEAN NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `products_version` (
  `product_id` int,
  `version` int,
  PRIMARY KEY (`product_id`, `version`)
);

CREATE TABLE `product_price` (
  `product_id` int,
  `version` int,
  `price` int NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (`product_id`, `version`)
);

CREATE TABLE `orders` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `paid_orders` (
  `order_id` INT PRIMARY KEY,
  `order_amount` INT NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `order_options` (
  `order_detail_id` INT AUTO_INCREMENT,
  `option_id` int,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (`order_detail_id`, `option_id`)
);

CREATE TABLE `options` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) UNIQUE NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `order_details` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `price_version` INT NOT NULL,
  `quantity` INT NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `order_coupons` (
  `order_detail_id` int,
  `coupon_id` int,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (`order_detail_id`, `coupon_id`)
);

CREATE TABLE `coupons` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `type` VARCHAR(255) UNIQUE NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP)
);

ALTER TABLE `products_version` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_price` ADD FOREIGN KEY (`product_id`,`version`) REFERENCES `products_version` (`product_id`,`version`);

ALTER TABLE `orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `paid_orders` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_options` ADD FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`id`);

ALTER TABLE `order_options` ADD FOREIGN KEY (`option_id`) REFERENCES `options` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

-- ALTER TABLE `order_details` ADD FOREIGN KEY (`price_version`) REFERENCES `product_price` (`version`);

ALTER TABLE `order_coupons` ADD FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`id`);

ALTER TABLE `order_coupons` ADD FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`);
