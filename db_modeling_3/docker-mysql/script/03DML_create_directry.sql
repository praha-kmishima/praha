-- 1. ディレクトリをいくつか追加する
-- 現在のディレクトリ：フォルダA,B,C
-- 親Aに子D, Eを追加する
-- 親Cに子Fを追加する
-- 子Fに孫Gを追加する

INSERT INTO directory (user_id, name) VALUES 
    (1, "子D"),
    (2, "子E"),
    (3, "子F"),
    (4, "孫G");

-- フォルダの親子関係レコード追加
INSERT INTO directory_relationship (parent_id, child_id) VALUES 
    (1, 4),
    (4, 4),
    (1, 5),
    (5, 5),
    (3, 6),
    (6, 6),
    (3, 7),
    (6, 7),
    (7, 7);

-- 2. ファイルをいくつか追加する
-- 子Eにファイルを追加
-- 子Fにファイルを追加
-- 孫Gにファイルを追加
INSERT INTO document (directory_id, user_id, name) VALUES 
    (5, 3, "ファイルE1"),
    (6, 4, "ファイルF1"),
    (6, 4, "ファイルF2"),
    (7, 5, "ファイルG1");


