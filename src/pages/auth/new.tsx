import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonInput,
  IonItem,
  IonPage,
  IonSpinner,
  IonTitle,
  IonToolbar,
  useIonRouter,
} from "@ionic/react";
import { useEffect, useState } from "react";
import { SubmitHandler, useForm } from "react-hook-form";
import AvatarUpload from "../../components/AvatarUpload";
import useBoolean from "../../hooks/useBoolean";
import { useStorage } from "../../hooks/useStorage";
import appwrite from "../../lib/appwrite";

export default function New() {
  const { set } = useStorage();
  const router = useIonRouter();
  type FormValues = {
    name: string;
    avatar: File;
  };

  const { setValue, handleSubmit, watch } = useForm<FormValues>();
  const [fields, setFields] = useState<{ [x: string]: any }>();

  const { value: isLoading, toggle } = useBoolean(false);

  useEffect(() => {
    const sub = watch((data) => {
      setFields(data);
    });

    return () => {
      sub.unsubscribe();
    };
  }, [watch]);

  const onSubmit: SubmitHandler<FormValues> = async (data: FormValues) => {
    toggle();
    // Save avatar to cloud storage
    const response = await appwrite.storage.createFile(
      "624a379de69288705051",
      "unique()",
      data.avatar,
      ["role:all"]
    );
    await appwrite.account.updateName(data.name);
    await appwrite.account.updatePrefs({ avatar: response.$id });
    const updatedUser = await appwrite.account.get();
    await set("user", JSON.stringify(updatedUser));
    toggle();
    router.push("/");
  };
  const onError = (error: any) => {
    console.log(error);
  };
  return (
    <IonPage id="new">
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton text="" />
          </IonButtons>
          <IonTitle>Create profile</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <form onSubmit={handleSubmit(onSubmit, onError)}>
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
              disabled={!fields?.avatar || !fields?.name}
              type="submit"
            >
              Done &nbsp;
              {isLoading && <IonSpinner name="crescent" />}
            </IonButton>
          </div>
        </form>
      </IonContent>
    </IonPage>
  );
}
