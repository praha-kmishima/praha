---
id: 20250121T22130200
aliases: 
tags: []
created: 2025-01-21T22:13:02
updated: 2025-01-21T22:13:02
sr-due: 2025-01-25
sr-interval: 3
sr-ease: 250
---

← [3-1 storybookのメリットとデメリット](3-1%20storybookのメリットとデメリット.md) | 

## testing library の基本原則

「The more your tests resemble the way your software is used, the more confidence they can give you.」

> テストがソフトウェアの使用方法と似ていれば似ているほど、信頼性は高まる。

testing-libarary では、テストを書きやすくする手法として以下の 3 つが挙げられている：

1. Queries Accessible to Everyone
2. Semantic Queries
3. Test IDs

## 今回の課題のテストを書きやすくするためには？

９つの Square 要素にアクセスしやすくするために、aria 要素を以下のように振っておく。

```jsx
<Square aria-label="square 1"/>
```

こうすると、story 上で要素を取得するクエリが書きやすくなり、DOM 操作のコードの可読性が上がる。

```jsx
// 1つ目の×
const x1 = canvas.getByLabelText('square 1');
await userEvent.click(x1);

// 1つ目のo
const o1 = canvas.getByLabelText('square 3');
await userEvent.click(o1);

// 2つ目のx
const x2 = canvas.getByLabelText('square 7');
await userEvent.click(x2);

```

## testing-library のドキュメント

AI に翻訳させています。

testing-library を活用するためには、id 属性や aria-label などを使って各要素が取得しやすいコンポーネントを実装することが大事なようです。

### Queries Accessible to Everyone

1. `getByRole`: 最優先で使用すべきクエリです。
    
    - 例: `getByRole('button', {name: /送信/i})`
    - ボタン、リンク、フォーム要素などほとんどの要素に使用可能
    - `aria-label` や `aria-labelledby` 属性を活用して要素を特定
    
2. `getByLabelText`: フォームフィールドに最適
    
    - 例: `getByLabelText('ユーザー名')`
    - ラベルとフォーム要素の関連付けを確認できる
    
3. `getByPlaceholderText`: プレースホルダーテキストでの検索
    
    - 例: `getByPlaceholderText('メールアドレスを入力')`
    - ラベルがない場合の代替手段として使用
    
4. `getByText`: 非インタラクティブ要素の検索に使用
    
    - 例: `getByText('ようこそ')`
    - 段落、見出し、スパンなどのテキストコンテンツを持つ要素に使用
    
5. `getByDisplayValue`: フォーム要素の現在の値で検索
    
    - 例: `getByDisplayValue('John Doe')`
    - 入力済みのフォームをテストする際に有用

### Semantic Queries

1. `getByAltText`: 画像や入力要素の代替テキストで検索
    
    - 例: `getByAltText('プロフィール画像')`
    
2. `getByTitle`: title 属性で要素を検索
    
    - 例: `getByTitle('詳細情報')`
    - ただし、スクリーンリーダーでの読み上げが一貫していないため、優先度は低い
    

### Test IDs

1. `getByTestId`: 最後の手段として使用
    
    - 例: `getByTestId('submit-button')`
    - `data-testid` 属性を要素に追加して使用
    - 他の方法で要素を特定できない場合にのみ使用