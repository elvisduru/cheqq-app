import {
  closestCenter,
  DndContext,
  KeyboardSensor,
  MouseSensor,
  TouchSensor,
  useSensor,
  useSensors,
} from "@dnd-kit/core";
import {
  arraySwap,
  rectSwappingStrategy,
  SortableContext,
  sortableKeyboardCoordinates,
} from "@dnd-kit/sortable";
import { IonIcon, IonLoading, IonSpinner, IonThumbnail } from "@ionic/react";
import { add, imagesOutline } from "ionicons/icons";
import { useEffect, useState } from "react";
import { UseFormSetValue, useWatch } from "react-hook-form";
import useAddImages from "../hooks/mutations/images/addImages";
import { useDeleteImage } from "../hooks/mutations/images/deleteImage";
import usePhotoGallery from "../hooks/usePhotoGallery";
import { uploadFiles } from "../utils";
import { ImageWithRequiredId, ProductInput, User } from "../utils/types";
import SortableImage from "./SortableImage";

type Props = {
  setValue: UseFormSetValue<ProductInput>;
  user: User;
  name: string;
  control: any;
};

// TODO: 1.Camera and 2.Upload Media buttons instead of just Upload
export default function MediaUploader({
  name,
  control,
  setValue,
  user,
}: Props) {
  const { takePhotos, files, setPhotos, setFiles, uploading, setUploading } =
    usePhotoGallery();
  const deleteImage = useDeleteImage();
  const addImages = useAddImages();

  const [activeIndex, setActiveIndex] = useState<number | null>(null);

  const photos: ImageWithRequiredId[] = useWatch({
    control,
    name,
  });

  const sensors = useSensors(
    useSensor(TouchSensor),
    useSensor(MouseSensor),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    })
  );

  const handleDragEnd = ({ ...props }) => {
    const { active, over } = props;

    if (active.id !== over?.id) {
      const oldIndex = photos.findIndex((photo) => photo.id === active.id);
      const newIndex = photos.findIndex((photo) => photo.id === over?.id);
      const sortedPhotos = arraySwap(photos, oldIndex, newIndex);
      setValue("images", sortedPhotos);
    }

    setActiveIndex(null);
  };

  const handleDragStart = ({ ...props }) => {
    const { active } = props;
    const index = photos.findIndex((photo) => photo.id === active.id);
    setActiveIndex(index);
  };

  useEffect(() => {
    if (files.length) {
      // upload files to s3
      setUploading(true);
      uploadFiles(user, files).then((uploadedFiles) => {
        addImages.mutate(uploadedFiles, {
          onSuccess: ({ data }) => {
            // update form state
            setValue("images", photos ? [...photos, ...data] : data);
            // reset usePhotoGallery hook state
            setPhotos([]);
            setFiles([]);
            setUploading(false);
          },
          onError: () => {
            setUploading(false);
          },
        });
      });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [files.length, setValue]);

  const handleDelete = (id: number) => {
    deleteImage.mutate(id, {
      onSuccess: (_, id) => {
        setValue(
          "images",
          photos.filter((photo) => photo.id !== id)
        );
      },
      onError: (_, id) => {
        setValue(
          "images",
          photos.filter((photo) => photo.id !== id)
        );
      },
    });
  };

  return (
    <>
      <IonLoading isOpen={uploading} />
      <IonLoading isOpen={deleteImage.isLoading} message="Deleting image..." />
      <div
        className="border rounded-xl px-4 pt-4 mt-4"
        style={{ borderStyle: "dashed" }}
      >
        {!photos?.length ? (
          <div
            onClick={() => {
              takePhotos(photos?.length || 0);
            }}
            className="flex flex-col items-center ion-justify-content-center"
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
              <div className="flex flex-wrap">
                <DndContext
                  sensors={sensors}
                  collisionDetection={closestCenter}
                  onDragStart={handleDragStart}
                  onDragEnd={handleDragEnd}
                >
                  <SortableContext
                    items={photos}
                    strategy={rectSwappingStrategy}
                  >
                    {photos.map((photo, index) => (
                      <SortableImage
                        styles={activeIndex === index ? { opacity: 0.4 } : {}}
                        key={photo.id}
                        photo={photo}
                        handleDelete={handleDelete}
                      />
                    ))}
                    <IonThumbnail
                      className={`${
                        photos.length < 10 ? "" : "hidden"
                      } bg-light upload-btn rounded mb-4 w-12 h-12 flex ion-justify-content-center items-center`}
                    >
                      {uploading ? (
                        <IonSpinner name="crescent" />
                      ) : (
                        <IonIcon
                          icon={add}
                          size="small"
                          style={{ top: -7, right: -7 }}
                          onClick={() => takePhotos(photos?.length || 0)}
                        />
                      )}
                    </IonThumbnail>
                  </SortableContext>
                </DndContext>
              </div>
            ) : null}
          </div>
        )}
      </div>
    </>
  );
}
