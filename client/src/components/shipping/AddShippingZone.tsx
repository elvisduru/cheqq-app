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
  useIonAlert,
  useIonModal,
} from "@ionic/react";
import { UseMutationResult } from "@tanstack/react-query";
import { AxiosResponse } from "axios";
import {
  add,
  cashOutline,
  close,
  earthOutline,
  ellipsisHorizontal,
} from "ionicons/icons";
import React, { useEffect, useState } from "react";
import { Controller, useFieldArray, useForm } from "react-hook-form";
import useAddShippingZone from "../../hooks/mutations/shipping/addShippingZone";
import useUpdateShippingZone from "../../hooks/mutations/shipping/updateShippingZone";
import { useStore } from "../../hooks/useStore";
import { Rate, ShippingZone } from "../../utils/types";
import withSuspense from "../hoc/withSuspense";
import AddShippingRate from "./AddShippingRate";

const SelectLocations = withSuspense(
  React.lazy(() => import("./SelectLocations"))
);

type Props = {
  dismiss: () => void;
  selectedStore: number;
  shippingZone?: ShippingZone;
  deleteShippingZone: UseMutationResult<
    AxiosResponse<ShippingZone, any>,
    unknown,
    number,
    unknown
  >;
};

export default function AddShippingZone({
  dismiss,
  selectedStore,
  shippingZone,
  deleteShippingZone,
}: Props) {
  const user = useStore((store) => store.user);
  const store = user?.stores.find((s) => s.id === selectedStore);

  const addShippingZone = useAddShippingZone();
  const updateShippingZone = useUpdateShippingZone();

  const {
    control,
    setValue,
    handleSubmit,
    watch,
    formState: { errors, isValid },
  } = useForm<ShippingZone>({
    mode: "onChange",
    defaultValues: {
      name: shippingZone?.name || "",
      locations:
        shippingZone?.locations?.map((zone) => {
          return {
            ...zone.country,
            states: zone.states,
          };
        }) || [],
      rates: shippingZone?.rates || [],
      id: shippingZone?.id,
    },
  });

  const { update, append, remove } = useFieldArray({ control, name: "rates" });

  const locations = watch("locations");
  const rates = watch("rates");

  const domestic =
    locations.length === 1 && locations?.[0]?.id === store?.country.id;

  const onSubmit = (data: ShippingZone) => {
    const storeId = store?.id;
    if (shippingZone) {
      updateShippingZone.mutate(data, {
        onSuccess: () => {
          dismiss();
        },
      });
    } else {
      addShippingZone.mutate(
        { ...data, storeId },
        {
          onSuccess: (res) => {
            dismiss();
          },
        }
      );
    }
  };
  const onError = (error: any) => console.log(error);

  const [rateIndex, setRateIndex] = useState<number>();
  const [present, dismissModal] = useIonModal(SelectLocations, {
    dismiss: () => {
      dismissModal();
    },
    setValue,
    initialLocations: locations,
  });

  const handleRateForm = (rate: Rate, index?: number) => {
    if (isNaN(index!)) {
      append(rate);
    } else {
      update(index!, rate);
    }
  };

  const [presentRate, dismissRate] = useIonModal(AddShippingRate, {
    dismiss: () => {
      dismissRate();
    },
    rate: rates[rateIndex!],
    index: rateIndex,
    handleRateForm,
    domestic,
    store,
  });

  const [presentSheet] = useIonActionSheet();
  const [presentAlert] = useIonAlert();

  // TODO: Write blog post about transition times. Mention this in the blog post.
  // Update transit time for each rate when location lenght changes
  useEffect(() => {
    if (domestic) {
      rates.forEach((rate, index) => {
        if (rate.transitTime.includes("International")) {
          update(index, {
            ...rate,
            transitTime: `${rate.transitTime.replace(
              "International",
              ""
            )}` as any,
          });
        }
      });
    } else {
      rates.forEach((rate, index) => {
        if (
          rate.transitTime !== "custom" &&
          !rate.transitTime.includes("International")
        ) {
          update(index, {
            ...rate,
            transitTime: `${rate.transitTime}International` as any,
          });
        }
      });
    }
  }, [domestic]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>{shippingZone ? "Edit" : "Add"} Shipping Zone</IonTitle>
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
          {shippingZone && (
            <IonButtons slot="end">
              <IonButton
                color="danger"
                onClick={() => {
                  presentAlert({
                    header: "Alert!",
                    message: "Are you sure you want to delete this zone?",
                    buttons: [
                      {
                        text: "Cancel",
                        role: "cancel",
                      },
                      {
                        text: "Delete",
                        role: "confirm",
                        handler: () => {
                          deleteShippingZone.mutate(shippingZone?.id!);
                          dismiss();
                        },
                      },
                    ],
                  });
                }}
              >
                Delete
              </IonButton>
            </IonButtons>
          )}
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <form className="ion-padding-top ion-padding-horizontal flex flex-col modal-form">
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
          <IonItemGroup className="mt-4">
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Locations</IonLabel>
            </IonItemDivider>
            {locations?.length ? (
              <IonItem lines="none" className="px-0 mt-2">
                <span className="font-sans mr-2 text-2xl!">
                  {locations.length === 1 ? (
                    locations[0].emoji
                  ) : (
                    <IonIcon slot="start" icon={earthOutline} />
                  )}
                </span>
                <IonLabel className="ion-text-wrap text-md!">
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
                      translucent: true,
                      buttons: [
                        {
                          text: "Delete",
                          role: "destructive",
                          handler() {
                            setValue("locations", []);
                          },
                        },
                        {
                          text: "Edit locations",
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
          <IonItemGroup className="mt-4">
            <IonItemDivider className="pl-0">
              <IonLabel color="medium">Rates</IonLabel>
            </IonItemDivider>
            <div>
              {rates.map((rate, index) => {
                let time = "";
                switch (rate.transitTime) {
                  case "economy":
                    time = "5 to 8 business days";
                    break;
                  case "standard":
                    time = "3 to 4 business days";
                    break;
                  case "express":
                    time = "1 to 2 business days";
                    break;
                  case "economyInternational":
                    time = "6 to 18 business days";
                    break;
                  case "standardInternational":
                    time = "6 to 12 business days";
                    break;
                  case "expressInternational":
                    time = "1 to 5 business days";
                    break;
                  default:
                    time = "";
                    break;
                }

                let transitName = "";
                switch (rate.transitTime) {
                  case "economyInternational":
                    transitName = "Economy International";
                    break;
                  case "standardInternational":
                    transitName = "Standard International";
                    break;
                  case "expressInternational":
                    transitName = "Express International";
                    break;
                  default:
                    transitName = rate.transitTime;
                    break;
                }
                return (
                  <IonItem key={index} lines="none" className="px-0 mt-2">
                    <IonIcon slot="start" icon={cashOutline} />
                    <IonLabel>
                      <div>
                        <div className="flex justify-between items-center">
                          <span className="capitalize truncate">
                            {rate.transitTime === "custom"
                              ? rate.customRateName
                              : transitName}
                          </span>
                          <span className="ml-2">
                            {rate.price == 0
                              ? "Free"
                              : `${rate.currency_symbol} ${rate.price}`}
                          </span>
                        </div>
                        <div className="flex justify-between items-center text-sm font-light text-gray-300">
                          <span className="truncate">
                            {time || "No transit time"}
                          </span>
                          <span className="ml-2">
                            {rate.rateCondition === "weight"
                              ? `${rate.rateConditionMin} — ${
                                  rate.rateConditionMax || "∞"
                                } kg`
                              : rate.rateCondition === "price"
                              ? `${
                                  rate.currency_symbol
                                } ${rate.rateConditionMin!} — ${
                                  (rate.rateConditionMax &&
                                    Number(rate.rateConditionMax).toFixed(2)) ||
                                  "∞"
                                }`
                              : null}
                          </span>
                        </div>
                      </div>
                    </IonLabel>
                    <IonButton
                      slot="end"
                      fill="clear"
                      color="dark"
                      onClick={() => {
                        presentSheet({
                          translucent: true,
                          buttons: [
                            {
                              text: "Delete",
                              role: "destructive",
                              handler() {
                                remove(index);
                              },
                            },
                            {
                              text: "Edit Rate",
                              handler() {
                                setRateIndex(index);
                                presentRate({
                                  id: "add-shipping-rate",
                                  breakpoints: [0, 0.6, 1],
                                  initialBreakpoint: rates[index]?.rateCondition
                                    ? 1
                                    : 0.6,
                                  onDidDismiss() {
                                    setRateIndex(undefined);
                                  },
                                });
                              },
                            },
                            {
                              text: "Cancel",
                              role: "cancel",
                            },
                          ],
                        });
                      }}
                    >
                      <IonIcon icon={ellipsisHorizontal} />
                    </IonButton>
                  </IonItem>
                );
              })}
            </div>
            <div
              className="border rounded-xl p-1 mt-4"
              style={{ borderStyle: "dashed" }}
            >
              <IonButton
                fill="clear"
                expand="block"
                color="medium"
                onClick={() => {
                  presentRate({
                    id: "add-shipping-rate",
                    breakpoints: [0, 0.6, 1],
                    initialBreakpoint: 0.6,
                    onDidDismiss() {
                      setRateIndex(undefined);
                    },
                  });
                }}
              >
                <IonIcon slot="start" icon={add} /> Add shipping rate
              </IonButton>
            </div>
          </IonItemGroup>
        </form>
        <div
          slot="fixed"
          className={`${
            !isValid ? "opacity-0" : "opacity-100"
          } transition-opacity backdrop-filter backdrop-blur-lg bg-opacity-30 bottom-0 ion-padding-horizontal pb-4 w-full`}
        >
          <IonButton
            hidden={!isValid}
            expand="block"
            color="primary"
            onClick={() => handleSubmit(onSubmit, onError)()}
          >
            Complete
          </IonButton>
        </div>
      </IonContent>
    </>
  );
}
