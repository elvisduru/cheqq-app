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
import { useEffect, useState } from "react";
import { Control, FieldValues, UseFormSetValue } from "react-hook-form";
import { ProductInput, ProductVariant } from "../../../../../utils/types";
import MediaSelector from "../../../../MediaSelector";

type Props = {
  dismiss: () => void;
  variantIndex: number;
  control: Control<FieldValues, any>;
  setValue: UseFormSetValue<ProductInput>;
  variant: ProductVariant;
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
    if (variant) setSelected(variant.imageId);
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

          <IonButtons slot="end">
            <IonButton
              color="dark"
              onClick={() => {
                setValue(`variants.${variantIndex}.imageId`, selected);
                dismiss();
              }}
            >
              Done
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding">
        <MediaSelector
          name="images"
          control={control}
          setValue={setValue}
          selected={selected!}
          setSelected={setSelected}
        />
      </IonContent>
    </>
  );
}
