import { NameApiService } from "../nameApiService";
import axios from "axios";
import { FirstNameApiClient } from "../nameApiService";


describe("NameApiService", () => {
    const apiClient = {
        get: jest.fn()
    };
    test("デフォルトは4文字までの名前を取得して返す", async () => {
        apiClient.get.mockResolvedValue("みしまみ");
        const nameApiService = new NameApiService(apiClient);
        await expect(nameApiService.getFirstName()).resolves.toBe("みしまみ");
    });
    test("デフォルトは4文字以上の場合、エラー出力", async () => {
        apiClient.get.mockResolvedValue("ながいみょうじ");
        const nameApiService = new NameApiService(apiClient);
        await expect(nameApiService.getFirstName()).rejects.toThrow("firstName is too long!");
    });
    test("最大文字数は変更可能", async () => {
        apiClient.get.mockResolvedValue("ながいみょうじ");
        const nameApiService = new NameApiService(apiClient, 7);
        await expect(nameApiService.getFirstName()).resolves.toBe("ながいみょうじ");
    });
});

jest.mock("axios");
const mockedAxios = axios as jest.Mocked<typeof axios>;

describe("FirstNameApiClient", () => {
    test("APIから名前を正常に取得する", async () => {
        const firstName = "みしま";
        mockedAxios.get.mockResolvedValue({ data: { first_name: firstName } });

        const apiClient = new FirstNameApiClient();
        const result = await apiClient.get();

        expect(result).toBe(firstName);
    });

    test("APIから名前の取得に失敗した場合、エラーをスローする", async () => {
        mockedAxios.get.mockRejectedValue(new Error("API Error"));

        const apiClient = new FirstNameApiClient();
        await expect(apiClient.get()).rejects.toThrow("Failed to fetch first name from API.");
    });
});