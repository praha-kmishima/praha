---
id: 20250120T21390087
aliases: []
tags: [review]
created: 2025-01-20T21:39:00
updated: 2025-01-20T21:39:00
---

## 2-1 storybook のインストール

`npx storybook@latest init` でインストールされて、localhost にページが立ち上がったことを確認

## 2-2 story の作成

各コンポーネントの story を作成しました

なお、チュートリアル実施状態では各コンポーネントが１つの app.js のファイルの中にまとめられていたため、
- `Board.jsx`
- `Square.jsx`
- `Game.jsx`
にそれぞれファイルを切り出した後、各コンポーネントに対する story を作成しています

### Board コンポーネントの story

```jsx
import Board from "./Board";

export default {
  title: 'TicTacToe/Board',
  component: Board,
  parameters: {
    layout: 'centered',
  },
};

export const EmptyBoard = {
  args: {
    xisNext: true,
    squares: Array(9).fill(null),
    onPlay: () => console.log('played'),
  },
};

export const InProgress = {
  args: {
    xisNext: false,
    squares: ['X', 'O', 'X', null, 'O', null, null, null, null],
    onPlay: () => console.log('played'),
  },
}; 
```

### Square コンポーネントの story

```jsx
import Square from "./Square";
export default {
  title: 'TicTacToe/Square',
  component: Square,
  parameters: {
    layout: 'centered',
  },
};

export const Empty = {
  args: {
    value: null,
    onClick: () => console.log('clicked'),
  },
};

export const WithX = {
  args: {
    value: 'X',
    onClick: () => console.log('clicked'),
  },
};

export const WithO = {
  args: {
    value: 'O',
    onClick: () => console.log('clicked'),
  },
}; 
```

### preview.js に tictactoe の css を適用

tictactoe のクラスに適用していた `styles.css` が、storybook が生成する web ページ上に反映されていないため、 `preview.js` に変更を加えました

```jsx
/** @type { import('@storybook/react').Preview } */
import '../src/styles.css';  // 追加

const preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;
```

## 2-3 △でマスを埋めた Board を作る

### story の実装

Board に渡す squares を全て配列の△にして、`args` で設定しました

```tsx
import Board from "./Board";

export default {
  title: 'TicTacToe/Board',
  component: Board,
  parameters: {
    layout: 'centered',
  },
};

export const AllTriangles = {
  args: {
    xisNext: false,
    squares: ['△', '△', '△', '△', '△', '△', '△', '△', '△'],
    onPlay: () => console.log('played'),
  },
}; 
```

### web ページでの表示

storybook 上に△で埋め尽くした状態の story が表示されるようになりました

![](attachments/Pasted%20image%2020250120214249.png)

## 2-4 play function を使ってインタラクションのテストを追加する

### 関連パッケージのインストール

play function 機能を使うにあたって、下記ライブラリを新しく追加しました

`npm install @storybook/testing-library`
`npm install @storybook/jest`

### 実際にゲームする play 機能を実装した story

```jsx
import  Game  from './Game';
import { within, userEvent } from '@storybook/testing-library';
import { expect } from '@storybook/jest';

export default {
  title: 'Game',
  component: Game,
  parameters: {
    layout: 'centered',
  },
};

// 基本的なストーリー
export const Default = {
  render: () => <Game />,
};

// 勝利シナリオのテストを追加
export const WinningScenario = {
  render: () => <Game />,
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);
    
    // 遅延用の関数
    const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));
    
    // すべてのマス目を取得
    const squares = canvas.getAllByRole('button');
    
    // X が勝利するパターン（上段横一列）を再現
    // X → 0 → X → 0 → X の順番で選択
    await userEvent.click(squares[0]); // X を配置 (左上)
    await delay(200);
    await userEvent.click(squares[3]); // O を配置
    await delay(200);
    await userEvent.click(squares[1]); // X を配置 (上段中央)
    await delay(200);
    await userEvent.click(squares[4]); // O を配置
    await delay(200);
    await userEvent.click(squares[2]); // X を配置 (右上)

    // 勝利メッセージが表示されることを確認
    const winningMessage = await canvas.findByText('Winner: X');
    await expect(winningMessage).toBeInTheDocument();
  },
};


```

### 動作確認

ゲーム開始から終了までの動作が実行されています

（userEvent.click がされるたびに盤面の位置が動いているが、おそらく css のスタイリングの問題だと思われる）

![Gyazo](https://gyazo.com/665b0d22c790cd8118c472df8568732a.gif)