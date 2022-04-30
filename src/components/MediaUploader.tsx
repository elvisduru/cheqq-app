import { IonIcon, IonThumbnail } from "@ionic/react";
import { add, close, closeCircle, imagesOutline } from "ionicons/icons";
import React, { useEffect } from "react";
import { FieldValues, UseFormSetValue } from "react-hook-form";
import usePhotoGallery from "../hooks/usePhotoGallery";
import useReRender from "../hooks/useReRender";

type Props = {
  setValue: UseFormSetValue<FieldValues>;
};

export default function MediaUploader({ setValue }: Props) {
  const { photos, takePhotos, files } = usePhotoGallery();
  const forceUpdate = useReRender();
  useEffect(() => {
    if (files) {
      setValue("photos", files);
    }
  }, [files.length, setValue]);
  return (
    <div className="border rounded-xl p-1 mt-1">
      {!photos?.length ? (
        <div
          onClick={takePhotos}
          className="flex flex-column ion-align-items-center ion-justify-content-center"
        >
          <div
            className="rounded-full bg-light flex ion-align-items-center ion-justify-content-center"
            style={{
              padding: "0.5rem",
              fontSize: 25,
              width: 45,
              height: 45,
            }}
          >
            <IonIcon icon={imagesOutline} />
          </div>
          <p>Add Photos</p>
        </div>
      ) : (
        <div className="flex ion-wrap">
          {photos.map((photo, index) => (
            <IonThumbnail
              key={index}
              className="rounded mr-1 mb-1 relative w-3 h-3"
            >
              <IonIcon
                icon={closeCircle}
                size="small"
                className="absolute"
                style={{ top: -7, right: -7 }}
                onClick={() => {
                  files.splice(index, 1);
                  photos.splice(index, 1);
                  forceUpdate();
                }}
              />
              <img
                src={photo.webPath}
                alt="photo"
                className="object-center object-cover"
              />
            </IonThumbnail>
          ))}
          {photos.length < 10 && (
            <IonThumbnail className="bg-light rounded mr-1 mb-1 w-3 h-3 flex ion-justify-content-center ion-align-items-center">
              <IonIcon
                icon={add}
                size="small"
                style={{ top: -7, right: -7 }}
                onClick={takePhotos}
              />
            </IonThumbnail>
          )}
        </div>
      )}
    </div>
  );
}