import {
  IonApp,
  IonRouterOutlet,
  IonSplitPane,
  setupIonicReact,
} from "@ionic/react";
import { IonReactRouter } from "@ionic/react-router";
import { Storage } from "@capacitor/storage";
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
import { Route, Redirect } from "react-router-dom";
import "./App.css";
import profilePic from "./assets/images/profile-sqr.jpg";
import ProtectedRoute from "./components/ProtectedRoute";
import SideMenu from "./components/SideMenu";
import Tabs from "./components/Tabs";
import Confirm from "./pages/auth/confirm";
import Login from "./pages/auth/login";
import New from "./pages/auth/new";
import SignUp from "./pages/auth/signup";
import "./styles/global.scss";
/* Theme variables */
import "./theme/variables.css";

setupIonicReact({
  mode: "ios",
});

export const User = {
  firstName: "Elvis",
  lastName: "Duru",
  avatar: profilePic,
};

const App: React.FC = () => {
  const user = null;
  return (
    <IonApp>
      <IonReactRouter>
        <IonSplitPane disabled={!user} contentId="main">
          <SideMenu user={User} contentId="main" />
          <IonRouterOutlet id="main">
            <Route
              path="/"
              exact={!user}
              render={() => (
                <ProtectedRoute redirectPath="/signup" isAllowed={!!user}>
                  <Tabs />
                </ProtectedRoute>
              )}
            />
            <Route path="/signup" component={SignUp} />
            <Route path="/login" component={Login} />
            <Route path="/confirm" component={Confirm} />
            <Route path="/new" component={New} />
            <Route render={() => <Redirect to="/signup" />} />
          </IonRouterOutlet>
        </IonSplitPane>
      </IonReactRouter>
    </IonApp>
  );
};

export default App;
