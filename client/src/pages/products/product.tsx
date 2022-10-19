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
  IonSegment,
  IonSegmentButton,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { filter, notifications, trash, trashBinOutline } from "ionicons/icons";
import useProducts from "../../hooks/queries/products/useProducts";
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const Products: React.FC<Props> = ({ user }) => {
  const { selectedStore } = useStore();
  const store = user?.stores.find((s) => s.id === selectedStore);
  const filter = {
    store: {
      ownerId: user.id,
    },
  };
  const { data: products, isLoading } = useProducts(filter);

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
        <div className="ion-padding">
          <IonSegment>
            <IonSegmentButton>All Products</IonSegmentButton>
            <IonSegmentButton>Subscriptions</IonSegmentButton>
          </IonSegment>
        </div>
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
