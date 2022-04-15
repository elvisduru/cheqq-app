import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonRouterLink,
  IonTitle,
  IonToolbar,
  useIonRouter,
  useIonToast,
  useIonViewDidEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import { useCallback, useEffect, useState } from "react";
import { Redirect } from "react-router";
import useCountdown from "../../hooks/useCountdown";
import useQuery from "../../hooks/useQuery";
import { useStore } from "../../hooks/useStore";
import appwrite from "../../lib/appwrite";

export default function Confirm() {
  const { user, setUser } = useStore();
  const [fresh, setFresh] = useState(false);
  const query = useQuery();
  const email = query.get("email");
  const userId = query.get("userId");
  const secret = query.get("secret");

  const router = useIonRouter();

  const [present, dismiss] = useIonToast();

  const [count, { start, stop, reset }] = useCountdown({
    seconds: 30,
    interval: 1000,
  });

  useEffect(() => {
    if (count === 0) {
      stop();
    }
  }, [count, stop]);

  useIonViewDidEnter(() => {
    confirmMagicLink();
    start();
  });

  useIonViewWillLeave(() => {
    reset();
  });

  const confirmMagicLink = useCallback(async () => {
    try {
      if (user) return;
      console.log("confirming magic link...");
      if (userId && secret) {
        const res = await appwrite.account.updateMagicURLSession(
          userId,
          secret
        );
        if (res) {
          present({
            duration: 1500,
            message: "Signed in successfully!",
            color: "dark",
            onWillDismiss: async () => {
              const user = await appwrite.account.get();
              if (!user.name) {
                setFresh(true);
              } else {
                setUser(user);
              }
            },
          });
        }
      }
    } catch (error) {
      console.log(error);
      present({
        message: "We couldn't confirm your email. Please try again.",
        buttons: [
          {
            text: "Retry",
            handler: async () => {
              if (email) {
                await appwrite.account.createMagicURLSession(
                  "unique()",
                  email!,
                  `${
                    "https://cheqq.me" || process.env.REACT_APP_BASE_URL
                  }/confirm`
                );
                dismiss();
              } else {
                router.push("/login", "back");
              }
            },
          },
        ],
      });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [email, secret, userId]);

  useEffect(() => {
    confirmMagicLink();
  }, [userId, secret, confirmMagicLink]);

  if (user) {
    return <Redirect to="/" />;
  }

  if (fresh) {
    return <Redirect to="/new" />;
  }

  return (
    <IonPage id="confirm">
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton text="" />
          </IonButtons>
          <IonTitle>Confirm Email</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="flex flex-column h-full ion-padding">
          <h2>Check your Email</h2>
          <div className="text-mute leading-normal mt-0">
            {email && <p>We've sent an email to {email}.</p>}
            <p>
              Didn't get an email? Check your spam or{" "}
              <IonRouterLink routerLink="/login" routerDirection="back">
                try another address.
              </IonRouterLink>
            </p>
          </div>

          <IonButton
            disabled={count > 0}
            className="mt-2"
            expand="block"
            onClick={async () => {
              reset();
              start();
              if (email) {
                await appwrite.account.createMagicURLSession(
                  "unique()",
                  email,
                  `${process.env.REACT_APP_BASE_URL}/confirm`
                );
              } else {
                router.push("/login", "back");
              }
            }}
          >
            {count > 0 ? `Resend email in ${count}s` : "Resend email"}
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
