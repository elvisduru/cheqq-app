import { IonButton, IonCol, IonGrid, IonRow } from "@ionic/react";
import { useLottie } from "lottie-react";

type Props = {
  title: string;
  description?: string;
  buttonText?: string;
  buttonLink?: string;
  animationData?: any;
  buttonHandler?: () => void;
};

export default function NoData({
  title,
  description,
  buttonLink,
  buttonText,
  animationData,
  buttonHandler,
}: Props) {
  const { View } = useLottie({
    animationData,
    loop: true,
  });
  return (
    <>
      <IonGrid className="mt-2">
        <IonRow>
          <IonCol>{View}</IonCol>
        </IonRow>
      </IonGrid>
      <div className="ion-text-center mt-2 px-2">
        <h3>{title}</h3>
        {description && <p>{description}</p>}
        {buttonText && (
          <IonButton
            routerLink={buttonLink}
            onClick={buttonHandler}
            className="mt-3"
            expand="block"
          >
            {buttonText}
          </IonButton>
        )}
      </div>
    </>
  );
}
