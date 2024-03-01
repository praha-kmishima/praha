# データベース設計

## ER図

<img src="https://github.com/kmishima16/praha/blob/image/db_modeling_1/images/Copy%20of%20DB%E3%83%A2%E3%83%87%E3%83%AA%E3%83%B3%E3%82%B01%20%E5%AF%BF%E5%8F%B8%E6%B3%A8%E6%96%87DB.png" alt="寿司DBのER図" title="寿司DBのER図">

https://dbdiagram.io/d/DBモデリング1-寿司注文DB-65db06525cd0412774bf0ea7  
NULL制約

### テーブル構成

#### マスタテーブル

- customers: 顧客テーブル
  - 名前、電話番号
- products: 商品テーブル
  - 価格、セット商品フラグ
- options: 商品のオプション
  - オプション名（わさび抜き、シャリ小）

#### トランザクションテーブル

- orders: 注文テーブル
  - 顧客id、合計金額、支払有無
- order_datails: 注文詳細テーブル
  - 注文id, 商品id, 商品オプションid, 注文数

## 利用ユースケース

- お客さんが注文する際の合計金額
- お客さんが注文する際のオプション付き商品
- セット商品を除き、寿司ネタが各月単位でどれだけ売れているか
