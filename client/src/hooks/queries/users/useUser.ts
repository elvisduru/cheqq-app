import { useQuery } from "react-query";
import api from "../../../lib/api";
import { User } from "../../../utils/types";

const getUser = async () => {
  const { data } = await api.get<User>("/users/current");
  return data;
};

export default function useUser() {
  return useQuery("user", getUser, {
    enabled: !["/signup", "/login", "/magic-link"].includes(
      window.location.pathname
    ),
    retry: 1,
  });
}
