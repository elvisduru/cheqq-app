import {
  IonAvatar,
  IonButtons,
  IonContent,
  IonHeader,
  IonLoading,
  IonMenuButton,
  IonPage,
  IonTitle,
  IonToolbar,
  useIonModal,
  useIonViewWillEnter,
} from "@ionic/react";
import notFoundAnimation from "../../assets/json/no-data-found.json";
import ChooseProduct from "../../components/ChooseProduct";
import NoData from "../../components/NoData";
import useOrders from "../../hooks/queries/orders/useOrders";
import { User } from "../../utils/types";

type Props = {
  user: User;
  routerRef: React.MutableRefObject<HTMLIonRouterOutletElement | null>;
};

const Orders: React.FC<Props> = ({ user, routerRef }) => {
  const { data, isLoading, refetch } = useOrders(user?.prefs.stores[0]);

  const [present, dismiss] = useIonModal(ChooseProduct, {
    routerEl: routerRef.current,
    dismiss: () => {
      dismiss();
    },
  });

  useIonViewWillEnter(refetch, []);

  if (isLoading) {
    return <IonLoading isOpen={true} message={"Fetching orders..."} />;
  }

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
        {!data?.pages[0].total ? (
          <NoData
            title="No Order"
            description="Create a new product to start receiving orders from customers"
            buttonText="Create Product"
            animationData={notFoundAnimation}
            buttonHandler={() =>
              present({
                breakpoints: [0, 0.5],
                initialBreakpoint: 0.5,
              })
            }
          />
        ) : (
          <div>Order list here</div>
        )}
      </IonContent>
    </IonPage>
  );
};

export default Orders;
