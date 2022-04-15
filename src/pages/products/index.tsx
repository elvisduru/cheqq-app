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

type Props = {
  user: User;
};

const Products: React.FC<Props> = ({ user }) => {
  return (
    <IonPage id="products">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img
                  src={`${process.env.REACT_APP_APPWRITE_ENDPOINT}/storage/buckets/${process.env.REACT_APP_APPWRITE_BUCKET_CHEQQ}/files/${user?.prefs.avatar}/preview?width=65&height=65&project=${process.env.REACT_APP_APPWRITE_PROJECT_ID}`}
                  alt="avatar"
                />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
          <IonTitle>Products</IonTitle>
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
