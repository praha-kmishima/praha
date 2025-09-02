# curlやpostmanに慣れてみよう

## 課題1-1

>以下のリクエストをcurlコマンドでhttpbinに送信してください。

- カスタムヘッダーを加える（`X-Test='hello'`）
- methodはGET
- URLは`https://httpbin.org/headers`

### 実行結果

2025/8/12 22:06に実行してみたが、なぜか503エラーになっていた（サーバーダウン？）。

何回か時間を空けて実行してみたら、curlの結果が返ってきた。

```bash
 curl -X GET -H "X-Test: hello" https://httpbin.org/headers

 {
   "headers": {
     "Accept": "*/*",
     "Host": "httpbin.org",
     "User-Agent": "curl/8.5.0",
     "X-Amzn-Trace-Id": "Root=1-689b3c0c-567fddfb483b1a9332aafe64",
     "X-Test": "hello"
   }
 }
```

curlのコマンドのオプション引数のメモ
```txt
 主要なオプション
 -X: HTTPメソッドを指定します。
   -X GET: データを取得します（デフォルト）。
   -X POST: データを送信します。
   -X PUT: データを更新します。
   -X DELETE: データを削除します。
 -H: リクエストヘッダーを追加します。
   -H "Content-Type: application/json": 送信するデータの形式を指定します。
   -H "Authorization: Bearer <トークン>": 認証情報を追加します。
 -d: リクエストボディ（データ）を送信します。
   -d '{"key": "value"}': JSONデータを送信する場合などに使います。
 -o: レスポンスをファイルに保存します。
   -o output.html: レスポンスをoutput.htmlという名前で保存します。
 -L: 301や302などのリダイレクトに従います。
 -i: レスポンスヘッダーも表示します。
 -v: 詳細な通信ログ（リクエストとレスポンスのヘッダーなど）を表示します。デバッグに非常に便利です。

```

## 課題1-2

> 以下のリクエストをcurlコマンドでhttpbinに送信してください。
- Content-Typeは`"application/json"`
- methodはPOST
- bodyは `{"name": "hoge"}`
- URLは`https://httpbin.org/post`

### 実行結果

```bash
 curl -X POST -H "Content-Type: application/json" -d '{"name": "hoge"}' https://httpbin.org/post

 {
   "args": {},
   "data": "{\"name\": \"hoge\"}",
   "files": {},
   "form": {},
   "headers": {
     "Accept": "*/*",
     "Content-Length": "16",
     "Content-Type": "application/json",
     "Host": "httpbin.org",
     "User-Agent": "curl/8.5.0",
     "X-Amzn-Trace-Id": "Root=1-689b3d4b-367b0fe66867847c24757476"
   },
   "json": {
     "name": "hoge"
   },
   "origin": "xxx.xxx.xx.xx",
   "url": "https://httpbin.org/post"
 }

```

## 課題1-3

> もう少し複雑なbodyを送信してみましょう。以下のようなネストしたデータをbodyに含めて、送信してください。
> {userA: {name: "hoge", age: 29}}

```bash
curl -X POST -H "Content-Type: application/json" -d '{"userA": {"name": "hoge", "age": 29}}' https://httpbin.org/post

 {
   "args": {},
   "data": "{\"userA\": {\"name\": \"hoge\", \"age\": 29}}",
   "files": {},
   "form": {},
   "headers": {
     "Accept": "*/*",
     "Content-Length": "38",
     "Content-Type": "application/json",
     "Host": "httpbin.org",
     "User-Agent": "curl/8.5.0",
     "X-Amzn-Trace-Id": "Root=1-689b3d88-6aa8cf9c0e72d12f00bd6f1d"
   },
   "json": {
     "userA": {
       "age": 29,
       "name": "hoge"
     }
   },
   "origin": "xxx.xxx.xx.xx",
   "url": "https://httpbin.org/post"
 }
```

## 課題1-4

＞「ごめんごめん、問題２のエンドポイント、まだ`application/json`に対応してないから、Content-Typeは`application/x-www-form-urlencoded`で送ってもらえる？」と先輩に頼まれました。
 Content-Typeを変更して、リクエストを送信してみましょう。

```bash
 curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "name=hoge&age=29" https://httpbin.org/post
 
 {
   "args": {},
   "data": "",
   "files": {},
   "form": {
     "age": "29",
     "name": "hoge"
   },
   "headers": {
     "Accept": "*/*",
     "Content-Length": "16",
     "Content-Type": "application/x-www-form-urlencoded",
     "Host": "httpbin.org",
     "User-Agent": "curl/8.5.0",
     "X-Amzn-Trace-Id": "Root=1-689b3dab-5568eeaa17a7a32940f338eb"
   },
   "json": null,
   "origin": "xxx.xxx.xx.xx",
   "url": "https://httpbin.org/post"
 }
```

## 課題1-5 curlについてのクイズ

#### クイズ1

- curlって、どのOSにも標準装備されているコマンドなのでしょうか？自分でインストールが必要なコマンドなのでしょうか？

#### クイズ2

curlはURL部分をシングルクォートで囲んでも、囲まなくてもコマンドは実行できます。では、以下のコマンドは動作にどのような違いがあるでしょうか？

- `curl localhost:8080?key1=value1&key2=value2`
- `curl 'localhost:8080?key1=value1&key2=value2'`

#### クイズ3

`curl`から出力されたレスポンスを見やすくするため、`jq`というjson整形用のシェルコマンドがcurlと組み合わされて使われるようです。では、以下のコマンドを実行するとどのような帰り値になるでしょうか？

`echo '{"name": "Bob", "age": 40, "city": "Tokyo"}' | jq '.name, .city'`


### 回答

#### クイズ1

Windows, Mac, Linuxなど多くのOS、ディストリビューションで標準装備されている。
https://qiita.com/ko1nksm/items/30982a5f357f26ae166f#%E5%90%84-os-%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E6%83%85%E5%A0%B1

#### クイズ2

クォートがないと、URL部分がメタ文字として判定されてしまう。例えば`&`はバックグラウンド実行を示すメタ文字としてシェルでは扱われている。

https://www.tohoho-web.com/ex/shell.html#meta

[新しい curl コマンドの使い方 完全ガイド（2025年版）
 - Qiita](https://qiita.com/ko1nksm/items/30982a5f357f26ae166f)

#### クイズ3 

```bash
echo '{"name": "Bob", "age": 40, "city": "Tokyo"}' | jq '.name, .city'
# "Bob"
# "Tokyo"
```

[jqコマンドでcurlのJSONレスポンスを見やすくする](https://qiita.com/unsoluble_sugar/items/8a1fcbec2d5e336ecbf3)

## 課題2 postman

未実施です。。

## 任意課題

> 指示に従いながら少しずつcurlコマンドを変更していくゲーム？があるので、もしお時間があればcurlに慣れるためにも遊んでみてください！

https://challenge-your-limits.onrender.com/

やってみた。

curlでPOSTリクエストを4,5回くらい打てばゴールになった。

課題1と同じくらいの難易度だった。