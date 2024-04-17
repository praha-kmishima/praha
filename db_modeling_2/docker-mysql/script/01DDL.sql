CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `channels` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `workspaces` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `messages` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `workspace_id` int,
  `channel_id` int,
  `user_id` int,
  `content` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `channels_in_workspace` (
  `workspace_id` int,
  `channel_id` int,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (`workspace_id`, `channel_id`)
);

CREATE TABLE `users_in_workspace` (
  `workspace_id` int,
  `user_id` int,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (`workspace_id`, `user_id`)
);

CREATE TABLE `users_in_channel` (
  `channel_id` int,
  `user_id` int,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (`channel_id`, `user_id`)
);

CREATE TABLE `thread_messages` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `message_id` int,
  `user_id` int,
  `content` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT (CURRENT_TIMESTAMP),
  `updated_at` timestamp DEFAULT (CURRENT_TIMESTAMP)
);

ALTER TABLE `messages` ADD FOREIGN KEY (`workspace_id`) REFERENCES `workspaces` (`id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `channels_in_workspace` ADD FOREIGN KEY (`workspace_id`) REFERENCES `workspaces` (`id`);

ALTER TABLE `channels_in_workspace` ADD FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`);

ALTER TABLE `users_in_workspace` ADD FOREIGN KEY (`workspace_id`) REFERENCES `workspaces` (`id`);

ALTER TABLE `users_in_workspace` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `users_in_channel` ADD FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`);

ALTER TABLE `users_in_channel` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `thread_messages` ADD FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`);

ALTER TABLE `thread_messages` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
