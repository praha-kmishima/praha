CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `account_name` varchar(255) NOT NULL UNIQUE,
  `slack_id` varchar(255) NOT NULL UNIQUE, 
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `reminders` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `regist_user_id` int NOT NULL,
  `receive_user_id` int NOT NULL,
  `remind_message` varchar(255) NOT NULL,
  `cycle_message` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`regist_user_id`) REFERENCES `users` (`id`),
  FOREIGN KEY (`receive_user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `scheduled_reminders` (
  `reminder_id` int NOT NULL,
  `scheduled_at` timestamp NOT NULL,
  PRIMARY KEY (`reminder_id`, `scheduled_at`),
  FOREIGN KEY (`reminder_id`) REFERENCES `reminders` (`id`)
);


CREATE TABLE `completed_reminders` (
  `reminder_id` int NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reminder_id`, `created_at`),
  FOREIGN KEY (`reminder_id`) REFERENCES `reminders` (`id`)
);
