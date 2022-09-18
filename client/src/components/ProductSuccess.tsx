import { IonButton, IonContent, IonIcon } from "@ionic/react";
import LottieWrapper from "./lottieWrapper";
import successAnimation from "../assets/json/success.json";
import {
  copy,
  globe,
  mail,
  openOutline,
  shareOutline,
  shareSocial,
  shareSocialSharp,
} from "ionicons/icons";

type Props = { dismiss: () => void };

export default function ProductSuccess({ dismiss }: Props) {
  return (
    <IonContent className="ion-padding">
      <LottieWrapper
        animationData={successAnimation}
        title="Your product is live!"
        description="Your product is now live on the internet. You can view it, copy it's link, or share it with your friends."
      />
      <div className="border border-gray-400 border-opacity-10 w-2/3 mx-auto my-10" />
      <div className="flex justify-center space-x-5 max-w-min mx-auto px-4 mb-10">
        <div className="flex flex-col items-center">
          <IonButton className="text-sm" color="light">
            <IonIcon size="medium" slot="icon-only" icon={globe} />
          </IonButton>
          <p className="text-sm">View</p>
        </div>
        <div className="flex flex-col items-center">
          <IonButton className="text-sm" color="light">
            <IonIcon slot="icon-only" icon={copy} />
          </IonButton>
          <p className="text-sm">Copy link</p>
        </div>
        <div className="flex flex-col items-center">
          <IonButton className="text-sm" color="light">
            <IonIcon slot="icon-only" icon={shareSocial} />
          </IonButton>
          <p className="text-sm">Share</p>
        </div>
      </div>
      <IonButton expand="block" onClick={dismiss}>
        Back to Home
      </IonButton>
      <IonButton expand="block" color="medium" fill="clear" onClick={dismiss}>
        Continue Editing
      </IonButton>
    </IonContent>
  );
}
