import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonContent,
  IonGrid,
  IonHeader,
  IonIcon,
  IonMenuButton,
  IonPage,
  IonRow,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { notifications } from "ionicons/icons";
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
        <IonGrid>
          <IonRow>
            <IonTitle>See your Messenger</IonTitle>
          </IonRow>
          <IonButton routerLink="/store/new">Create new store</IonButton>
        </IonGrid>
      </IonContent>
    </IonPage>
  );
};

export default Messenger;
