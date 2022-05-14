import { IonInput, useIonModal } from "@ionic/react";
import { FieldValues, Noop, UseFormSetValue } from "react-hook-form";
import ChooseCategory from "./ChooseCategory";

type Props = {
  onChange: (...event: any[]) => void;
  onBlur: Noop;
  value: any;
  setValue: UseFormSetValue<FieldValues>;
};

export default function SelectCategory({
  onChange,
  onBlur,
  value,
  setValue,
}: Props) {
  const [present, dismiss] = useIonModal(ChooseCategory, {
    dismiss: () => {
      dismiss();
    },
    handleSelect: (category: string) => {
      setValue("category", category);
      dismiss();
    },
  });

  return (
    <IonInput
      value={value}
      onIonFocus={() => {
        present();
      }}
      onIonBlur={onBlur}
      onIonChange={onChange}
    />
  );
}