import { useEffect } from "react";
import { useHistory } from "react-router";
import { App, URLOpenListenerEvent } from "@capacitor/app";

const AppUrlListener: React.FC<any> = () => {
  let history = useHistory();
  useEffect(() => {
    App.addListener("appUrlOpen", (event: URLOpenListenerEvent) => {
      const slug = event.url.split("me").pop();
      if (slug) {
        history.push(slug);
      }
    });
  }, [history]);

  return null;
};

export default AppUrlListener;
