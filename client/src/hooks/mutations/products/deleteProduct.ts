import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Product } from "../../../utils/types";
import { useStore } from "../../useStore";

export default function useDeleteProduct() {
  const physicalFormData = useStore((store) => store.physicalFormData);
  const setPhysicalFormData = useStore((store) => store.setPhysicalFormData);
  const queryClient = useQueryClient();
  return useMutation((id: number) => api.delete<Product>("/products/" + id), {
    onSuccess({ data }) {
      queryClient.invalidateQueries(["products"]);
      if (physicalFormData?.id === data.id) {
        setPhysicalFormData(undefined);
      }
    },
  });
}
