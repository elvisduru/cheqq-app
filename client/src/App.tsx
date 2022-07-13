import { App as NativeApp } from "@capacitor/app";
import {
  BackButtonEvent,
  IonApp,
  IonRouterOutlet,
  IonSplitPane,
  setupIonicReact,
  useIonRouter,
} from "@ionic/react";
import { IonReactRouter } from "@ionic/react-router";
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
import React, { useEffect } from "react";
import { Redirect, Route } from "react-router-dom";
import "./App.css";
import AppUrlListener from "./components/AppUrlListener";
import withSuspense from "./components/hoc/withSuspense";
import SideMenu from "./components/SideMenu";
import New from "./pages/auth/new";
import StoreRouterOutlet from "./pages/store";
// import Login from "./pages/auth/login";
// import New from "./pages/auth/new";
// import SignUp from "./pages/auth/signup";
/* Theme variables */
import "./styles/global.scss";
import "./theme/variables.css";

const Tabs = withSuspense(React.lazy(() => import("./components/Tabs")));
const Confirm = withSuspense(React.lazy(() => import("./pages/auth/confirm")));
const Login = withSuspense(React.lazy(() => import("./pages/auth/login")));
const SignUp = withSuspense(React.lazy(() => import("./pages/auth/signup")));

setupIonicReact({
  mode: "ios",
});

const App: React.FC = () => {
  const ionRouter = useIonRouter();
  useEffect(() => {
    document.addEventListener("ionBackButton", (ev) => {
      (ev as BackButtonEvent).detail.register(0, () => {
        if (
          !ionRouter.canGoBack() ||
          ["/home", "/signup"].includes(window.location.pathname)
        ) {
          NativeApp.exitApp();
        } else {
          window.history.back();
        }
      });
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <IonApp>
      <IonReactRouter>
        <AppUrlListener />
        <IonSplitPane contentId="main">
          <SideMenu contentId="main" />
          <IonRouterOutlet id="main">
            <Route path="/(home|orders|products|notifications|messenger|settings)">
              <Tabs />
            </Route>
            <Route exact path="/signup">
              <SignUp />
            </Route>
            <Route exact path="/login">
              <Login />
            </Route>
            <Route exact path="/magic-link">
              <Confirm />
            </Route>
            <Route exact path="/new">
              <New />
            </Route>
            <Route path="/store">
              <StoreRouterOutlet />
            </Route>
            <Route path="/" exact>
              <Redirect to="/home" />
            </Route>
          </IonRouterOutlet>
        </IonSplitPane>
      </IonReactRouter>
    </IonApp>
  );
};

export default App;
