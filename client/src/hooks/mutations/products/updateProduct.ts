import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Product } from "../../../utils/types";

export default function useUpdateProduct() {
  const queryClient = useQueryClient();
  return useMutation(
    (data: Product) => api.patch<Product>("/products/" + data.id, data),
    {
      onSuccess() {
        queryClient.invalidateQueries(["products"]);
      },
    }
  );
}
