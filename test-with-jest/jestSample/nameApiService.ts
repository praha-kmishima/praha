import axios from "axios";

// API処理のインターフェースを作成
interface ApiClient {
  get(): Promise<string>;
}

// APIにアクセスして苗字を返すクラスを作成
export class FirstNameApiClient implements ApiClient {
  public constructor() {
  }
  public async get(): Promise<string> {
    const url = "https://random-data-api.com/api/name/random_name";
    return await axios.get(url);
  }
}

export class NameApiService {
  private MAX_LENGTH = 4;
  private apiClient: ApiClient;
  public constructor(apiClient: ApiClient) {
    this.apiClient = apiClient;
  }

  public async getFirstName(): Promise<string> {
    const firstName = await this.apiClient.get(); 

    if (firstName.length > this.MAX_LENGTH) {
      throw new Error("firstName is too long!");
    }

    return firstName;
  }
}
