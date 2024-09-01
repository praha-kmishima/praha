-- ユーザ
INSERT INTO user (name) VALUES 
    ('ユーザA'),
    ('ユーザB'),
    ('ユーザC');

-- フォルダ
INSERT INTO directory (user_id, name) VALUES 
    (1, "フォルダA"),
    (1, "フォルダB"),
    (2, "フォルダC");

INSERT INTO directory_tree (parent_id, child_id) VALUES 
    (1, 1),
    (2, 2),
    (3, 3);

-- フォルダにファイルを追加
INSERT INTO document (directory_id, user_id, name) VALUES 
    (1, 1, "ファイルA1"),
    (2, 2, "ファイルB1"),
    (3, 3, "ファイルC1");



