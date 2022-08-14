import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { ShippingZone } from "../../../utils/types";

export default function useAddShippingZone() {
  const queryClient = useQueryClient();

  return useMutation(
    (data: ShippingZone) => api.post<ShippingZone>("/shipping", data),
    {
      onSuccess() {
        queryClient.invalidateQueries(["shippingZones"]);
      },
    }
  );
}
