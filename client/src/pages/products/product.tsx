import {
  IonBackButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import React from "react";
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const Product: React.FC<Props> = ({ user }) => {
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

export default Product;
