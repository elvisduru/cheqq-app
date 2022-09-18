import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonCol,
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
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const Products: React.FC<Props> = ({ user }) => {
  const { selectedStore } = useStore();
  const store = user?.stores.find((s) => s.id === selectedStore);
  return (
    <IonPage id="products">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={store?.logo} alt="avatar" />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
          <IonTitle>Products</IonTitle>
          <IonButton fill="solid" color="white" slot="end">
            <IonIcon slot="icon-only" icon={notifications} />
          </IonButton>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Products</IonTitle>
          </IonToolbar>
        </IonHeader>
        <IonGrid>
          <IonRow>
            <IonTitle>See your products</IonTitle>
          </IonRow>
          <IonRow>
            <IonCol>
              <IonButton routerLink="/products/1">View Detail page</IonButton>
            </IonCol>
          </IonRow>
        </IonGrid>
      </IonContent>
    </IonPage>
  );
};

export default Products;
