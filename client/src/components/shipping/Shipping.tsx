import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonSelect,
  IonSelectOption,
  IonTitle,
  IonToggle,
  IonToolbar,
  useIonActionSheet,
  useIonModal,
} from "@ionic/react";
import "@ionic/react/css/ionic-swiper.css";
import { polyfillCountryFlagEmojis } from "country-flag-emoji-polyfill";
import { add, close, earthOutline, ellipsisHorizontal } from "ionicons/icons";
import React from "react";
import "swiper/scss";
import useDeleteFulfillmentService from "../../hooks/mutations/fulfillmentServices/deleteFulfillmentService";
import useDeleteShippingZone from "../../hooks/mutations/shipping/deleteShippingZone";
import useFulfillmentServices from "../../hooks/queries/fulfillmentService/useFulfillmentServices";
import useShippingZones from "../../hooks/queries/shipping/useShippingZones";
import { useStore } from "../../hooks/useStore";
import withSuspense from "../hoc/withSuspense";
// const AddDeliveryZone = withSuspense(
//   React.lazy(() => import("./AddDeliveryZone"))
// );
const AddShippingZone = withSuspense(
  React.lazy(() => import("./AddShippingZone"))
);
const AddFulfillmentService = withSuspense(
  React.lazy(() => import("./AddFulfillmentService"))
);

type Props = {
  dismiss: () => void;
};

polyfillCountryFlagEmojis();

