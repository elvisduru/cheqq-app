import { Storage } from "@capacitor/storage";
import axios from "axios";
import createAuthRefreshInterceptor, {
  AxiosAuthRefreshRequestConfig,
} from "axios-auth-refresh";

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  headers: {
    accept: "*/*",
    "Content-Type": "application/json",
  },
});

enum TokenEnum {
  access_token = "access_token",
  refresh_token = "refresh_token",
}

const getToken = async (key: TokenEnum) => {
  const data = await Storage.get({ key });
  return data.value;
};

api.interceptors.request.use(async (request) => {
  const accessToken = await getToken(TokenEnum.access_token);
  if (accessToken) {
    request.headers!.Authorization! = `Bearer ${accessToken}`;
  }
  return request;
});

const refreshAccessToken = async (failedRequest: any) => {
  const refreshToken = await getToken(TokenEnum.refresh_token);
  if (!refreshToken) {
    console.log("No refresh token found");
    return Promise.reject(failedRequest);
  }
  const response = await axios.get(
    `${import.meta.env.VITE_API_URL}/auth/refresh`,
    {
      skipAuthRefresh: true,
      headers: {
        Authorization: `Bearer ${refreshToken}`,
      },
    } as AxiosAuthRefreshRequestConfig
  );
  if (response.status !== 200) {
    console.log("Refresh token failed");
  }
  await Promise.all([
    Storage.set({
      key: TokenEnum.access_token,
      value: response.data.access_token,
    }),
    Storage.set({
      key: TokenEnum.refresh_token,
      value: response.data.refresh_token,
    }),
  ]);
  failedRequest.response.config.headers.Authorization = `Bearer ${response.data.access_token}`;
  return Promise.resolve();
};

createAuthRefreshInterceptor(api, refreshAccessToken, {
  statusCodes: [401, 403],
});

export default api;
