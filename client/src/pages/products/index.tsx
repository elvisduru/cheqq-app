import { IonPage, IonRouterOutlet } from "@ionic/react";
import React from "react";
import { Route } from "react-router-dom";
import withSuspense from "../../components/hoc/withSuspense";
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";
const ProductDetails = withSuspense<{ user: User }>(
  React.lazy(() => import("./details"))
);
const Products = withSuspense<{ user: User }>(
  React.lazy(() => import("./product"))
);

const ProductsRouterOutlet = () => {
  const user = useStore((store) => store.user);
  return (
    <IonPage>
      <IonRouterOutlet>
        <Route path="/products" exact={true}>
          <Products user={user!} />
        </Route>
        <Route path="/products/:id" exact={true}>
          <ProductDetails user={user!} />
        </Route>
      </IonRouterOutlet>
    </IonPage>
  );
};

export default ProductsRouterOutlet;
