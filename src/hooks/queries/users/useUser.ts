import { useQuery } from "react-query";
import appwrite from "../../../lib/appwrite";

export default function useUser() {
  return useQuery("user", appwrite.account.get, {
    enabled: !["/signup", "/login", "/confirm"].includes(
      window.location.pathname
    ),
    retry: 1,
  });
}
