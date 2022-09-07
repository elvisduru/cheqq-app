import {
  IonButton,
  IonContent,
  IonIcon,
  IonLabel,
  IonPage,
} from "@ionic/react";
import { logoApple, logoFacebook, logoGoogle } from "ionicons/icons";
import "./index.scss";

export default function SignUp() {
  return (
    <IonPage id="signup">
      <IonContent fullscreen>
        <div className="flex flex-col h-full">
          <div className="top-illustration flex flex-col">
            <h1 className="mt-auto text-2xl font-black">
              Get started. It's Free.
            </h1>
          </div>
          <div className="custom-card">
            <IonButton routerLink="/login" expand="block">
              Continue with Email
            </IonButton>
            <p className="ion-text-center">or</p>
            <IonButton color="dark" expand="block">
              <IonIcon icon={logoFacebook} className="mr-auto" />
              <IonLabel className="mr-auto">Continue with Facebook</IonLabel>
            </IonButton>
            <IonButton color="dark" expand="block">
              <IonIcon icon={logoGoogle} className="mr-auto" />
              <IonLabel className="mr-auto">Continue with Google</IonLabel>
            </IonButton>
            <IonButton color="dark" expand="block">
              <IonIcon icon={logoApple} className="mr-auto" />
              <IonLabel className="mr-auto">Continue with Apple</IonLabel>
            </IonButton>
          </div>
        </div>
      </IonContent>
    </IonPage>
  );
}
