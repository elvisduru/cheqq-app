import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { ShippingZone } from "../../../utils/types";

export default function useUpdateShippingZone() {
  const queryClient = useQueryClient();

  return useMutation(
    (data: ShippingZone) =>
      api.patch<ShippingZone>("/shipping/" + data.id, data),
    {
      onSuccess() {
        queryClient.invalidateQueries(["shippingZones"]);
      },
    }
  );
}
