import {
  Camera,
  CameraResultType,
  CameraSource,
  GalleryPhoto,
  Photo,
} from "@capacitor/camera";
import { useState } from "react";

export type SortablePhoto = GalleryPhoto & { id: number };
export type SortableFile = File & { id: number };

export default function usePhotoGallery() {
  const [photo, setPhoto] = useState<Photo>();
  const [photos, setPhotos] = useState<SortablePhoto[]>([]);
  const [file, setFile] = useState<File>();
  const [files, setFiles] = useState<SortableFile[]>([]);
  const [uploading, setUploading] = useState(false);

  const takePhoto = async () => {
    try {
      const photo = await Camera.getPhoto({
        quality: 90,
        resultType: CameraResultType.Uri,
        source: CameraSource.Prompt,
        webUseInput: true,
        allowEditing: true,
      });
      setUploading(true);
      setPhoto(photo);
      const file = await getFileFromPath(photo.webPath!, photo.format);
      setFile(file);
    } catch (error) {
      setUploading(false);
      console.error(error);
    }
  };

  const takePhotos = async (uploadCount = 0) => {
    try {
      const newPhotos = await Camera.pickImages({
        quality: 90,
        limit: 10 - uploadCount,
      });

      setUploading(true);

      // trim photos to 10
      const photosToAdd = newPhotos.photos.slice(0, 10 - uploadCount);
      setPhotos((prev) =>
        [...prev, ...photosToAdd]
          .slice(0, 10)
          .map((photo, index) => ({ ...photo, id: index }))
      );
      const files = await Promise.all(
        photosToAdd.map(async (photo, index) => {
          const file: File = await getFileFromPath(
            photo.webPath!,
            photo.format,
            index
          );
          return file;
        })
      );
      setFiles((prev) =>
        [...prev, ...files].slice(0, 10).map((file, index) => {
          let newFile = file as SortableFile;
          newFile.id = index;
          return newFile as SortableFile;
        })
      );
    } catch (error) {
      setUploading(false);
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
    setPhotos,
    setFiles,
    uploading,
    setUploading,
  };
}

// Function to Get File object from Uri
export async function getFileFromPath(
  path: string,
  extension: string,
  index?: number
): Promise<File> {
  const res = await fetch(path);
  const blob = await res.blob();
  const file = new File(
    [blob],
    `${
      index
        ? `${Date.now() + index}.${extension}`
        : `${Date.now()}.${extension}`
    }`,
    {
      type: blob.type,
    }
  );
  return file;
}
