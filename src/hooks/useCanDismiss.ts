import { useIonActionSheet } from "@ionic/react";
import { useCallback } from "react";

export default function useCanDismiss() {
  const [present] = useIonActionSheet();

  const canDismiss = useCallback(() => {
    return new Promise(async (resolve: (value: boolean) => void) => {
      await present({
        translucent: true,
        header: "Are you sure you want to discard your changes?",
        buttons: [
          {
            text: "Discard Changes",
            role: "destructive",
          },
          {
            text: "Keep Editing",
            role: "cancel",
          },
        ],
        onDidDismiss: (ev: CustomEvent) => {
          const role = ev.detail.role;

          if (role === "destructive") {
            resolve(true);
          }

          resolve(false);
        },
      });
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return canDismiss;
}
