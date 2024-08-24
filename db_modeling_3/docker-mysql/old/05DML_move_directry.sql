-- ディレクトリFをディレクトリDの子供に移動させる

-- 移動するディレクトリidを取得する
CREATE TEMPORARY TABLE MoveDirectoryIDs (directory_id INT);

-- 1.ドキュメントid=6を親に持つディレクトリのIDを取得
INSERT INTO MoveDirectoryIDs (directory_id) (
    SELECT child_id
    FROM directory_relationship
    WHERE parent_id = 6
);

-- 2.directory_relationshipにレコードを追加
SELECT 
	T1.parent_id AS parent_id,
	MoveDirectoryIDs.directory_id AS child_id
FROM (
	SELECT parent_id
	FROM directory_relationship
	WHERE child_id = 4
) AS T1
CROSS JOIN MoveDirectoryIDs;

-- 3.移動元の親に紐づいていたディレクトリのレコードを削除する