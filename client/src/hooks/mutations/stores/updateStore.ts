import { useMutation, useQueryClient } from '@tanstack/react-query';
import api from "../../../lib/api";
import { Store } from "../../../utils/types";

export default function useUpdateStore() {
  const queryClient = useQueryClient();

  return useMutation(
    (data: Store) => api.patch<Store>("/stores/current", data),
    {
      onSuccess() {
        queryClient.invalidateQueries(['store']);
      },
    }
  );
}
