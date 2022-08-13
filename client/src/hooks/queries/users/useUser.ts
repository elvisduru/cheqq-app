import { useQuery } from '@tanstack/react-query';
import api from "../../../lib/api";
import { User } from "../../../utils/types";
import { useStore } from "../../useStore";

const getUser = async () => {
  const { data } = await api.get<User>("/users/current");
  useStore.setState({ user: data });
  return data;
};

export default function useUser() {
  return useQuery(['user'], getUser, {
    enabled: !["/signup", "/login", "/magic-link"].includes(
      window.location.pathname
    ),
    retry: 1,
  });
}
