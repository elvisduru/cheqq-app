import { PutObjectCommandInput } from "@aws-sdk/client-s3";
import {
  barbellOutline,
  carOutline,
  colorPaletteOutline,
  desktopOutline,
  fastFoodOutline,
  flaskOutline,
  gameControllerOutline,
  homeOutline,
  libraryOutline,
  medicalOutline,
  pawOutline,
  planetOutline,
  shirtOutline,
  sparklesOutline,
} from "ionicons/icons";
import s3Client from "./lib/s3Client";
import { Image, User } from "./utils/types";

export const uploadFiles = async (
  user: User,
  files: File[]
): Promise<Image[]> => {
  return await Promise.all(
    files.map(async (file, index): Promise<Image> => {
      const filePath = `users/${user?.id}/${file.name}`;
      const params: PutObjectCommandInput = {
        Bucket: process.env.REACT_APP_SPACES_BUCKET,
        Key: filePath,
        Body: file,
        ACL: "public-read",
        ContentType: file.type,
      };
      await s3Client.putObject(params);

      return {
        url: `${process.env.REACT_APP_CDN_URL}/${filePath}`,
        sortOrder: index,
        userId: user.id,
      };
    })
  );
};

export const getCurrentDayPeriod = (): string => {
  const currentHour = new Date().getHours();
  if (currentHour < 12) {
    return "morning";
  } else if (currentHour < 18) {
    return "afternoon";
  } else {
    return "evening";
  }
};

export const categoryIcons: Record<string, string> = {
  Fashion: shirtOutline,
  "Food & Grocery": fastFoodOutline,
  Electronics: desktopOutline,
  "Health & Beauty": medicalOutline,
  "Home & Office": homeOutline,
  "Collectibles & Art": colorPaletteOutline,
  "Sports & Outdoors": barbellOutline,
  "Books, Movies & Music": libraryOutline,
  "Toys & Games": gameControllerOutline,
  "Baby Essentials": planetOutline,
  "Pet Supplies": pawOutline,
  "Scientific & Industrial": flaskOutline,
  Automotive: carOutline,
  Others: sparklesOutline,
};

const DEFAULT_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

function getRandomCharFromAlphabet(alphabet: string): string {
  return alphabet.charAt(Math.floor(Math.random() * alphabet.length));
}

export function generateId(
  idDesiredLength: number,
  alphabet = DEFAULT_ALPHABET
): string {
  /**
   * Create n-long array and map it to random chars from given alphabet.
   * Then join individual chars as string
   */
  return Array.from({ length: idDesiredLength })
    .map(() => {
      return getRandomCharFromAlphabet(alphabet);
    })
    .join("");
}
