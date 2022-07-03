import { IonIcon, IonSpinner, IonThumbnail, isPlatform } from "@ionic/react";
import { add, closeCircle, imagesOutline } from "ionicons/icons";
import { useEffect, useState } from "react";
import { FieldValues, UseFormSetValue, useWatch } from "react-hook-form";
import { ReactSortable } from "react-sortablejs";
import useAddImages from "../hooks/mutations/images/addImages";
import { useDeleteImage } from "../hooks/mutations/images/deleteImage";
import usePhotoGallery from "../hooks/usePhotoGallery";
import { uploadFiles } from "../utils";
import { Image, User } from "../utils/types";

type Props = {
  setValue: UseFormSetValue<FieldValues>;
  user: User;
  name: string;
  control: any;
};

type ImageWithRequiredId = Image & { id: number };

export default function MediaUploader({
  name,
  control,
  setValue,
  user,
}: Props) {
  const { takePhotos, files, setPhotos, setFiles, uploading, setUploading } =
    usePhotoGallery();
  const [isSorting, setIsSorting] = useState(false);
  const deleteImage = useDeleteImage();
  const addImages = useAddImages();

  const photos: Image[] = useWatch({
    control,
    name,
  });

  useEffect(() => {
    if (files.length) {
      // upload files to s3
      setUploading(true);
      uploadFiles(user, files).then((uploadedFiles) => {
        addImages.mutate(uploadedFiles, {
          onSuccess: ({ data }) => {
            // update form state
            setValue("photos", photos ? [...photos, ...data] : data);
            // reset usePhotoGallery hook state
            setPhotos([]);
            setFiles([]);
            setUploading(false);
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
          onClick={() => {
            if (uploading) return;
            takePhotos();
          }}
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
            {uploading ? (
              <IonSpinner name="crescent" />
            ) : (
              <IonIcon icon={imagesOutline} />
            )}
          </div>
          <p>Add Photos</p>
        </div>
      ) : (
        <div className="flex ion-wrap swiper-no-swiping">
          {photos?.length ? (
            <ReactSortable
              className="flex ion-wrap"
              onUpdate={() => setIsSorting(true)}
              list={photos as ImageWithRequiredId[]}
              setList={(newState) => {
                if (!isSorting) return;
                setIsSorting(false);
                // Update images sort order
                setValue("photos", newState);
              }}
              animation={150}
              filter=".upload-btn"
              preventOnFilter
            >
              {photos.map((photo) => (
                <IonThumbnail
                  key={photo.id}
                  className="rounded mr-4 mb-4 relative w-16 h-16"
                >
                  <IonIcon
                    icon={closeCircle}
                    size="small"
                    className="absolute -top-3 -right-3"
                    onTouchStart={() => {
                      if (isPlatform("desktop")) return;
                      deleteImage.mutate(photo.id!, {
                        onSuccess: (_, id) => {
                          setValue(
                            "photos",
                            photos.filter((photo) => photo.id !== id)
                          );
                        },
                      });
                    }}
                    onClick={() => {
                      console.log("clicked delete icon");
                      // delete photo from server update form state
                      deleteImage.mutate(photo.id!, {
                        onSuccess: (_, id) => {
                          setValue(
                            "photos",
                            photos.filter((photo) => photo.id !== id)
                          );
                        },
                      });
                    }}
                  />
                  <img
                    src={photo.url}
                    alt=""
                    className="object-center object-cover"
                  />
                </IonThumbnail>
              ))}
              {photos.length < 10 && (
                <IonThumbnail className="bg-light upload-btn rounded mb-4 w-12 h-12 flex ion-justify-content-center items-center">
                  {uploading ? (
                    <IonSpinner name="crescent" />
                  ) : (
                    <IonIcon
                      icon={add}
                      size="small"
                      style={{ top: -7, right: -7 }}
                      onClick={takePhotos}
                    />
                  )}
                </IonThumbnail>
              )}
            </ReactSortable>
          ) : null}
        </div>
      )}
    </div>
  );
}
