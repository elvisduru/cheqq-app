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
} from "@ionic/react";
import { close } from "ionicons/icons";

import "leaflet/dist/leaflet.css";
import { useState } from "react";
import { Controller, useForm } from "react-hook-form";
import { useStore } from "../../hooks/useStore";
import RadiusMap from "../RadiusMap";

type Props = {
  dismiss: () => void;
};

export default function AddDeliveryZone({ dismiss }: Props) {
  const [radius, setRadius] = useState<number>(0);
  const user = useStore((store) => store.user);
  const selectedStore = useStore((store) => store.selectedStore);
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
  const addressCoordinates = user?.stores[selectedStore].addressCoordinates;
  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Add Delivery Zone</IonTitle>
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
                  placeholder="e.g. Zone 1"
                />
              )}
            />
            <IonNote slot="helper">Enter a name for this zone.</IonNote>
            <IonNote slot="error">{errors.name?.message}</IonNote>
          </IonItem>
          <IonItem className="input mt-4">
            <IonLabel position="floating">Distance</IonLabel>
            <IonInput
              type="number"
              value={radius}
              onIonChange={(e) => setRadius(Number(e.target.value))}
              placeholder="e.g. 10"
              debounce={200}
            />
          </IonItem>
          <RadiusMap addressCoordinates={addressCoordinates!} radius={radius} />
        </form>
      </IonContent>
    </>
  );
}
