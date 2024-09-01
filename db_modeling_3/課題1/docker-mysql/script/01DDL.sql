CREATE TABLE `user` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `directory` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `name` varchar(255),
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `document` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `directory_id` int NOT NULL,
  `user_id` int,
  `name` varchar(255),
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `directory_relationship` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `parent_id` int,
  `child_id` int,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);


ALTER TABLE `directory` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `document` ADD FOREIGN KEY (`directory_id`) REFERENCES `directory` (`id`);

ALTER TABLE `document` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `directory_relationship` ADD FOREIGN KEY (`parent_id`) REFERENCES `directory` (`id`);

ALTER TABLE `directory_relationship` ADD FOREIGN KEY (`child_id`) REFERENCES `directory` (`id`);

