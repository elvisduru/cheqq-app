import { IonApp } from "@ionic/react";
import { IonReactRouter } from "@ionic/react-router";
import ReactDOM from "react-dom/client";
import { QueryClient, QueryClientProvider } from "react-query";
import App from "./App";
import reportWebVitals from "./reportWebVitals";

const queryClient = new QueryClient();

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  // <React.StrictMode>
  <QueryClientProvider client={queryClient}>
    <IonApp>
      <IonReactRouter>
        <App />
      </IonReactRouter>
    </IonApp>
    {/* <ReactQueryDevtools initialIsOpen={false} /> */}
  </QueryClientProvider>
  // </React.StrictMode>
);

// Call the element loader after the app has been rendered the first time
// defineCustomElements(window);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
