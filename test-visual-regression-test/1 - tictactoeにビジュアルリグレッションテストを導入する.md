[1 - tictactoeにビジュアルリグレッションテストを導入する](1%20-%20tictactoeにビジュアルリグレッションテストを導入する.md) |  [2,3 - ビジュアルリグレッションテストの具体例とテスト](2,3%20-%20ビジュアルリグレッションテストの具体例とテスト.md) →

---

## 1-1 ビジュアルリグレッションテストを実装する

下記リポジトリに Chromatic を導入して、ビジュアルリグレッションテストを実装しました。

[GitHub - praha-kmishima/tictactoe-chromatic: react + storybook + chromatic](https://github.com/praha-kmishima/tictactoe-chromatic)

Github Actions を用いて、プルリク作成時に storybook をビルドして、過去にビルドした story 同士で自動テストが実行されるようになっています。

[Pull requests · praha-kmishima/tictactoe-chromatic · GitHub](https://github.com/praha-kmishima/tictactoe-chromatic/pulls?q=is%3Apr+is%3Aclosed)

## 1-2 Square の中身を黒色→赤色に変える

[×の文字色を赤色に変える by kmishima16 · Pull Request #4 · praha-kmishima/tictactoe-chromatic · GitHub](https://github.com/praha-kmishima/tictactoe-chromatic/pull/4)

css に変更を加え、

`color: red;`

プルリクエストを発行すると、chromatic 上で前回のマージ時点とのレビューができるようになりました。

![](attachments/Pasted%20image%2020250126140042.png)

story で square の色が変化している差分が確認できます。

![](attachments/Pasted%20image%2020250126140055.png)


すべて Accept して、このプルリクはマージしました。

![](attachments/Pasted%20image%2020250126140104.png)

chromatic では、この前回との UI の差分を比較することを UI Test と呼ぶらしいです。

CI の実行時間が 3 分ぐらいかかることと、アクセス制限などセキュリティ面での運用を考える必要はありそうですが、とても便利だと思いました。

## 3x3 ではなく 4x3 の Board を作成してみる

3 * 3 から 4 * 3 のボードに変更してプルリクエストを発行しました。

[3\*3から4\*3のボードに変更する by kmishima16 · Pull Request #5 · praha-kmishima/tictactoe-chromatic · GitHub](https://github.com/praha-kmishima/tictactoe-chromatic/pull/5)

UI テストに失敗があった通知がでています。

![](attachments/Pasted%20image%2020250126140250.png)

### play function テストが失敗している

詳細を開くと、Game Winning Scenario の Story が失敗しているようでした。

3 * 3 の盤面を想定して play function テストを作成していたので、クリック対象の盤面がうまく取得できなくなっていたようです。

![](attachments/Pasted%20image%2020250126140328.png)

![](attachments/Pasted%20image%2020250126140343.png)

### 更新があった Board の差分検出

3×3 から 3×4 に盤面が変わっていることがキャプチャからわかりました。

![](attachments/Pasted%20image%2020250126141407.png)

このプルリクエストは、マージせず close しました。

![](attachments/Pasted%20image%2020250126140519.png)

### (検証) プルリクが reject されると、最新の snapshot はどの時点になるのか？

プルリクを close したあと、再度×の文字色を黒に戻したときに、story が更新されていないことを確認してみる。

まず、feature ブランチで reject されたコミットを取り消すために、gitlab のコミットグラフ上で Revert commit する。

これで 3×4 の盤面変更コードが取り消される。

![](attachments/Pasted%20image%2020250126140626.png)

次に、`style.css` を編集して、ボードの文字色を黒色に戻す。

その後プルリクを発行して、Chromatic 上のスクリーンショットを確認してみる。

![](attachments/Pasted%20image%2020250126140726.png)

reject したプルリクエスト分の更新は取り消されているで、最後に Accept されたコードベースのキャプチャが最新版となっているようだった。

![](attachments/Pasted%20image%2020250126140836.png)

また、過去のビルド一覧を見てみると、Reject されたビルドも確認することができるようだった。

ステータスごとにビルドが色付けされている。
- 緑：レビュー済みビルド
- 赤：Reject されたビルド
- 黄：レビューされなかったけどマージされたビルド

![Pasted image 20250126140914](attachments/Pasted%20image%2020250126140914.png)

### Baselines

ブランチや差分比較の概念・進め方については [Branches and baselines • Chromatic docs](https://www.chromatic.com/docs/branching-and-baselines/) で Chromatic 公式が説明しているようだ。

![](attachments/Pasted%20image%2020250126141114.png)

