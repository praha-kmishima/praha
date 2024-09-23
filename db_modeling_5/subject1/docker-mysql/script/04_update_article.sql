-- hogehogeさんの記事(article_id=1)を改訂する場合のクエリ
SET @user_id = 1;
SET @article_id = 1;

-- 修正前のsubject, contentを保存
SET @subject = NULL;
SET @content = NULL;

SELECT subject, content
INTO @subject, @content
FROM articles
WHERE id = @article_id;

-- 1秒待機
SELECT SLEEP(1);
-- オリジナルの記事レコードを更新（１回目）
UPDATE articles
SET 
  subject = 'ほげほげ（第一回変更）',
  content = '2024/09/21 初投稿 タイトルを修正しました',
  created_at = NOW()
WHERE id = @article_id;
-- 1秒待機
SELECT SLEEP(1);

-- 更新前の記事レコードを挿入
INSERT INTO articles(user_id, history, subject, content)
VALUES(
    @user_id,
    @article_id,
    @subject,
    @content
);


-- オリジナルの記事レコードを更新（２回目）
-- 修正前のsubject, contentを保存
SELECT subject, content
INTO @subject, @content
FROM articles
WHERE id = @article_id;


-- 更新前の記事レコードを挿入
INSERT INTO articles(user_id, history, subject, content)
VALUES(
    @user_id,
    @article_id,
    @subject,
    @content
);

-- 1秒待機
SELECT SLEEP(1);
-- 記事を更新
UPDATE articles
SET 
  subject = 'ほげほげ（第二回変更）',
  content = '2024/09/21 初投稿 タイトルを修正しました by hogehoge',
  created_at = NOW()
WHERE id = @article_id;