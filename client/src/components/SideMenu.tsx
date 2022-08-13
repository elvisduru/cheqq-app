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
import { useRef } from "react";
import { useStore } from "../hooks/useStore";
import "./SideMenu.scss";

export default function SideMenu() {
  const menuRef = useRef<HTMLIonMenuElement>(null);
  const user = useStore((store) => store.user);
  const selectedStore = useStore((store) => store.selectedStore);

  return (
    <IonMenu
      side="start"
      contentId="main"
      disabled={!user?.name || !user?.stores.length}
      draggable={!user?.name}
      ref={menuRef}
    >
      {user && (
        <>
          <IonHeader>
            <IonToolbar className="ion-no-padding ion-padding-vertical">
              <IonItem lines="none">
                <div>
                  <IonAvatar className="ion-margin-bottom">
                    <img src={user.stores[selectedStore]?.logo} alt="avatar" />
                  </IonAvatar>
                  <IonLabel>{user?.name}</IonLabel>
                  <IonNote>@{user.stores[selectedStore]?.tag}</IonNote>
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
          <IonContent fullscreen onClick={() => menuRef.current?.close()}>
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
              <IonItem button routerLink="/settings">
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
        </>
      )}
    </IonMenu>
  );
}
