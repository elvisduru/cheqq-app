import {
  IonAvatar,
  IonContent,
  IonFooter,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonMenu,
  IonNote,
  IonToolbar,
} from "@ionic/react";
import { Models } from "appwrite";
import {
  albumsOutline,
  analyticsOutline,
  atOutline,
  bookmarkOutline,
  bulbOutline,
  cashOutline,
  cogOutline,
  help,
  peopleOutline,
  personOutline,
  readerOutline,
  searchOutline,
} from "ionicons/icons";
import "./SideMenu.scss";

type Props = {
  user?: Models.User<Record<string, any>>;
  contentId: string;
};

export default function SideMenu({ user, contentId }: Props) {
  return (
    <IonMenu
      side="start"
      contentId={contentId}
      disabled={!user?.name}
      draggable={!user?.name}
    >
      <IonHeader>
        <IonToolbar className="ion-no-padding ion-padding-vertical">
          <IonItem lines="none">
            <div>
              <IonAvatar className="ion-margin-bottom">
                <img src={user?.prefs.avatar} alt="" />
              </IonAvatar>
              <IonLabel>{user?.name}</IonLabel>
              <IonNote>@elvisduru</IonNote>
              <p className="flex ion-justify-content-between w-full">
                <span>
                  230 <IonNote>Followers</IonNote>
                </span>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <span>
                  230 <IonNote>Followers</IonNote>
                </span>
              </p>
            </div>
          </IonItem>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonList lines="none" className="ion-padding-vertical">
          <IonItem button>
            <IonIcon icon={personOutline} slot="start" />
            <IonLabel>Profile</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={analyticsOutline} slot="start" />
            <IonLabel>Analytics</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={peopleOutline} slot="start" />
            <IonLabel>Audience</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={readerOutline} slot="start" />
            <IonLabel>Posts</IonLabel>
          </IonItem>
        </IonList>
        <IonList lines="none" className="ion-padding-vertical">
          <IonItem button>
            <IonIcon icon={cashOutline} slot="start" />
            <IonLabel>Payouts</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={atOutline} slot="start" />
            <IonLabel>Affiliates</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={searchOutline} slot="start" />
            <IonLabel>Discover</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={bookmarkOutline} slot="start" />
            <IonLabel>Library</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={albumsOutline} slot="start" />
            <IonLabel>Starters</IonLabel>
          </IonItem>
        </IonList>
        <IonList lines="none" className="ion-padding-vertical">
          <IonItem button>
            <IonIcon icon={cogOutline} slot="start" />
            <IonLabel>Settings</IonLabel>
          </IonItem>
          <IonItem button>
            <IonIcon icon={help} slot="start" />
            <IonLabel>Help Center</IonLabel>
          </IonItem>
        </IonList>
      </IonContent>
      <IonFooter>
        <IonToolbar>
          <IonItem lines="none" button>
            <IonIcon icon={bulbOutline} slot="start" />
            <IonLabel>Automatic</IonLabel>
          </IonItem>
        </IonToolbar>
      </IonFooter>
    </IonMenu>
  );
}
