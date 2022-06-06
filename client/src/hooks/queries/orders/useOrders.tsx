import { useInfiniteQuery } from "react-query";
import api from "../../../lib/api";

const fetchOrders = async ({ pageParam }: any) => {
  const { data } = await api.get(`/orders/current?cursor=${pageParam}`);
  return data;
};

export default function useOrders(id?: string) {
  return useInfiniteQuery("orders", fetchOrders, {
    getNextPageParam: (lastPage) => {
      return lastPage[lastPage.length - 1]?.id;
    },
  });
}
