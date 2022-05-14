import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonTitle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import {
  bagHandleOutline,
  close,
  downloadOutline,
  reloadOutline,
} from "ionicons/icons";
import { useState } from "react";
import useCanDismiss from "../hooks/useCanDismiss";
import NewProduct from "./products/new";

type Props = {
  dismiss: () => void;
};

export default function ChooseProduct({ dismiss: dismissModal }: Props) {
  const [productType, setProductType] = useState<string>();
  const canDismiss = useCanDismiss();
  const [present, dismiss] = useIonModal(NewProduct, {
    productType,
    dismiss: () => {
      dismiss();
    },
  });
  const routerOutletEl = document.querySelector(
    "ion-router-outlet"
  ) as HTMLElement;

  const productTypes = [
    {
      title: "Physical Product",
      description: "Sell physical items like books, clothing, etc.",
      handler: () => {
        setProductType("physical");
        present({
          presentingElement: routerOutletEl,
          canDismiss,
          id: "new-physical-product",
        });
      },
      icon: bagHandleOutline,
    },
    {
      title: "Digital Product",
      description: "Sell a course, ebook, album, artwork, etc.",
      handler: () => {
        setProductType("digital");
        present({
          presentingElement: routerOutletEl,
          canDismiss,
        });
      },
      icon: downloadOutline,
    },
    {
      title: "Membership",
      description: "Charge on a recurring basis.",
      handler: () => {
        setProductType("membership");
        present({
          presentingElement: routerOutletEl,
          canDismiss,
        });
      },
      icon: reloadOutline,
    },
  ];

  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Choose Product Type</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismissModal();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonList className="bg-transparent" id="choose-product">
          {productTypes.map(({ icon, title, description, handler }) => (
            <IonItem
              key={title}
              lines="none"
              button
              onClick={handler}
              className="py-1 bg-transparent"
            >
              <IonIcon slot="start" style={{ fontSize: 50 }} icon={icon} />
              <IonLabel className="ion-text-wrap">
                {title}
                <p>{description}</p>
              </IonLabel>
            </IonItem>
          ))}
        </IonList>
      </IonContent>
    </>
  );
}
