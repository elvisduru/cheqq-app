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
import withSuspense from "../hoc/withSuspense";

const PhysicalProductForm = withSuspense(
  React.lazy(() => import("./forms.tsx/physical"))
);

type Props = {
  productType: string;
  dismiss: () => void;
  edit?: boolean;
};

export default function NewProduct({ productType, dismiss, edit }: Props) {
  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle className="capitalize">
            {edit ? "Edit" : "Create"} {productType} Product
          </IonTitle>
          <IonButtons slot="start">
            <IonButton onClick={dismiss} color="dark">
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <PhysicalProductForm />
      </IonContent>
    </>
  );
}
