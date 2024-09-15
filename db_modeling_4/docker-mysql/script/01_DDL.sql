CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `account_name` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `reminders` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `reminder_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `cycle_message` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`reminder_id`) REFERENCES `users` (`id`),
  FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `scheduled_reminders` (
  `id` int NOT NULL,
  `scheduled_at` timestamp NOT NULL,
  PRIMARY KEY (`id`, `scheduled_at`),
  FOREIGN KEY (`id`) REFERENCES `reminders` (`id`)
);


CREATE TABLE `completed_reminders` (
  `id` int NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `created_at`),
  FOREIGN KEY (`id`) REFERENCES `reminders` (`id`)
);
