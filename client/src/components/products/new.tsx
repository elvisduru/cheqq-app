import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import React, { useEffect } from "react";
import { FormProvider, useForm } from "react-hook-form";
import useReRender from "../../hooks/useReRender";
import { useStore } from "../../hooks/useStore";
import { Nullable, ProductInput, ProductType } from "../../utils/types";
import withSuspense from "../hoc/withSuspense";

const PhysicalProductForm = withSuspense(
  React.lazy(() => import("./forms.tsx/physical"))
);

type Props = {
  productType: ProductType;
  dismiss: () => void;
};

export default function NewProduct({ productType, dismiss }: Props) {
  const physicalFormData = useStore((state) => state.physicalFormData);
  const setPhysicalFormData = useStore((state) => state.setPhysicalFormData);
  const methods = useForm<Nullable<ProductInput>>({
    mode: "onBlur",
    defaultValues: { type: productType, ...physicalFormData },
  });

  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle className="capitalize">
            {physicalFormData?.id ? "Edit" : "Create"} {productType} Product
          </IonTitle>
          <IonButtons slot="start">
            <IonButton onClick={dismiss} color="dark">
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
          <IonButtons slot="end">
            <IonButton
              color="dark"
              onClick={() => {
                setPhysicalFormData(undefined);
                methods.reset({ type: productType });
                // HACK: This is a hack to force clear some fields that are not being cleared by the above reset
                methods.setValue("title", "");
                methods.setValue("description", "");
                methods.setValue("slug", "");
                methods.setValue("tags", null);
                methods.setValue("images", null);
                methods.setValue("price", null);
                methods.setValue("compareAtPrice", null);
                methods.setValue("condition", null);
              }}
            >
              Reset
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <FormProvider {...methods}>
          <PhysicalProductForm />
        </FormProvider>
      </IonContent>
    </>
  );
}
