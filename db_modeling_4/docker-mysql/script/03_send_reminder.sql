-- リマインダーを送信する場合の処理
SET @scheduled_remind_id = NULL;

-- 1. scheduled_remindersからリマインダー対象のid取得
SELECT id INTO @scheduled_remind_id
FROM scheduled_reminders 
WHERE scheduled_at <= NOW();

-- 2. remindersからリマインド文と送信先ユーザ名を取得
SELECT r.message AS `リマインド文章`, u.account_name AS `送信先ユーザ名`
FROM reminders r
JOIN users u ON r.reminder_id = u.id
WHERE r.id = @scheduled_remind_id;

-- 3. 次回リマインダー日付を再登録
UPDATE scheduled_reminders 
SET scheduled_at = NOW() + INTERVAL 1 DAY 
WHERE id = @scheduled_remind_id;

