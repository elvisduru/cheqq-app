import { App as NativeApp } from "@capacitor/app";
import {
  BackButtonEvent,
  IonApp,
  IonContent,
  IonRouterOutlet,
  IonSplitPane,
  setupIonicReact,
  useIonRouter,
} from "@ionic/react";
import { IonReactRouter } from "@ionic/react-router";
import { SplashScreen } from "@capacitor/splash-screen";
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
/* Theme variables */
import "./theme/variables.css";

import "./App.css";
import "./styles/global.scss";

import withSuspense from "./components/hoc/withSuspense";
import StoreRouterOutlet from "./pages/store";
import useReRender from "./hooks/useReRender";
import SideMenu from "./components/SideMenu";

const AppUrlListener = withSuspense(
  React.lazy(() => import("./components/AppUrlListener"))
);
// const SideMenu = withSuspense<any>(
//   React.lazy(() => import("./components/SideMenu"))
// );
const New = withSuspense(React.lazy(() => import("./pages/auth/new")));

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
    <>
      <AppUrlListener />
      <IonSplitPane contentId="main">
        <SideMenu />
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
    </>
  );
};

export default App;
