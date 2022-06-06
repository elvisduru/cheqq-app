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
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";

type Props = {
  user: User;
};

const Orders: React.FC<Props> = ({ user }) => {
  const { selectedStore } = useStore();
  const { data, isLoading } = useOrders();

  const [present, dismiss] = useIonModal(ChooseProduct, {
    dismiss: () => {
      dismiss();
    },
  });

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
                <img src={user.stores[selectedStore].logo} alt="avatar" />
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
