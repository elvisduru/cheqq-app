import {
  IonBackButton,
  IonButton,
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
import { useQueryClient } from "@tanstack/react-query";
import { Preferences } from "@capacitor/preferences";
import { useStore } from "../../hooks/useStore";

type Props = {};

const Settings: React.FC = (props: Props) => {
  const toggleHideTabBar = useStore((store) => store.toggleHideTabBar);

  useIonViewWillEnter(() => {
    toggleHideTabBar(true);
  });

  useIonViewWillLeave(() => {
    toggleHideTabBar(false);
  });

  const queryClient = useQueryClient();

  return (
    <IonPage id="settings">
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
            await Preferences.clear();
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
