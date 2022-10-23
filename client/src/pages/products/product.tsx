import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonCard,
  IonCardContent,
  IonCol,
  IonContent,
  IonGrid,
  IonHeader,
  IonIcon,
  IonImg,
  IonMenuButton,
  IonPage,
  IonRow,
  IonSegment,
  IonSegmentButton,
  IonThumbnail,
  IonTitle,
  IonToolbar,
  useIonModal,
} from "@ionic/react";
import {
  filter,
  imagesOutline,
  notifications,
  trash,
  trashBinOutline,
} from "ionicons/icons";
import LottieWrapper from "../../components/lottieWrapper";
import OrdersSkeleton from "../../components/skeletons/orders";
import useProducts from "../../hooks/queries/products/useProducts";
import { useStore } from "../../hooks/useStore";
import notFoundAnimation from "../../assets/json/no-data-found.json";
import { User } from "../../utils/types";
import ChooseProduct from "../../components/ChooseProduct";
import React from "react";
import ProductCard from "../../components/products/card";

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
          <div>
            {isLoading ? (
              <OrdersSkeleton length={9} />
            ) : !products?.pages[0].length ? (
              <div className="mt-8">
                <LottieWrapper
                  title="No Products"
                  description="Create a new product to start receiving orders from customers"
                  buttonText="Create Product"
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
