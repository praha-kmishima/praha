---
id: 20250114T22462921
aliases: []
tags:
  - review
created: 2025-01-14T22:46:29
updated: 2025-01-15T22:02
sr-due: 2025-01-30
sr-interval: 8
sr-ease: 250
---

## asyncSumOfArraySometimesZero

### コードの変更

database を依存性注入ができる形に変更して、単体テストを作成しました。

### 修正前

```typescript
export const asyncSumOfArraySometimesZero = (
  numbers: number[]
): Promise<number> => {
  return new Promise((resolve): void => {
    try {
      const database = new DatabaseMock(); // fixme: この関数をテストするには、DatabaseMockの使い方を変える必要がありそう！ヒント：依存性の注入
      database.save(numbers);
      resolve(sumOfArray(numbers));
    } catch (error) {
      resolve(0);
    }
  });
};
```

### 修正後

```typescript
// database処理のインターフェース
interface IDatabase {
  save: (numbers: number[]) => void;
};

export const asyncSumOfArraySometimesZero = (
  numbers: number[],
  database: IDatabase　// databaseは引数から受け取る
): Promise<number> => {
  return new Promise((resolve): void => {
    try {
      database.save(numbers);
      resolve(sumOfArray(numbers));
    } catch (error) {
      resolve(0);
    }
  });
};
```

### 単体テスト

`jest.fn()` と `mockImplementation()` で `database.save()` をモック化して、単体テストを実装しました

```typescript
// asyncSumOfArraySometimesZero.test.ts
const mockDatabase = {
    save: jest.fn()
};
test('渡された数値の合計を返す', async () => {
    const x = [1, 2, 3, 4];
    mockDatabase.save.mockImplementation(() => {});
    const result = await asyncSumOfArraySometimesZero(x, mockDatabase);
    expect(result).toBe(10);
});
test('データベースの保存に失敗した場合、0を返す', async () => {
    const x = [1, 2, 3, 4];
    mockDatabase.save.mockImplementation(() => {
        throw new Error('fail!');
    });
    const result = await asyncSumOfArraySometimesZero(x, mockDatabase);
    expect(result).toBe(0);
});
test('空の配列を渡された場合、0を返す', async () => {
    const x: number[] = [];
    mockDatabase.save.mockImplementation(() => {});
    const result = await asyncSumOfArraySometimesZero(x, mockDatabase);
    expect(result).toBe(0);
});
```

## getFirstNameThrowIfLong

`NameApiService` を依存性注入できるように変更して、単体テストを実装しました。

### 変更前

```typescript
export const getFirstNameThrowIfLong = async (
  maxNameLength: number
): Promise<string> => {
  const nameApiService = new NameApiService(); // fixme: この関数をテストするには、NameApiServiceの使い方を変える必要がありそう！ヒント：依存性の注入
  const firstName = await nameApiService.getFirstName();

  if (firstName.length > maxNameLength) {
    throw new Error("first_name too long");
  }
  return firstName;
};
```

### 修正後

```typescript
// getFirstNameThrowIfLong.ts
// 名前を取得する処理のインターフェース
interface INameApiService {
  getFirstName: () => Promise<string>;
}

export const getFirstNameThrowIfLong = async (
  maxNameLength: number,
  nameApiService: INameApiService // 引数から呼び出し
): Promise<string> => {
  const firstName = await nameApiService.getFirstName();

  if (firstName.length > maxNameLength) {
    throw new Error("first_name too long");
  }
  return firstName;
};
```

### 単体テスト

`jest.fn()` と `mockResolvedValue()`, `mockRejectedValue()` で `nameApiService.getFirstName()` をモック化して、単体テストを実装しました

```typescript
// getFirstNameThrowIfLong.test.ts
const nameApiService = {
    getFirstName: jest.fn()
};
test('指定文字数以下であれば苗字を返す', async () => {
    const len = 4;
    nameApiService.getFirstName.mockResolvedValue('三島');
    const result = await getFirstNameThrowIfLong(len, nameApiService);    
    expect(result).toBe('三島');
});

test('指定文字数を超える苗字だとエラーを返す', async () => {
    const len = 4;
    nameApiService.getFirstName.mockResolvedValue('プラハチャレンジ');
    await expect(getFirstNameThrowIfLong(len, nameApiService)).rejects.toThrow('first_name too long');
});

test('渡された苗字取得クラス側でエラーが起こる場合もある', async () => {
    const len = 4;
    nameApiService.getFirstName.mockRejectedValue(new Error());
    await expect(getFirstNameThrowIfLong(len, nameApiService)).rejects.toThrow();
});
```