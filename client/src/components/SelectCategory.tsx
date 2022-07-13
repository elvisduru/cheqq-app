import { IonInput, useIonModal } from "@ionic/react";
import React from "react";
import { FieldValues, Noop, UseFormSetValue } from "react-hook-form";
import withSuspense from "./hoc/withSuspense";
const ChooseCategory = withSuspense(
  React.lazy(() => import("./ChooseCategory"))
);

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
    handleSelect: (categoryId: number, categoryName: string) => {
      setValue("category", categoryId);
      setValue("categoryName", categoryName);
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
