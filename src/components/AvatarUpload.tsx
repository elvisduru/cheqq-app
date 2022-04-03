import { IonIcon, IonThumbnail } from "@ionic/react";
import { addCircle, person } from "ionicons/icons";
import usePhotoGallery from "../hooks/usePhotoGallery";

type Props = {};

export default function AvatarUpload({}: Props) {
  const { photo, takePhoto } = usePhotoGallery();
  return (
    <IonThumbnail
      onClick={takePhoto}
      className="flex ion-align-items-center ion-align-self-center ion-justify-content-center border rounded-full my-2 relative w-8 h-8"
    >
      {photo ? (
        <img src={photo.webPath} alt="avatar" />
      ) : (
        <IonIcon icon={person} className="text-6xl" />
      )}
      <IonIcon
        icon={addCircle}
        color="primary"
        className="absolute bottom-0 right-0 text-5xl drop-shadow-2xl"
      />
    </IonThumbnail>
  );
}
