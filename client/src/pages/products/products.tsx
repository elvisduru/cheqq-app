import {
  IonAvatar,
  IonButton,
  IonButtons,
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
  useIonModal,
} from "@ionic/react";
import { notifications, search, searchOutline } from "ionicons/icons";
import React from "react";
import notFoundAnimation from "../../assets/json/no-data-found.json";
import ChooseProduct from "../../components/ChooseProduct";
import LottieWrapper from "../../components/lottieWrapper";
import ProductCard from "../../components/products/card";
import OrdersSkeleton from "../../components/skeletons/orders";
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

  const [present, dismiss] = useIonModal(ChooseProduct, {
    dismiss: () => {
      dismiss();
    },
  });

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
          {/* HACK: Margin vertical to make the toolbar like other pages */}
          <IonButtons slot="end" className="my-2">
            <IonButton fill="solid" color="white">
              <IonIcon slot="icon-only" icon={search} />
            </IonButton>
            <IonButton fill="solid" color="white">
              <IonIcon slot="icon-only" icon={notifications} />
            </IonButton>
          </IonButtons>
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
          <div>
            {isLoading ? (
              <OrdersSkeleton length={9} />
            ) : !products?.pages[0].length ? (
              <div className="mt-8">
                <LottieWrapper
                  title="No Products"
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
              <IonGrid className="p-0">
                {products.pages.map((group, i) => (
                  <IonRow key={i}>
                    {group.map((product, i) => (
                      <ProductCard key={i} {...product} />
                    ))}
                  </IonRow>
                ))}
              </IonGrid>
            )}
          </div>
        </div>
      </IonContent>
    </IonPage>
  );
};

export default Products;
