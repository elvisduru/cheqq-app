import { IonButton, IonContent } from "@ionic/react";
import LottieWrapper from "./lottieWrapper";
import successAnimation from "../assets/json/success.json";

type Props = { dismiss: () => void };

export default function ProductSuccess({ dismiss }: Props) {
  return (
    <IonContent className="ion-padding">
      <LottieWrapper
        animationData={successAnimation}
        title="Your product is live!"
        description="Your product is now live on the internet. You can view it in your store."
      />
      <div className="grid grid-cols-3 divide-x">
        <div>01</div>
        <div>02</div>
        <div>03</div>
      </div>
      <IonButton expand="block" onClick={dismiss}>
        Back to Home
      </IonButton>
    </IonContent>
  );
}
