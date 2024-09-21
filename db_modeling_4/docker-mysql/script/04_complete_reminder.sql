-- リマインダーが完了した場合の処理
SET @completed_remind_id = 1;

-- 1. scheduled_remindersから対象idを削除
DELETE FROM scheduled_reminders WHERE reminder_id = @completed_remind_id;

-- 2. completed_remindersに対象idを登録
INSERT INTO completed_reminders (reminder_id, created_at)
VALUES (@completed_remind_id, NOW());