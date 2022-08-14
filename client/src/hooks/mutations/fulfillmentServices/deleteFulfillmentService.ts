import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { FulfillmentService } from "../../../utils/types";

export default function useDeleteFulfillmentService() {
  const queryClient = useQueryClient();

  return useMutation(
    (id: number) =>
      api.delete<FulfillmentService>("/fulfillment-services/" + id),
    {
      onSuccess() {
        queryClient.invalidateQueries(["fulfillmentServices"]);
      },
    }
  );
}
