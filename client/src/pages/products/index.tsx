import { IonPage, IonRouterOutlet } from "@ionic/react";
import { Route } from "react-router-dom";
import { useStore } from "../../hooks/useStore";
import ProductDetails from "./details";
import Products from "./product";

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
