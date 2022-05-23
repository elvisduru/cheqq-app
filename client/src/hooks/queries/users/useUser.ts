import { useQuery } from "react-query";
import api from "../../../lib/api";

export default function useUser() {
  return useQuery("user", () => api.get("/users/current"), {
    enabled: !["/signup", "/login", "/confirm"].includes(
      window.location.pathname
    ),
    retry: 1,
  });
}
