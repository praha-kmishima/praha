## 課題 1 Docker 環境をもとに SQL クエリを作る

## 10 本ノック

### 1 本目 Group By で集計後、フィルタ

解き方
- cusomer_id でグループ化
- 年次を where で絞る
- 並び順を order by で指定する

```sql
SELECT 
    customer_id, 
    COUNT(*) AS order_count
FROM 
    orders
WHERE 
    YEAR(order_date) = 2023
GROUP BY 
    customer_id
HAVING 
    COUNT(*) >= 3
ORDER BY 
    order_count DESC, customer_id ASC;
```

### 2 本目 集計結果をテーブル末尾に追加する

解き方
- サブクエリ：customer_id で group 化して注文回数を用意
- サブクエリと JOIN して、注文回数を末尾列に追加する

```sql
SELECT 
    c.customer_id,
    c.contact_name,
    c.address,
    c.city,
    c.postal_code,
    c.country,
    o.order_count -- 注文回数
FROM 
    customers c
JOIN (
    SELECT 
        customer_id, 
        COUNT(*) AS order_count
    FROM 
        orders
    WHERE 
        YEAR(order_date) = 2023
    GROUP BY 
        customer_id
    HAVING 
        COUNT(*) >= 3
) o ON c.customer_id = o.customer_id
ORDER BY 
    o.order_count DESC;
```

## 3 本目 集計した後の最大値をもとにフィルタ

- 注文回数をグループ化して、最大注文回数を取得する
- 最大注文回数でフィルタする

```sql
WITH 
	shipper_order_counts AS (
    	SELECT 
        	shipper_id, 
        	COUNT(*) AS order_count
    	FROM 
        	orders
    	GROUP BY 
        	shipper_id
	),
	max_count AS (
    	SELECT 
        	MAX(order_count) AS max_order_count
    	FROM 
        	shipper_order_counts
	)
SELECT 
    shipper_id,
    order_count
FROM 
    shipper_order_counts
WHERE 
    order_count = (SELECT max_order_count FROM max_count);
```

![](../images/Pasted%20image%2020250406195207.png)

### 4 本目 JOIN した後にかけ算

```sql
SELECT 
    c.country,
    SUM(od.quantity * p.price) AS proceeds
FROM 
    order_details od
JOIN 
    orders o ON od.order_id = o.order_id
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    products p ON od.product_id = p.product_id
GROUP BY 
    c.country
ORDER BY 
    proceeds DESC;
```

![](../images/Pasted%20image%2020250406195612.png)

### 5 本目 DATE_FORMAT したカラムで group_by

```sql
SELECT 
    c.country,
    DATE_FORMAT(o.order_date, '%Y') AS year,
    SUM(od.quantity * p.price) AS proceeds
FROM 
    order_details od
JOIN 
    orders o ON od.order_id = o.order_id
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    products p ON od.product_id = p.product_id
GROUP BY 
    c.country, 
    DATE_FORMAT(o.order_date, '%Y')
ORDER BY 
    c.country ASC,
    year ASC;
```

![](../images/Pasted%20image%2020250406195859.png)

高難易度版
- UNION で各月のテーブルを作る
- customers から、各国のテーブルを作る
- date_format を使って各月のデータを集計する
- JOIN する

```sql
-- 12ヶ月を生成するためのテーブル
WITH months AS (
    SELECT '2023-01' AS month UNION SELECT '2023-02' UNION SELECT '2023-03' UNION
    SELECT '2023-04' UNION SELECT '2023-05' UNION SELECT '2023-06' UNION
    SELECT '2023-07' UNION SELECT '2023-08' UNION SELECT '2023-09' UNION
    SELECT '2023-10' UNION SELECT '2023-11' UNION SELECT '2023-12'
),
-- 各国を取得
countries AS (
    SELECT DISTINCT country FROM customers
),
-- 実際の売上データを月ごとに集計
sales_data AS (
    SELECT 
        c.country,
        DATE_FORMAT(o.order_date, '%Y-%m') AS date,
        SUM(od.quantity * p.price) AS proceeds
    FROM 
        order_details od
    JOIN 
        orders o ON od.order_id = o.order_id
    JOIN 
        customers c ON o.customer_id = c.customer_id
    JOIN 
        products p ON od.product_id = p.product_id
    WHERE
        YEAR(o.order_date) = 2023
    GROUP BY 
        c.country, 
        DATE_FORMAT(o.order_date, '%Y-%m')
)
-- 国・月の全組み合わせと売上データを結合
SELECT 
    c.country,
    m.month AS date,
    sd.proceeds
FROM 
    countries c
CROSS JOIN
    months m
LEFT JOIN
    sales_data sd ON c.country = sd.country AND m.month = sd.date
ORDER BY
    c.country ASC,
    m.month ASC;
```

