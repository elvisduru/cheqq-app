import { IonIcon, IonThumbnail } from "@ionic/react";
import { add, closeCircle, imagesOutline } from "ionicons/icons";
import { useEffect, useState } from "react";
import { FieldValues, UseFormSetValue } from "react-hook-form";
import { ReactSortable } from "react-sortablejs";
import usePhotoGallery from "../hooks/usePhotoGallery";
import useReRender from "../hooks/useReRender";

type Props = {
  setValue: UseFormSetValue<FieldValues>;
};

export default function MediaUploader({ setValue }: Props) {
  const { photos, takePhotos, files, setPhotos } = usePhotoGallery();
  const forceUpdate = useReRender();
  const [isSorting, setIsSorting] = useState(false);
  useEffect(() => {
    if (files) {
      setValue("photos", files);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [files.length, setValue]);

  return (
    <div
      className="border rounded-xl p-1 mt-1"
      style={{ borderStyle: "dashed" }}
    >
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
          <ReactSortable
            className="flex ion-wrap"
            onUpdate={() => setIsSorting(true)}
            list={photos}
            setList={(newState) => {
              if (!isSorting) return;
              setIsSorting(false);
              setPhotos(newState);
            }}
          >
            {photos.map((photo, index) => (
              <IonThumbnail
                key={photo.id}
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
                  alt=""
                  className="object-center object-cover"
                />
              </IonThumbnail>
            ))}
          </ReactSortable>
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
