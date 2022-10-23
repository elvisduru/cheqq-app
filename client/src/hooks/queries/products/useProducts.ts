import { useInfiniteQuery } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Product } from "../../../utils/types";

const fetchProducts = async (pageParam: any, filter: any) => {
  const { data } = await api.get<Product[]>(
    `/products?cursor=${pageParam}&take=10${
      filter ? `&filter=${JSON.stringify(filter)}` : ""
    }`
  );
  return data;
};

export default function useProducts(filter: any) {
  return useInfiniteQuery(
    ["products"],
    ({ pageParam }) => fetchProducts(pageParam, filter),
    {
      getNextPageParam: (lastPage) => {
        return lastPage[lastPage.length - 1]?.id;
      },
      getPreviousPageParam: (firstPage) => {
        return firstPage[0]?.id;
      },
    }
  );
}
