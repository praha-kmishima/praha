-- オプション、クーポン無しでの注文
-- 中とろ２皿、いか２皿、ホタテ１皿、ほか３皿注文

-- 注文商品
INSERT INTO order_details (order_id, product_id, price_version, quantity) VALUES
  (1, 59, 2, 2),
  (1, 33, 1, 2),
  (1, 51, 1, 1),
  (1, 27, 1, 1),
  (1, 28, 1, 1),
  (1, 29, 1, 1);

-- 注文
INSERT INTO orders (customer_id) VALUES (1);

-- order_id = 1の注文合計額を取得: total_price=1970円
SELECT
	SUM(o_d.quantity * p_p.price) AS total_price
FROM
	order_details AS o_d
INNER JOIN
	product_price AS p_p
ON
	o_d.product_id = p_p.product_id AND
	o_d.price_version = p_p.version
WHERE
	o_d.order_id = 1;

-- 注文支払完了したらpaid_ordersにデータ登録
INSERT INTO paid_orders (order_id, order_amount) VALUES (1, 1970);