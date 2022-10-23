import { useQuery } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Product } from "../../../utils/types";

const getProduct = async (id: number) => {
  const { data } = await api.get<Product>("/products/" + id);
  return data;
};

export default function useProduct(id: number) {
  return useQuery(["products", id], () => getProduct(id), {
    enabled: !!id,
  });
}
