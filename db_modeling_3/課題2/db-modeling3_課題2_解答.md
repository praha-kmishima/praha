# 課題2-1

>もし上記のシステムに以下のような仕様が追加された場合、どのようなテーブル設計にしますか？
> - ディレクトリ内のドキュメントの順番を変更できる
> - 順番はユーザー間で共有される（例えばAさんがディレクトリ内で`hoge.txt`の前に `fuga.txt`が表示されるように並べ替えたら、Bさんがディレクトリを開いた時に`fuga.txt`が先に表示される）

> 色んなサービスのAPIリクエストを眺めてみると面白いかもしれません。例えばTrelloやAirtableで要素を並び替えてみた時、どんなリクエストが送られているでしょうか？

## テーブル設計

### ER図

![ER](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/ER%E5%9B%B3.png)

新しく、`document_order`テーブルを追加して、各ディレクトリのドキュメントの並び順はこのテーブルで管理する。例えば、タスク1,2,3のドキュメントがある場合、以下のような並びになる。

| directory_id | document_id | name    | rank |
| ------------ | ----------- | ------- | ---- |
| 1            | 1           | タスク1 | 100  |
| 1            | 2           | タスク2 | 200  |
| 1            | 3           | タスク3 | 300  |

タスク1を一番下に並べ替えする場合は`rank`を100→400に変更

| directory_id | document_id | name    | rank |
| ------------ | ----------- | ------- | ---- |
| 1            | 1           | タスク1 | 400  |
| 1            | 2           | タスク2 | 200  |
| 1            | 3           | タスク3 | 300  |

タスク1を中央に並べ替えする場合は`rank`を400→250に変更

| directory_id | document_id | name    | rank |
| ------------ | ----------- | ------- | ---- |
| 1            | 1           | タスク1 | 250  |
| 1            | 2           | タスク2 | 200  |
| 1            | 3           | タスク3 | 300  |

とすることで、rankを昇順させることで並び順を保存できるようになる。

## 実際のサービスでの並べ替え時のリクエスト

### Airtableの場合

入れ替えてみる

![alt text](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/image.png)

![alt text](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/image-1.png)

リクエストを確認してみると、`targetVisibleIndex:3`のリクエストが発行されている。各レコードの並び順は`targetVisibleIndex`が昇順になるように表示している？

![alt text](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/image-2.png)

おそらく、項目を入れ替えるたびにテーブル内の全ての項目の`targetVisibleIndex`を再設定している？（あまり効率は良くなさそうだが、、）

### Trelloの場合

入れ替えてみる

![alt text](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/image-3.png)

![alt text](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/image-5.png)

リクエストをいくつか確認してみたところ、`pos`の値が並び順を示していそう

![alt text](https://github.com/kmishima16/praha/blob/feature/db_modeling_3/%E8%AA%B2%E9%A1%8C2/image-6.png)

stackoverflowにも、並び順の仕様についての質問があった
- [Trello のようにカードやリストを並べ替えるにはどうすればいいですか?](https://stackoverflow.com/questions/60896229/how-to-rearrange-cards-and-lists-like-trello)
- [Trelloはカード、リスト、チェックリストなどの並べ替えをどのように処理しますか](https://stackoverflow.com/questions/29791543/how-does-trello-handle-rearrangement-of-cards-lists-checklists-etc)

Trelloは、移動先の位置によって`pos`の値を設定しているらしい
- リストの一番下：現在の`pos`の最大値+α
- リストの一番上：現在の`pos`の最小値/2
- それ以外：隣接する２つの項目の平均

このやり方だと、`pos`の値が大きくなり、データサイズが無駄に大きくなってしまう懸念があるが、Lexorankというアルゴリズムを使えばデータサイズを減らした形で2つの項目の間の値を設定することができるらしい。
- [githubに公開されているlexorank.jsのライブラリ](https://github.com/acadea/lexorank)
- [zenn-LexoRankで任意順ソートを効率的に保存する](https://zenn.dev/moroya/articles/001745a74c74d5)