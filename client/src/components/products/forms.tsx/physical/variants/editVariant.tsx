import {
  IonButton,
  IonButtons,
  IonCheckbox,
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
  IonToggle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import { useEffect } from "react";
import {
  Control,
  Controller,
  FieldValues,
  UseFormSetValue,
  UseFormWatch,
} from "react-hook-form";
import { ProductInput, ProductVariant } from "../../../../../utils/types";

type Props = {
  dismiss: () => void;
  variant: ProductVariant;
  variantIndex: number;
  watch: UseFormWatch<FieldValues>;
  control: Control<FieldValues, any>;
  setValue: UseFormSetValue<ProductInput>;
  errors: { [x: string]: any };
};

export default function EditVariant({
  dismiss,
  variant,
  variantIndex,
  watch,
  control,
  errors,
}: Props) {
  const enabledTracking = watch(`variants.${variantIndex}.inventoryTracking`);
  useEffect(() => {
    const modal = document.querySelector(
      "#edit-variant"
    ) as HTMLIonModalElement;
    if (enabledTracking) {
      modal.setCurrentBreakpoint(1);
    } else {
      modal.setCurrentBreakpoint(0.65);
    }
  }, [enabledTracking]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Edit {variant.title}</IonTitle>
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
                dismiss();
              }}
            >
              Done
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent
        fullscreen
        className="ion-padding-horizontal ion-padding-bottom modal-form"
      >
        <IonItemGroup className="mt-8">
          <IonItemDivider className="pl-0">
            <IonLabel color="medium">Pricing</IonLabel>
          </IonItemDivider>
          <IonItem
            className={`input mt-4 ${
              errors.variants?.[variantIndex]?.price ? "ion-invalid" : ""
            }`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Price</IonLabel>
            <Controller
              control={control}
              name={`variants.${variantIndex}.price`}
              rules={{
                min: {
                  value: 0,
                  message: "Price must be greater than or equal to 0",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="number"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  min={0}
                  step="0.01"
                />
              )}
            />
            <IonNote slot="helper">
              Defaults to original product price if left blank.
            </IonNote>
            <IonNote slot="error">
              {errors.variants?.[variantIndex]?.price?.message}
            </IonNote>
          </IonItem>
          <IonItem
            className={`input mt-4 ${
              errors.variants?.[variantIndex]?.compareAtPrice
                ? "ion-invalid"
                : ""
            }`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Compare at price</IonLabel>
            <Controller
              control={control}
              name={`variants.${variantIndex}.compareAtPrice`}
              rules={{
                min: {
                  value: 0,
                  message: "Price must be greater than or equal to 0",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="number"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  min={0}
                  step="0.01"
                />
              )}
            />
            <IonNote slot="helper">
              Optional. Defaults to original product price if left blank.
            </IonNote>
            <IonNote slot="error">
              {errors.variants?.[variantIndex]?.price?.message}
            </IonNote>
          </IonItem>
        </IonItemGroup>
        <IonItemGroup className="mt-8">
          <IonItemDivider className="pl-0">
            <IonLabel color="medium">Inventory</IonLabel>
          </IonItemDivider>
          <IonItem lines="none" className="input checkbox">
            <IonLabel>Track inventory for this product</IonLabel>
            <Controller
              control={control}
              name={`variants.${variantIndex}.inventoryTracking`}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonCheckbox
                  onIonChange={(e) => {
                    onChange(e.detail.checked);
                  }}
                  onIonBlur={onBlur}
                  checked={value}
                  slot="start"
                />
              )}
            />
          </IonItem>
          {watch(`variants.${variantIndex}.inventoryTracking`) && (
            <>
              <IonItem
                className={`input mt-4 ${
                  errors.variants?.[variantIndex]?.inventoryLevel
                    ? "ion-invalid"
                    : ""
                }`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Quantity</IonLabel>
                <Controller
                  name={`variants.${variantIndex}.inventoryLevel`}
                  control={control}
                  rules={{
                    required: "Please enter a quantity",
                    min: {
                      value: 1,
                      message: "Quantity must be greater than 0",
                    },
                  }}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="number"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                      min={1}
                    />
                  )}
                />
                <IonNote slot="helper">
                  How many of this product are you selling?
                </IonNote>
                <IonNote slot="error">
                  {errors.variants?.[variantIndex]?.inventoryLevel?.message}
                </IonNote>
              </IonItem>
              <IonItem
                className={`input mt-4 ${
                  errors.variants?.[variantIndex]?.inventoryWarningLevel
                    ? "ion-invalid"
                    : ""
                }`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Warning Level</IonLabel>
                <Controller
                  name={`variants.${variantIndex}.inventoryWarningLevel`}
                  control={control}
                  rules={{
                    min: {
                      value: 1,
                      message: "Quantity must be greater than 0",
                    },
                    max: {
                      value:
                        watch(`variants.${variantIndex}.inventoryLevel`) || 1,
                      message: "Warning level can't be greater than quantity",
                    },
                  }}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="number"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                      min={1}
                    />
                  )}
                />
                <IonNote slot="helper">
                  Optional. Set a warning level when low on stock.
                </IonNote>
                <IonNote slot="error">
                  {
                    errors.variants?.[variantIndex]?.inventoryWarningLevel
                      ?.message
                  }
                </IonNote>
              </IonItem>
              <IonItem lines="none" className="input checkbox mt-4">
                <IonLabel>Allow purchase when out of stock</IonLabel>
                <Controller
                  control={control}
                  name={`variants.${variantIndex}.allowBackOrder`}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonToggle
                      slot="end"
                      color="primary"
                      checked={value}
                      onIonChange={(e) => {
                        onChange(e.detail.checked);
                      }}
                      onIonBlur={onBlur}
                      value={value}
                    />
                  )}
                />
              </IonItem>
              <IonItem className="input mt-4" fill="outline" mode="md">
                <IonLabel position="floating">SKU</IonLabel>
                <Controller
                  name={`variants.${variantIndex}.sku`}
                  control={control}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="text"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                      minlength={3}
                    />
                  )}
                />
                <IonNote slot="helper">
                  Stock Keeping Unit. Only visible to you.
                </IonNote>
              </IonItem>
              <IonItem className="input mt-4" fill="outline" mode="md">
                <IonLabel position="floating">Barcode</IonLabel>
                <Controller
                  name={`variants.${variantIndex}.gtin`}
                  control={control}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="text"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                      minlength={3}
                    />
                  )}
                />
                <IonNote slot="helper">
                  Optional. ISBN, UPC, GTIN, etc. Only visible to you.
                </IonNote>
              </IonItem>
            </>
          )}
        </IonItemGroup>
      </IonContent>
    </>
  );
}
