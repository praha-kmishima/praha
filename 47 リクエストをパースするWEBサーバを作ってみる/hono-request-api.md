SSのレポジトリにエラーを報告すると、エラーを再現する最小限のサンプルを求められることが多々あります。

どれだけ開発に習熟した人でも情報が不足していたらデバッグは困難なので、「自分がpullして手元で起動できる最小限のサンプルを作って欲しい」と頼まれることは、実際の現場でも起こり得ます。

また、何かを説明する時や、新しいライブラリーを追加する時に、最小限のサンプルを作成して動作確認することがあります。開発者として新しいことを試みる際には、最小限のサンプルを作成して扱う機会が増えてくるはずです。

こうした取り組みに慣れていくために、まずはシンプルなWEBサーバを作成して、これからの課題に取り組む際に活用していきましょう！

https://separated-rover-67e.notion.site/WEB-11a633efdb0b809bb586df5137e12c19

## 課題1 GET,POSTリクエストを処理するWebサーバを作る

### 仕様

`curl localhost:8080 -H "Content-Type: application/json"`

- 結果: `{text: "hello world"}` が返ってくるはずです。


`curl localhost:8080 -d '{"name": "hoge"}' -H "Content-Type:application/json"`

- 結果: `{"name": "hoge"}` が返ってくるはずです。

`curl localhost:8080 -d '{"name": "hoge"}'`
- 結果: HTTPステータス `400` でエラーが発生するはずです。


### index.ts

[実装しました](https://github.com/praha-kmishima/praha-hono/blob/49e1d000a789d6a9267947030c451e65608af130/src/index.ts)

[参考 - Hono Request](https://hono.dev/docs/api/request#json)

```js
import { serve } from '@hono/node-server'
import { Hono } from 'hono'

const app = new Hono()

app.get('/', (c) => {
  return c.json({ text: "hello world" }, 200)
})

app.post('/', async (c) => {
  if (c.req.header('content-type') !== 'application/json') {
    return c.text('Bad Request', 400)
  }
  const body = await c.req.json()
  return c.json(body, 201)
})

serve({
  fetch: app.fetch,
  port: 8080
}, (info) => {
  console.log(`Server is running on http://localhost:${info.port}`)
})
```

### 動作結果

```txt
> curl localhost:8080 -H "Content-Type: application/json"
  {"text":"hello world"}
→ OK

> curl localhost:8080 -d '{"name": "hoge"}' -H "Content-Type: application/json"                                      
  {"name":"hoge"}
→ OK

> curl localhost:8080 -d '{"name": "hoge"}'
  Bad Request
→ OK
```

## 課題2　Content-typeに`application/x-www-form-urlencoded`を指定した時と、`application/json`を指定した時で、送信されるデータ形式がどのように異なるのか説明してください。

### `application/x-www-form-urlencoded`
 
リクエストボディはキーと値のペアを`&`で連結し、特殊文字をURLエンコードした文字列で送信される。

サーバ側はURL文字列をデコードしてパースする。

HTMLの`<form>`要素のデフォルトの送信形式で、ブラウザがform要素からリクエストを送信する際は、通常この形式でリクエストが送信される。

### `application/json`

リクエストボディはJSON形式（オブジェクトや配列など）で送信される。

また、サーバ側はJSONとしてパースする。

複雑なデータ構造や配列の表現がJSON形式だと容易なため、多くのAPIでリクエストの標準形式として使われている。
