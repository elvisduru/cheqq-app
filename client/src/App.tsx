import { App as NativeApp } from "@capacitor/app";
import {
  BackButtonEvent,
  IonApp,
  IonLoading,
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
import React, { Suspense, useEffect } from "react";
import { Redirect, Route } from "react-router-dom";
import "./App.css";
import AppUrlListener from "./components/AppUrlListener";
import ProtectedRoute from "./components/ProtectedRoute";
import SideMenu from "./components/SideMenu";
import useUser from "./hooks/queries/users/useUser";
import "./styles/global.scss";
/* Theme variables */
import "./theme/variables.css";

const Tabs = React.lazy(() => import("./components/Tabs"));
const Confirm = React.lazy(() => import("./pages/auth/confirm"));
const Login = React.lazy(() => import("./pages/auth/login"));
const New = React.lazy(() => import("./pages/auth/new"));
const SignUp = React.lazy(() => import("./pages/auth/signup"));
const NewStore = React.lazy(() => import("./pages/store/new"));

setupIonicReact({
  mode: "ios",
});

const App: React.FC = () => {
  const { data: user, isLoading } = useUser();
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
      <Suspense fallback={<IonLoading isOpen={true} translucent />}>
        <IonReactRouter>
          <AppUrlListener />
          {isLoading ? (
            <IonLoading isOpen={true} translucent />
          ) : (
            <IonSplitPane contentId="main">
              {user && <SideMenu user={user!} contentId="main" />}
              <IonRouterOutlet id="main">
                <Route
                  path="/"
                  exact={!user}
                  render={() => (
                    <ProtectedRoute redirectPath="/signup" user={user!}>
                      <Tabs user={user!} />
                    </ProtectedRoute>
                  )}
                />
                <Route path="/signup" render={() => <SignUp user={user!} />} />
                <Route path="/login" render={() => <Login user={user!} />} />
                <Route
                  path="/magic-link"
                  render={() => <Confirm user={user!} />}
                />
                <Route
                  path="/new"
                  render={() => <New user={user} isLoading={isLoading} />}
                />
                <Route
                  path="/store/new"
                  render={() => (
                    <ProtectedRoute
                      redirectPath="/signup"
                      user={user!}
                      disableExtraRedirect
                    >
                      <NewStore user={user!} />
                    </ProtectedRoute>
                  )}
                />
                {user ? (
                  <Route render={() => <Redirect to="/home" />} />
                ) : (
                  <Redirect to="/signup" />
                )}
              </IonRouterOutlet>
            </IonSplitPane>
          )}
        </IonReactRouter>
      </Suspense>
    </IonApp>
  );
};

export default App;
