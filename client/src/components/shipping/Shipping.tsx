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
  IonTitle,
  IonToggle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import "@ionic/react/css/ionic-swiper.css";
import { add, close } from "ionicons/icons";
import "swiper/scss";
import AddDeliveryZone from "./AddDeliveryZone";
import AddShippingZone from "./AddShippingZone";

type Props = {
  dismiss: () => void;
};

export default function ShippingZones({ dismiss }: Props) {
  const [present, dismissAddZone] = useIonModal(AddShippingZone, {
    dismiss: () => {
      dismissAddZone();
    },
  });
  const [presentDeliveryZone, dismissAddDeliveryZone] = useIonModal(
    AddDeliveryZone,
    {
      dismiss: () => {
        dismissAddDeliveryZone();
      },
    }
  );

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
          <IonItemGroup className="mt-4">
            <IonItem lines="none" className="input checkbox w-full">
              <IonLabel color="medium">
                Local Delivery <br />
                <IonNote
                  color="medium"
                  className="text-xs font-normal ion-text-wrap"
                >
                  Choose where you ship and how much you charge for shipping at
                  checkout.
                </IonNote>
              </IonLabel>
            </IonItem>
          </IonItemGroup>
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
                  canDismiss: true,
                });
              }}
            >
              <IonIcon slot="start" icon={add} /> Add Delivery Zone
            </IonButton>
          </div>
          <IonItemGroup className="mt-4">
            <IonItem lines="none" className="input checkbox w-full">
              <IonLabel color="medium">
                Shipping Zones <br />
                <IonNote
                  color="medium"
                  className="text-xs font-normal ion-text-wrap"
                >
                  Choose where you ship and how much you charge for shipping at
                  checkout.
                </IonNote>
              </IonLabel>
            </IonItem>
          </IonItemGroup>
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
                });
              }}
            >
              <IonIcon slot="start" icon={add} /> Add Shipping Zone
            </IonButton>
          </div>
        </div>
      </IonContent>
    </>
  );
}
