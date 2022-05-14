import { Query } from "appwrite";
import { useInfiniteQuery } from "react-query";
import appwrite from "../../../lib/appwrite";

export default function useOrders(id: string) {
  return useInfiniteQuery(
    "orders",
    ({ pageParam }) =>
      appwrite.database.listDocuments(
        "orders",
        [Query.equal("store_id", id)],
        10,
        0,
        pageParam
      ),
    {
      getNextPageParam: (lastPage) => {
        return lastPage.documents[lastPage.documents.length - 1]?.$id;
      },

      enabled: false,
    }
  );
}
