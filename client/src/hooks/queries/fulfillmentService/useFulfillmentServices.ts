import { useQuery } from "@tanstack/react-query";
import api from "../../../lib/api";
import { FulfillmentService } from "../../../utils/types";

const getFulfillmentServices = async (storeId: number) => {
  const { data } = await api.get<FulfillmentService[]>(
    "/fulfillment-services/store/" + storeId
  );
  return data;
};

export default function useFulfillmentServices(storeId: number) {
  return useQuery(["fulfillmentServices"], () =>
    getFulfillmentServices(storeId)
  );
}
