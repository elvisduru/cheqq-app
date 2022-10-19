import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonMenuButton,
  IonPage,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { notifications } from "ionicons/icons";
import chattingAnimation from "../../assets/json/chatting.json";
import LottieWrapper from "../../components/lottieWrapper";
import { useStore } from "../../hooks/useStore";

const Messenger = () => {
  const user = useStore((store) => store.user);
  const selectedStore = useStore((store) => store.selectedStore);
  const store = user?.stores.find((s) => s.id === selectedStore);
  return (
    <IonPage id="messenger">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={store?.logo} alt="avatar" />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
          <IonTitle>Messenger</IonTitle>
          <IonButton fill="solid" color="white" slot="end">
            <IonIcon slot="icon-only" icon={notifications} />
          </IonButton>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Messenger</IonTitle>
          </IonToolbar>
        </IonHeader>
        <div className="ion-padding">
          <div className="mt-8">
            <LottieWrapper
              title="Chat with your customers"
              animationData={chattingAnimation}
              description="You have no messages yet. When you do, they will appear here."
              // loop={false}
              // initialSegment={[0, 130]}
              buttonHandler={() => {
                console.log("button clicked");
              }}
              buttonText="Start a conversation"
            />
          </div>
        </div>
      </IonContent>
    </IonPage>
  );
};

export default Messenger;
