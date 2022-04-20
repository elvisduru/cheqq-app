import { App as NativeApp } from "@capacitor/app";
import {
  BackButtonEvent,
  IonRouterOutlet,
  IonSplitPane,
  setupIonicReact,
  useIonRouter,
} from "@ionic/react";
/* Core CSS required for Ionic components to work properly */
import "@ionic/react/css/core.css";
import "@ionic/react/css/display.css";
import "@ionic/react/css/flex-utils.css";
import "@ionic/react/css/float-elements.css";
/* Basic CSS for apps built with Ionic */
import "@ionic/react/css/normalize.css";
/* Optional CSS utils that can be commented out */
import "@ionic/react/css/padding.css";
import "@ionic/react/css/structure.css";
import "@ionic/react/css/text-alignment.css";
import "@ionic/react/css/text-transformation.css";
import "@ionic/react/css/typography.css";
import { useEffect } from "react";
import { Redirect, Route } from "react-router-dom";
import "./App.css";
import AppUrlListener from "./components/AppUrlListener";
import ProtectedRoute from "./components/ProtectedRoute";
import SideMenu from "./components/SideMenu";
import Tabs from "./components/Tabs";
import { useHydration, useStore } from "./hooks/useStore";
import Confirm from "./pages/auth/confirm";
import Login from "./pages/auth/login";
import New from "./pages/auth/new";
import SignUp from "./pages/auth/signup";
import NewStore from "./pages/store/new";
import "./styles/global.scss";
/* Theme variables */
import "./theme/variables.css";

setupIonicReact({
  mode: "ios",
});

const App: React.FC = () => {
  const { user } = useStore();
  const isHydrated = useHydration();
  const ionRouter = useIonRouter();

  useEffect(() => {
    document.addEventListener("ionBackButton", (ev) => {
      (ev as BackButtonEvent).detail.register(0, () => {
        console.log();
        if (!ionRouter.canGoBack() || window.location.pathname === "/home") {
          NativeApp.exitApp();
        } else {
          window.history.back();
        }
      });
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (!isHydrated) {
    return <p>Loading...</p>;
  }

  return (
    <>
      <AppUrlListener />
      <IonSplitPane contentId="main">
        <SideMenu user={user} contentId="main" />
        <IonRouterOutlet id="main">
          <Route
            path="/:tab"
            render={() => (
              <ProtectedRoute redirectPath="/signup" user={user}>
                <Tabs user={user} />
              </ProtectedRoute>
            )}
          />
          <Route path="/signup" component={SignUp} />
          <Route path="/login" component={Login} />
          <Route path="/confirm" component={Confirm} />
          <Route path="/new" component={New} />
          <Route
            path="/store/new"
            render={() => (
              <ProtectedRoute
                redirectPath="/signup"
                user={user}
                disableExtraRedirect
              >
                <NewStore />
              </ProtectedRoute>
            )}
          />
          <Route render={() => <Redirect to="/home" />} />
        </IonRouterOutlet>
      </IonSplitPane>
    </>
  );
};

export default App;
