import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { FulfillmentService } from "../../../utils/types";

export default function useAddFulfillmentService() {
  const queryClient = useQueryClient();

  return useMutation(
    (data: FulfillmentService) =>
      api.post<FulfillmentService>("/fulfillment-services", data),
    {
      onSuccess() {
        queryClient.invalidateQueries(["fulfillmentServices"]);
      },
    }
  );
}
