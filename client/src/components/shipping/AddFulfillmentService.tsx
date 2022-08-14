import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonNote,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import { Controller, useForm } from "react-hook-form";
import useAddFulfillmentService from "../../hooks/mutations/fulfillmentServices/addFulfillmentService";
import useUpdateFulfillmentService from "../../hooks/mutations/fulfillmentServices/updateFulfillmentService";
import { FulfillmentService } from "../../utils/types";

type Props = {
  dismiss: () => void;
  fulfillmentService?: FulfillmentService;
  selectedStore: number;
};

export default function AddFulfillmentService({
  dismiss,
  fulfillmentService,
  selectedStore,
}: Props) {
  const addFulfillmentService = useAddFulfillmentService();
  const updateFullfillmentService = useUpdateFulfillmentService();
  const {
    formState: { isValid, errors },
    control,
    handleSubmit,
  } = useForm<FulfillmentService>({
    mode: "onChange",
    defaultValues: fulfillmentService,
  });

  const onSubmit = (data: FulfillmentService) => {
    if (fulfillmentService) {
      updateFullfillmentService.mutate(data, {
        onSuccess: () => {
          dismiss();
        },
      });
    } else {
      addFulfillmentService.mutate(
        { ...data, storeId: selectedStore },
        {
          onSuccess: () => {
            dismiss();
          },
        }
      );
    }
  };
  const onError = (errors: any) => {
    console.log(errors);
  };

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>{fulfillmentService ? "Edit" : "Add"} Rate</IonTitle>
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
          <IonButtons slot="end">
            <IonButton
              disabled={!isValid}
              color="dark"
              onClick={() => handleSubmit(onSubmit, onError)()}
            >
              Done
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="modal-form ion-padding">
          <IonItem
            className={`input mt-4 ${errors.name ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Name</IonLabel>
            <Controller
              name="name"
              control={control}
              rules={{ required: "Please enter a name" }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="text"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                />
              )}
            />
            <IonNote slot="helper">
              Enter the name of the fulfillment service.
            </IonNote>
            <IonNote slot="error">{errors.name?.message}</IonNote>
          </IonItem>
          <IonItem
            className={`input mt-4 ${errors.email ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Email address</IonLabel>
            <Controller
              name="email"
              control={control}
              rules={{
                required: "Please enter an email address",
                pattern: {
                  value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                  message: "Please enter a valid email address",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="email"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                />
              )}
            />
            <IonNote slot="helper">
              Enter the email address of the fulfillment service.
            </IonNote>
            <IonNote slot="error">{errors.email?.message}</IonNote>
          </IonItem>
        </div>
      </IonContent>
    </>
  );
}
