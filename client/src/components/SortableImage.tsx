import { arraySwap, useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { IonIcon, IonThumbnail, isPlatform } from "@ionic/react";
import { closeCircle } from "ionicons/icons";
import { ImageWithRequiredId } from "../utils/types";

type Props = {
  photo: ImageWithRequiredId;
  handleDelete?: (id: number) => void;
  styles?: any;
};

function getNewIndex({ id, items, activeIndex, overIndex }: any) {
  return arraySwap(items, overIndex, activeIndex).indexOf(id);
}

export default function SortableImage({ photo, handleDelete, styles }: Props) {
  const { attributes, listeners, setNodeRef, transform, transition } =
    useSortable({ id: photo.id, getNewIndex });

  const style = {
    transition,
    transform: CSS.Transform.toString(transform),
    ...styles,
  };

  return (
    <IonThumbnail
      key={photo.id}
      className="rounded mr-4 mb-4 relative w-16 h-16 touch-auto"
      ref={setNodeRef}
      style={style}
    >
      <IonIcon
        icon={closeCircle}
        size="small"
        className="absolute -top-3 -right-3"
        onTouchStart={() => {
          if (!isPlatform("hybrid")) return;
          if (handleDelete) handleDelete(photo.id);
        }}
        onClick={() => {
          if (isPlatform("hybrid")) return;
          if (handleDelete) handleDelete(photo.id);
        }}
      />
      <img
        {...attributes}
        {...listeners}
        src={photo.url}
        alt=""
        className="object-center object-cover"
      />
    </IonThumbnail>
  );
}
