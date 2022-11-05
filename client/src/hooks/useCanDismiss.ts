import { useIonActionSheet } from "@ionic/react";
import { useCallback } from "react";
import shallow from "zustand/shallow";
import { AppState, ModalState, useStore } from "./useStore";
const selector = ({ setPhysicalModalState }: AppState) => ({
  setPhysicalModalState,
});

export default function useCanDismiss(formType?: string, noSave?: boolean) {
  const [present] = useIonActionSheet();
  const { setPhysicalModalState } = useStore(selector, shallow);

  const canDismiss = useCallback(() => {
    return new Promise<boolean>((resolve, reject) => {
      present({
        translucent: true,
        header: "Are you sure you want to discard your changes?",
        buttons: noSave
          ? [
              {
                text: "Discard Changes",
                role: "destructive",
              },
              {
                text: "Keep Editing",
                role: "cancel",
              },
            ]
          : [
              {
                text: "Discard Changes",
                role: "destructive",
              },
              {
                text: "Keep Editing",
                role: "cancel",
              },
              {
                text: "Save Changes and Quit",
                handler: () => {
                  setPhysicalModalState(ModalState.SAVE);
                  resolve(true);
                },
              },
            ],
        onWillDismiss: (ev: CustomEvent) => {
          const role = ev.detail.role;

          if (role === "destructive") {
            // Delete form data
            switch (formType) {
              case "physical":
                setPhysicalModalState(ModalState.DELETE);
                break;

              default:
                break;
            }
            resolve(true);
          } else {
            reject();
          }
        },
      });
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return canDismiss;
}
