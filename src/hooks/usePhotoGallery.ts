import {
  Camera,
  CameraResultType,
  CameraSource,
  Photo,
} from "@capacitor/camera";
import { useState } from "react";

export default function usePhotoGallery() {
  const [photo, setPhoto] = useState<Photo>();
  const takePhoto = async () => {
    try {
      console.log("Taking photo");
      const photo = await Camera.getPhoto({
        quality: 90,
        resultType: CameraResultType.Uri,
        source: CameraSource.Prompt,
      });
      setPhoto(photo);
    } catch (error) {
      console.error(error);
    }
  };

  return {
    photo,
    takePhoto,
  };
}
