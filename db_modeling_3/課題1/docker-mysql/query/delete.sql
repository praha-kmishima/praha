-- ディレクトリ3を削除
SELECT *
FROM directory_relationship
WHERE parent_id = 3;

-- id;parent_id;child_id;created_at
-- 3;3;3;2024-08-24 19:28:26
-- 8;3;6;2024-08-24 19:28:26
-- 10;3;7;2024-08-24 19:28:26

-- id=3,6,7のディレクトリを削除する
-- sql上で実装してみる：削除対象のディレクトリIDをDeleteDirectryIDsに格納する
CREATE TEMPORARY TABLE DeleteDirectoryIDs (directory_id INT);
INSERT INTO DeleteDirectoryIDs (directory_id) (
    SELECT child_id 
    FROM directory_relationship
    WHERE parent_id = 3
);
-- 削除対象ディレクトリidに関するレコードを削除する
DELETE FROM directory_relationship WHERE child_id IN (SELECT directory_id FROM DeleteDirectoryIDs);
DELETE FROM document WHERE directory_id IN (SELECT directory_id FROM DeleteDirectoryIDs);
DELETE FROM directory WHERE id IN (SELECT directory_id FROM DeleteDirectoryIDs);
-- DeleteDirectryIDsを削除
DROP TEMPORARY TABLE IF EXISTS DeleteDirectoryIDs;

-- ディレクトリid=3,6,7が削除できているか確認
SELECT *
FROM directory
WHERE id IN (3,6,7);

-- id;parent_id;child_id;created_at