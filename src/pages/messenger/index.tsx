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

const Messenger: React.FC = () => {
  const user = {
    firstName: "John",
    lastName: "Doe",
    avatar: "https://randomuser.me/api/portraits/men/86.jpg",
  };
  return (
    <IonPage id="messenger">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={user.avatar} alt="avatar" />
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
