import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { FulfillmentService } from "../../../utils/types";

export default function useUpdateFulfillmentService() {
  const queryClient = useQueryClient();

  return useMutation(
    (data: FulfillmentService) =>
      api.patch<FulfillmentService>("/fulfillment-services/" + data.id, data),
    {
      onSuccess() {
        queryClient.invalidateQueries(["fulfillmentServices"]);
      },
    }
  );
}
