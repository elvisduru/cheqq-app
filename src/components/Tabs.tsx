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
import NotFoundPage from "../pages/404";
import Home from "../pages/home";
import Messenger from "../pages/messenger";
import Notifications from "../pages/notifications";
import Orders from "../pages/orders";
import Products from "../pages/products";
import Product from "../pages/products/product";
import "./Tabs.scss";

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
        <Route path="/:tab(home)" render={() => <Home />} />
        <Route path="/:tab(orders)" render={() => <Orders />} />
        <Route path="/:tab(products)" render={() => <Products />} exact />
        <Route path="/:tab(products)/:id" render={() => <Product />} />
        <Route path="/:tab(notifications)" render={() => <Notifications />} />
        <Route path="/:tab(messenger)" render={() => <Messenger />} />
        <Route path="/" render={() => <Redirect to="/home" />} exact />
        {/* <Route render={() => <NotFoundPage />} /> */}
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
