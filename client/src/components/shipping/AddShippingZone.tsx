import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonItemDivider,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonTitle,
  IonToolbar,
  useIonActionSheet,
  useIonModal,
} from "@ionic/react";
import {
  add,
  close,
  earthOutline,
  ellipseSharp,
  ellipsisHorizontal,
} from "ionicons/icons";
import React from "react";
import { Controller, useForm } from "react-hook-form";
import { CountryStates } from "../../utils/types";
import withSuspense from "../hoc/withSuspense";

const SelectLocations = withSuspense(
  React.lazy(() => import("./SelectLocations"))
);

type Props = {
  dismiss: () => void;
};

export type LocationFormData = {
  name: string;
  locations: CountryStates[];
  rates: { [x: string]: any }[];
};

export default function AddShippingZone({ dismiss }: Props) {
  const {
    control,
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
  } = useForm<LocationFormData>({
    mode: "onBlur",
  });

  const locations = watch("locations");
  const rates = watch("rates");

  const onSubmit = (data: any) => console.log(data);
  const onError = (error: any) => console.log(error);

  const [present, dismissModal] = useIonModal(SelectLocations, {
    dismiss: () => {
      dismissModal();
    },
    setValue,
    locations,
  });

  const [presentSheet] = useIonActionSheet();

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
          <IonItemGroup className="mt-8">
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Locations</IonLabel>
            </IonItemDivider>
            {locations?.length ? (
              <IonItem lines="none" className="px-0 mt-2">
                <IonIcon slot="start" icon={earthOutline} />
                <IonLabel className="ion-text-wrap">
                  <span className="line-clamp-2">
                    {locations
                      .map(
                        (location) =>
                          location.name +
                          " " +
                          (location.states.length
                            ? ` (${location.states.length})`
                            : "")
                      )
                      .join(", ")}
                  </span>
                </IonLabel>
                <IonButton
                  onClick={() => {
                    presentSheet({
                      buttons: [
                        {
                          text: "Delete",
                          role: "destructive",
                          handler() {
                            setValue("locations", []);
                          },
                        },
                        {
                          text: "Edit Locations",
                          handler() {
                            present();
                          },
                        },
                        {
                          text: "Cancel",
                          role: "cancel",
                        },
                      ],
                    });
                  }}
                  slot="end"
                  fill="clear"
                  color="dark"
                >
                  <IonIcon icon={ellipsisHorizontal} />
                </IonButton>
              </IonItem>
            ) : (
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
            )}
          </IonItemGroup>
          <IonItemGroup className="mt-8">
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Rates</IonLabel>
            </IonItemDivider>
            {rates?.length ? (
              <div>Rates</div>
            ) : (
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
                  <IonIcon slot="start" icon={add} /> Add shipping rate
                </IonButton>
              </div>
            )}
          </IonItemGroup>
        </form>
      </IonContent>
    </>
  );
}
