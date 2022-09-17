import {
  IonButton,
  IonCol,
  IonGrid,
  IonIcon,
  IonRow,
  IonSegment,
  IonSegmentButton,
  useIonModal,
} from "@ionic/react";
import { chevronBack } from "ionicons/icons";
import React, { useEffect, useRef, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import "swiper/css";
import { Swiper, SwiperSlide } from "swiper/react";
import { Swiper as SwiperType } from "swiper/types";
import shallow from "zustand/shallow";
import { useDeleteImages } from "../../../../hooks/mutations/images/deleteImages";
import { AppState, ModalState, useStore } from "../../../../hooks/useStore";
import useUpdateEffect from "../../../../hooks/useUpdateEffect";
import { ProductInput } from "../../../../utils/types";
import withSuspense from "../../../hoc/withSuspense";
import ProductDetails from "../../details";
import General from "./general";
const Checkout = withSuspense(React.lazy(() => import("./checkout")));
const Variants = withSuspense(React.lazy(() => import("./variants")));

const selector = ({
  setPhysicalFormData,
  physicalFormData,
  physicalModalState,
  user,
  selectedStore,
}: AppState) => ({
  setPhysicalFormData,
  physicalFormData,
  physicalModalState,
  user,
  selectedStore,
});

// TODO: When submitting form, update sortOrder of photos and videos

export default function PhysicalProductForm() {
  const {
    setPhysicalFormData,
    physicalFormData,
    physicalModalState,
    user,
    selectedStore,
  } = useStore(selector, shallow);

  const store = user?.stores?.find((store) => store.id === selectedStore);

  const deleteImages = useDeleteImages();

  const methods = useForm<ProductInput>({
    mode: "onBlur",
    defaultValues: { ...physicalFormData, type: "physical" },
  });

  const onSubmit = (data: any) => console.log(data);
  const onError = (error: any) => console.log(error);

  const ref = useRef(null);

  const [tabIndex, setTabIndex] = useState<number>(0);
  const [swiper, setSwiper] = useState<SwiperType | null>(null);

  const [formValid, setFormValid] = useState(false);

  // Product Preview Modal
  const [present, dismiss] = useIonModal(ProductDetails, {
    product: { ...methods.getValues(), store },
    goBack: () => {
      dismiss();
    },
    isPreview: true,
    handleSubmit: methods.handleSubmit(onSubmit, onError),
  });

  useUpdateEffect(() => {
    methods.trigger().then((result) => {
      setFormValid(result);
    });
  }, [tabIndex]);

  useEffect(() => {
    const formValues = methods.getValues();

    // Save form data to store
    if (physicalModalState === ModalState.SAVE) {
      setPhysicalFormData({ ...formValues });
    }

    if (physicalModalState === ModalState.DELETE) {
      // Delete all uploaded images
      if (formValues?.images?.length) {
        deleteImages.mutate(formValues.images);
      }
      setPhysicalFormData(undefined);
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [physicalModalState]);

  // TODO: Empty Variant slide should be filled with an illustration/animation explaining the concept of variants

  return (
    <FormProvider {...methods}>
      <div
        slot="fixed"
        className="w-full backdrop-filter backdrop-blur-lg bg-opacity-30 ion-padding-horizontal py-4"
      >
        <IonSegment
          onIonChange={(e) => {
            const index = parseFloat(e.detail.value!);
            setTabIndex(index);
            swiper?.slideTo(index);
          }}
          value={tabIndex.toString()}
        >
          <IonSegmentButton value="0">General</IonSegmentButton>
          <IonSegmentButton value="1">Variants</IonSegmentButton>
          <IonSegmentButton value="2">Checkout</IonSegmentButton>
        </IonSegment>
      </div>
      <form ref={ref} className="modal-form h-full">
        <Swiper
          initialSlide={tabIndex}
          onSwiper={(swiper) => {
            setSwiper(swiper);
          }}
          onSlideChange={(swiper) => {
            setTabIndex(swiper.realIndex);
          }}
          className="h-full"
        >
          <SwiperSlide>
            <General />
          </SwiperSlide>
          <SwiperSlide>
            <Variants />
          </SwiperSlide>
          <SwiperSlide>
            <Checkout />
          </SwiperSlide>
        </Swiper>
      </form>
      <div
        slot="fixed"
        className="bottom-0 w-full ion-padding-horizontal py-1 bg-neutral-850"
      >
        <IonGrid className="p-0">
          <IonRow>
            <IonCol size="3" className="px-0">
              <IonButton
                className="drop-shadow"
                onClick={() => {
                  if (tabIndex === 0) {
                    const modal = document.querySelector(
                      "#new-physical-product"
                    ) as HTMLIonModalElement;
                    modal.dismiss();
                  } else {
                    swiper?.slidePrev();
                  }
                }}
                expand="block"
                color="light"
                size="default"
              >
                <IonIcon slot="icon-only" icon={chevronBack} />
                {tabIndex === 0 ? "Cancel" : "Back"}
              </IonButton>
            </IonCol>
            <IonCol className="px-1">
              <IonButton
                className="drop-shadow"
                onClick={() => {
                  if (tabIndex === 2) {
                    present();
                  } else {
                    swiper?.slideNext();
                  }
                }}
                disabled={tabIndex === 2 && !formValid}
                color={swiper?.activeIndex! < 2 ? "medium" : "primary"}
                expand="block"
                size="default"
              >
                {swiper?.activeIndex === 2 ? "Preview" : "Continue"}
              </IonButton>
            </IonCol>
          </IonRow>
        </IonGrid>
      </div>
    </FormProvider>
  );
}
