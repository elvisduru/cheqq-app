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
            try {
              // await appwrite.account.deleteSession("current");
              await queryClient.invalidateQueries("user");
              window.location.href = "/signup";
            } catch (e) {
              console.log(e);
              window.location.href = "/signup";
            }
          }}
        >
          Logout
        </IonButton>
      </IonContent>
    </IonPage>
  );
};

export default Settings;
