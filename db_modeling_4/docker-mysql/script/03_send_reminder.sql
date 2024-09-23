-- 1.リマインダーを送信する場合の処理
-- リマインドid=2をリマインドする場合
SET @scheduled_remind_id = 2; 

-- 2. remindersからリマインドと送信先ユーザのデータを取得してリマインドを送る
SELECT r.remind_message AS `リマインド文章`, u.account_name AS `送信先ユーザ名`
FROM reminders r
JOIN users u ON r.receive_user_id = u.id
WHERE r.id = @scheduled_remind_id;

-- 3. 送信後、次回リマインダー日付を再登録する
UPDATE scheduled_reminders 
SET scheduled_at = NOW() + INTERVAL 3 HOUR 
WHERE reminder_id = @scheduled_remind_id;

