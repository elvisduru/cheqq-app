import { IonIcon, IonThumbnail } from "@ionic/react";
import { addCircle, person } from "ionicons/icons";
import { useEffect } from "react";
import { UseFormSetValue } from "react-hook-form";
import usePhotoGallery from "../hooks/usePhotoGallery";

type Props = {
  setValue: UseFormSetValue<{
    name: string;
    avatar: File;
  }>;
};

export default function AvatarUpload({ setValue }: Props) {
  const { photo, file, takePhoto } = usePhotoGallery();
  useEffect(() => {
    if (file) {
      setValue("avatar", file);
    }
  }, [file, setValue]);
  return (
    <IonThumbnail
      onClick={takePhoto}
      className="flex items-center ion-align-self-center ion-justify-content-center border rounded-full my-8 relative w-32 h-32"
    >
      {photo ? (
        <img src={photo.webPath} alt="avatar" className="rounded-full" />
      ) : (
        <IonIcon icon={person} className="text-6xl" />
      )}
      <IonIcon
        icon={addCircle}
        color="primary"
        className="absolute bottom-0 right-0 text-4xl drop-shadow-2xl"
      />
    </IonThumbnail>
  );
}
