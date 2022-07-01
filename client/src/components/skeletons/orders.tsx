import {
  IonItem,
  IonLabel,
  IonList,
  IonSkeletonText,
  IonThumbnail,
} from "@ionic/react";

type Props = {
  length: number;
};

export default function OrdersSkeleton({ length }: Props) {
  return (
    <IonList lines="none" className="mt-2">
      {new Array(length).fill(0).map((_, index) => (
        <IonItem key={index} className="mt-2">
          <IonThumbnail slot="start">
            <IonSkeletonText className="rounded-full" animated />
          </IonThumbnail>
          <IonLabel>
            <h2>
              <IonSkeletonText animated className="w-3/5 h-4" />
            </h2>
            <p>
              <IonSkeletonText animated className="w-4/5 h-4" />
            </p>
          </IonLabel>
          <IonLabel slot="end">
            <h2>
              <IonSkeletonText animated className="w-24 h-4" />
            </h2>
            <p>
              <IonSkeletonText animated className="w-24 h-4" />
            </p>
          </IonLabel>
        </IonItem>
      ))}
    </IonList>
  );
}
