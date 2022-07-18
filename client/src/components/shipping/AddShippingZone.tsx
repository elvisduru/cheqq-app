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
  IonTitle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import { add, close } from "ionicons/icons";
import React from "react";
import { Controller, useForm } from "react-hook-form";
import withSuspense from "../hoc/withSuspense";

const SelectLocations = withSuspense(
  React.lazy(() => import("./SelectLocations"))
);

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

  const [present, dismissModal] = useIonModal(SelectLocations, {
    dismiss: () => {
      dismissModal();
    },
    setValue,
  });

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
            className={`input mt-4 ${errors.name ? "ion-invalid" : ""}`}
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
                  placeholder="My Shipping Zone 1"
                />
              )}
            />
            <IonNote slot="helper">Enter a name for this zone.</IonNote>
            <IonNote slot="error">{errors.name?.message}</IonNote>
          </IonItem>
          <div
            className="border rounded-xl p-1 mt-4"
            style={{ borderStyle: "dashed" }}
          >
            <IonButton
              fill="clear"
              expand="block"
              color="medium"
              onClick={() => {
                present();
              }}
            >
              <IonIcon slot="start" icon={add} /> Add countries and regions
            </IonButton>
          </div>
        </form>
      </IonContent>
    </>
  );
}
