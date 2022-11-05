import { Clipboard } from "@capacitor/clipboard";
import { IonButton, IonContent, IonIcon } from "@ionic/react";
import { copy, globe, shareSocial } from "ionicons/icons";
import { useEffect, useState } from "react";
import successAnimation from "../assets/json/success.json";
import LottieWrapper from "./lottieWrapper";
import { Share } from "@capacitor/share";
import { Browser } from "@capacitor/browser";
import { Product } from "../utils/types";

type Props = {
  product: Product;
  dismiss: () => void;
  clearFormData: () => void;
};

export default function ProductSuccess({
  product,
  dismiss,
  clearFormData,
}: Props) {
  const [copied, setCopied] = useState(false);

  const resetCopyText = () => setCopied(false);

  useEffect(() => {
    let timeout: any;
    if (copied) {
      timeout = setTimeout(resetCopyText, 2000);
    }

    return () => clearTimeout(timeout);
  }, [copied]);

  return (
    <IonContent className="ion-padding">
      <LottieWrapper
        animationData={successAnimation}
        title="Your product is live!"
        description="Your product is now live on the internet. You can view it, copy it's link, or share it with your friends."
      />
      <div className="border border-gray-400 border-opacity-10 w-2/3 mx-auto my-10" />
      <div className="flex justify-center space-x-7 max-w-min mx-auto px-4 mb-10">
        <div className="flex flex-col items-center text-center">
          <IonButton
            className="text-sm"
            color="light"
            onClick={async () => {
              await Browser.open({
                url: `${import.meta.env.VITE_SITE_URL}/${product.store?.tag}/${
                  product.slug
                }`,
              });
            }}
          >
            <IonIcon size="medium" slot="icon-only" icon={globe} />
          </IonButton>
          <p className="text-xs">View</p>
        </div>
        <div className="flex flex-col items-center text-center">
          <IonButton
            className="text-sm"
            color="light"
            onClick={async () => {
              await Clipboard.write({
                url: `${import.meta.env.VITE_SITE_URL}/${product.store?.tag}/${
                  product.slug
                }`,
              });
              setCopied(true);
            }}
          >
            <IonIcon slot="icon-only" icon={copy} />
          </IonButton>
          <p className="text-xs">{copied ? "Copied!" : "Copy link"}</p>
        </div>
        <div className="flex flex-col items-center text-center">
          <IonButton
            className="text-sm"
            color="light"
            onClick={async () => {
              await Share.share({
                title: product.title,
                text: "Really awesome thing you need to see right meow",
                url: `${import.meta.env.VITE_SITE_URL}/${product.store?.tag}/${
                  product.slug
                }`,
                dialogTitle: "Share with buddies",
              });
            }}
          >
            <IonIcon slot="icon-only" icon={shareSocial} />
          </IonButton>
          <p className="text-xs">Share</p>
        </div>
      </div>
      <IonButton expand="block" routerLink="/home" onClick={clearFormData}>
        Back to Home
      </IonButton>
      <IonButton expand="block" color="medium" fill="clear" onClick={dismiss}>
        Continue Editing
      </IonButton>
    </IonContent>
  );
}
