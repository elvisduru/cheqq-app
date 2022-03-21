import {
  BackButtonEvent,
  IonIcon,
  IonRouterOutlet,
  IonTabBar,
  IonTabButton,
  IonTabs,
  useIonRouter,
  useIonViewDidEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import {
  addCircle,
  addOutline,
  bagHandle,
  bagHandleOutline,
  chatbubble,
  chatbubbleOutline,
  checkbox,
  checkboxOutline,
  home,
  homeOutline,
  notifications,
  notificationsOutline,
  pulse,
} from "ionicons/icons";
import { Redirect, Route, useLocation } from "react-router-dom";
import Home from "../pages/home";
import Messenger from "../pages/messenger";
import Notifications from "../pages/notifications";
import Orders from "../pages/orders";
import Products from "../pages/products";
import "./Tabs.scss";
import Product from "../pages/products/product";

export default function Tabs() {
  const location = useLocation();
  const isSelected = (tab: string) => {
    if (tab === "home" && location.pathname === "/") return true;
    return tab === location.pathname.split("/")[1];
  };

  const ionRouter = useIonRouter();

  const handleBackButton = (ev: Event) => {
    (ev as BackButtonEvent).detail.register(0, () => {
      if (ionRouter.routeInfo.pathname === "/home") {
        alert("You're home");
      }
    });
  };

  useIonViewDidEnter(() => {
    document.addEventListener("ionBackButton", handleBackButton);
  });

  useIonViewWillLeave(() => {
    document.removeEventListener("ionBackButton", handleBackButton);
  });

  return (
    <IonTabs>
      <IonRouterOutlet>
        <Route path="/:tab(home)" component={Home} exact={true} />
        <Route path="/:tab(orders)" component={Orders} exact={true} />
        <Route path="/:tab(products)" component={Products} exact={true} />
        <Route path="/:tab(products)/:id" component={Product} exact={true} />
        <Route
          path="/:tab(notifications)"
          component={Notifications}
          exact={true}
        />
        <Route path="/:tab(messenger)" component={Messenger} exact={true} />
        <Route exact path="/">
          <Redirect to="/home" />
        </Route>
      </IonRouterOutlet>
      <IonTabBar slot="bottom" translucent>
        <IonTabButton tab="home" href="/home">
          <IonIcon icon={isSelected("home") ? home : homeOutline} />
        </IonTabButton>
        <IonTabButton tab="orders" href="/orders">
          <IonIcon icon={isSelected("orders") ? checkbox : checkboxOutline} />
        </IonTabButton>
        <IonTabButton className="centerTab" tab="products">
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
