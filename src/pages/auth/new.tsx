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
  useIonToast,
  useIonViewDidEnter,
  useIonViewWillEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import { useEffect, useState } from "react";
import { SubmitHandler, useForm } from "react-hook-form";
import { Subscription } from "react-hook-form/dist/utils/createSubject";
import { Redirect } from "react-router-dom";
import AvatarUpload from "../../components/AvatarUpload";
import useBoolean from "../../hooks/useBoolean";
import { useStore } from "../../hooks/useStore";
import appwrite from "../../lib/appwrite";

export default function New() {
  const [present, dismiss] = useIonToast();
  const { user, setUser } = useStore();
  const [name, setName] = useState("");
  const [funcId, setFuncId] = useState<string>("");
  type FormValues = {
    name: string;
    avatar: File;
  };

  const { setValue, handleSubmit, watch } = useForm<FormValues>();
  const [fields, setFields] = useState<{ [x: string]: any }>();

  const { value: isLoading, toggle } = useBoolean(false);

  const executeNewUserFunc = async () => {
    // Create user bucket and activate user
    console.log("executing function for new user");
    const res = await appwrite.functions.createExecution(
      "6261f1ecc820a289a0c1"
    );
    setFuncId(res.$id);
  };

  useIonViewWillEnter(() => {
    console.log("ionViewWillEnter");
    executeNewUserFunc();
  }, []);

  let sub: Subscription;

  useIonViewDidEnter(() => {
    sub = watch((data) => {
      setFields(data);
    });
  }, []);

  useIonViewWillLeave(() => {
    sub.unsubscribe();
  });

  const onSubmit: SubmitHandler<FormValues> = async (data: FormValues) => {
    try {
      toggle();

      // Check function state
      const res = await appwrite.functions.getExecution(
        "6261f1ecc820a289a0c1",
        funcId
      );

      if (
        res.status === "failed" &&
        !res.stderr.includes("Bucket already exists")
      ) {
        console.log(res.stderr);
        executeNewUserFunc();
        toggle();
        return present("Error instantiating user. Please try again.", 2000);
      }

      const user = await appwrite.account.get();

      // Save avatar to cloud storage
      const response = await appwrite.storage.createFile(
        user?.$id!,
        "unique()",
        data.avatar,
        ["role:all"]
      );
      await appwrite.account.updateName(data.name);
      await appwrite.account.updatePrefs({ avatar: response.$id, stores: [] });
      setUser(await appwrite.account.get());
      toggle();
      setName(data.name);
    } catch (e: any) {
      console.log(e);
      present(e.message);
    }
  };

  const onError = (error: any) => {
    console.log(error);
  };

  if (user?.name || name) {
    return <Redirect to="/" />;
  }

  return (
    <IonPage id="new">
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton />
          </IonButtons>
          <IonTitle>Create profile</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <form onSubmit={handleSubmit(onSubmit, onError)}>
          <div className="flex flex-column h-full ion-padding">
            <h2>Create a profile</h2>
            <div className="text-gray leading-normal mt-0">
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
