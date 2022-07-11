import { IonIcon, IonThumbnail } from "@ionic/react";
import { add, checkmarkCircle, imagesOutline } from "ionicons/icons";
import { useEffect } from "react";
import { FieldValues, UseFormSetValue, useWatch } from "react-hook-form";
import useAddImages from "../hooks/mutations/images/addImages";
import useUser from "../hooks/queries/users/useUser";
import usePhotoGallery from "../hooks/usePhotoGallery";
import { uploadFiles } from "../utils";
import { Image } from "../utils/types";

type Props = {
  setValue: UseFormSetValue<FieldValues>;
  name: string;
  control: any;
  selected: number;
  setSelected: (index?: number) => void;
};

export default function MediaSelector({
  name,
  control,
  setValue,
  selected,
  setSelected,
}: Props) {
  const { data: user } = useUser(); //TODO: show loading if user data not ready
  const { takePhotos, files, setPhotos, setFiles, uploading } =
    usePhotoGallery();
  const addImages = useAddImages();
  const photos: Image[] = useWatch({
    control,
    name,
  });

  useEffect(() => {
    if (files.length) {
      // upload files to s3
      uploadFiles(user!, files).then((uploadedFiles) => {
        addImages.mutate(uploadedFiles, {
          onSuccess: ({ data }) => {
            // update form state
            setValue("photos", photos ? [...photos, ...data] : data);
            // reset usePhotoGallery hook state
            setPhotos([]);
            setFiles([]);
          },
        });
      });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [files.length, setValue]);

  return (
    <div
      className="border rounded-xl px-4 pt-4 mt-4"
      style={{ borderStyle: "dashed" }}
    >
      {!photos?.length ? (
        <div
          onClick={() => takePhotos()}
          className="flex flex-column items-center ion-justify-content-center"
        >
          <div
            className="rounded-full bg-light flex items-center ion-justify-content-center"
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
        <div className="flex ion-wrap swiper-no-swiping">
          {photos?.length ? (
            <div className="flex ion-wrap">
              {photos.map((photo) => (
                <IonThumbnail
                  key={photo.id}
                  className={`${
                    selected == photo.id ? "border border-primary" : ""
                  } relative rounded mr-4 mb-4 w-16 h-16`}
                  onClick={() => {
                    if (selected === photo.id) {
                      setSelected(undefined);
                    } else {
                      setSelected(photo.id!);
                    }
                  }}
                >
                  {selected === photo.id ? (
                    <IonIcon
                      className="absolute text-primary"
                      size="small"
                      icon={checkmarkCircle}
                    />
                  ) : null}
                  <img
                    src={photo.url}
                    alt=""
                    className="object-center object-cover"
                  />
                </IonThumbnail>
              ))}
              {photos.length < 10 && (
                <IonThumbnail className="bg-light upload-btn rounded mb-4 w-12 h-12 flex ion-justify-content-center items-center">
                  <IonIcon
                    icon={add}
                    size="small"
                    style={{ top: -7, right: -7 }}
                    onClick={() => takePhotos()}
                  />
                </IonThumbnail>
              )}
            </div>
          ) : null}
        </div>
      )}
    </div>
  );
}
