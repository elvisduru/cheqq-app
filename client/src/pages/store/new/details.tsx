import { ErrorMessage } from "@hookform/error-message";
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
  IonSpinner,
  IonTextarea,
  IonTitle,
  IonToolbar,
  useIonRouter,
  useIonToast,
} from "@ionic/react";
import { Query } from "appwrite";
import { imagesOutline } from "ionicons/icons";
import { useEffect } from "react";
import { CircularProgressbar } from "react-circular-progressbar";
import { Controller, useFormContext } from "react-hook-form";
import { RouteComponentProps } from "react-router";
import PlacesAutocomplete from "../../../components/PlacesAutocomplete";
import { useUpdateUser } from "../../../hooks/mutations/user/updateUser";
import useBoolean from "../../../hooks/useBoolean";
import usePhotoGallery from "../../../hooks/usePhotoGallery";
import appwrite from "../../../lib/appwrite";
import { User } from "../../../utils/types";

type Props = {
  user: User;
  progress: number;
} & RouteComponentProps;

export default function Details({ progress, user }: Props) {
  const updateUser = useUpdateUser();
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

  const [present] = useIonToast();
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

  const { value: isLoading, toggle } = useBoolean(false);

  const checkTag = async (tag: string) => {
    const res = await appwrite.database.listDocuments("stores", [
      Query.equal("tag", tag.substring(1)),
    ]);
    return res.total;
  };

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
                validate: async (value) => {
                  if (await checkTag(value)) {
                    return "Tag already exists";
                  }
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
                <>
                  <IonTextarea
                    onIonChange={onChange}
                    onIonBlur={onBlur}
                    value={value}
                    maxlength={200}
                  />
                  <IonNote className="ml-auto" style={{ paddingBottom: 4 }}>
                    {value?.length || 0}/200
                  </IonNote>
                </>
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
          {/* TODO: Add currency (Sell in...) */}
          <IonButton
            onClick={async () => {
              try {
                toggle();
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
                  toggle();
                  return present("Please fill the missing fields", 2000);
                }

                // prepare data
                delete values.avatarUrl;
                delete values.bannerUrl;
                values.tag = values.tag.substring(1);

                // store files and get ids
                const avatarRes = await appwrite.storage.createFile(
                  user?.$id!,
                  "store_avatar",
                  values.avatar,
                  ["role:all"]
                );
                values.avatar = avatarRes.$id;

                const bannerRes = await appwrite.storage.createFile(
                  user?.$id!,
                  "store_banner",
                  values.banner,
                  ["role:all"]
                );
                values.banner = bannerRes.$id;

                // create store
                let date = Date.now();
                await appwrite.database.createDocument("stores", "unique()", {
                  ...values,
                  user_id: user?.$id,
                  createdAt: date,
                  updatedAt: date,
                });

                // Update user
                if (!user?.prefs?.stores?.includes(values.tag)) {
                  updateUser.mutate(
                    {
                      prefs: {
                        ...user?.prefs,
                        stores: user?.prefs.stores
                          ? [...user?.prefs.stores, values.tag]
                          : [values.tag],
                      },
                    },
                    {
                      onSuccess: () => {
                        window.location.href = "/";
                      },
                    }
                  );
                } else {
                  window.location.href = "/";
                }

                toggle();
              } catch (e) {
                console.log(e);
                toggle();
              }
            }}
            expand="block"
            className="mt-2"
          >
            Complete &nbsp;
            {isLoading && <IonSpinner name="crescent" />}
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