export default function ShippingZones({ dismiss }: Props) {
  const selectedStore = useStore((store) => store.selectedStore);
  const { data: shippingZones } = useShippingZones(selectedStore!);
  const { data: fulfillmentServices } = useFulfillmentServices(selectedStore!);
  const [selectedZone, setSelectedZone] = React.useState<number | undefined>();
  const [selectedService, setSelectedService] = React.useState<
    number | undefined
  >();

  const deleteShippingZone = useDeleteShippingZone();
  const deleteFulfillmentService = useDeleteFulfillmentService();

  const [present, dismissAddZone] = useIonModal(AddShippingZone, {
    dismiss: () => {
      dismissAddZone();
    },
    selectedStore,
    shippingZone: shippingZones?.find((zone) => zone.id === selectedZone),
  });

  const [presentFulfillment, dismissFulfillment] = useIonModal(
    AddFulfillmentService,
    {
      dismiss: () => {
        dismissFulfillment();
      },
      selectedStore,
      fulfillmentService: fulfillmentServices?.find(
        (service) => service.id === selectedService
      ),
    }
  );

  const [presentSheet] = useIonActionSheet();
  // const [presentDeliveryZone, dismissAddDeliveryZone] = useIonModal(
  //   AddDeliveryZone,
  //   {
  //     dismiss: () => {
  //       dismissAddDeliveryZone();
  //     },
  //   }
  // );

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Shipping &amp; Delivery</IonTitle>
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
        <div className="ion-padding-top ion-padding-horizontal flex flex-column">
          <IonItem lines="none" className="input checkbox w-full">
            <IonLabel>
              Enable local pickup <br />
              <IonNote color="medium" className="text-xs ion-text-wrap">
                Allow customers pick up orders from your store.
              </IonNote>
            </IonLabel>
            <IonToggle color="primary" />
          </IonItem>
          {/* <IonItemGroup className="mt-4"> // TODO: Complete Local Delivery feature
            <IonItem lines="none" className="input checkbox w-full">
              <IonLabel color="medium">
                Local Delivery <br />
                <IonNote
                  color="medium"
                  className="text-xs font-normal ion-text-wrap"
                >
                  Deliver orders directly to local customers.{" "}
                  <IonRouterLink
                    onClick={async () => {
                      // TODO: Add correct link to help guide
                      await Browser.open({ url: "https://elvisduru.com" });
                    }}
                  >
                    Learn more
                  </IonRouterLink>
                </IonNote>
              </IonLabel>
            </IonItem>
            <div
            className="border rounded-xl p-1 mt-4"
            style={{ borderStyle: "dashed" }}
          >
            <IonButton
              fill="clear"
              expand="block"
              color="medium"
              onClick={() => {
                presentDeliveryZone({
                  presentingElement: document.querySelector(
                    "#shipping-settings"
                  ) as HTMLElement,
                  swipeToClose: false,
                });
              }}
            >
              <IonIcon slot="start" icon={add} /> Add Delivery Zone
            </IonButton>
          </div>
          </IonItemGroup>
           */}
          <IonItemGroup className="mt-4">
            <IonItem lines="none" className="input checkbox w-full">
              <IonLabel color="medium">
                Shipping zones <br />
                <IonNote
                  color="medium"
                  className="text-xs font-normal ion-text-wrap"
                >
                  Choose where you ship and how much you charge for shipping at
                  checkout.
                </IonNote>
              </IonLabel>
            </IonItem>
            {shippingZones?.map((zone) => (
              <IonItem key={zone.id} className="px-0 mt-2">
                <span className="font-sans mr-2 text-2xl!">
                  {zone.locations.length === 1 ? (
                    zone.locations[0]?.country?.emoji
                  ) : (
                    <IonIcon slot="start" icon={earthOutline} />
                  )}
                </span>
                <IonLabel>
                  <div className="flex justify-between">
                    {zone.name === "Domestic" ? (
                      <span>
                        Domestic{" "}
                        <span className="text-gray-500">
                          ({zone.locations[0]?.country?.name})
                        </span>
                      </span>
                    ) : zone.locations.length === 1 ? (
                      <span>
                        {zone.locations[0]?.country?.name}{" "}
                        <span className="text-gray-500">
                          ({zone.locations[0].states.length}{" "}
                          {zone.locations[0].states.length === 1
                            ? "state"
                            : "states"}
                          )
                        </span>
                      </span>
                    ) : (
                      <span>
                        {zone.name}{" "}
                        <span className="text-gray-500">
                          ({zone.locations.length}{" "}
                          {zone.locations.length === 1
                            ? "country"
                            : "countries"}
                          )
                        </span>
                      </span>
                    )}
                    <span className="text-gray-300">
                      {zone.rates.length} rates
                    </span>
                  </div>
                </IonLabel>
                <IonButton
                  onClick={() => {
                    setSelectedZone(zone.id);
                    presentSheet({
                      translucent: true,
                      buttons: [
                        {
                          text: "Delete",
                          role: "destructive",
                          handler() {
                            deleteShippingZone.mutate(zone.id!);
                          },
                        },
                        {
                          text: "Edit shipping zone",
                          handler() {
                            present({
                              presentingElement: document.querySelector(
                                "#shipping-settings"
                              ) as HTMLElement,
                              canDismiss: true,
                              id: "add-shipping-zone",
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
                  slot="end"
                  fill="clear"
                  color="dark"
                >
                  <IonIcon icon={ellipsisHorizontal} />
                </IonButton>
              </IonItem>
            ))}
            <div
              className="border rounded-xl p-1 mt-4"
              style={{ borderStyle: "dashed" }}
            >
              <IonButton
                fill="clear"
                expand="block"
                color="medium"
                onClick={() => {
                  present({
                    presentingElement: document.querySelector(
                      "#shipping-settings"
                    ) as HTMLElement,
                    canDismiss: true,
                    id: "add-shipping-zone",
                  });
                }}
              >
                <IonIcon slot="start" icon={add} /> Add shipping zone
              </IonButton>
            </div>
          </IonItemGroup>
          <IonItemGroup className="mt-4 modal-form">
            <IonItem lines="none" className="input checkbox w-full">
              <IonLabel color="medium">
                Processing time <br />
                <IonNote
                  color="medium"
                  className="text-xs font-normal ion-text-wrap"
                >
                  Total time it takes to process an order, from placement to
                  when the package is handed to the carrier. This adds up to the
                  transit time of your shipping rates.
                </IonNote>
              </IonLabel>
            </IonItem>
            <IonItem className="input mt-4" fill="outline" mode="md">
              <IonLabel position="floating">Your processing time</IonLabel>
              <IonSelect
                interface="action-sheet"
                interfaceOptions={{
                  translucent: true,
                  mode: "ios",
                  size: "auto",
                }}
                onIonBlur={(e) => {
                  if (e.target.value) {
                    // TODO: Update data at API
                  }
                }}
              >
                <IonSelectOption>No processing time</IonSelectOption>
                <IonSelectOption>Same business day</IonSelectOption>
                <IonSelectOption>Next business day</IonSelectOption>
                <IonSelectOption>2 business days</IonSelectOption>
              </IonSelect>
            </IonItem>
          </IonItemGroup>
          <IonItemGroup className="mt-4">
            <IonItem lines="none" className="input checkbox w-full">
              <IonLabel color="medium">
                Custom order fulfillment <br />
                <IonNote
                  color="medium"
                  className="text-xs font-normal ion-text-wrap"
                >
                  Add the emails of custom providers that fulfill orders for
                  you. They will get an email when you mark an order as
                  fulfilled.
                </IonNote>
              </IonLabel>
            </IonItem>
            {fulfillmentServices?.map((service) => (
              <IonItem key={service.id} className="px-0 mt-2">
                <IonLabel>{service.name}</IonLabel>
                <IonButton
                  onClick={() => {
                    setSelectedService(service.id);
                    presentSheet({
                      translucent: true,
                      buttons: [
                        {
                          text: "Delete",
                          role: "destructive",
                          handler() {
                            deleteFulfillmentService.mutate(service.id!);
                          },
                        },
                        {
                          text: "Edit fulfillment service",
                          handler() {
                            presentFulfillment({
                              id: "add-fulfillment-service",
                              breakpoints: [0, 0.4],
                              initialBreakpoint: 0.4,
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
                  slot="end"
                  fill="clear"
                  color="dark"
                >
                  <IonIcon icon={ellipsisHorizontal} />
                </IonButton>
              </IonItem>
            ))}
            <div
              className="border rounded-xl p-1 mt-4 mb-8"
              style={{ borderStyle: "dashed" }}
            >
              <IonButton
                fill="clear"
                expand="block"
                color="medium"
                onClick={() => {
                  presentFulfillment({
                    id: "add-fulfillment-service",
                    breakpoints: [0, 0.4],
                    initialBreakpoint: 0.4,
                  });
                }}
              >
                <IonIcon slot="start" icon={add} /> Add fulfillment service
              </IonButton>
            </div>
          </IonItemGroup>
        </div>
      </IonContent>
    </>
  );
}
