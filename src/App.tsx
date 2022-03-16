import {
  IonApp,
  IonRouterOutlet,
  IonSplitPane,
  setupIonicReact,
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
import { Route } from "react-router-dom";
import "./App.css";
import SideMenu from "./components/SideMenu";
import Tabs from "./components/Tabs";
import "./styles/global.scss";
/* Theme variables */
import "./theme/variables.css";

setupIonicReact({
  mode: "ios",
});

const user = {
  firstName: "John",
  lastName: "Doe",
  avatar: "https://randomuser.me/api/portraits/men/86.jpg",
};

const App: React.FC = () => {
  return (
    <IonApp>
      <IonReactRouter>
        <IonSplitPane contentId="main">
          <SideMenu user={user} contentId="main" />
          <IonRouterOutlet id="main">
            <Route path="/" component={Tabs} />
          </IonRouterOutlet>
        </IonSplitPane>
      </IonReactRouter>
    </IonApp>
  );
};

export default App;
