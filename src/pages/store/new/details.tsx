import {
  IonAvatar,
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonNote,
  IonPage,
  IonTextarea,
  IonTitle,
  IonToolbar,
  useIonRouter,
  useIonToast,
} from "@ionic/react";
import { imagesOutline } from "ionicons/icons";
import { useEffect } from "react";
import { CircularProgressbar } from "react-circular-progressbar";
import { Controller, useFormContext } from "react-hook-form";
import { RouteComponentProps } from "react-router";
import PlacesAutocomplete from "../../../components/PlacesAutocomplete";
import usePhotoGallery from "../../../hooks/usePhotoGallery";
import { useStore } from "../../../hooks/useStore";
import { ErrorMessage } from "@hookform/error-message";
import appwrite from "../../../lib/appwrite";

type Props = {
  progress: number;
} & RouteComponentProps;

export default function Details({ progress }: Props) {
  const { user } = useStore();
  const {
    setValue,
    control,
    watch,
    getValues,
    trigger,
    formState: { errors, isValid, isDirty },
  } = useFormContext();
  const {
    photo: bannerPhoto,
    takePhoto: takeBannerPhoto,
    file: bannerFile,
  } = usePhotoGallery();
  const {
    photo: avatarPhoto,
    takePhoto: takeAvatarPhoto,
    file: avatarFile,
  } = usePhotoGallery();

  const [present, dismiss] = useIonToast();
  const router = useIonRouter();
  useEffect(() => {
    if (avatarFile) {
      setValue("avatar", avatarFile);
      setValue("avatarUrl", avatarPhoto?.webPath);
    }
    if (bannerFile) {
      setValue("banner", bannerFile);
      setValue("bannerUrl", bannerPhoto?.webPath);
    }
  }, [avatarFile, avatarPhoto, bannerFile, bannerPhoto, setValue]);

  return (
    <IonPage>
      <IonHeader translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton />
          </IonButtons>
          <IonTitle>Create your store</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonItem lines="none">
          <div slot="start">
            <CircularProgressbar
              value={progress}
              maxValue={2}
              text={`${progress}/2`}
            />
          </div>
          <IonLabel>
            <h2>Add store details</h2>
            <p>Setup your store by entering it's details</p>
          </IonLabel>
        </IonItem>
        <div className="ion-padding">
          <div>
            <div
              onClick={takeBannerPhoto}
              className="banner bg-mute rounded-t-3xl w-full h-11 relative border"
            >
              {watch("bannerUrl") && (
                <img
                  className="w-full h-full object-cover object-center rounded-t-3xl"
                  src={watch("bannerUrl")}
                  alt="banner"
                />
              )}
              <IonButton
                size="small"
                color="light"
                className="absolute bottom-1 right-1"
              >
                <IonIcon slot="start" icon={imagesOutline} />
                {watch("bannerUrl") ? "Replace" : "Add"}
              </IonButton>
            </div>
            <div className="rounded-b-3xl border border-t-none ion-padding">
              <IonAvatar
                onClick={takeAvatarPhoto}
                className="relative bg-mute flex ion-align-items-center ion-justify-content-center"
              >
                {watch("avatarUrl") ? (
                  <img src={watch("avatarUrl")} alt="avatar" />
                ) : (
                  user?.name[0]
                )}
                <div
                  style={{ padding: 5 }}
                  className="bg-light absolute bottom-0 right-0 rounded-full flex ion-align-items-center ion-justify-content-center"
                >
                  <IonIcon
                    slot="icon-only"
                    className="text-sm"
                    icon={imagesOutline}
                  />
                </div>
              </IonAvatar>
            </div>
          </div>
          <IonItem className="input mt-1" fill="outline" mode="md">
            <IonLabel position="floating">Store name</IonLabel>
            <Controller
              name="name"
              control={control}
              rules={{ required: "Please enter your store name" }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="text"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  maxlength={50}
                  minlength={3}
                />
              )}
            />
          </IonItem>
          <ErrorMessage
            errors={errors}
            name="name"
            render={({ message }) => (
              <IonNote color="danger">{message}</IonNote>
            )}
          />
          <IonItem className="input mt-1" fill="outline" mode="md">
            <IonLabel position="floating">Cheqq Tag</IonLabel>
            <Controller
              name="tag"
              control={control}
              rules={{
                required: "Please enter a unique tag",
                pattern: {
                  value: /^[@\w](?!.*?\.{2})[\w.]{1,28}[\w]$/,
                  message:
                    "Tag must be between 3 and 30 characters and can only contain letters, numbers, underscores and periods. It cannot start or end with a period.",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  onIonBlur={onBlur}
                  value={value}
                  placeholder="@yourstore"
                  onIonFocus={(e) => {
                    if (!value) setValue("tag", "@");
                  }}
                  onIonChange={(e) => {
                    let val = e.detail.value!;
                    val = val.startsWith("@")
                      ? "@" + val.substring(1)
                      : "@" + val;
                    onChange(val);
                  }}
                  type="text"
                  maxlength={20}
                />
              )}
            />
          </IonItem>
          <ErrorMessage
            errors={errors}
            name="tag"
            render={({ message }) => (
              <IonNote color="danger">{message}</IonNote>
            )}
          />
          <IonItem className="input mt-1" fill="outline" mode="md">
            <IonLabel position="floating">Store description</IonLabel>
            <Controller
              name="description"
              control={control}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonTextarea
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  value={value}
                  maxlength={200}
                />
              )}
            />
          </IonItem>
          <Controller
            name="address"
            control={control}
            render={({ field: { onChange, onBlur, value } }) => (
              <PlacesAutocomplete
                onChange={onChange}
                onBlur={onBlur}
                value={value}
              />
            )}
          />
          <IonButton
            onClick={async () => {
              const values = getValues();
              if (!values.category) {
                present("Please select a category", 2000);
                return router.push("/store/new", "back");
              }

              if (!isValid || !isDirty) {
                if (!isDirty) {
                  trigger(["name", "tag"]);
                } else {
                  const errorList = Object.keys(errors);
                  trigger(errorList);
                }
                return present("Please fill the missing fields", 2000);
              }

              // prepare data
              delete values.avatarUrl;
              delete values.bannerUrl;
              values.tag = values.tag.substring(1);

              // store files and get ids
              const avatarRes = await appwrite.storage.createFile(
                process.env.REACT_APP_APPWRITE_BUCKET_CHEQQ!,
                "unique()",
                values.avatar,
                ["role:all"]
              );
              values.avatar = avatarRes.$id;

              const bannerRes = await appwrite.storage.createFile(
                process.env.REACT_APP_APPWRITE_BUCKET_CHEQQ!,
                "unique()",
                values.banner,
                ["role:all"]
              );
              values.banner = bannerRes.$id;

              const res = await appwrite.database.createDocument(
                "625c424374df35741b0f",
                "unique()",
                { ...values, user: user?.$id }
              );
              console.log(res);
              //save store id to user pref
            }}
            expand="block"
            className="mt-2"
          >
            Complete
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
