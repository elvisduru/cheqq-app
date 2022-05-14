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
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const Messenger: React.FC<Props> = ({ user }) => {
  return (
    <IonPage id="messenger">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img
                  src={`${process.env.REACT_APP_APPWRITE_ENDPOINT}/storage/buckets/${user?.$id}/files/${user?.prefs.avatar}/preview?width=65&height=65&project=${process.env.REACT_APP_APPWRITE_PROJECT_ID}`}
                  alt="avatar"
                />
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
