import { useStorageItem } from "@capacitor-community/storage-react";
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
import AvatarUpload from "../../components/AvatarUpload";
import { useForm } from "react-hook-form";

export default function New() {
  const [user] = useStorageItem("user");

  const { register, setValue, handleSubmit, watch } = useForm();

  console.log(watch("name"));
  console.log("avatar", watch("avatar"));

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
        <form>
          <div className="flex flex-column h-full ion-padding">
            <h2>Create a profile</h2>
            <div className="text-mute leading-normal mt-0">
              <p>
                It looks like you're new here. Add your name and a profile
                picture to introduce yourself.
              </p>
            </div>
            <AvatarUpload setValue={setValue} />
            <IonItem className="input" fill="outline" mode="md">
              <IonInput
                required
                onIonChange={(e) => setValue("name", e.detail.value!)}
                type="text"
                placeholder="Full name"
              />
            </IonItem>
            <IonButton
              className="mt-1"
              expand="block"
              // disabled={!name}
              onClick={() => {
                // TODO: Send welcome email
              }}
            >
              Done
            </IonButton>
          </div>
        </form>
      </IonContent>
    </IonPage>
  );
}
