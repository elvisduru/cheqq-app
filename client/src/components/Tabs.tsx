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
import { Route, useLocation } from "react-router-dom";
import { useStore } from "../hooks/useStore";
import New from "../pages/auth/new";
import Home from "../pages/home";
import Messenger from "../pages/messenger";
import Notifications from "../pages/notifications";
import Orders from "../pages/orders";
import ProductsRouterOutlet from "../pages/products";
import StoreRouterOutlet from "../pages/store";
import Settings from "../pages/settings";
import { User } from "../utils/types";
import ChooseProduct from "./ChooseProduct";
import withAuth from "./hoc/withAuth";
import "./Tabs.scss";

type Props = {
  user: User;
};

function Tabs({ user }: Props) {
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
          <Home user={user} />
        </Route>
        <Route exact path="/orders">
          <Orders user={user} />
        </Route>
        <Route path="/products">
          <ProductsRouterOutlet user={user} />
        </Route>
        <Route exact path="/notifications">
          <Notifications user={user} />
        </Route>

        <Route exact path="/messenger">
          <Messenger user={user} />
        </Route>
        <Route exact path="/settings">
          <Settings />
        </Route>
      </IonRouterOutlet>
      <IonTabBar
        className={hideTabBar ? "hidden" : ""}
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
