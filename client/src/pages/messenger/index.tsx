import {
  IonAvatar,
  IonButtons,
  IonContent,
  IonGrid,
  IonHeader,
  IonMenuButton,
  IonPage,
  IonRow,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const Messenger: React.FC<Props> = ({ user }) => {
  const { selectedStore } = useStore();
  return (
    <IonPage id="messenger">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={user.stores[selectedStore]?.logo} alt="avatar" />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
          <IonTitle>Messenger</IonTitle>
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
        </IonGrid>
      </IonContent>
    </IonPage>
  );
};

export default Messenger;
