-- kmishimaの更新記事(id=1の'初めてのページ')を最初の状態に戻す

-- 待機(更新日時順にソートできるようにするため)
SELECT SLEEP(1);

-- 1.記事の履歴レコードを挿入する
-- 現在の記事データを取得
SET @user_id = 1;
SET @update_article_id = 1;
SET @now_subject = NULL;
SET @now_content = NULL;

SELECT subject, content
INTO @now_subject, @now_content
FROM articles
WHERE id = @update_article_id;

-- 記事履歴をINSERT
INSERT INTO articles(user_id, history, subject, content)
VALUES(
    @user_id,
    @update_article_id,
    @now_subject,
    @now_content
);

-- 2.記事を復元する

-- 対象の記事内容を取得(今回はid=4の記事内容を復元する)
SET @rebert_article_id = 4;
SET @rebert_subject = NULL;
SET @rebert_content = NULL;

SELECT subject, content
INTO @rebert_subject, @rebert_content
FROM articles
WHERE id = @rebert_article_id;

-- 待機(更新日時順にソートできるようにするため)
SELECT SLEEP(1);

-- 復元記事をUPDATE
UPDATE articles
SET 
  subject = @rebert_subject,
  content = @rebert_content,
  updated_at = NOW()
WHERE id = @update_article_id;

