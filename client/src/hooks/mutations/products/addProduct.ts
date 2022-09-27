import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Product } from "../../../utils/types";

export default function useAddProduct() {
  const queryClient = useQueryClient();
  return useMutation((data: Product) => api.post<Product>("/products", data), {
    onSuccess() {
      queryClient.invalidateQueries(["products"]);
    },
  });
}
