import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonTitle,
  IonToolbar,
  useIonModal,
  useIonToast,
} from "@ionic/react";
import {
  bagHandleOutline,
  close,
  downloadOutline,
  reloadOutline,
} from "ionicons/icons";
import { useEffect, useState } from "react";
import shallow from "zustand/shallow";
import useCanDismiss from "../hooks/useCanDismiss";
import { AppState, useStore } from "../hooks/useStore";
import NewProduct from "./products/new";

type Props = {
  dismiss: () => void;
};

const selector = ({
  setPhysicalModalState,
  physicalFormData,
  setPhysicalFormData,
}: AppState) => ({
  setPhysicalModalState,
  physicalFormData,
  setPhysicalFormData,
});

export default function ChooseProduct({ dismiss: dismissModal }: Props) {
  const { physicalFormData, setPhysicalModalState, setPhysicalFormData } =
    useStore(selector, shallow);
  const [productType, setProductType] = useState<string>();
  const canDismissPhyical = useCanDismiss("physical");
  const canDismissDigital = useCanDismiss("digital");
  const canDismissMembership = useCanDismiss("membership");
  const [present, dismiss] = useIonModal(NewProduct, {
    productType,
    dismiss: () => {
      dismiss();
    },
  });

  const [presentToast] = useIonToast();

  useEffect(() => {
    if (physicalFormData?.id) setPhysicalFormData(undefined);
  }, [physicalFormData?.id]);

  const productTypes = [
    {
      title: "Physical Product",
      description: "Sell physical items like books, clothing, etc.",
      handler: () => {
        setProductType("physical");
        present({
          // presentingElement: routerOutletEl,
          canDismiss: canDismissPhyical,
          id: "physical-product-form",
          onWillPresent() {
            (
              document.querySelector("#choose-product") as HTMLIonModalElement
            ).dismiss();
            if (physicalFormData) {
              presentToast(
                "Continue where you left off. We saved your progress 🎉.",
                1500
              );
            }
          },
          onDidDismiss() {
            setPhysicalModalState(undefined);
          },
        });
      },
      icon: bagHandleOutline,
    },
    {
      title: "Digital Product",
      description: "Sell a course, ebook, album, artwork, etc.",
      handler: () => {
        setProductType("digital");
        present({
          // presentingElement: routerOutletEl,
          canDismiss: canDismissDigital,
          onWillPresent() {
            (
              document.querySelector("#choose-product") as HTMLIonModalElement
            ).dismiss();
          },
        });
      },
      icon: downloadOutline,
    },
    {
      title: "Membership",
      description: "Charge on a recurring basis.",
      handler: () => {
        setProductType("membership");
        present({
          // presentingElement: routerOutletEl,
          canDismiss: canDismissMembership,
          onWillPresent() {
            (
              document.querySelector("#choose-product") as HTMLIonModalElement
            ).dismiss();
          },
        });
      },
      icon: reloadOutline,
    },
  ];

  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Choose Product Type</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismissModal();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonList className="bg-transparent" id="choose-product">
          {productTypes.map(({ icon, title, description, handler }) => (
            <IonItem
              key={title}
              lines="none"
              button
              onClick={handler}
              className="mt-4 bg-transparent"
            >
              <div
                slot="start"
                className="flex items-center justify-center p-4 bg-card text-2xl"
              >
                <IonIcon icon={icon} />
              </div>
              <IonLabel className="ion-text-wrap">
                {title}
                <p>{description}</p>
              </IonLabel>
            </IonItem>
          ))}
        </IonList>
      </IonContent>
    </>
  );
}
