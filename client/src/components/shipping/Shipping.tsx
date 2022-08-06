import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonSelect,
  IonSelectOption,
  IonTitle,
  IonToggle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import "@ionic/react/css/ionic-swiper.css";
import { add, close } from "ionicons/icons";
import React from "react";
import "swiper/scss";
import withSuspense from "../hoc/withSuspense";
// const AddDeliveryZone = withSuspense(
//   React.lazy(() => import("./AddDeliveryZone"))
// );
const AddShippingZone = withSuspense(
  React.lazy(() => import("./AddShippingZone"))
);

type Props = {
  dismiss: () => void;
};

export default function ShippingZones({ dismiss }: Props) {
  const [present, dismissAddZone] = useIonModal(AddShippingZone, {
    dismiss: () => {
      dismissAddZone();
    },
  });
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
                  transit time of the carrier.
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
                  Choose where you ship and how much you charge for shipping at
                  checkout.
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
        </div>
      </IonContent>
    </>
  );
}
