import { sumOfArray, asyncSumOfArray, asyncSumOfArraySometimesZero } from "../functions";

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


describe('asyncSumOfArraySometimesZero', () => {
    // モック用のデータベースクラス
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
});

// getFirstNameThrowIfLongのテスト
import { getFirstNameThrowIfLong } from "../functions";
describe('getFirstNameThrowIfLong', () => {
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
    
});

