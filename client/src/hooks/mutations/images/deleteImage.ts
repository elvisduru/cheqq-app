import { DeleteObjectCommandInput } from "@aws-sdk/client-s3";
import { useMutation, useQueryClient } from "react-query";
import api from "../../../lib/api";
import s3Client from "../../../lib/s3Client";
import { Image } from "../../../utils/types";

export function useDeleteImage() {
  const queryClient = useQueryClient();
  return useMutation((id: number) => api.delete<Image>(`/images/${id}`), {
    onSuccess({ data }) {
      queryClient.invalidateQueries("images");
      // delete file from s3 bucket
      const params: DeleteObjectCommandInput = {
        Bucket: import.meta.env.VITE_SPACES_BUCKET,
        Key: data.url.substring(data.url.indexOf("users")),
      };
      s3Client.deleteObject(params);
    },
  });
}