![](../images/Pasted%20image%2020250406200249.png)

### 6 本目 カラムの追加・UPDATE

```sql
-- 1. juniorカラムをemployeesテーブルに追加
ALTER TABLE employees 
ADD COLUMN junior BOOLEAN DEFAULT FALSE;

-- 2. 条件に合わせてデータを更新
UPDATE employees
SET junior = TRUE
WHERE birth_date > '1990-01-01';
```

![](../images/Pasted%20image%2020250406200644.png)

### 7 本目 カラムの追加・UPDATE(サブクエリ有)

```sql
-- 1. long_relationカラムをshippersテーブルに追加
ALTER TABLE shippers
ADD COLUMN long_relation BOOLEAN DEFAULT FALSE;

-- 2. 70回以上注文に関わった運送会社を特定し、long_relationをtrueに設定
UPDATE shippers
SET long_relation = TRUE
WHERE shipper_id IN (
    SELECT shipper_id
    FROM orders
    GROUP BY shipper_id
    HAVING COUNT(*) >= 70
);
```

![](../images/Pasted%20image%2020250406215232.png)

### 8 本目 with 句で複雑なクエリを処理する

```sql
WITH 
	latest_order_dates AS (
	    -- 各社員の最新注文日を取得
	    SELECT 
	        employee_id,
	        MAX(order_date) AS latest_date
	    FROM 
	        orders
	    GROUP BY 
	        employee_id
	),
	latest_orders AS (
	    -- 最新日の注文から各社員ごとに最小のorder_idを持つものを選択
	    SELECT 
	        o.order_id,
	        o.employee_id,
	        o.order_date
	    FROM 
	        orders o
	    JOIN 
	        latest_order_dates lod ON o.employee_id = lod.employee_id AND
	         o.order_date = lod.latest_date
	    WHERE 
	        o.order_id = (
	            -- 同日の注文のうち最小のorder_idを取得
	            SELECT MIN(order_id)
	            FROM orders
	            WHERE employee_id = o.employee_id AND order_date = o.order_date
	        )
	)
-- 最終結果を取得（社員ID順に並べる）
SELECT 
    employee_id,
    order_id,
    order_date
FROM 
    latest_orders
ORDER BY 
    employee_id;
```

![](../images/Pasted%20image%2020250406215958.png)

### 9 本目 NULL を含むクエリ

```sql
-- 1. customersテーブルのcontact_nameカラムをNULL許容に変更
ALTER TABLE customers
MODIFY COLUMN contact_name VARCHAR(255) NULL;

-- 2. customer_id=1のレコードのcontact_nameをNULLに設定
UPDATE customers
SET contact_name = NULL
WHERE customer_id = 1;

-- 3. contact_nameが存在する（非NULL）ユーザを取得
SELECT *
FROM customers
WHERE contact_name IS NOT NULL;

-- 4. contact_nameが存在しない（NULL）ユーザを取得
SELECT *
FROM customers
WHERE contact_name IS NULL;
```

- `where contact_name IS NULL` と `where contact_name = NULL` は違うクエリ結果が返ってくる

### 10 本目 

```sql
-- 1. employee_id=1 の従業員レコードを削除
DELETE FROM employees
WHERE employee_id = 1;

-- 2. INNER JOIN
-- 削除された従業員（employee_id=1）のorderは取得されない
SELECT 
    o.*,
    e.*
FROM 
    orders o
INNER JOIN 
    employees e ON e.employee_id = o.employee_id;

-- 3. LEFT JOIN
-- employeesに関連する情報はNULLで埋められる
SELECT 
    o.*,
    e.*
FROM 
    orders o
LEFT JOIN 
    employees e ON o.employee_id = e.employee_id;
```

INNER JOIN
- 削除された従業員の
![](../images/Pasted%20image%2020250406221029.png)

LEFT JOIN
![](../images/Pasted%20image%2020250406221550.png)

## 課題 2

### 2-1 GROUP BY 利用時の WHERE と HAVING の違い

動作の違い
- WHERE 句は、**GROUP BY 操作の前**にレコードをフィルタリングする
- HAVING 句は、**GROUP BY 操作の後**に集計結果をフィルタリングする

使い分け

