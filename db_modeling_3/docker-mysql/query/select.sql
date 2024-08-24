-- id=1のディレクトリを親に持つディレクトリ
SELECT *
FROM directory_relationship AS d
WHERE d.parent_id = 1;

-- id;parent_id;child_id;created_at
-- 1;1;1;2024-08-24 19:28:26
-- 4;1;4;2024-08-24 19:28:26
-- 6;1;5;2024-08-24 19:28:26

-- id=1のディレクトリに所属するドキュメント
SELECT *
FROM document AS d
WHERE d.directory_id = 1;

-- id;directory_id;user_id;name;created_at
-- 1;1;3;ファイルA1;2024-08-24 19:28:26
