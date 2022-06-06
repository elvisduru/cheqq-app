import { S3 } from "@aws-sdk/client-s3";

const s3Client = new S3({
  endpoint: "https://fra1.digitaloceanspaces.com",
  region: "fra1",
  credentials: {
    accessKeyId: process.env.REACT_APP_SPACES_KEY!,
    secretAccessKey: process.env.REACT_APP_SPACES_SECRET!,
  },
});

export default s3Client;
