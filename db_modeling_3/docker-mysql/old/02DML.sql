-- ユーザを追加
INSERT INTO user (name) VALUES 
    ('John'),
    ('Alice'),
    ('Bob'),
    ('Dan'),
    ('Rick');

-- 親フォルダを追加
INSERT INTO directory (user_id, name) VALUES 
    (1, "親A"),
    (1, "親B"),
    (2, "親C");


-- 各親フォルダにファイルを追加
INSERT INTO document (directory_id, user_id, name) VALUES 
    (1, 3, "ファイルA1"),
    (2, 4, "ファイルB1"),
    (3, 5, "ファイルC1");

-- フォルダの親子関係レコード追加
INSERT INTO directory_relationship (parent_id, child_id) VALUES 
    (1, 1),
    (2, 2),
    (3, 3);


