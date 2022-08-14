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
  IonRadio,
  IonRadioGroup,
  IonSearchbar,
  IonTitle,
  IonToggle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import { close } from "ionicons/icons";
import React, { useRef, useState } from "react";
import { Controller, useForm } from "react-hook-form";
import { useStore } from "../../hooks/useStore";
import useToggle from "../../hooks/useToggle";
import { generateId } from "../../utils";
import withSuspense from "../hoc/withSuspense";
const SelectItems = withSuspense(React.lazy(() => import("../SelectItems")));

type Props = {
  dismiss: () => void;
  title: string;
};

export default function NewDiscount({ dismiss, title }: Props) {
  const user = useStore((state) => state.user);
  const selectedStore = useStore((store) => store.selectedStore);
  const store = user?.stores.find((s) => s.id === selectedStore);
  const [code, toggleCode] = useToggle(true);
  const [appliedTo, setAppliedTo] = useState<string>("products");
  const {
    setValue,
    watch,
    control,
    formState: { errors },
  } = useForm({
    mode: "onBlur",
  });
  const adjustmentType = watch("adjustmentType", "percent");
  const inputRef = useRef<HTMLIonItemElement>(null);
  const [present, dismissModal] = useIonModal(SelectItems, {
    dismiss: () => {
      dismissModal();
    },
    type: appliedTo,
  });

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>{title} Discount</IonTitle>
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
          // onSubmit={handleSubmit(onSubmit, onError)}
          className="ion-padding-top ion-padding-horizontal flex flex-column modal-form"
        >
          <IonItemGroup>
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Method</IonLabel>
            </IonItemDivider>
            <IonItem lines="none" className="input checkbox mt-4">
              <IonLabel>Use Discount Code?</IonLabel>
              <IonToggle
                slot="end"
                color="primary"
                checked={code}
                onIonChange={() => {
                  toggleCode();
                }}
              />
            </IonItem>
            {code ? (
              <div className="mt-4">
                <div className="flex items-center justify-between">
                  <IonItem
                    className={`input w-full ${
                      errors.code ? "ion-invalid" : ""
                    }`}
                    fill="outline"
                    mode="md"
                    ref={inputRef}
                  >
                    <IonLabel position="floating">Discount Code</IonLabel>
                    <Controller
                      name="code"
                      control={control}
                      shouldUnregister
                      rules={{
                        required: "Please enter a discount code",
                      }}
                      render={({ field: { onChange, onBlur, value } }) => (
                        // TODO: Check if code exists
                        <IonInput
                          value={value}
                          type="text"
                          onIonChange={onChange}
                          onIonBlur={onBlur}
                          className="uppercase"
                        />
                      )}
                    />
                  </IonItem>
                  <IonButton
                    className="ml-4"
                    onClick={() => {
                      setValue("code", generateId(10));
                      inputRef.current?.focus();
                    }}
                  >
                    Generate
                  </IonButton>
                </div>
                <IonNote
                  color={errors.code ? "danger" : "medium"}
                  className="text-xs ml-4"
                >
                  {!errors.code
                    ? "Customers will enter this code at checkout."
                    : errors.code?.message}
                </IonNote>
              </div>
            ) : (
              <IonItem
                className={`input mt-4 ${errors.title ? "ion-invalid" : ""}`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Title</IonLabel>
                <Controller
                  name="title"
                  control={control}
                  shouldUnregister
                  rules={{ required: "Please enter a title" }}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="text"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                    />
                  )}
                />
                <IonNote slot="helper">
                  Customers will see this in their cart and at checkout.
                </IonNote>
                <IonNote slot="error">{errors.title?.message}</IonNote>
              </IonItem>
            )}
          </IonItemGroup>
          <IonItemGroup className="mt-8">
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Adjustment Value</IonLabel>
            </IonItemDivider>
            <Controller
              name="adjustmentType"
              defaultValue="percent"
              control={control}
              render={({ field: { onChange, value } }) => (
                <IonRadioGroup
                  value={value}
                  onIonChange={(e) => {
                    setValue("adjustmentValue", undefined);
                    onChange(e);
                  }}
                >
                  <IonItem className="input" lines="none">
                    <IonLabel>Percent</IonLabel>
                    <IonRadio mode="md" slot="start" value="percent" />
                  </IonItem>
                  <IonItem className="input" lines="none">
                    <IonLabel>Fixed amount</IonLabel>
                    <IonRadio mode="md" slot="start" value="fixed" />
                  </IonItem>
                </IonRadioGroup>
              )}
            />
            <IonItem
              className={`input mt-4 ${
                errors.adjustmentValue ? "ion-invalid" : ""
              }`}
              fill="outline"
              mode="md"
            >
              <IonLabel position="floating">
                {adjustmentType === "percent"
                  ? "Enter Percentage (%)"
                  : `Enter Fixed amount (${store?.currency})`}
              </IonLabel>
              <Controller
                name="adjustmentValue"
                control={control}
                shouldUnregister
                rules={{ required: "Please enter a value" }}
                render={({ field: { onChange, onBlur, value } }) => (
                  <IonInput
                    value={value}
                    type="number"
                    onIonChange={onChange}
                    onIonBlur={onBlur}
                  />
                )}
              />
              <IonNote slot="helper">
                Enter a{" "}
                {adjustmentType === "percent" ? "percentage" : "fixed amount"}{" "}
                that will be discounted.
              </IonNote>
              <IonNote slot="error">{errors.adjustmentValue?.message}</IonNote>
            </IonItem>
          </IonItemGroup>
          <IonItemGroup className="mt-8">
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Apply Discount To</IonLabel>
            </IonItemDivider>
            <IonRadioGroup
              value={appliedTo}
              onIonChange={(e) => setAppliedTo(e.detail.value)}
            >
              <IonItem className="input" lines="none">
                <IonLabel>Specific Products</IonLabel>
                <IonRadio mode="md" slot="start" value="products" />
              </IonItem>
              <IonItem className="input" lines="none">
                <IonLabel>Specific Collections</IonLabel>
                <IonRadio mode="md" slot="start" value="collections" />
              </IonItem>
            </IonRadioGroup>
            <IonSearchbar
              animated
              className="!px-0"
              onClick={() => {
                present({
                  breakpoints: [0, 0.5, 1],
                  initialBreakpoint: 0.5,
                });
              }}
              placeholder={`Search ${appliedTo}`}
            />
          </IonItemGroup>
        </form>
      </IonContent>
    </>
  );
}
