CREATE TABLE `user` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `directory` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `name` varchar(255),
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
);

CREATE TABLE `document` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `directory_id` int NOT NULL,
  `user_id` int,
  `name` varchar(255),
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  FOREIGN KEY (`directory_id`) REFERENCES `directory` (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
);

CREATE TABLE `directory_tree` (
  `parent_id` int,
  `child_id` int,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  FOREIGN KEY (`parent_id`) REFERENCES `directory` (`id`),
  FOREIGN KEY (`child_id`) REFERENCES `directory` (`id`),
  PRIMARY KEY(`parent_id`,`child_id`)
);