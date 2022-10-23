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
} from "@ionic/react";
import {
  bagAddOutline,
  bagHandleOutline,
  cartOutline,
  close,
  rocketOutline,
} from "ionicons/icons";
import React, { useState } from "react";
import useCanDismiss from "../../hooks/useCanDismiss";
import withSuspense from "../hoc/withSuspense";
const NewDiscount = withSuspense(React.lazy(() => import("./newDiscount")));

type Props = {
  dismiss: () => void;
};

export default function DiscountOptions({ dismiss }: Props) {
  const [discountType, setDiscountType] = useState<string>();
  const [present, dismissDiscount] = useIonModal(NewDiscount, {
    dismiss: () => {
      dismissDiscount();
    },
    title: discountType,
  });
  const parentEl = document.querySelector("#discount-settings") as HTMLElement;
  const canDismiss = useCanDismiss();
  const discountTypes = [
    {
      title: "Product Discount",
      description: "Amount off one or more products",
      handler: () => {
        setDiscountType("Product");
        present({
          presentingElement: parentEl,
          canDismiss,
          id: "physical-product-form",
        });
      },
      icon: bagHandleOutline,
    },
    {
      title: "Order Discount",
      description: "Amount off orders",
      handler: () => {
        setDiscountType("Order");
        present({
          presentingElement: parentEl,
          canDismiss,
        });
      },
      icon: cartOutline,
    },
    {
      title: "Buy X Get Y",
      description: "Customers get offers when they buy X products",
      handler: () => {
        setDiscountType("Buy X Get Y");
        present({
          presentingElement: parentEl,
          canDismiss,
        });
      },
      icon: bagAddOutline,
    },
    {
      title: "Free Shipping",
      description: "Free shipping discount on orders",
      handler: () => {
        setDiscountType("Free Shipping");
        present({
          presentingElement: parentEl,
          canDismiss,
        });
      },
      icon: rocketOutline,
    },
  ];
  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Select Discount Type</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismiss();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonList className="bg-transparent" id="choose-product">
          {discountTypes.map(({ icon, title, description, handler }) => (
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
