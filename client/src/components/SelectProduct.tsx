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

type Props = {
  dismiss: () => void;
};

export default function SelectProduct({ dismiss }: Props) {
  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Select Products</IonTitle>
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
      <IonContent fullscreen></IonContent>
    </>
  );
}
