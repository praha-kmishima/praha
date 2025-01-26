---
id: 20250115T22051238
aliases: 
tags:
  - review
created: 2025-01-15T22:05:12
updated: 2025-01-15T22:27
sr-due: 2025-01-31
sr-interval: 9
sr-ease: 250
---

## nameApiService

### コード変更

変更前の関数だと、
- axios.get()がコード内に埋め込まれている
- axios.get()のAPIにアクセスできなかった時に例外処理が起こるかもしれない
という懸念があったので、apiにアクセスするオブジェクトを依存性注入できるように変更しました。

### 変更前

```typescript
export class NameApiService {
  private MAX_LENGTH = 4;
  public constructor() {}

  public async getFirstName(): Promise<string> {
    const { data } = await axios.get(
      "https://random-data-api.com/api/name/random_name"
    );
    const firstName = data.first_name as string;

    if (firstName.length > this.MAX_LENGTH) {
      throw new Error("firstName is too long!");
    }

    return firstName;
  }
}
```

### 変更後

```typescript
// API処理のインターフェース
interface ApiClient {
  get(): Promise<string>;
}

// APIからfetchするjsonデータの型
type NameResponse = {
  first_name: string;
}

// APIから苗字取得するクラス
export class FirstNameApiClient implements ApiClient {
  public async get(): Promise<string> {
    const url = "https://random-data-api.com/api/name/random_name";
    try {
      const response = await axios.get<NameResponse>(url);
      return response.data.first_name;
    } catch (error) {
      throw new Error("Failed to fetch first name from API.");
    }
  }
}

export class NameApiService {
  private MAX_LENGTH: number;
  private apiClient: ApiClient;
  
  public constructor(apiClient: ApiClient, maxLength: number = 4) {
    this.apiClient = apiClient;
    this.MAX_LENGTH = maxLength; // 最大文字数は指定できるように(デフォルトは4)
  }

  public async getFirstName(): Promise<string> {
    const firstName = await this.apiClient.get(); 

    if (firstName.length > this.MAX_LENGTH) {
      throw new Error("firstName is too long!");
    }

    return firstName;
  }
}
```

### 単体テスト

```typescript
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
```