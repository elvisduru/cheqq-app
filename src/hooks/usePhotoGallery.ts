import {
  Camera,
  CameraResultType,
  CameraSource,
  Photo,
} from "@capacitor/camera";
import { useState } from "react";

export default function usePhotoGallery() {
  const [photo, setPhoto] = useState<Photo>();
  const [file, setFile] = useState<File>();
  const takePhoto = async () => {
    try {
      const photo = await Camera.getPhoto({
        quality: 90,
        resultType: CameraResultType.Uri,
        source: CameraSource.Prompt,
        allowEditing: true,
      });
      setPhoto(photo);
      const file = await getFileFromPath(photo.webPath!, photo.format);
      setFile(file);
    } catch (error) {
      console.error(error);
    }
  };

  return {
    photo,
    file,
    takePhoto,
  };
}

// Function to Get File object from Uri
export async function getFileFromPath(
  path: string,
  extension: string
): Promise<File> {
  const res = await fetch(path);
  const blob = await res.blob();
  const file = new File([blob], `${new Date().getTime()}.${extension}`, {
    type: blob.type,
  });
  return file;
}
