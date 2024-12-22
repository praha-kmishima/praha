import axios from "axios";

// API処理のインターフェースを作成
interface ApiClient {
  get(): Promise<string>;
}

interface NameResponse {
  first_name: string;
}

// APIにアクセスして苗字を返すクラスを作成
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
    this.MAX_LENGTH = maxLength;
  }

  public async getFirstName(): Promise<string> {
    const firstName = await this.apiClient.get(); 

    if (firstName.length > this.MAX_LENGTH) {
      throw new Error("firstName is too long!");
    }

    return firstName;
  }
}
