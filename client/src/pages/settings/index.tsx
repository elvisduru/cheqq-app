import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import React from "react";
import { useQueryClient } from "react-query";
import { Storage } from "@capacitor/storage";

type Props = {};

const Settings: React.FC = (props: Props) => {
  const queryClient = useQueryClient();
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton />
          </IonButtons>
          <IonTitle>Settings</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Settings</IonTitle>
          </IonToolbar>
        </IonHeader>
        <div>Product Details</div>
        <IonButton
          onClick={async () => {
            await Storage.clear();
            queryClient.clear();
            window.location.reload();
          }}
        >
          Logout
        </IonButton>
      </IonContent>
    </IonPage>
  );
};

export default Settings;
