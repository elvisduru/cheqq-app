import { useIonActionSheet } from "@ionic/react";

export default function useCanDismiss() {
  const [present, dismiss] = useIonActionSheet();

  const canDismiss = () => {
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
  };

  return canDismiss;
}
