import { PutObjectCommand, PutObjectCommandInput } from "@aws-sdk/client-s3";
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
} from "@ionic/react";
import { SubmitHandler, useForm } from "react-hook-form";
import { Redirect } from "react-router-dom";
import AvatarUpload from "../../components/AvatarUpload";
import useUpdateUser from "../../hooks/mutations/user/updateUser";
import useBoolean from "../../hooks/useBoolean";
import { useStore } from "../../hooks/useStore";

function New() {
  const user = useStore((store) => store.user);
  const [present] = useIonToast();
  const updateUser = useUpdateUser();

  type FormValues = {
    name: string;
    avatar: File;
  };

  const { setValue, handleSubmit, watch } = useForm<FormValues>();
  const { value: isLoading, toggle } = useBoolean(false);

  const onSubmit: SubmitHandler<FormValues> = async (data: FormValues) => {
    try {
      toggle();
      // Save avatar to cloud storage
      const filePath = `users/${user?.id}/${data.avatar.name}`;
      const params: PutObjectCommandInput = {
        Bucket: import.meta.env.VITE_SPACES_BUCKET,
        Key: filePath,
        Body: data.avatar,
        ACL: "public-read",
        ContentType: data.avatar.type,
      };
      const { s3Client } = await import("../../lib/s3Client");
      const command = new PutObjectCommand(params);
      await s3Client.send(command);

      // Update user
      updateUser.mutate(
        {
          avatarUrl: `${import.meta.env.VITE_CDN_URL}/${filePath}`,
          name: data.name,
        },
        {
          onSuccess: () => {
            toggle();
            window.location.href = "/store/new";
          },
          onError: () => {
            toggle();
            present({
              message: "Error updating user",
              color: "danger",
            });
          },
        }
      );
    } catch (e: any) {
      console.log(e);
      present(e.message);
    }
  };

  const onError = (error: any) => {
    console.log(error);
  };

  if (user?.name) {
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
          <div className="flex flex-col h-full ion-padding">
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
              className="mt-8"
              expand="block"
              disabled={!watch("avatar") || !watch("name")}
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

export default New;
