import { IonPage, IonRouterOutlet } from "@ionic/react";
import { Route } from "react-router-dom";
import { User } from "../../utils/types";
import ProductDetails from "./details";
import Products from "./product";

type Props = {
  user: User;
};

const ProductsRouterOutlet: React.FC<Props> = ({ user }) => {
  return (
    <IonPage>
      <IonRouterOutlet>
        <Route path="/products" exact={true}>
          <Products user={user} />
        </Route>
        <Route path="/products/:id" exact={true}>
          <ProductDetails user={user} />
        </Route>
      </IonRouterOutlet>
    </IonPage>
  );
};

export default ProductsRouterOutlet;
