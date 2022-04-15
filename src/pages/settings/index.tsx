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
import { useStore } from "../../hooks/useStore";
import appwrite from "../../lib/appwrite";

type Props = {};

const Settings: React.FC = (props: Props) => {
  const { setUser } = useStore();
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
            setUser(null);
            await appwrite.account.deleteSession("current");
          }}
          routerLink="/signup"
        >
          Logout
        </IonButton>
      </IonContent>
    </IonPage>
  );
};

export default Settings;
