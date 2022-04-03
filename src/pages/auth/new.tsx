import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonPage,
  IonThumbnail,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import {
  addCircle,
  imageOutline,
  person,
  personAddOutline,
  personCircle,
  personCircleOutline,
  personCircleSharp,
  personOutline,
  personSharp,
} from "ionicons/icons";
import { useState } from "react";
import AvatarUpload from "../../components/AvatarUpload";

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
          <AvatarUpload />
          <IonItem className="input" fill="outline" mode="md">
            <IonInput
              required
              onIonChange={(e) => setName(e.detail.value!)}
              type="text"
              placeholder="Full name"
            />
          </IonItem>
          <IonButton
            className="mt-1"
            expand="block"
            onClick={() => {
              // TODO: Send welcome email
            }}
          >
            Done
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
