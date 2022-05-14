import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonInput,
  IonItem,
  IonLabel,
  IonPage,
  IonRouterLink,
  IonTitle,
  IonToolbar,
  useIonRouter,
} from "@ionic/react";
import { useState } from "react";
import { Redirect } from "react-router";
import appwrite from "../../../lib/appwrite";
import { User } from "../../../utils/types";
import "./index.scss";

export default function Login({ user }: { user: User }) {
  const router = useIonRouter();
  const [email, setEmail] = useState<string>("");
  const [valid, setValid] = useState<boolean>(true);
  const validateEmail = (value: string) => {
    if (
      value.match(
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      )
    ) {
      return true;
    } else {
      return false;
    }
  };

  const handleMagicLink = async () => {
    try {
      if (validateEmail(email)) {
        setValid(true);
        await appwrite.account.createMagicURLSession(
          "unique()",
          email,
          "https://cheqq.me/confirm"
        );
        router.push("/confirm?email=" + email);
      } else {
        setValid(false);
      }
    } catch (error) {
      console.log(error);
    }
  };

  if (user) {
    return <Redirect to="/" />;
  }

  return (
    <IonPage id="login">
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton />
          </IonButtons>
          <IonTitle>Log in</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="flex flex-column h-full ion-padding">
          <h2>Welcome to Cheqq</h2>
          <div className="text-gray leading-normal mt-0">
            <p>Cheqq is the home for all your business needs.</p>
            <p>To sign up or log in, enter your email.</p>
          </div>

          <IonLabel color="danger" style={{ minHeight: 20 }} className="mt-1">
            {!valid && "Email address not valid"}
          </IonLabel>
          <IonItem className="input" fill="outline" mode="md">
            <IonInput
              required
              onIonChange={(e) => setEmail(e.detail.value!)}
              type="email"
              placeholder="Email (personal or work)"
              value={email}
            />
          </IonItem>
          <IonButton
            disabled={!email}
            className="mt-1"
            expand="block"
            onClick={handleMagicLink}
          >
            Send Magic Link
          </IonButton>
          {
            // HACK: This is a hack to get to the /new route
            <IonRouterLink className="mt-4 ion-text-center" routerLink="/new">
              Skip to New page
            </IonRouterLink>
          }
        </div>
      </IonContent>
    </IonPage>
  );
}