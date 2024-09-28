-- 最新の記事一覧
SELECT *
FROM articles
WHERE history = 0
ORDER BY user_id, id;