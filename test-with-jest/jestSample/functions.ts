import { NameApiService } from "./nameApiService";
import { DatabaseMock } from "./util";

export const sumOfArray = (numbers: number[]): number => {
  return numbers.reduce((a: number, b: number): number => a + b);
};

export const asyncSumOfArray = (numbers: number[]): Promise<number> => {
  return new Promise((resolve): void => {
    resolve(sumOfArray(numbers));
  });
};


// DatabaseMockが満たすべきインターフェース
interface IDatabase {
  save: (numbers: number[]) => void;
};


export const asyncSumOfArraySometimesZero = (
  numbers: number[],
  database: IDatabase
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

// NameApiServiceが満たすべきインターフェース
interface INameApiService {
  getFirstName: () => Promise<string>;
}

export const getFirstNameThrowIfLong = async (
  maxNameLength: number,
  nameApiService: INameApiService
): Promise<string> => {
  const firstName = await nameApiService.getFirstName();

  if (firstName.length > maxNameLength) {
    throw new Error("first_name too long");
  }
  return firstName;
};
