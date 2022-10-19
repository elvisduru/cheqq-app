import { useInfiniteQuery } from "@tanstack/react-query";
import api from "../../../lib/api";

const fetchProducts = async (pageParam: any, filter: any) => {
  const { data } = await api.get(
    `/products?cursor=${pageParam}&take=10${
      filter ? `&filter=${JSON.stringify(filter)}` : ""
    }`
  );
  console.log(data);

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
    }
  );
}
