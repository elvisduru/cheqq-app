import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { ShippingZone } from "../../../utils/types";

export default function useDeleteShippingZone() {
  const queryClient = useQueryClient();

  return useMutation(
    (id: number) => api.delete<ShippingZone>("/shipping/" + id),
    {
      onSuccess() {
        queryClient.invalidateQueries(["shippingZones"]);
      },
    }
  );
}
