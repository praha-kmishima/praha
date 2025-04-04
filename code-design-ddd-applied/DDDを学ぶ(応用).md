## 課題 1-1 「ログインしているユーザしか投稿できない」のようなアクセス制御ロジックはどの層に実装すべきでしょうか？

「ログインしているユーザしか投稿できない」という仕様が具体的にどんな処理を行うのか？
- URL アクセス自体を禁止するべきなのか
- 投稿ボタンが押された時に、ログイン状態をもとに投稿可能判定を行うのか
- アクセス時に、ページ内の投稿ボタンがアクティブ or 非アクティブになっていればよいのか
- ログインの認証はどうやって行うのか (Cookie, Session)

全体の仕様によって実装方法も変わり、記述する層によって表現できる処理の範囲も異なるはず。

ポイントとしては、「認証機能を実装する場合、どの層に記述するかの判断基準は何なのか？」というところのはず。

まずは、各層でログイン認証を行う場合の実装方法を記載する。

### ドメイン層で認証を実装するパターン

ドメイン層で実装する場合、投稿サービスなら Post エンティティと、User エンティティがあるはず

仕様としては、「ログインしているユーザであれば、投稿ができる」なので、Post と User の複数集約を用いた実装が必要になる。

ドメインモデルは異なる集約のドメインモデルには依存できないので、PostPermission のようなドメインサービスを作る必要がある。

これを踏まえてコードを書くと、以下の通り

```ts
class Post {
  constructor(
    public readonly id: PostId
    public readonly authorId: UserId,
    private content: string,
  ) {}

  create(user: User, content: string, permission: PostPermission): Post {
    if (!permission.canCreate(user)) {
      throw new DomainError("作成権限がありません");
    }
    const postId = postId.generate();
    const post = new Post(postId, user.id, content);
    return
  }
}

class PostPermission { 
  canCreate(user: User): boolean {
	    return user.isLoggedIn(); 
	}
}
```

メリット
- ドメイン層に認証ルールを閉じ込められるので、認証ルールの管理がしやすい
- 投稿可能な分岐パターンが複雑化したときに強い
	- 管理職じゃないと見れないとか、人事考課期間中じゃないと投稿できないとか

デメリット
- Postに置くべき実装と、Userに置くべき実装と、PostPermissionに置くべき実装の区別が曖昧
- もっと複雑な仕様が増えた時に、ドメインサービスをどうやって管理するかは事前に見通しておきたい

### ユースケース層で認証を実装するパターン

ユースケース層で実装する場合、User エンティティをチェックして、処理の分岐を行えばよい

```ts
class CreatePostUseCase {
  constructor() {}

  execute(user: User, content: string) {
    if (!user.isLoggedIn) {
      throw new Error("ログインが必要です");
    }
    
    const newPost = new Post(user.id, content);
    return this.postRepository.save(newPost);
  }
}

```

メリット
- 実装がシンプル

デメリット
- ただし、認証パターンが増えてきた場合、ビジネスロジックの記述箇所が分散され、処理修正時の動作確認コストが上がる
- DDDでは、ユースケース層で複数集約の参照・更新は望ましくないとされている

### インフラ層で認証を実装するパターン

middleware とか、ルーターなどで、セッションやクッキーをもとにレスポンスを変える

```ts
app.post('/posts', (context) => { 
	if (!c.var.session.user) { 
		return c.json({ error: 'Unauthorized' }, 401) 
	} 
	return createPostUseCase.execute(c.var.session.user.id, c.req.body) 
}
```

メリット
- Web フレームワーク側の認証メカニズムを直接利用できる
- URL アクセス単位での認証チェックが行える

デメリット
- URL単位でしかチェックできない

### 結論：ケースバイケースだが、まずはアプリケーション層から書いていくと良さそう

アプリケーション層にドメインロジックが複数記載されるようになった場合には、ドメインサービスへの移行を検討する

ドメインサービスがさらに複雑化していった場合は、ドメインイベントへの移行も視野に入れる

## 課題 1-2 ログイン状態を持った user オブジェクトをどの層で実装すべきか？

アプリケーション層で実装すべき
- 認証はユースケースの一部である
- アプリケーション層はドメイン層と認証を呼び出し、実行することを担当する層
- 認証におけるトークン検証はインフラ層に移譲する

## 課題 1-3 複数集約の整合性を担保するための実装方法

複数集約を整合しつつ実装するための方法は、
- ユースケース内で複数集約を更新
- ドメインサービスで複数集約を更新
- ドメインイベントで複数集約を更新
- Saga パターンで複数集約を更新

など様々な実装パターンがある。

どの実装パターンを選択するかは、整合性・実装の複雑さ・拡張性を考慮して選択する必要がある。

### 整合性の用語定義

- 強い整合性
	- 1 トランザクションで状態が更新されること
- 結果整合性
	- 複数トランザクションで状態が更新されること
	- 非同期処理で実現されることが多い

### 実装パターンの特徴

| 実装方法       | 結合度   | 整合性の種類 | 実装の複雑さ | スケーラビリティ | 適切な場面              |
| :--------- | :---- | :----- | :----- | :------- | :----------------- |
| ユースケースでの更新 | 高い    | 強い整合性  | 低い     | 低い       | 小規模システム、開発初期段階     |
| ドメインサービス   | やや高い  | 強い整合性  | 中程度    | 低い       | ドメイン知識の明確な表現が必要な場合 |
| ドメインイベント   | 低い    | 結果整合性  | 高い     | 高い       | 集約間の疎結合が重要な場合      |
| Saga パターン   | 非常に低い | 結果整合性  | 非常に高い  | 非常に高い    | 分散システム、マイクロサービス環境  |

## 課題１-４ User エンティティに認証にかかわる情報をプロパティとして追加することに問題はないのか？

集約内のエンティティに認証処理に使用するプロパティを増やすことで発生する問題

### 単一責任原則に違反する

責務が「認証の管理」と「ユーザ情報の管理」を持つようになってしまう

### データベースのテーブル分割が困難になる

エンティティのプロパティは、DB テーブルのカラムと同じ構成にしたい

認証に関するプロパティを持たせると、「User」と「Account」のようなテーブルの分け方で進めた場合、１つのドメインオブジェクトから２つのテーブルに書き出しが必要になるため、リポジトリの実装が複雑になる

### ドメインロジックにドメインルール以外が記載されてしまう可能性がある

ドメイン層にプレゼン層のルールが持ち込まれ、各層の境界が曖昧になってしまう

### 単体テストが困難になる

認証状態も含めて、プロパティを用意して User エンティティを生成する必要が出てくる

単体テストは、認証状態も考慮したテストケースが必要になってきてしまい、複雑化につながる

### 関連キーワード

- 腐敗防止層
- 認証コンテキスト
- アクセスコンテキスト
- DDD における認証

## 課題 1-5 ドメインオブジェクトでエラーを throw した。こうすることで起こり得る問題は何か？

### エラーハンドリングが強制される

アプリケーション層などで Post を生成する際に、実装者はエラーが起きるかどうか確認しておく必要がある

### try-catch 式はネストが深くなってしまう

エラー処理のに対処する記述箇所が偏在する

正常系と異常系の処理が分かれる形になり可読性が悪い

### 未処理の例外がプレゼン層でキャッチされる可能性がある

ユーザにとって不適切なエラーになる可能性がある

401 エラーなどが発生した場合、ユーザはなぜエラーになったのか把握できない
