import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from "../../../lib/api";
import { Store } from "../../../utils/types";

export default function useAddStore() {
  const queryClient = useQueryClient();

  return useMutation((data: Store) => api.post<Store>("/stores", data), {
    onSuccess() {
      queryClient.invalidateQueries(['store']);
    },
  });
}
