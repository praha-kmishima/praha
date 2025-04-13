---
id: 20250121T22401815
aliases: 
tags: []
created: 2025-01-21T22:40:18
updated: 2025-01-21T22:40:18
sr-due: 2025-01-29
sr-interval: 7
sr-ease: 250
---

## クイズ

play function で、要素のクリック動作をシミュレーションする関数は `userEvent.click()` ですが、Input 要素などに文字を入力する関数はなんでしょうか？

<details>
<summary>クリックして展開</summary>

答え：`userEvent.type()`

具体例：「メールアドレス」というラベルの要素に「john@example.com」と入力します

`await userEvent.type(canvas.getByLabelText('メールアドレス'), 'john@example.com');`

</details>