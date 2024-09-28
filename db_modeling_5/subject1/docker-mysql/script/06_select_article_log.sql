-- 記事の履歴一覧
-- id = 1 の記事の履歴
SELECT *
FROM articles
WHERE id = 1 OR history = 1
ORDER BY updated_at;
