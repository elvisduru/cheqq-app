import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonCol,
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
import { useLottie } from "lottie-react";
import notFoundAnimation from "../../assets/json/no-data-found.json";

type Props = {
  user: User;
};

const Orders: React.FC<Props> = ({ user }) => {
  const { View } = useLottie({
    animationData: notFoundAnimation,
    loop: true,
  });

  return (
    <IonPage id="orders">
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
          <IonTitle>Orders</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Orders</IonTitle>
          </IonToolbar>
        </IonHeader>
        <IonGrid className="mt-2">
          <IonRow>
            <IonCol>{View}</IonCol>
          </IonRow>
        </IonGrid>
        <div className="ion-text-center mt-2 px-2">
          <h3>No orders</h3>
          <p>
            Create your first product and start receiving orders from customers.
          </p>
          <IonButton className="mt-3" expand="block">
            Create a new product
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
};

export default Orders;
