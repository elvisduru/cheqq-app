import { DeleteObjectCommandInput } from "@aws-sdk/client-s3";
import { useMutation, useQueryClient } from "react-query";
import api from "../../../lib/api";
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
            Bucket: import.meta.env.VITE_SPACES_BUCKET,
            Key: image.url.substring(image.url.indexOf("users")),
          };
          import("../../../lib/s3Client").then(({ s3Client }) => {
            s3Client.deleteObject(params);
          });
        });
      },
    }
  );
}
