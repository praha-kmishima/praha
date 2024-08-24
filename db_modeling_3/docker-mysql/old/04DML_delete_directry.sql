-- 3. 子Eのフォルダを削除する
-- 一時テーブルに削除対象ディレクトリIDを格納する
CREATE TEMPORARY TABLE DeleteDirectoryIDs (directory_id INT);

-- A.ドキュメントid=5を親に持つディレクトリのIDを取得
INSERT INTO DeleteDirectoryIDs (directory_id) (
    SELECT child_id 
    FROM directory_relationship
    WHERE parent_id = 5
);

-- Aで取得したディレクトリIDを親に持つレコードを削除する
DELETE FROM directory_relationship WHERE child_id IN (SELECT directory_id FROM DeleteDirectoryIDs);
DELETE FROM document WHERE directory_id IN (SELECT directory_id FROM DeleteDirectoryIDs);
DELETE FROM directory WHERE id IN (SELECT directory_id FROM DeleteDirectoryIDs);

DROP TEMPORARY TABLE IF EXISTS DeleteDirectoryIDs;
