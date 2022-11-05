import { PutObjectCommand, PutObjectCommandInput } from "@aws-sdk/client-s3";
import {
  AlertOptions,
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
  IonLoading,
  IonNote,
  IonPage,
  IonSelect,
  IonSelectOption,
  IonSpinner,
  IonTextarea,
  IonTitle,
  IonToolbar,
  useIonRouter,
  useIonToast,
  useIonViewWillEnter,
} from "@ionic/react";
import { imagesOutline } from "ionicons/icons";
import { useEffect } from "react";
import { CircularProgressbar } from "react-circular-progressbar";
import { Controller, useFormContext } from "react-hook-form";
import PhoneInput from "react-phone-input-2";
import "react-phone-input-2/lib/material.css";
import { useHistory } from "react-router";
import { StoreFormValues } from ".";
import PlacesAutocomplete from "../../components/PlacesAutocomplete";
import useAddStore from "../../hooks/mutations/stores/addStore";
import useCountries from "../../hooks/queries/locations/useCountries";
import useBoolean from "../../hooks/useBoolean";
import usePhotoGallery from "../../hooks/usePhotoGallery";
import api from "../../lib/api";
import { User } from "../../utils/types";

type Props = {
  user: User;
  progress: number;
};

export default function Details({ progress, user }: Props) {
  const addStore = useAddStore();

  const { data: countries } = useCountries();

  const history = useHistory();

  const {
    setValue,
    control,
    watch,
    getValues,
    trigger,
    formState: { errors, isValid, isDirty },
  } = useFormContext<StoreFormValues>();

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

  const countryId = watch("countryId");

  useEffect(() => {
    if (avatarFile) {
      setValue("logo", avatarFile);
      setValue("logoUrl", avatarPhoto?.webPath);
    }
    if (bannerFile) {
      setValue("banner", bannerFile);
      setValue("bannerUrl", bannerPhoto?.webPath);
    }
  }, [avatarFile, avatarPhoto, bannerFile, bannerPhoto, setValue]);

  const setCoordinates = (coordinates: { lat: number; lng: number }) => {
    setValue("addressCoordinates", coordinates);
  };

  const { value: isLoading, toggle } = useBoolean(false);

  const checkTag = async (tag: string) => {
    const res = await api.get(`stores/tag/${tag}`);
    return res.data;
  };

  useIonViewWillEnter(() => {
    if (!watch("categories")) history.replace("/store/new");
  });

  if (!countries) return <IonLoading isOpen={true} translucent />;

  return (
    <IonPage id="store-details">
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
        <div className="ion-padding mb-14">
          <div>
            <div
              onClick={takeBannerPhoto}
              className="banner bg-mute rounded-t-3xl w-full h-44 relative border border-solid border-gray-400 border-opacity-50"
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
            <div className="rounded-b-3xl border border-solid border-gray-400 border-opacity-50 border-t-0 ion-padding">
              <IonAvatar
                onClick={takeAvatarPhoto}
                className="relative bg-mute flex items-center ion-justify-content-center"
              >
                {watch("logoUrl") ? (
                  <img src={watch("logoUrl")} alt="avatar" />
                ) : (
                  user?.name?.substring(0, 1)
                )}
                <div
                  style={{ padding: 5 }}
                  className="bg-light absolute bottom-0 right-0 rounded-full flex items-center ion-justify-content-center"
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
          <IonItem
            className={`input mt-4 ${errors.name ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
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
            <IonNote slot="helper">
              Give your store a short and clear name.
            </IonNote>
            <IonNote slot="error">{errors.name?.message}</IonNote>
          </IonItem>
          <IonItem
            className={`input mt-4 ${errors.tag ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
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
                  if (await checkTag(value.substring(1))) {
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
            <IonNote slot="helper">Enter a unique tag for your store.</IonNote>
            <IonNote slot="error">{errors.tag?.message}</IonNote>
          </IonItem>
          <IonItem className="input mt-4" fill="outline" mode="md">
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
            <IonNote slot="helper">
              Provide a short description of your store.
            </IonNote>
          </IonItem>
          <IonItem
            className={`input mt-4 ${errors.countryId ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Country</IonLabel>
            <Controller
              name="countryId"
              control={control}
              rules={{ required: "Please select your country" }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonSelect
                  interface="alert"
                  interfaceOptions={
                    {
                      translucent: true,
                      mode: "ios",
                      header: "Select country",
                    } as AlertOptions
                  }
                  onIonChange={(e) => {
                    onChange(e.detail.value);
                    // Set currency based on country
                    const country = countries?.find(
                      (c) => c.id === e.detail.value
                    )!;
                    setValue("currency", `${country.name}-${country.currency}`);
                  }}
                  onIonBlur={onBlur}
                  value={value}
                >
                  {countries?.map((country) => (
                    <IonSelectOption key={country.id} value={country.id}>
                      {country.name}
                    </IonSelectOption>
                  ))}
                </IonSelect>
              )}
            />
            <IonNote slot="helper">
              Select the country your store is located.
            </IonNote>
            <IonNote slot="error">{errors.countryId?.message}</IonNote>
          </IonItem>
          {countryId && (
            <Controller
              name="address"
              control={control}
              rules={{
                required: "Please enter an address for your store",
                pattern: {
                  value: /^[a-zA-Z0-9\s,'-]*$/,
                  message: "Please enter a valid address",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <PlacesAutocomplete
                  onChange={onChange}
                  onBlur={onBlur}
                  value={value}
                  error={errors.address?.message}
                  country={countries.find((c) => c.id === countryId)?.iso2}
                  setCoordinates={setCoordinates}
                />
              )}
            />
          )}
          <IonItem
            className={`input mt-4 ${errors.currency ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Currency</IonLabel>
            <Controller
              name="currency"
              control={control}
              rules={{ required: "Please select a currency for your store" }}
              render={({ field: { onBlur, onChange, value } }) => (
                <IonSelect
                  interface="alert"
                  interfaceOptions={
                    {
                      translucent: true,
                      mode: "ios",
                      header: "Select currency",
                    } as AlertOptions
                  }
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  value={value}
                >
                  {countries.map((country) => (
                    <IonSelectOption
                      key={country.id}
                      value={`${country.name}-${country.currency}`}
                    >
                      {`${country.name} - ${country.currency} (${country.currency_symbol})`}
                    </IonSelectOption>
                  ))}
                </IonSelect>
              )}
            />
            <IonNote slot="helper">Select the currency for your store.</IonNote>
            <IonNote slot="error">{errors.currency?.message}</IonNote>
          </IonItem>
          <div>
            <Controller
              name="phone"
              control={control}
              rules={{
                required: "Please enter a phone number",
                pattern: {
                  value: /^\+?[0-9]{10,15}$/,
                  message: "Please enter a valid phone number",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <PhoneInput
                  containerClass="mt-4"
                  country={
                    countries
                      .find((c) => c.id === countryId)
                      ?.iso2.toLowerCase() || "us"
                  }
                  value={value}
                  onChange={(value) => {
                    onChange(value);
                  }}
                  onBlur={onBlur}
                />
              )}
            />
            {!errors.phone ? (
              <IonNote slot="helper" className="ml-1 text-xs text-helper">
                Enter your store's phone number
              </IonNote>
            ) : (
              <IonNote slot="error" className="ml-1 text-xs" color="danger">
                {errors.phone?.message}
              </IonNote>
            )}
          </div>
        </div>
        <div
          slot="fixed"
          className={`${
            !isValid || !isDirty ? "opacity-0" : "opacity-100"
          } transition-opacity backdrop-filter backdrop-blur-lg bg-opacity-30 bottom-0 ion-padding-horizontal pb-4 w-full`}
        >
          <IonButton
            hidden={!isValid || !isDirty}
            onClick={async () => {
              try {
                toggle();
                const values = getValues();
                if (!values.categories) {
                  present("Please select a categories", 2000);
                  return router.push("/store/new", "back");
                }

                if (!isValid || !isDirty) {
                  trigger(["name", "tag", "address", "currency", "phone"]);
                  toggle();
                  return present("Please fill out all required fields", 2000);
                }

                // prepare data
                delete values.logoUrl;
                delete values.bannerUrl;
                values.tag = values.tag.substring(1);
                values.currency = values.currency.split("-")[1];

                // store files to cloud storage
                const logoFilePath = `users/${user?.id}/${values.logo.name}`;
                const bannerFilePath = `users/${user?.id}/${values.banner.name}`;
                const logoParams: PutObjectCommandInput = {
                  Bucket: import.meta.env.VITE_SPACES_BUCKET,
                  Key: logoFilePath,
                  Body: values.logo,
                  ACL: "public-read",
                  ContentType: values.logo.type,
                };

                const bannerParams: PutObjectCommandInput = {
                  Bucket: import.meta.env.VITE_SPACES_BUCKET,
                  Key: bannerFilePath,
                  Body: values.logo,
                  ACL: "public-read",
                  ContentType: values.logo.type,
                };
                const { s3Client } = await import("../../lib/s3Client");
                const logoCommand = new PutObjectCommand(logoParams);
                const bannerCommand = new PutObjectCommand(bannerParams);
                await Promise.all([
                  s3Client.send(logoCommand),
                  s3Client.send(bannerCommand),
                ]);

                // Create Store
                await addStore.mutateAsync({
                  ...values,
                  logo: `${import.meta.env.VITE_CDN_URL}/${logoFilePath}`,
                  banner: `${import.meta.env.VITE_CDN_URL}/${bannerFilePath}`,
                  ownerId: user.id,
                  language: navigator.language || "en-US",
                  phone: `+${values.phone}`,
                });

                // TODO: Initialize store with defaults, e.g "Domestic" shipping zone

                window.location.href = "/";

                toggle();
              } catch (e: any) {
                console.log(e);
                if (e.response) {
                  if (typeof e.response.data.message === "string") {
                    present(e.response.data.message, 2000);
                  } else {
                    present(e.response.data.message.join(", "), 3000);
                  }
                }
                toggle();
              }
            }}
            expand="block"
          >
            Complete &nbsp;
            {isLoading && <IonSpinner name="crescent" />}
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
