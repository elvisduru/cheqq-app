import { useMutation, useQueryClient } from "@tanstack/react-query";
import api from "../../../lib/api";
import { Image } from "../../../utils/types";

export default function useAddImages() {
  const queryClient = useQueryClient();

  return useMutation((data: Image[]) => api.post<Image[]>("/images", data), {
    onSuccess() {
      queryClient.invalidateQueries(["images"]);
    },
  });
}
