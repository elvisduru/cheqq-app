import { defineCustomElements } from "@ionic/pwa-elements/loader";
import { IonApp } from "@ionic/react";
import { IonReactRouter } from "@ionic/react-router";
import React from "react";
import ReactDOM from "react-dom";
import { QueryClient, QueryClientProvider } from "react-query";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import * as serviceWorkerRegistration from "./serviceWorkerRegistration";

const queryClient = new QueryClient();

// queryClient.setDefaultOptions({
//   queries: {
//     onError: (err: any) => {
//       if (err?.name === "AxiosError" && err?.response.status === 401) {
//         window.location.href = "/signup";
//       }
//     },
//   },
// });

ReactDOM.render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <IonApp>
        <IonReactRouter>
          <App />
        </IonReactRouter>
      </IonApp>
      {/* <ReactQueryDevtools initialIsOpen={false} /> */}
    </QueryClientProvider>
  </React.StrictMode>,
  document.getElementById("root")
);

// Call the element loader after the app has been rendered the first time
defineCustomElements(window);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://cra.link/PWA
serviceWorkerRegistration.unregister();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
