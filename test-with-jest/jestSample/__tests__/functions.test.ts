import { sumOfArray, asyncSumOfArray, asyncSumOfArraySometimesZero } from "../functions";

describe('sumOfArray', () => {
    test('配列内の数値の合計値を返す', () => {
        expect(sumOfArray([1, 2, 3, 4])).toBe(10);
        expect(sumOfArray([0, 0, 0, 0])).toBe(0);
        expect(sumOfArray([-1, -2, -3, -4])).toBe(-10);
    });

});

describe('asyncSumOfArray', () => {
    test('配列内の数値の合計値を非同期で返す', async () => {
        await expect(asyncSumOfArray([1, 2, 3, 4])).resolves.toBe(10);
        await expect(asyncSumOfArray([0, 0, 0, 0])).resolves.toBe(0);
        await expect(asyncSumOfArray([-1, -2, -3, -4])).resolves.toBe(-10);
    });
});


describe('asyncSumOfArraySometimesZero', () => {
    // モック用のデータベースクラス
    const mockDatabase = {
        save: jest.fn()
    };

    test('データベースの保存に成功した場合、合計値を返す', async () => {
        await expect(asyncSumOfArraySometimesZero([1, 2, 3, 4], mockDatabase)).resolves.toBe(10);
        expect(mockDatabase.save).toHaveBeenCalledWith([1, 2, 3, 4]);
    });

    test('データベースの保存に失敗した場合、0を返す', async () => {
        // モックのsaveメソッドを上書き (失敗するようにする)
        mockDatabase.save.mockImplementation(() => {
            throw new Error('fail!');
        });
        await expect(asyncSumOfArraySometimesZero([1, 2, 3, 4], mockDatabase)).resolves.toBe(0);
    });
});




