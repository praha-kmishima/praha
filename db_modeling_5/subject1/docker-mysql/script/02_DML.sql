-- userテーブルにinsert
INSERT INTO users (name) VALUES ('kmishima'), ('hogehoge');

-- articleテーブルにinsert
INSERT INTO articles (user_id, history, subject, content) VALUES 
    (1, 0, '初めてのページ', 'よろしくお願いします！'),
    (2, 0, '初投稿です', 'テスト投稿してみました'),
    (1, 0, 'サービス2日目', '使い始めて2日目になりました。');