import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  useIonRouter,
  useIonToast,
  useIonViewDidEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import { useEffect } from "react";
import { Link } from "react-router-dom";
import useCountdown from "../../hooks/useCountdown";
import useQuery from "../../hooks/useQuery";
import appwrite from "../../lib/appwrite";

export default function Confirm() {
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

  const confirmMagicLink = async () => {
    try {
      if (userId && secret) {
        const res = await appwrite.account.updateMagicURLSession(
          userId,
          secret
        );
        if (res) {
          const user = await appwrite.account.get();
          if (!user.name) {
            router.push("/new");
          }
        }
      }
    } catch (error) {
      console.log(error);
      present({
        message: "Something went wrong. Please try again.",
        buttons: [
          {
            text: "Retry",
            handler: async () => {
              await appwrite.account.createMagicURLSession(
                "unique()",
                email!,
                `${process.env.REACT_APP_BASE_URL}/confirm`
              );
              dismiss();
            },
          },
        ],
      });
    }
  };

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
            <p>We've sent an email to {email}.</p>
            <p>
              Didn't get the email? Check your spam or{" "}
              <Link to="/login">try another address.</Link>
            </p>
          </div>

          <IonButton
            disabled={count > 0}
            className="mt-2"
            expand="block"
            onClick={async () => {
              reset();
              start();
              await appwrite.account.createMagicURLSession(
                "unique()",
                email!,
                `${process.env.REACT_APP_BASE_URL}/confirm`
              );
            }}
          >
            {count > 0 ? `Resend email in ${count}s` : "Resend email"}
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
