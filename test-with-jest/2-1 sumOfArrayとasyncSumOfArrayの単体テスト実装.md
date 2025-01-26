---
id: 20250114T22433055
aliases: 
tags:
  - review
created: 2025-01-14T22:43:30
updated: 2025-01-15T22:04
sr-due: 2025-02-01
sr-interval: 10
sr-ease: 250
---

## sumOfArray

### 実装

```typescript
export const sumOfArray = (numbers: number[]): number => {
  return numbers.reduce((a: number, b: number): number => a + b);
};
```

### 単体テスト

```typescript
// sumOfArray.test.ts
describe('sumOfArray', () => {
    test('配列が空の場合、エラーを返す', () => {
				expect(() => sumOfArray([])).toThrow(Error);
		});
		test('配列内の数値の合計値を返す', () => {
				expect(sumOfArray([1, 2, 3, 4])).toBe(10);
				expect(sumOfArray([0, 0, 0, 0])).toBe(0);
				expect(sumOfArray([-1, -2, -3, -4])).toBe(-10);
		});
});
```

## asyncSumOfArray

### 実装

```typescript
export const asyncSumOfArray = (numbers: number[]): Promise<number> => {
  return new Promise((resolve): void => {
    resolve(sumOfArray(numbers));
  });
};
```

### 単体テスト

```typescript
// asyncSumOfArray.test.ts
describe('asyncSumOfArray', () => {
    test('配列が空の場合、エラーを返す', async () => {
        await expect(asyncSumOfArray([])).rejects.toThrow(Error);
    });
    test('配列内の数値の合計値を非同期で返す', async () => {
        await expect(asyncSumOfArray([1, 2, 3, 4])).resolves.toBe(10);
        await expect(asyncSumOfArray([0, 0, 0, 0])).resolves.toBe(0);
        await expect(asyncSumOfArray([-1, -2, -3, -4])).resolves.toBe(-10);
    });
});
```