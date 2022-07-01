import { DeleteObjectCommandInput } from "@aws-sdk/client-s3";
import { useMutation, useQueryClient } from "react-query";
import api from "../../../lib/api";
import s3Client from "../../../lib/s3Client";
import { Image } from "../../../utils/types";

export function useDeleteImages() {
  const queryClient = useQueryClient();
  return useMutation(
    (data: Image[]) => api.delete<Image[]>("/images", { data }),
    {
      onSuccess({ data }) {
        queryClient.invalidateQueries("images");
        // delete files from s3 bucket
        data.forEach((image) => {
          const params: DeleteObjectCommandInput = {
            Bucket: process.env.REACT_APP_SPACES_BUCKET,
            Key: image.url.substring(image.url.indexOf("users")),
          };
          s3Client.deleteObject(params);
        });
      },
    }
  );
}
