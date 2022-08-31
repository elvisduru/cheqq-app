import { IonButton, IonCol, IonGrid, IonRow } from "@ionic/react";
import { useLottie } from "lottie-react";

type Props = {
  title: string;
  animationData: any;
  description?: string;
  buttonText?: string;
  buttonLink?: string;
  loop?: boolean;
  buttonHandler?: () => void;
  initialSegment?: [number, number];
};

export default function LottieWrapper({
  title,
  description,
  buttonLink,
  buttonText,
  animationData,
  buttonHandler,
  loop = true,
  initialSegment,
}: Props) {
  const { View } = useLottie({
    animationData,
    loop,
    initialSegment,
  });
  return (
    <div className="mt-2">
      <IonGrid>
        <IonRow>
          <IonCol>{View}</IonCol>
        </IonRow>
      </IonGrid>
      <div className="ion-text-center leading-normal mt-10">
        <h3>{title}</h3>
        {description && <p className="text-gray text-base">{description}</p>}
        {buttonText && (
          <IonButton
            routerLink={buttonLink}
            onClick={buttonHandler}
            className="mt-12"
            expand="block"
          >
            {buttonText}
          </IonButton>
        )}
      </div>
    </div>
  );
}
