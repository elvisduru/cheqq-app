import {
  DeleteObjectCommand,
  DeleteObjectCommandInput,
} from "@aws-sdk/client-s3";
import { useMutation, useQueryClient } from "react-query";
import api from "../../../lib/api";
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
      import("../../../lib/s3Client").then(({ s3Client }) => {
        const command = new DeleteObjectCommand(params);
        s3Client.send(command);
      });
    },
  });
}
