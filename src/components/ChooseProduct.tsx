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
  checkmarkCircle,
  close,
  downloadOutline,
} from "ionicons/icons";
import { useCallback, useState } from "react";
import useCanDismiss from "../hooks/useCanDismiss";
import NewProduct from "./products/new";

type Props = {
  routerEl: HTMLIonRouterElement;
};

export default function ChooseProduct({ routerEl }: Props) {
  const handleDismiss = () => {
    dismiss();
  };

  const [productType, setProductType] = useState<string>();
  const [present, dismiss] = useIonModal(NewProduct, {
    productType,
    handleDismiss,
  });
  const canDismiss = useCanDismiss();

  const productTypes = [
    {
      title: "Physical Product",
      description: "Physical products are delivered to your door.",
      handler: () => {
        setProductType("physical");
        present({
          presentingElement: routerEl,
          canDismiss,
        });
      },
      icon: bagHandleOutline,
    },
    {
      title: "Digital Product",
      description: "Digital products are delivered to your email.",
      handler: () => {
        setProductType("digital");
        present({
          presentingElement: routerEl,
          canDismiss,
        });
      },
      icon: downloadOutline,
    },
  ];

  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Choose Product Type</IonTitle>
          <IonButtons slot="start">
            <IonButton color="dark">
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
