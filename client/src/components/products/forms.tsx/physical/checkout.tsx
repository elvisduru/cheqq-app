import {
  IonButton,
  IonCheckbox,
  IonInput,
  IonItem,
  IonItemDivider,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonRouterLink,
  IonSelect,
  IonSelectOption,
  IonToggle,
  useIonModal,
} from "@ionic/react";
import { Controller, useFormContext } from "react-hook-form";
import { ProductInput } from "../../../../utils/types";
import Discounts from "../../../discounts";
import ShippingZones from "../../../shipping/Shipping";
import Step from "../Step";

export default function Checkout() {
  const {
    watch,
    control,
    formState: { errors },
  } = useFormContext<ProductInput>();

  const shippingInfo = watch("shippingInfo");
  const flatShipping = watch("flatShipping");
  const dimensions = watch("dimensions");
  const redirect = watch("redirect");

  // Shipping Zones
  const [present, dismiss] = useIonModal(ShippingZones, {
    dismiss: () => {
      dismiss();
    },
  });
  //
  const [presentDiscount, dismissDiscount] = useIonModal(Discounts, {
    dismiss: () => {
      dismissDiscount();
    },
  });

  return (
    <Step>
      <IonItemGroup>
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Shipping</IonLabel>
          <IonButton
            size="small"
            fill="clear"
            slot="end"
            onClick={() => {
              present({
                presentingElement: document.querySelector(
                  "#physical-product-form"
                ) as HTMLElement,
                canDismiss: true,
                id: "shipping-settings",
              });
            }}
          >
            Manage settings
          </IonButton>
        </IonItemDivider>
        <IonItem lines="none" className="input mt-4 checkbox">
          <IonLabel>Add shipping information</IonLabel>
          <Controller
            control={control}
            name="shippingInfo"
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

        {shippingInfo && (
          <>
            <IonItem className="input mt-4" fill="outline" mode="md">
              <IonLabel position="floating">Weight</IonLabel>
              <Controller
                name="weight"
                control={control}
                shouldUnregister
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
                Optional. Used to calculate shipping rates at checkout.
              </IonNote>
            </IonItem>
            <IonItem className="input mt-4" fill="outline" mode="md">
              <IonLabel position="floating">Weight Unit</IonLabel>
              <Controller
                name="weightUnit"
                shouldUnregister
                control={control}
                render={({ field: { onChange, onBlur, value } }) => (
                  <IonSelect
                    interface="popover"
                    interfaceOptions={{
                      translucent: true,
                      mode: "ios",
                      size: "auto",
                    }}
                    onIonChange={onChange}
                    onIonBlur={onBlur}
                    value={value}
                  >
                    <IonSelectOption>g</IonSelectOption>
                    <IonSelectOption>kg</IonSelectOption>
                    <IonSelectOption>lb</IonSelectOption>
                    <IonSelectOption>oz</IonSelectOption>
                  </IonSelect>
                )}
              />
            </IonItem>
            <IonItem lines="none" className="input mt-4 checkbox">
              <IonLabel>Add product dimensions</IonLabel>
              <Controller
                control={control}
                name="dimensions"
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
            {dimensions && (
              <>
                <IonItem className="input mt-4" fill="outline" mode="md">
                  <IonLabel position="floating">Width</IonLabel>
                  <Controller
                    name="width"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonInput
                        value={value}
                        type="number"
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                      />
                    )}
                  />
                </IonItem>
                <IonItem className="input mt-4" fill="outline" mode="md">
                  <IonLabel position="floating">Height</IonLabel>
                  <Controller
                    name="height"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonInput
                        value={value}
                        type="number"
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                      />
                    )}
                  />
                </IonItem>
                <IonItem className="input mt-4" fill="outline" mode="md">
                  <IonLabel position="floating">Depth</IonLabel>
                  <Controller
                    name="depth"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonInput
                        value={value}
                        type="number"
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                      />
                    )}
                  />
                </IonItem>
                <IonItem className="input mt-4" fill="outline" mode="md">
                  <IonLabel position="floating">Dimensions Unit</IonLabel>
                  <Controller
                    name="dimensionUnit"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonSelect
                        interface="popover"
                        interfaceOptions={{
                          translucent: true,
                          mode: "ios",
                          size: "auto",
                        }}
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                        value={value}
                      >
                        <IonSelectOption>in</IonSelectOption>
                        <IonSelectOption>cm</IonSelectOption>
                        <IonSelectOption>m</IonSelectOption>
                      </IonSelect>
                    )}
                  />
                </IonItem>
              </>
            )}
          </>
        )}
        <IonItem lines="none" className="input mt-2 checkbox">
          <IonLabel>Enable free shipping</IonLabel>
          <Controller
            control={control}
            name="isFreeShipping"
            render={({ field: { onChange, onBlur, value } }) => (
              <IonToggle
                slot="end"
                checked={value}
                color="primary"
                onIonChange={(e) => {
                  onChange(e.detail.checked);
                }}
                onIonBlur={onBlur}
              />
            )}
          />
        </IonItem>
        <IonItem lines="none" className="input mt-2 checkbox">
          <IonLabel>Enable flat shipping rate</IonLabel>
          <Controller
            control={control}
            name="flatShipping"
            render={({ field: { onChange, onBlur, value } }) => (
              <IonToggle
                slot="end"
                checked={flatShipping}
                color="primary"
                onIonChange={(e) => {
                  onChange(e.detail.checked);
                }}
                onIonBlur={onBlur}
              />
            )}
          />
        </IonItem>

        {flatShipping && (
          <IonItem className="input mt-2" fill="outline" mode="md">
            <IonLabel position="floating">Fixed Shipping Rate</IonLabel>
            <Controller
              name="fixedShippingRate"
              control={control}
              shouldUnregister
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
              Warning. This will override your default{" "}
              <IonRouterLink
                onClick={() => {
                  present({
                    presentingElement: document.querySelector(
                      "#physical-product-form"
                    ) as HTMLElement,
                    canDismiss: true,
                    id: "shipping-settings",
                  });
                }}
              >
                shipping settings
              </IonRouterLink>
              .
            </IonNote>
          </IonItem>
        )}
      </IonItemGroup>
      {/* TODO: If fulfillment services exist, show select options */}
      {/* <IonItemGroup className="mt-4">
        <IonItem lines="none" className="input checkbox w-full">
          <IonLabel color="medium">
            Fulfillment <br />
            <IonNote
              color="medium"
              className="text-xs font-normal ion-text-wrap"
            >
              Choose the fulfillment service that fulfills orders for you.
            </IonNote>
          </IonLabel>
        </IonItem>
      </IonItemGroup> */}
      {/* TODO: Discounts feature half-way */}
      {/* <IonItemGroup className="mt-4">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Discounts</IonLabel>
          <IonButton
            size="small"
            fill="clear"
            slot="end"
            onClick={() => {
              presentDiscount({
                presentingElement: document.querySelector(
                  "#physical-product-form"
                ) as HTMLElement,
                canDismiss: true,
                id: "discount-settings",
              });
            }}
          >
            Manage Settings
          </IonButton>
        </IonItemDivider>
      </IonItemGroup> */}
      <IonItem lines="none" className="input mt-2 checkbox">
        <IonLabel>Redirect after purchase?</IonLabel>
        <Controller
          control={control}
          name="redirect"
          render={({ field: { onChange, onBlur, value } }) => (
            <IonToggle
              onIonChange={(e) => {
                onChange(e.detail.checked);
              }}
              onIonBlur={onBlur}
              checked={value}
              color="primary"
              slot="end"
            />
          )}
        />
      </IonItem>
      {redirect ? (
        <IonItem
          className={`input mt-1 mb-8 ${
            errors.redirectUrl ? "ion-invalid" : ""
          }`}
          fill="outline"
          mode="md"
        >
          <IonLabel position="floating">Redirect URL</IonLabel>
          <Controller
            name="redirectUrl"
            shouldUnregister
            control={control}
            rules={{
              pattern: {
                value:
                  /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/,
                message: "Invalid URL format",
              },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <IonInput
                value={value}
                onIonChange={onChange}
                onIonBlur={onBlur}
                type="url"
              />
            )}
          />
          <IonNote slot="helper">
            Send customers to a URL of your choice after purchase.
          </IonNote>
          <IonNote slot="error">{errors.redirectUrl?.message}</IonNote>
        </IonItem>
      ) : null}
    </Step>
  );
}
