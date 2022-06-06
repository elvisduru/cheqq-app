import {
  Camera,
  CameraResultType,
  CameraSource,
  GalleryPhoto,
  Photo,
} from "@capacitor/camera";
import { useCallback, useEffect, useState } from "react";

type SortablePhoto = GalleryPhoto & { id: number };

export default function usePhotoGallery() {
  const [photo, setPhoto] = useState<Photo>();
  const [photos, setPhotos] = useState<SortablePhoto[]>([]);
  const [file, setFile] = useState<File>();
  const [files, setFiles] = useState<File[]>([]);

  useEffect(() => {
    getFilesFromPhotos();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [photos]);

  const getFilesFromPhotos = useCallback(async () => {
    const files = await Promise.all(
      photos.map(async (photo) => {
        const file = await getFileFromPath(photo.webPath!, photo.format);
        return file;
      })
    );
    setFiles(files);
  }, [photos]);

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

      setPhotos((prev) =>
        [...prev, ...newPhotos.photos]
          .slice(0, 10)
          .map((photo, index) => ({ ...photo, id: index }))
      );
      // const files = await Promise.all(
      //   newPhotos.photos.map(async (photo) => {
      //     const file = await getFileFromPath(photo.webPath!, photo.format);
      //     return file;
      //   })
      // );
      // setFiles((prev) =>
      //   [...prev, ...files]
      //     .slice(0, 10)
      //     .map((file, index) => ({ ...file, id: index }))
      // );
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
    setPhotos,
  };
}

// Function to Get File object from Uri
export async function getFileFromPath(
  path: string,
  extension: string
): Promise<File> {
  const res = await fetch(path);
  const blob = await res.blob();
  const file = new File([blob], `${Date.now()}.${extension}`, {
    type: blob.type,
  });
  return file;
}
