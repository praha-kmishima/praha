---
id: 20250120T12352119
aliases: 
tags:
  - review
created: 2025-01-20T12:35:21
updated: 2025-01-20T12:35:21
sr-due: 2025-01-23
sr-interval: 3
sr-ease: 250
---
# 課題2

## 課題2-1

境界づけられたコンテキストの実例を一つ挙げてください。

<aside>
💡 例：「商品」という名前の概念を製造部門と経理部門が扱う際、同じ「価格」というプロパティだとしても、製造部門だと原価、経理部門だと注文金額の意味を持つ、など

</aside>

## 課題2-2

以下のプロパティを持つ「Human」エンティティを作成してください。

- 識別子(ID)
- 血液型
- 生年月日
- 名前

## 課題2-3

上記のHumanモデリングを担当した新人エンジニアからこんな事を聞かれました。

> Humanクラスを設計しろと言われたので[こんなコード](https://www.typescriptlang.org/play?#code/MYGwhgzhAEASCuBbMA7aBvAUNH1gHsUIAXAJ3mGP1IAoAHeAIxAEthpSBTMAE0JACe0FjwBc0EqRYoA5gBpoDZmw7c+KQdGb58PYgLqdxk6fMVNW7Lr35DGLUsQAWPMMSPQAIm84Kll1RsNIRQwRA8TWQBKDGxceJYAM2gaAEJnFggAOgA3MFYeAAVSfDoIGnQROW1dfUNqh2dXdzlQ8IBfKJj0aGcSgHdoFE5BgFFSEtoAcmk8gsUSuimY9ricVbWFljz3aDmRYtLyukWIcUqxCTJTBRq9Awjr2VvGlx9xbxahsMepWU7xIwdCBuGgsPF4lxiPBSGgMtl9jwAJI8einLIiGIAMixvScmVy+REACEQDp7oY0Ucsnc6pxsbj4YSCsTXs1OFSyjS2T4GXiCYiAHI-TnZNr0zareInbY+PZE5GoubwX6mKKiIH4EGoDDQAD0ACpoIBIc0AnUqAKwYkZ5AOYMgCEGQDRDIBouUAdgyABYZAFcMgHGGQA-DIB2hkA5wyAZ4ZAEkMgBkIwBiDNADXrVNDYb1yJxoFLcDKdknEaTyXSaMrVdENcDQbrDSaLYABCMATbaAaPU7U63V6-UGw5Ho7GYXDE8nNmm5Zmee4aPZHG93B9eYWtcWeqWzebAPiugBc9QAQ5oBT0zrLo9PoDIYjUZjUI7CZV3elUnT8oKwvCNHFxieMnVmu1YP1RrngFgVQCyShuG9vm3ubaHvGZAnqsGxAA)を書いたら、別の先輩に『プロパティはデータ型じゃなくて値オブジェクトにしておいて』って言われたんです。何がダメなんですか？
> 

さて、何がいけないのでしょう？

## 課題2-4

先ほど新人エンジニアが作成した「Human」エンティティの各プロパティを値オブジェクトに置き換えてください。それぞれの値オブジェクトには以下のルールが存在します。

- ID：英数字のみ許容（!や$などの特殊記号は利用不可）
- 血液型：a,b,o,ab以外の値は設定できない
- 生年月日：20歳以上の生年月日しか設定できない
- 名前：20文字未満でなければいけない


