-- DML1:新しい階層にフォルダ追加
-- ・フォルダAにサブフォルダa1を作る
INSERT INTO directory (user_id, NAME) VALUES
	(1, "フォルダa1");

INSERT INTO directory_tree (parent_id, child_id) VALUES
	(1, 4), -- id=1はid=4の親
	(4, 4);

-- サブフォルダa1にサブフォルダa2を作る
INSERT INTO directory (user_id, NAME) VALUES
	(1, "フォルダa2");

INSERT INTO directory_tree (parent_id, child_id) VALUES
	(1, 5), -- id=1はid=4の先祖
	(4, 5), -- id=4はid=5の親
	(5, 5);

-- DML2:あるフォルダの親子フォルダの取得
-- ・サブフォルダa2(id=5)の親を取得
SELECT d.*
FROM directory AS d
	INNER JOIN directory_tree AS t ON d.id = t.parent_id
WHERE t.child_id = 5;

-- ・結果
-- id;user_id;name;created_at
-- 1;1;フォルダA;2024-09-01 20:06:50
-- 4;1;フォルダa1;2024-09-01 20:07:07
-- 5;1;フォルダa2;2024-09-01 20:07:07

-- ・フォルダa1(id=4)の子孫を取得
SELECT d.*
FROM directory AS d
	INNER JOIN directory_tree AS t ON d.id = t.child_id
WHERE t.parent_id = 4;

-- ・結果
-- id;user_id;name;created_at
-- 4;1;フォルダa1;2024-09-01 20:07:07
-- 5;1;フォルダa2;2024-09-01 20:07:07

-- DML3:ある階層のフォルダを削除する
-- フォルダa1(id=4)以下の階層のディレクトリを削除
DELETE FROM directory_tree WHERE child_id IN (
  SELECT x.id FROM
    (SELECT child_id AS id
    FROM directory_tree
    WHERE parent_id = 4) AS x
);


-- DML4:ある階層のフォルダを別のフォルダに移動させる
-- フォルダa1(id=4)以下の階層のディレクトリをフォルダB(id=2)の配下に移動
-- ・親フォルダと子フォルダa1,a2の親子関係のレコードを削除 ※(4,4)と(5,5)の自己参照レコードは削除しない
DELETE FROM directory_tree
WHERE child_id IN (
  SELECT x.id FROM
    (SELECT child_id AS id
    FROM directory_tree
    WHERE parent_id = 4) AS x
  ) AND parent_id IN (
  SELECT y.id FROM 
    (SELECT parent_id AS id
     FROM directory_tree
     WHERE child_id = 4 
	    AND parent_id != child_id) AS y
); 

-- ・移動先フォルダB(id=2)と子孫フォルダa1,a2の関係レコードを追加する
INSERT INTO directory_tree (parent_id, child_id)
  SELECT super_tree.parent_id, sub_tree.child_id
  FROM directory_tree AS super_tree
    CROSS JOIN directory_tree AS sub_tree
   WHERE super_tree.child_id = 2
     AND sub_tree.parent_id = 4;
     
-- チェック：フォルダBの子孫を取得
SELECT d.*
FROM directory AS d
	INNER JOIN directory_tree AS t ON d.id = t.child_id
WHERE t.parent_id = 2;

-- id;user_id;name;created_at
-- 2;1;フォルダB;2024-09-01 20:06:50
-- 4;1;フォルダa1;2024-09-01 20:07:07
-- 5;1;フォルダa2;2024-09-01 20:07:07

-- チェック：フォルダAの子孫を取得
SELECT d.*
FROM directory AS d
	INNER JOIN directory_tree AS t ON d.id = t.child_id
WHERE t.parent_id = 1;