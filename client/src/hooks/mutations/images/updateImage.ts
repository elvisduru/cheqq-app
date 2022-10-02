import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Image } from "../../../utils/types";

export default function useUpdateImage() {
  const queryClient = useQueryClient();

  return useMutation(
    (data: Image) => api.patch<Image>("/images/" + data.id, data),
    {
      onSuccess() {
        queryClient.invalidateQueries(["images"]);
      },
    }
  );
}
