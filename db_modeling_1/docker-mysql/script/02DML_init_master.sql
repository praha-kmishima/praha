-- 顧客テーブル用データ
INSERT INTO customers (name, phone_number) VALUES
('三島 賢祐', '123-456-7890'),
('鮨 Aさん', '987-654-3210'),
('鮨 Bさん', '555-123-4567'),
('鮨 Cさん', '777-888-9999'),
('鮨 Dさん', '111-222-3333');

-- 商品テーブルのデータ
INSERT INTO products (name, is_set) VALUES
  ('はな', true), 
  ('わだつみ', true), 
  ('あさなぎ', true),
  ('ゆうなぎ', true), 
  ('くろしお', true), 
  ('いさりび', true), 
  ('みさき', true), 
  ('みなと', true), 
  ('しおん', true),
  ('なぎさ', true), 
  ('海鮮ちらし', true), 
  ('鉄火丼', true), 
  ('鮨八方宝巻', true), 
  ('鮨八方宝巻（化粧箱入り）', true),
  -- 100円
  ('玉子', false), 
  ('いなり', false), 
  ('納豆軍艦', false), 
  ('ツナサラダ', false), 
  ('コーン', false), 
  ('カニサラダ', false), 
  ('オクラ軍艦', false), 
  -- 150円
  ('ゆでげそ', false), 
  ('とびっこ', false), 
  ('明太子サラダ', false), 
  ('いかの塩辛', false), 
  ('オクラ納豆', false), 
  ('かんぴょう巻', false), 
  ('なっとう巻', false), 
  ('かっぱ巻', false), 
  ('おしんこ巻', false), 
  ('梅しそ巻き', false), 
  -- 180円
  ('えび', false), 
  ('赤いか', false), 
  ('かにみそ軍艦', false), 
  -- 220円
  ('生サーモン', false), 
  ('オニオンサーモン', false), 
  ('マグロ赤身', false), 
  ('ゆでだこ', false), 
  -- 260円
  ('あじ', false), 
  ('赤えび', false), 
  ('生たこ', false), 
  ('えんがわ', false), 
  ('炙りえんがわ', false), 
  ('まぐろの塩だれ焼', false), 
  ('焼えび', false), 
  ('ねぎとろ', false), 
  ('炙りサーモン', false), 
  ('鉄火巻', false), 
  ('まぐろわさび巻', false), 
  -- 360円
  ('いくら', false), 
  ('ホタテ貝', false), 
  ('穴子', false), 
  ('真鯛', false), 
  -- 400円
  ('活ヒラメ', false), 
  ('数の子', false), 
  ('ずわいがに', false), 
  ('トロタク巻き', false), 
  ('すじこ巻', false), 
  -- 460円
  ('中トロ', false), 
  ('特大海老', false), 
  -- 520円
  ('あなご一本すし', false), 
  ('まぐろづくし', false), 
  ('白身づくし', false), 
  -- 600円
  ('うに', false), 
  ('インドまぐろ大トロ', false);

-- 商品価格バージョンのデータ
INSERT INTO products_version (product_id, version) VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 1),
  (5, 1),
  (6, 1),
  (7, 1),
  (8, 1),
  (9, 1),
  (10, 1),
  (11, 1),
  (12, 1),
  (13, 1),
  (14, 1),
  (15, 1),
  (16, 1),
  (17, 1),
  (18, 1),
  (19, 1),
  (20, 1),
  (21, 1),
  (22, 1),
  (23, 1),
  (24, 1),
  (25, 1),
  (26, 1),
  (27, 1),
  (28, 1),
  (29, 1),
  (30, 1),
  (31, 1),
  (32, 1),
  (33, 1),
  (34, 1),
  (35, 1),
  (36, 1),
  (37, 1),
  (38, 1),
  (39, 1),
  (40, 1),
  (41, 1),
  (42, 1),
  (43, 1),
  (44, 1),
  (45, 1),
  (46, 1),
  (47, 1),
  (48, 1),
  (49, 1),
  (50, 1),
  (51, 1),
  (52, 1),
  (53, 1),
  (54, 1),
  (55, 1),
  (56, 1),
  (57, 1),
  (58, 1),
  (59, 1),
  (60, 1),
  (61, 1),
  (62, 1),
  (63, 1),
  (64, 1),
  (65, 1);

-- 各商品の現在最新価格データ
INSERT INTO product_price (product_id, version, price) VALUES
  (1, 1, 8650),
  (2, 1, 5680),
  (3, 1, 4440),
  (4, 1, 3830),
  (5, 1, 2830),
  (6, 1, 2180),
  (7, 1, 1940),
  (8, 1, 1490),
  (9, 1, 1060),
  (10, 1, 800),
  (11, 1, 2830),
  (12, 1, 2180),
  (13, 1, 1280),
  (14, 1, 1480),
  (15, 1, 100),
  (16, 1, 100),
  (17, 1, 100),
  (18, 1, 100),
  (19, 1, 100),
  (20, 1, 100),
  (21, 1, 100),
  (22, 1, 150),
  (23, 1, 150),
  (24, 1, 150),
  (25, 1, 150),
  (26, 1, 150),
  (27, 1, 150),
  (28, 1, 150),
  (29, 1, 150),
  (30, 1, 150),
  (31, 1, 150),
  (32, 1, 180),
  (33, 1, 180),
  (34, 1, 180),
  (35, 1, 220),
  (36, 1, 220),
  (37, 1, 220),
  (38, 1, 220),
  (39, 1, 260),
  (40, 1, 260),
  (41, 1, 260),
  (42, 1, 260),
  (43, 1, 260),
  (44, 1, 260),
  (45, 1, 260),
  (46, 1, 260),
  (47, 1, 260),
  (48, 1, 260),
  (49, 1, 260),
  (50, 1, 360),
  (51, 1, 360),
  (52, 1, 360),
  (53, 1, 360),
  (54, 1, 400),
  (55, 1, 400),
  (56, 1, 400),
  (57, 1, 400),
  (58, 1, 400),
  (59, 1, 460),
  (60, 1, 460),
  (61, 1, 520),
  (62, 1, 520),
  (63, 1, 520),
  (64, 1, 600),
  (65, 1, 600);

-- 注文オプションデータの挿入
INSERT INTO options (id, name) VALUES
(1, 'わさび抜き'),
(2, 'シャリ小');

-- クーポンとクーポン割引タイプのデータ挿入
INSERT INTO coupons (id, type) VALUES
(1, '会計10%割引'),
(2, '会計100円引き');


