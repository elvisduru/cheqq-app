import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import React from "react";
import withSuspense from "./hoc/withSuspense";
const SelectCollections = withSuspense<any>(
  React.lazy(() => import("./collections/SelectCollections"))
);
const SelectProducts = withSuspense<any>(
  React.lazy(() => import("./products/SelectProducts"))
);

type Props = {
  dismiss: () => void;
  type: string;
};

export default function SelectItems({ dismiss, type }: Props) {
  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle className="capitalize">Select {type}</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismiss();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding-horizontal">
        {type === "products" ? (
          <SelectProducts handleSelection={() => {}} />
        ) : (
          <SelectCollections handleSelection={() => {}} />
        )}
      </IonContent>
    </>
  );
}
