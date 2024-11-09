import { NameApiService } from "../nameApiService";


describe("NameApiService", () => {
   // getFirstNameメソッドが成功した場合
    test("getFirstNameが成功した場合、firstNameを返す", async () => {
        // テスト毎にAPIにアクセスしてほしくないので、モックを作成
        const apiClient = {
            get: jest.fn()
        };
        // モックのgetメソッドを上書き
        apiClient.get.mockResolvedValue("みしま");

         const nameApiService = new NameApiService(apiClient);
         await expect(nameApiService.getFirstName()).resolves.toBe("みしま");
    });
  // getFirstNameメソッドが失敗した場合
  test("getFirstNameが失敗した場合、エラーを返す", async () => {
    // テスト毎にAPIにアクセスしてほしくないので、モックを作成
    const apiClient = {
      get: jest.fn()
    };
    apiClient.get.mockResolvedValue("ながいみょうじ");
    const nameApiService = new NameApiService(apiClient);
    await expect(nameApiService.getFirstName()).rejects.toThrow("firstName is too long!");
  });

});