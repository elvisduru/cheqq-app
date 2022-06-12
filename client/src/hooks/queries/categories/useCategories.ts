import { useQuery } from "react-query";
import api from "../../../lib/api";
import { Category } from "../../../utils/types";

const getCategories = async (filters: any) => {
  if (filters) {
    const { data } = await api.get<Category[]>("/categories", {
      params: {
        ...filters,
      },
    });
    return data;
  } else {
    const { data } = await api.get<Category[]>("/categories");
    return data;
  }
};

export default function useCategories(filters?: any) {
  return useQuery(["categories", filters], () => getCategories(filters));
}
