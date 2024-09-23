INSERT INTO users (account_name, slack_id, created_at) VALUES
    ('hogehoge', '@hoge_hoge', CURRENT_TIMESTAMP),
    ('kmishima', '@k_mishima', CURRENT_TIMESTAMP);

INSERT INTO reminders (regist_user_id, receive_user_id, remind_message, cycle_message, created_at) VALUES 
    (1, 2, "コードレビューお願いします！", "every 1 days", CURRENT_TIMESTAMP),
    (1, 2, "会費支払いのご確認お願いします！！", "every 3 hours", CURRENT_TIMESTAMP),
    (1, 2, "チームミーティングよろしくお願いします！！！", "every 1 weeks", CURRENT_TIMESTAMP);

INSERT INTO scheduled_reminders (reminder_id, scheduled_at) VALUES
    (2, NOW() + INTERVAL 3 HOUR),
    (3, NOW() + INTERVAL 1 WEEK);

INSERT INTO completed_reminders (reminder_id, created_at) VALUES
    (1, NOW());