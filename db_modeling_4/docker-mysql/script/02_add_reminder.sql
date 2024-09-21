-- リマインダーが登録された場合の処理
SET @regist_user_name = 'hogehoge';
SET @receive_user_name = 'kmishima';

-- 1. usersテーブルの挿入
INSERT INTO users (account_name) 
VALUES (@regist_user_name);

INSERT INTO users (account_name) 
VALUES (@receive_user_name);

-- 2. remindersテーブルの挿入
INSERT INTO reminders (regist_user_id, receive_user_id, remind_message, cycle_message)
SELECT u1.id, u2.id, 'コードレビューお願いします', 'every 1 days'
FROM users u1, users u2
WHERE u1.account_name = @regist_user_name AND u2.account_name = @receive_user_name;

-- 3. scheduled_remindersテーブルの挿入
SET @last_reminder_id = (SELECT id FROM reminders ORDER BY id DESC LIMIT 1);

INSERT INTO scheduled_reminders (reminder_id, scheduled_at)
SELECT @last_reminder_id, NOW()
