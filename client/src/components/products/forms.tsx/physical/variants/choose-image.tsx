import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import React, { useEffect, useState } from "react";
import { Control, FieldValues, UseFormSetValue } from "react-hook-form";
import { Variant } from ".";
import withSuspense from "../../../../hoc/withSuspense";
const MediaSelector = withSuspense<any>(
  React.lazy(() => import("../../../../MediaSelector"))
);

type Props = {
  dismiss: () => void;
  variantIndex: number;
  control: Control<FieldValues, any>;
  setValue: UseFormSetValue<FieldValues>;
  variant: Variant;
};

export default function ChooseImage({
  dismiss,
  control,
  setValue,
  variantIndex,
  variant,
}: Props) {
  const [selected, setSelected] = useState<number>();

  useEffect(() => {
    if (variant) setSelected(variant.image);
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Select Image</IonTitle>
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
          {selected && (
            <IonButtons slot="end">
              <IonButton
                color="dark"
                onClick={() => {
                  setValue(`variants.${variantIndex}.image`, selected);
                  dismiss();
                }}
              >
                Save
              </IonButton>
            </IonButtons>
          )}
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding">
        <MediaSelector
          name="photos"
          control={control}
          setValue={setValue}
          selected={selected!}
          setSelected={setSelected}
        />
      </IonContent>
    </>
  );
}
