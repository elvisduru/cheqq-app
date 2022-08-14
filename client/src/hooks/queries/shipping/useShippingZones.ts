import { useQuery } from "@tanstack/react-query";
import api from "../../../lib/api";
import { ShippingZone } from "../../../utils/types";

const getShippingZones = async (storeId: number) => {
  const { data } = await api.get<ShippingZone[]>(`/shipping/store/${storeId}`);
  return data;
};

export default function useShippingZones(storeId: number) {
  return useQuery(["shippingZones"], () => getShippingZones(storeId));
}
