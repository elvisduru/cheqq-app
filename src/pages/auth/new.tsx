import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonInput,
  IonItem,
  IonPage,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { useState } from "react";
import { Link } from "react-router-dom";

export default function New() {
  const [name, setName] = useState<string>("");

  return (
    <IonPage id="login">
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton text="" />
          </IonButtons>
          <IonTitle>Create profile</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="flex flex-column h-full ion-padding">
          <h2>Create a profile</h2>
          <div className="text-mute leading-normal mt-0">
            <p>
              It looks like you're new here. Add your name and a profile picture
              to introduce yourself.
            </p>
          </div>
          <IonItem className="input" fill="outline" mode="md">
            <IonInput
              required
              onIonChange={(e) => setName(e.detail.value!)}
              type="text"
              placeholder="Full name"
            />
          </IonItem>
          <IonButton className="mt-1" expand="block">
            Done
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
