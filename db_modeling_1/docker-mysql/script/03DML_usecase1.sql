-- 中トロ(id=59)の値段を460円→400円に値下げする
INSERT INTO products_version (product_id, version) VALUES (59, 2);

INSERT INTO product_price (product_id, version, price) VALUES (59, 2, 400);

-- 現在価格の商品一覧
SELECT
	p_v.product_id,
	p_v.latest_version,
	p.name,
	p_p.price
FROM (
		SELECT 
   		product_id, 
    		MAX(version) AS latest_version
		FROM products_version 
		GROUP BY product_id
	) AS p_v
INNER JOIN 
	products AS p ON p_v.product_id = p.id 
INNER JOIN
	product_price AS p_p ON p_v.product_id = p_p.product_id AND p_v.latest_version = p_p.version 
ORDER BY latest_version DESC, product_id
