import { sumOfArray } from "../functions";

describe('sumOfArray', () => {
    test('配列内の数値の合計値を返す', () => {
        expect(sumOfArray([1, 2, 3, 4])).toBe(10);
        expect(sumOfArray([0, 0, 0, 0])).toBe(0);
        expect(sumOfArray([-1, -2, -3, -4])).toBe(-10);
    });

    test('空の配列を渡した場合は0を返す', () => {
        expect(sumOfArray([])).toBe(0);
    });


});



