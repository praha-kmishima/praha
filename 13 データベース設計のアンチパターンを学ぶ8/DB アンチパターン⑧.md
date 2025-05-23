# 課題 1

## 解答 1

商品コードを変更する場合に更新コストがかかる

- `productCode` が外部キー制約として利用されていた場合、コード変更されると関連するデータベースを更新する必要があり、大規模なデータベースの場合、処理コストが大きくかかる可能性がある。
    - autoincrement される id など代理キーを主キーにしておくことで、この問題点は解消できる。

今回の商品コードだと、頭文字のコード A～Z で分類しているが、今後商品数が増えると対応できなくなるかもしれない

### 参考

[商品コードを主キーにするべきではない理由](https://blog.makotoishida.com/2010/12/blog-post_26.html)

# 課題 2

## 解答 2

新たに id を代理キーとして追加する。

```sql
TABLE Product {
  id: int AUTO_INCREMENT PRIMARY KEY,
  productCode: varchar UNIQUE,
  name: varchar
}
```

# 課題 3

## 解答 3

学籍番号の管理

- 学生番号を主キーとして使用してしまう場合。学生番号は一意に見えるが、転部や再入学の際に変更される可能性があり、主キーとして適切でない。

キーコードの管理

- 「県番号 (2 桁) 部門 ID(3 桁) 支店 ID(4 桁)」形式の ID でキーコードを作成して主キーにする