import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonTitle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import "@ionic/react/css/ionic-swiper.css";
import { close } from "ionicons/icons";
import "swiper/scss";
import LottieWrapper from "../lottieWrapper";
import discountAnimation from "../../assets/json/discounts.json";
import DiscountOptions from "./discountOptions";

type Props = {
  dismiss: () => void;
};

export default function Discounts({ dismiss }: Props) {
  const [present, dismissOptions] = useIonModal(DiscountOptions, {
    dismiss: () => {
      dismissOptions();
    },
  });
  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Discounts</IonTitle>
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
      <IonContent fullscreen className="ion-padding-horizontal">
        <LottieWrapper
          title="Manage Coupons and Discounts"
          animationData={discountAnimation}
          description="Create coupon codes and automatic discounts that can be applied at checkout."
          // loop={false}
          // initialSegment={[0, 130]}
          buttonHandler={() => {
            present({
              breakpoints: [0, 0.5],
              initialBreakpoint: 0.5,
            });
          }}
          buttonText="Create Discount"
        />
      </IonContent>
    </>
  );
}
