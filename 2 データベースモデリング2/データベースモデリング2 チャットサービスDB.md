# データベースモデリング 2 チャットサービス DB

## ER 図

![](attachments/Pasted%20image%2020250413135455.png)

- [ER図のリンク(dbdiagram)](https://dbdiagram.io/d/データベースモデリング2-slack-65f5c16dae072629ce2cd5d5)

## DDL

[テーブル作成](./docker-mysql/script/01DDL.sql)

## DML

- [ユーザ、ワークスペース、チャンネルの作成](./docker-mysql/script/02DML.sql)
- [ワークスペース1への投稿](./docker-mysql/script/03DML_workspace1.sql)
- [ワークスペース2への投稿](./docker-mysql/script/04DML_workspace2.sql)

### ユースケースに応じた SQL

#### 1.所属ワークスペースの取得

```sql
SELECT workspace_id
FROM users_in_workspace
WHERE user_id = 1;
```

| workspace_id |
| -----------: |
|            1 |
|            2 |

- DDL で作成したワークスペース 1,2 が表示されている

#### 2.ワークスペースの所属、脱退

```sql
DELETE FROM users_in_workspace AS u
WHERE u.user_id = 1 AND u.workspace_id = 1;

INSERT INTO users_in_workspace (workspace_id, user_id) VALUES
  (1, 1);
```

- INSERT,DELETE でワークスペースの所属、脱退が可能
- チャンネルの所属、脱退も同様

#### 3.所属チャンネルの取得

```sql
SELECT
  u.user_id, 
  u.channel_id,
  channels.name AS channel_name,
  c.workspace_id
FROM users_in_channel AS u
LEFT JOIN channels_in_workspace AS c
  ON u.channel_id = c.channel_id
LEFT JOIN channels
  ON u.channel_id = channels.id
WHERE u.user_id = 4
;
```

| user_id | channel_id | channel_name       | workspace_id |
| ------: | ---------: | ------------------ | -----------: |
|       4 |          1 | Python1            |            1 |
|       4 |          2 | Python2            |            1 |
|       4 |          4 | Python4            |            1 |
|       4 |          5 | Python5            |            1 |
|       4 |          6 | ProductManagement1 |            2 |
|       4 |          7 | ProductManagement2 |            2 |
|       4 |          8 | ProductManagement3 |            2 |
|       4 |          9 | ProductManagement4 |            2 |

- ユーザ 4 が所属しているチャンネルの一覧
- DML 文ではワークスペース 1 のチャンネル 3 のみ参加させていなかったので、クエリ処理が正しく発行できている

#### 4.チャンネル１の投稿メッセージ取得

```sql
SELECT
  msg.channel_id,
  msg.user_id,
  users.name,
  msg.content,
  CASE
    WHEN msg.id IN (select message_id FROM thread_messages) THEN TRUE
    ELSE FALSE
  END AS "スレッド有無フラグ",
  msg.created_at AS "投稿日時"
FROM messages AS msg
LEFT JOIN users
  ON msg.user_id = users.id
WHERE msg.channel_id = 1;
```

| message_id | channel_id | user_id | name | content | スレッド有無フラグ | 投稿日時 | 
| ---: | ---: | ---: | --- | --- | ---: | --- | 
| 1 | 1 | 1 | John | Python って便利ですよね。 | 1 | 2024-03-20 21:29:14 | 
| 2 | 1 | 2 | Alice | はい、特にデータ処理が得意ですね。 | 0 | 2024-03-20 21:29:14 | 
| 3 | 1 | 3 | Bob | 私も Python を使っています。 | 1 | 2024-03-20 21:29:14 | 
| 4 | 1 | 4 | Dan | 最近は機械学習のために Python を勉強中です。 | 0 | 2024-03-20 21:29:14 | 
| 5 | 1 | 1 | John | 機械学習、面白そうですね！ | 1 | 2024-03-20 21:29:14 | 
| 6 | 1 | 1 | John | Python の文法は比較的簡単ですよね。 | 0 | 2024-03-20 21:29:14 | 
| 7 | 1 | 2 | Alice | はい、他の言語と比べて読みやすいです。 | 1 | 2024-03-20 21:29:14 | 
| 8 | 1 | 3 | Bob | 私も Python のシンプルさが好きです。 | 0 | 2024-03-20 21:29:14 | 
| 9 | 1 | 4 | Dan | データサイエンスにおいて Python は欠かせませんね。 | 0 | 2024-03-20 21:29:14 | 
| 10 | 1 | 3 | Bob | そうですね、特に Pandas や NumPy が強力ですね。 | 0 | 2024-03-20 21:29:14 | 

- チャンネル 1 の投稿メッセージのリスト
- 各メッセージにスレッドが紐づいているかどうかを IN 演算子で求めている
  - スレッド有無フラグとしてカラムを用意した

#### 5.メッセージ ID１に紐づくスレッドメッセージ取得

```sql
SELECT 
  thread_msg.id AS thread_message_id, 
  thread_msg.message_id,
  users.name,
  thread_msg.content,
  thread_msg.created_at AS "投稿日時"
FROM thread_messages AS thread_msg
LEFT JOIN users
  ON thread_msg.user_id = users.id
WHERE thread_msg.message_id = 1;
```

| thread_message_id | message_id | name  | content                        | 投稿日時                |
| ----------------: | ---------: | ----- | ------------------------------ | ------------------- |
|                 1 |          1 | Alice | はい、Pandas はデータ処理に便利ですね。         | 2024-03-20 21:29:14 |
|                 2 |          1 | Bob   | 私も Pandas を使っていますが、使いこなすのは難しいです。 | 2024-03-20 21:29:14 |

- メッセージ id=1 のスレッドに投稿されたメッセージ一覧
- スレッドメッセージにさらにスレッドを作る、ということはできない

#### 6.メッセージの横断検索

```sql
SELECT *
from(
    SELECT 
      msg.id AS message_id,
      0 AS thread_message_id,
      msg.content,
      msg.channel_id,
      msg.created_at
    FROM messages AS msg
    UNION
    SELECT
      thread_msg.message_id AS message_id,
      thread_msg.id AS thread_message_id,
      thread_msg.content,
      msg.channel_id,
      thread_msg.created_at
    FROM thread_messages AS thread_msg
    LEFT JOIN messages AS msg
      ON thread_msg.message_id = msg.id
) AS subquery
WHERE subquery.content LIKE "%Python%"
  AND subquery.channel_id IN (
    SELECT u.channel_id FROM users_in_channel AS u
     WHERE u.user_id = 4
  )
;
```

| message_id | thread_message_id | content | channel_id | created_at | 
| ---: | ---: | --- | ---: | --- | 
| 1 | 0 | Python って便利ですよね。 | 1 | 2024-03-20 21:29:14 | 
| 3 | 0 | 私も Python を使っています。 | 1 | 2024-03-20 21:29:14 | 
| 4 | 0 | 最近は機械学習のために Python を勉強中です。 | 1 | 2024-03-20 21:29:14 | 
| 6 | 0 | Python の文法は比較的簡単ですよね。 | 1 | 2024-03-20 21:29:14 | 
| 8 | 0 | 私も Python のシンプルさが好きです。 | 1 | 2024-03-20 21:29:14 | 
| 9 | 0 | データサイエンスにおいて Python は欠かせませんね。 | 1 | 2024-03-20 21:29:14 | 
| 11 | 0 | Python で Web アプリケーションを開発しています。 | 2 | 2024-03-20 21:29:14 | 
| 13 | 0 | 私も Web 開発は Python でやっています。 | 2 | 2024-03-20 21:29:14 | 
| 31 | 0 | Python での並列処理、どうやっていますか？ | 4 | 2024-03-20 21:29:14 | 
| 39 | 0 | GIL の問題は CPython に限定されるので、別の実装も検討できます。 | 4 | 2024-03-20 21:29:14 | 
| 40 | 0 | Jython や IronPython などの実装もありますね。 | 4 | 2024-03-20 21:29:14 | 
| 41 | 0 | Python でのエラーハンドリングって難しいですよね。 | 5 | 2024-03-20 21:29:14 | 
| 7 | 5 | Python のコミュニティも大きく、情報が豊富ですね。 | 1 | 2024-03-20 21:29:14 | 
| 35 | 18 | 私は Python の並列処理に関しては GIL の影響を受けない方法を探しています。 | 4 | 2024-03-20 21:29:14 | 
| 39 | 20 | IronPython は.NET Framework との統合が強力ですね。 | 4 | 2024-03-20 21:29:14 | 

- Python という文字が含まれるメッセージ、スレッドメッセージを検索
- user4 が所属しているチャンネルに絞って検索
- UNION 句でメッセージテーブルと、スレッドメッセージテーブルを１つのテーブルに結合したクエリを where 句で絞り込んでいる
  - スレッドメッセージかどうかを判定できるように、thread_message_id のカラムを作っている
- user4 が所属していない、チャンネル 3 のメッセージが表示されないのでうまく処理できている