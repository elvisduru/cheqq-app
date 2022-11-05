import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonMenuButton,
  IonPage,
  IonTitle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import { notifications } from "ionicons/icons";
import notFoundAnimation from "../../assets/json/no-data-found.json";
import ChooseProduct from "../../components/ChooseProduct";
import LottieWrapper from "../../components/lottieWrapper";
import OrdersSkeleton from "../../components/skeletons/orders";
import useOrders from "../../hooks/queries/orders/useOrders";
import { useStore } from "../../hooks/useStore";

const Orders = () => {
  const user = useStore((store) => store.user);
  const selectedStore = useStore((store) => store.selectedStore);
  const store = user?.stores.find((s) => s.id === selectedStore);
  const { data, isLoading } = useOrders();

  const [present, dismiss] = useIonModal(ChooseProduct, {
    dismiss: () => {
      dismiss();
    },
  });

  return (
    <IonPage id="orders">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={store?.logo} alt="avatar" />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
          <IonTitle>Orders</IonTitle>
          <IonButton fill="solid" color="white" slot="end">
            <IonIcon slot="icon-only" icon={notifications} />
          </IonButton>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Orders</IonTitle>
          </IonToolbar>
        </IonHeader>
        <div className="ion-padding">
          {isLoading ? (
            <OrdersSkeleton length={9} />
          ) : !data?.pages[0].total ? (
            <div className="mt-8">
              <LottieWrapper
                title="No Order"
                description="Create a new product to start receiving orders from customers"
                buttonText="Create a product"
                animationData={notFoundAnimation}
                buttonHandler={() =>
                  present({
                    breakpoints: [0, 0.5],
                    initialBreakpoint: 0.5,
                    id: "choose-product",
                  })
                }
              />
            </div>
          ) : (
            <div>Order list here</div>
          )}
        </div>
      </IonContent>
    </IonPage>
  );
};

export default Orders;