| ポイント      | 説明                                      |
| --------- | --------------------------------------- |
| **最適化**   | データベースの負荷を減らすため、WHERE で可能な限り早くレコードを絞り込む |
| **読みやすさ** | WHERE 句、HAVING 句を適切に使うことでクエリの意図が明確になる   |
| **集計関数**  | SUMなどは WHERE 句で使えない                     |
| **実行計画**  | WHERE 句は実行計画に大きく影響し、インデックスを活用できる        |

### 2-2

DDL,DML,DCL,TCL の違い

| 分類      | 正式名称                                           | 説明              | コマンド例                                          |
| ------- | ---------------------------------------------- | --------------- | ---------------------------------------------- |
| **DDL** | Data Definition Language<br>(データ定義言語)          | DBの構造を定義、変更する   | CREATE, ALTER, DROP, TRUNCATE, RENAME, COMMENT |
| **DML** | Data Manipulation Language<br>(データ操作言語)        | DB内のデータを操作する    | SELECT, INSERT, UPDATE, DELETE, MERGE          |
| **DCL** | Data Control Language<br>(データ制御言語)             | DBへのアクセス権限を制御する | GRANT, REVOKE                                  |
| **TCL** | Transaction Control Language<br>(トランザクション制御言語) | トランザクションを管理する   | COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION   |

各分類の特徴と使用例

| 分類      | 特徴                                 | 具体的な使用例                                                                                                                             | 影響範囲             |
| ------- | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| **DDL** | 自動コミットされる<br>実行後に即時反映される           | `CREATE TABLE users(id INT, name VARCHAR(100));`<br>`ALTER TABLE users ADD COLUMN email VARCHAR(255);`<br>`DROP TABLE users;`       | データベースの構造に影響     |
| **DML** | トランザクション内で実行可能<br>COMMIT するまで確定しない | `SELECT * FROM users WHERE id = 1;`<br>`INSERT INTO users VALUES(1, 'Tanaka');`<br>`UPDATE users SET name = 'Suzuki' WHERE id = 1;` | データベース内のデータに影響   |
| **DCL** | セキュリティ管理に使用<br>権限制御が目的             | `GRANT SELECT, INSERT ON users TO user1;`<br>`REVOKE DELETE ON users FROM user2;`                                                   | ユーザー権限に影響        |
| **TCL** | トランザクションの境界を制御<br>データの一貫性を保証       | `BEGIN TRANSACTION;`<br>`COMMIT;`<br>`ROLLBACK;`<br>`SAVEPOINT sp1;`                                                                | トランザクションの完了状態に影響 |

## クイズ

### Q1.WITH 句の主な利点として正しいものはどれですか？

A. クエリのパフォーマンスを常に向上させる 
B. 複雑なクエリを読みやすく、保守しやすくする 
C. トランザクションの分離レベルを変更できる 
D. テーブル結合（JOIN）を使わずに複数テーブルからデータを取得できる

### Q2.EXISTS 演算子を使ったサブクエリの主な目的は何ですか？

A. サブクエリの結果の具体的な値を取得する 
B. サブクエリの結果が存在するかどうかを確認する 
C. サブクエリの結果の行数をカウントする 
D. サブクエリの結果を並べ替える

### Q3.スカラーサブクエリの特徴として正しいものはどれですか？

A. 常に複数の列を返す 
B. 常に複数の行を返す 
C. 常に単一の値（1 行 1 列）を返す 
D. 結果が空になることはない

## クイズの答え

### Q1: WITH 句

**正解: B. 複雑なクエリを読みやすく、保守しやすくする**

**解説:**  
WITH 句（Common Table Expression、CTE）の主な利点は、複雑なクエリを論理的な部分に分解し、読みやすく保守しやすくすることです。パフォーマンスは常に向上するとは限らず、データベースエンジンによって異なります。WITH 句は JOIN を置き換えるものではなく、トランザクションの分離レベルとも関係ありません。

### Q2: EXISTS 演算子

**正解: B. サブクエリの結果が存在するかどうかを確認する**

**解説:**  
EXISTS 演算子は、サブクエリが結果を返すかどうか（つまり、条件に一致する行が少なくとも 1 つ存在するかどうか）をチェックします。EXISTS 演算子は結果の存在確認のみを行い、具体的な値や行数を取得するのではありません。

### Q3: スカラーサブクエリ

**正解: C. 常に単一の値（1 行 1 列）を返す**

**解説:**  
スカラーサブクエリは、単一の値（1 行 1 列）を返すサブクエリです。SELECT 文の選択リスト、WHERE 句、HAVING 句などで使用できます。もし複数の行や列を返すようなクエリをスカラーサブクエリの位置で使用すると、多くのデータベース管理システムではエラーが発生します。また、スカラーサブクエリは結果が空（0 行）の場合は NULL を返します。