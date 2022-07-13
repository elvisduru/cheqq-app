import {
  IonBackButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  useIonViewWillEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import React from "react";
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const ProductDetails: React.FC<Props> = ({ user }) => {
  const toggleHideTabBar = useStore((store) => store.toggleHideTabBar);

  useIonViewWillEnter(() => {
    toggleHideTabBar(true);
  });

  useIonViewWillLeave(() => {
    toggleHideTabBar(false);
  });

  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton />
          </IonButtons>
          <IonTitle>Product Details</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Product Details</IonTitle>
          </IonToolbar>
        </IonHeader>
        <div>Product Details</div>
      </IonContent>
    </IonPage>
  );
};

export default ProductDetails;
