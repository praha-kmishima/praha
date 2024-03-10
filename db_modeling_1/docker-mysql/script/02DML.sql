-- 商品登録
INSERT INTO products (id, name, price, is_set)
VALUES 
  -- セット商品
  (1, 'はな', 8650, true), 
  (2, 'わだつみ', 5680, true), 
  (3, 'あさなぎ', 4440, true),
  (4, 'ゆうなぎ', 3830, true), 
  (5, 'くろしお', 2830, true), 
  (6, 'いさりび', 2180, true), 
  (7, 'みさき', 1940, true), 
  (8, 'みなと', 1490, true), 
  (9, 'しおん', 1060, true),
  (10, 'なぎさ', 800, true), 
  (11, '海鮮ちらし', 2830, true), 
  (12, '鉄火丼', 2180, true), 
  (13, '鮨八方宝巻', 1280, true), 
  (14, '鮨八方宝巻（化粧箱入り）', 1480, true),
  -- 100円
  (15, '玉子', 100, false), 
  (16, 'いなり', 100, false), 
  (17, '納豆軍艦', 100, false), 
  (18, 'ツナサラダ', 100, false), 
  (19, 'コーン', 100, false), 
  (20, 'カニサラダ', 100, false), 
  (21, 'オクラ軍艦', 100, false), 
  -- 150円
  (22, 'ゆでげそ', 150, false), 
  (23, 'とびっこ', 150, false), 
  (24, '明太子サラダ', 150, false), 
  (25, 'いかの塩辛', 150, false), 
  (26, 'オクラ納豆', 150, false), 
  (27, 'かんぴょう巻', 150, false), 
  (28, 'なっとう巻', 150, false), 
  (29, 'かっぱ巻', 150, false), 
  (30, 'おしんこ巻', 150, false), 
  (31, '梅しそ巻き', 150, false), 
  -- 180円
  (32, 'えび', 180, false), 
  (33, '赤いか', 180, false), 
  (34, 'かにみそ軍艦', 180, false), 
  -- 220円
  (35, '生サーモン', 220, false), 
  (36, 'オニオンサーモン', 220, false), 
  (37, 'マグロ赤身', 220, false), 
  (38, 'ゆでだこ', 220, false), 
  -- 260円
  (39, 'あじ', 260, false), 
  (40, '赤えび', 260, false), 
  (41, '生たこ', 260, false), 
  (42, 'えんがわ', 260, false), 
  (43, '炙りえんがわ', 260, false), 
  (44, 'まぐろの塩だれ焼', 260, false), 
  (45, '焼えび', 260, false), 
  (46, 'ねぎとろ', 260, false), 
  (47, '炙りサーモン', 260, false), 
  (48, '鉄火巻', 260, false), 
  (49, 'まぐろわさび巻', 260, false), 
  -- 360円
  (50, 'いくら', 360, false), 
  (51, 'ホタテ貝', 360, false), 
  (52, '穴子', 360, false), 
  (53, '真鯛', 360, false), 
  -- 400円
  (54, '活ヒラメ', 400, false), 
  (55, '数の子', 400, false), 
  (56, 'ずわいがに', 400, false), 
  (57, 'トロタク巻き', 400, false), 
  (58, 'すじこ巻', 400, false), 
  -- 460円
  (59, '中トロ', 460, false), 
  (60, '特大海老', 460, false), 
  -- 520円
  (61, 'あなご一本すし', 520, false), 
  (62, 'まぐろづくし', 520, false), 
  (63, '白身づくし', 520, false), 
  -- 600円
  (64, 'うに', 600, false), 
  (65, 'インドまぐろ大トロ', 600, false);

-- オプション登録
INSERT INTO options (id, name)
VALUES 
  (1, 'わさび抜き'),
  (2, 'シャリ半分');

-- 顧客登録
INSERT INTO customers (id, name, phone_number)
VALUES 
  (1, '三島 賢祐', '000-0000-0000');

-- 注文レコード登録
INSERT INTO orders (id, customer_id)
VALUES 
  (1, 1);

-- 注文詳細登録
INSERT INTO order_details (id, order_id, product_id, option_id, quantity)
VALUES 
  (1, 1, 1, null, 1),
  (2, 1, 15, 1, 2),
  (3, 1, 22, 2, 1),
  (4, 1, 32, null, 1),
  (5, 1, 54, null, 1),
  (6, 1, 59, null, 1),
  (7, 1, 61, null, 1);

-- 注文合計金額のVIEW作成
CREATE VIEW `order_amount` AS
    SELECT 
        `o`.`order_id` AS `order_id`,
        `os`.`customer_id` AS `customer_id`,
        SUM(`p`.`price`) AS `SUM(p.price)` as "total_amount"
    FROM
        ((`order_details` `o`
        JOIN `products` `p` ON ((`o`.`product_id` = `p`.`id`)))
        JOIN `orders` `os` ON ((`o`.`order_id` = `os`.`id`)))
    GROUP BY `o`.`order_id`
