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
import { Controller, useForm } from "react-hook-form";

type Props = {
  dismiss: () => void;
};

export default function AddDeliveryZone({ dismiss }: Props) {
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
        </form>
      </IonContent>
    </>
  );
}
