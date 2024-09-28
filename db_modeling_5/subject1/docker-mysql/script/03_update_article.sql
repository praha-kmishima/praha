-- kmishimaの記事(id=1の'初めてのページ')のタイトルを更新する

-- 待機(更新日時順にソートできるようにするため)
SELECT SLEEP(1);

-- 1.記事の履歴レコードを挿入する
-- 現在の記事データを取得
SET @user_id = 1;
SET @update_article_id = 1;
SET @prev_subject = NULL;
SET @prev_content = NULL;

SELECT subject, content
INTO @prev_subject, @prev_content
FROM articles
WHERE id = @update_article_id;

-- 履歴記事をINSERT
INSERT INTO articles(user_id, history, subject, content)
VALUES(
    @user_id,
    @update_article_id,
    @prev_subject,
    @prev_content
);

-- 2.記事を更新する

-- 待機(更新日時順にソートできるようにするため)
SELECT SLEEP(1);

UPDATE articles
SET 
  subject = '初めてのページ（第一回変更）',
  content = 'よろしくお願いします！ タイトルを修正しました',
  updated_at = NOW()
WHERE id = @update_article_id;

