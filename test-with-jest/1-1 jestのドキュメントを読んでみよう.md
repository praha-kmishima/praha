---
id: 20250114T22402398
aliases: 
tags:
  - review
created: 2025-01-14T22:40:23
updated: 2025-01-14T23:16
---

## ドキュメントを読んだ感想

### インストール

- typescript 込みでの jest インストール方法
    - babel か、ts-jest どちらかを利用することが書かれている
    - 裏で何が動いているかよくわかっていないので違いやメリデメが分かっていない
    - そもそもコマンドを打つと、typescript のコードがテストされる仕組みも曖昧
    - nodejs 自体もあまりよくわかっていない、typescript が絡んでくると特にわからん
- ts.config と jest.config
    - どんな時に使うのか理解できてない
    - ts.config は ESModule か CommonJS を選択できることは知っている
    - npm の package.json も npm run のエイリアスを指定できるところしか理解できてない
- jest のグローバル API の型付け方法の部分
    - test を書くときは jest の型 import とかしていないが、やっておいたほうがよいのか？
    - 型付けできたとして、何が嬉しいのか？
- ESLint の eslint-plugin-jest
    - 何を静的解析してくれるのか？
    - 裏で何が動作するのか？
    - どうやってセットアップするか？

### macthers

- `toStrictEqual()`
    - 厳密なチェックの利用に使う、ということは理解できた
    - ではどんな時に使うのか？
    - toEqual() との使い分けパターンってどんなとき？

### async chronous

- コールバック関数のテスト方法
    - 読み通してみたが難しくて理解できなかった
    - そもそもコールバック関数を受け取る関数を作ることがない