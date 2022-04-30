import {
  Camera,
  CameraResultType,
  CameraSource,
  GalleryPhoto,
  Photo,
} from "@capacitor/camera";
import { useState } from "react";

export default function usePhotoGallery() {
  const [photo, setPhoto] = useState<Photo>();
  const [photos, setPhotos] = useState<GalleryPhoto[]>([]);
  const [file, setFile] = useState<File>();
  const [files, setFiles] = useState<File[]>([]);
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

  const takePhotos = async () => {
    try {
      const newPhotos = await Camera.pickImages({
        quality: 90,
        limit: 10 - photos.length,
      });

      setPhotos((prev) => [...prev, ...newPhotos.photos].slice(0, 10));
      const files = await Promise.all(
        newPhotos.photos.map(async (photo) => {
          const file = await getFileFromPath(photo.webPath!, photo.format);
          return file;
        })
      );
      setFiles((prev) => [...prev, ...files].slice(0, 10));
    } catch (error) {
      console.error(error);
    }
  };

  return {
    photo,
    photos: photos,
    file,
    files,
    takePhoto,
    takePhotos,
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
