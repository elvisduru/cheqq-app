import {
  IonButton,
  IonCol,
  IonGrid,
  IonIcon,
  IonRow,
  IonSegment,
  IonSegmentButton,
} from "@ionic/react";
import { chevronBack } from "ionicons/icons";
import { useEffect, useRef, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import "swiper/css";
import { Swiper, SwiperSlide } from "swiper/react";
import { Swiper as SwiperType } from "swiper/types";
import shallow from "zustand/shallow";
import { useDeleteImages } from "../../../../hooks/mutations/images/deleteImages";
import useUser from "../../../../hooks/queries/users/useUser";
import { AppState, ModalState, useStore } from "../../../../hooks/useStore";
import Checkout from "./checkout";
import General from "./general";
import Variants from "./variants";

const selector = ({
  setPhysicalFormData,
  physicalFormData,
  physicalModalState,
}: AppState) => ({
  setPhysicalFormData,
  physicalFormData,
  physicalModalState,
});

// TODO: When submitting form, update sortOrder of photos and videos

export default function PhysicalProductForm() {
  const { data: user } = useUser();
  const { setPhysicalFormData, physicalFormData, physicalModalState } =
    useStore(selector, shallow);

  const deleteImages = useDeleteImages();

  const methods = useForm({
    mode: "onBlur",
    defaultValues: { ...physicalFormData, type: "physical" },
  });

  const onSubmit = (data: any) => console.log(data);
  const onError = (error: any) => console.log(error);

  const ref = useRef(null);

  const [tabIndex, setTabIndex] = useState<number>(0);
  const [swiper, setSwiper] = useState<SwiperType | null>(null);

  // Save photos to cloud
  useEffect(() => {
    const formValues = methods.getValues();
    if (physicalModalState === ModalState.SAVE) {
      setPhysicalFormData({ ...formValues });
    }

    if (physicalModalState === ModalState.DELETE) {
      // Delete all uploaded images
      if (formValues?.photos?.length) {
        deleteImages.mutate(formValues.photos);
      }
      setPhysicalFormData(undefined);
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [physicalModalState]);

  // TODO: Empty Variant slide should be filled with an illustration/animation explaining the concept of variants

  return (
    <FormProvider {...methods}>
      <form
        ref={ref}
        onSubmit={methods.handleSubmit(onSubmit, onError)}
        className="modal-form h-full"
      >
        <Swiper
          initialSlide={tabIndex}
          onSwiper={(swiper) => setSwiper(swiper)}
          onSlideChange={(swiper) => {
            setTabIndex(swiper.realIndex);
          }}
          className="h-[calc(100%-8.45rem)] [overflow:unset]"
        >
          <SwiperSlide>
            <General user={user!} />
          </SwiperSlide>
          <SwiperSlide>
            <Variants />
          </SwiperSlide>
          <SwiperSlide>
            <Checkout />
          </SwiperSlide>
          <div slot="container-start" className="ion-padding-horizontal py-4">
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
              <IonSegmentButton value="3">Preview</IonSegmentButton>
            </IonSegment>
          </div>
          <div
            slot="container-end"
            className="ion-padding-horizontal py-1 bg-neutral-850"
          >
            <IonGrid className="p-0">
              <IonRow>
                <IonCol size="3" className="px-0">
                  <IonButton
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
                    onClick={() => {
                      swiper?.slideNext();
                    }}
                    expand="block"
                    size="default"
                  >
                    Continue
                  </IonButton>
                </IonCol>
              </IonRow>
            </IonGrid>
          </div>
        </Swiper>
      </form>
    </FormProvider>
  );
}
