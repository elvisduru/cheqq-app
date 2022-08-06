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
import React from "react";
import { Route, useLocation } from "react-router-dom";
import { useStore } from "../hooks/useStore";
import ProductsRouterOutlet from "../pages/products";
import ChooseProduct from "./ChooseProduct";

import withAuth from "./hoc/withAuth";
import withSuspense from "./hoc/withSuspense";
import "./Tabs.scss";

// const ChooseProduct = withSuspense(React.lazy(() => import("./ChooseProduct")));
const Home = withSuspense(React.lazy(() => import("../pages/home")));
const Messenger = withSuspense(React.lazy(() => import("../pages/messenger")));
const Notifications = withSuspense(
  React.lazy(() => import("../pages/notifications"))
);
const Orders = withSuspense(React.lazy(() => import("../pages/orders")));
const Settings = withSuspense(React.lazy(() => import("../pages/settings")));

function Tabs() {
  const { pathname } = useLocation();
  const hideTabBar = useStore((store) => store.hideTabBar);
  const isSelected = (tab: string) => {
    if (tab === "home" && pathname === "/") return true;
    return tab === pathname.split("/")[1];
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
        <Route exact path="/home">
          <Home />
        </Route>
        <Route exact path="/orders">
          <Orders />
        </Route>
        <Route path="/products">
          <ProductsRouterOutlet />
        </Route>
        <Route exact path="/notifications">
          <Notifications />
        </Route>

        <Route exact path="/messenger">
          <Messenger />
        </Route>
        <Route exact path="/settings">
          <Settings />
        </Route>
      </IonRouterOutlet>
      <IonTabBar
        className={`${hideTabBar ? "hidden" : ""} lg:px-36`}
        slot="bottom"
        translucent
      >
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

export default withAuth(Tabs);
