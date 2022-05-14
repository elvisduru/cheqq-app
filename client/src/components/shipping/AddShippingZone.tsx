import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonNote,
  IonSelect,
  IonSelectOption,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import React from "react";
import { Controller, useForm } from "react-hook-form";

type Props = {
  dismiss: () => void;
};

export default function AddShippingZone({ dismiss }: Props) {
  const {
    control,
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
  } = useForm({
    mode: "onBlur",
  });
  const onSubmit = (data: any) => console.log(data);
  const onError = (error: any) => console.log(error);

  const LocationsInput = () => {
    const zoneType = watch("type");
    switch (zoneType) {
      case "zip":
        break;
      case "state":
        break;
      case "country":
        break;
      case "global":
      default:
        return null;
    }
  };

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Add Shipping Zone</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismiss();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <form
          onSubmit={handleSubmit(onSubmit, onError)}
          className="ion-padding-top ion-padding-horizontal flex flex-column modal-form"
        >
          <IonItem
            className={`input mt-1 ${errors.name ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Name</IonLabel>
            <Controller
              name="name"
              control={control}
              rules={{ required: "Please enter a name for this zone" }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="text"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                />
              )}
            />
            <IonNote slot="helper">Enter a name for this zone.</IonNote>
            <IonNote slot="error">{errors.name?.message}</IonNote>
          </IonItem>
          <IonItem
            className={`input mt-1 ${errors.type ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Zone type</IonLabel>
            <Controller
              name="type"
              control={control}
              rules={{ required: "Please select a zone type" }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonSelect
                  interface="popover"
                  interfaceOptions={{
                    translucent: true,
                    mode: "ios",
                    size: "auto",
                  }}
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  value={value}
                >
                  <IonSelectOption value="zip">Zip</IonSelectOption>
                  <IonSelectOption value="state">State</IonSelectOption>
                  <IonSelectOption value="country">Country</IonSelectOption>
                  <IonSelectOption value="global">Global</IonSelectOption>
                </IonSelect>
              )}
            />
            <IonNote slot="helper">
              Select zone type .i.e. zip, country, state or global.
            </IonNote>
            <IonNote slot="error">{errors.type?.message}</IonNote>
          </IonItem>
        </form>
      </IonContent>
    </>
  );
}
