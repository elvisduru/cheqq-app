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
import PhysicalProductForm from "./forms.tsx/physical";

type Props = {
  productType: string;
  dismiss: () => void;
};

export default function NewProduct({ productType, dismiss }: Props) {
  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle className="capitalize">
            Create {productType} Product
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
