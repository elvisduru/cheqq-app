import {
  IonAvatar,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonMenu,
  IonNote,
  IonToolbar,
} from "@ionic/react";
import { personOutline } from "ionicons/icons";
import "./SideMenu.scss";

type User = {
  firstName: string;
  lastName: string;
  avatar: string;
};

type Props = {
  user: User;
  contentId: string;
};

export default function SideMenu({ user, contentId }: Props) {
  return (
    <IonMenu side="start" contentId={contentId}>
      <IonHeader>
        <IonToolbar className="ion-no-padding ion-padding-vertical">
          <IonItem lines="none">
            <div>
              <IonAvatar className="ion-margin-bottom">
                <img src={user.avatar} alt="" />
              </IonAvatar>
              <IonLabel>
                {user.firstName} {user.lastName}
              </IonLabel>
              <IonNote>@elvisduru</IonNote>
            </div>
          </IonItem>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonList lines="none" className="ion-padding-vertical">
          <IonItem>
            <IonIcon icon={personOutline} slot="start" />
            <IonLabel>Profile</IonLabel>
          </IonItem>
          <IonItem>
            <IonLabel>Profile</IonLabel>
          </IonItem>
          <IonItem>
            <IonLabel>Profile</IonLabel>
          </IonItem>
          <IonItem>
            <IonLabel>Profile</IonLabel>
          </IonItem>
        </IonList>
      </IonContent>
    </IonMenu>
  );
}
