import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonNote,
  IonRouterLink,
  IonSegment,
  IonSegmentButton,
  IonTitle,
  IonToggle,
  IonToolbar,
} from "@ionic/react";
import "@ionic/react/css/ionic-swiper.css";
import { add, close } from "ionicons/icons";
import { useState } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/scss";
import { Swiper as SwiperType } from "swiper/types";

type Props = {
  dismiss: () => void;
};

export default function ShippingZones({ dismiss }: Props) {
  const [tabIndex, setTabIndex] = useState<number>(0);
  const [swiper, setSwiper] = useState<SwiperType | null>(null);

  const localZones: any = [];
  const globalZones: any = [];

  const ShippingZoneList = ({
    type,
    title,
    description,
    items,
    children,
  }: {
    type: string;
    title: string;
    description: JSX.Element;
    items?: any;
    children?: JSX.Element[] | JSX.Element;
  }) => (
    <IonList className="bg-modal ion-text-left h-full ion-padding-horizontal flex flex-column ion-align-items-center">
      <IonListHeader className="ion-no-padding">
        <IonLabel>{title}</IonLabel>
      </IonListHeader>
      <IonNote color="medium" className="text-sm">
        {description}
      </IonNote>
      {children}
    </IonList>
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
        <div className="ion-padding-top ion-padding-horizontal">
          <IonSegment
            onIonChange={(e) => {
              const index = parseFloat(e.detail.value!);
              setTabIndex(index);
              swiper?.slideTo(index);
            }}
            value={tabIndex.toString()}
          >
            <IonSegmentButton value="0">
              <IonLabel>Local Delivery</IonLabel>
            </IonSegmentButton>
            <IonSegmentButton value="1">
              <IonLabel>Global Delivery</IonLabel>
            </IonSegmentButton>
          </IonSegment>
        </div>
        <Swiper
          initialSlide={tabIndex}
          onSlideChange={(swiper) => {
            setTabIndex(swiper.activeIndex);
          }}
          onSwiper={(swiper) => setSwiper(swiper)}
          style={{ height: "calc(100% - 50px)" }}
        >
          <SwiperSlide>
            <ShippingZoneList
              type="local"
              title="Local Delivery"
              description={
                <>
                  Deliver orders directly to local customers. Learn more about{" "}
                  <IonRouterLink routerLink="/products/1">
                    local delivery.
                  </IonRouterLink>
                </>
              }
            >
              <IonItem lines="none" className="input checkbox mt-1 w-full">
                <IonLabel>
                  Enable local pickup <br />
                  <IonNote color="medium" className="text-xs ion-text-wrap">
                    Allow customers pick up their orders.{" "}
                    <IonRouterLink routerLink="/">Learn more.</IonRouterLink>
                  </IonNote>
                </IonLabel>
                <IonToggle mode="ios" color="primary" />
              </IonItem>
              <IonButton
                fill="clear"
                expand="block"
                className={localZones.length ? "mt-2" : "my-auto"}
              >
                <IonIcon slot="start" icon={add} /> Add Shipping Zone
              </IonButton>
            </ShippingZoneList>
          </SwiperSlide>
          <SwiperSlide>
            <ShippingZoneList
              type="global"
              title="Global Delivery"
              description={
                <>
                  Allow local customers to pick up their orders. Learn more
                  about{" "}
                  <IonRouterLink routerLink="/products/1">
                    local pickup.
                  </IonRouterLink>
                </>
              }
            >
              <IonButton
                fill="clear"
                expand="block"
                className={globalZones.length ? "mt-2" : "my-auto"}
              >
                <IonIcon slot="start" icon={add} /> Add Shipping Zone
              </IonButton>
            </ShippingZoneList>
          </SwiperSlide>
        </Swiper>
      </IonContent>
    </>
  );
}
