import { S3Client as S3C } from "@aws-sdk/client-s3";

const s3Client = new S3C({
  endpoint: "https://fra1.digitaloceanspaces.com",
  region: "fra1",
  credentials: {
    accessKeyId: import.meta.env.VITE_SPACES_KEY!,
    secretAccessKey: import.meta.env.VITE_SPACES_SECRET!,
  },
});

export { s3Client };
