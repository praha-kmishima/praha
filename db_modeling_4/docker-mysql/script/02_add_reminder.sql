-- リマインダーが登録された場合の処理
SET @register_user_name = 'kmishima';
SET @send_user_name = 'penpen';

-- 1. usersテーブルの挿入
INSERT INTO users (account_name) 
VALUES (@register_user_name);

INSERT INTO users (account_name) 
VALUES (@send_user_name);

-- 2. remindersテーブルの挿入
INSERT INTO reminders (reminder_id, sender_id, message, cycle_message)
SELECT u1.id, u2.id, 'コードレビューお願いします', 'every 1 days'
FROM users u1, users u2
WHERE u1.account_name = @register_user_name AND u2.account_name = @send_user_name;

-- 3. scheduled_remindersテーブルの挿入
INSERT INTO scheduled_reminders (id, scheduled_at)
SELECT r.id, NOW()
FROM reminders r
WHERE r.reminder_id = (SELECT id FROM users WHERE account_name = @register_user_name);
