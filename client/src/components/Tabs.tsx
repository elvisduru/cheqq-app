import {
  IonIcon,
  IonRouterOutlet,
  IonTabBar,
  IonTabButton,
  IonTabs,
  useIonModal,
} from "@ionic/react";
import {
  addCircle,
  bagHandle,
  bagHandleOutline,
  chatbubble,
  chatbubbleOutline,
  checkbox,
  checkboxOutline,
  home,
  homeOutline,
} from "ionicons/icons";
import { Redirect, Route, useLocation } from "react-router-dom";
import Home from "../pages/home";
import Messenger from "../pages/messenger";
import Notifications from "../pages/notifications";
import Orders from "../pages/orders";
import Products from "../pages/products";
import Product from "../pages/products/product";
import Settings from "../pages/settings";
import { User } from "../utils/types";
import ChooseProduct from "./ChooseProduct";
import "./Tabs.scss";

type Props = {
  user: User;
};

export default function Tabs({ user }: Props) {
  const location = useLocation();
  const isSelected = (tab: string) => {
    if (tab === "home" && location.pathname === "/") return true;
    return tab === location.pathname.split("/")[1];
  };

  // present add modal
  const [present, dismiss] = useIonModal(ChooseProduct, {
    dismiss: () => {
      dismiss();
    },
  });

  return (
    <IonTabs
      onIonTabsWillChange={(e) => {
        if (e.detail.tab === "create") {
          present({
            breakpoints: [0, 0.5],
            initialBreakpoint: 0.5,
          });
        }
      }}
    >
      <IonRouterOutlet>
        <Route path="/home" render={() => <Home user={user} />} />
        <Route path="/orders" render={() => <Orders user={user} />} />
        <Route path="/products" render={() => <Products user={user} />} exact />
        <Route path="/products/:id" render={() => <Product user={user} />} />
        <Route
          path="/notifications"
          render={() => <Notifications user={user} />}
        />
        <Route path="/messenger" render={() => <Messenger user={user} />} />
        <Route path="/settings" component={Settings} />

        <Route render={() => <Redirect to="/home" />} />
      </IonRouterOutlet>
      <IonTabBar slot="bottom" translucent>
        <IonTabButton tab="home" href="/home">
          <IonIcon icon={isSelected("home") ? home : homeOutline} />
        </IonTabButton>
        <IonTabButton tab="orders" href="/orders">
          <IonIcon icon={isSelected("orders") ? checkbox : checkboxOutline} />
        </IonTabButton>
        <IonTabButton className="centerTab" tab="create">
          <IonIcon color="primary" icon={addCircle} />
        </IonTabButton>
        <IonTabButton tab="products" href="/products">
          <IonIcon
            icon={isSelected("products") ? bagHandle : bagHandleOutline}
          />
        </IonTabButton>
        <IonTabButton tab="messenger" href="/messenger">
          <IonIcon
            icon={isSelected("messenger") ? chatbubble : chatbubbleOutline}
          />
        </IonTabButton>
      </IonTabBar>
    </IonTabs>
  );
}
