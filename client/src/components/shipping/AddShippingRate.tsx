import {
  IonButton,
  IonButtons,
  IonCheckbox,
  IonContent,
  IonHeader,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonNote,
  IonRadio,
  IonRadioGroup,
  IonSelect,
  IonSelectOption,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import { useEffect } from "react";
import { Controller, useForm } from "react-hook-form";
import useToggle from "../../hooks/useToggle";
import { Rate } from "../../utils/types";

type Props = {
  dismiss: () => void;
  rate?: Rate;
  index?: number;
  handleRateForm: (rate: Rate, index?: number) => void;
  domestic: boolean;
};

export default function AddShippingRate({
  dismiss,
  rate,
  index,
  handleRateForm,
  domestic,
}: Props) {
  const {
    watch,
    control,
    trigger,
    getValues,
    setValue,
    formState: { errors, isValid },
  } = useForm<Rate>({
    mode: "onChange",
    defaultValues: { ...rate },
  });

  const rateCondition = watch("rateCondition");
  const transitTime = watch("transitTime");
  const [conditions, toggleConditions] = useToggle(!!rateCondition);

  useEffect(() => {
    const modal = document.querySelector(
      "#add-shipping-rate"
    ) as HTMLIonModalElement;
    if (conditions) {
      if (!rateCondition) setValue("rateCondition", "weight");
      modal.setCurrentBreakpoint(1);
    } else {
      modal.setCurrentBreakpoint(0.6);
    }
  }, [conditions]);

  const handleSubmit = async () => {
    try {
      const valid = await trigger();
      if (!valid) return;
      // submit form
      const data = getValues();
      // remove undefined conditions
      if (!data.rateConditionMin) delete data.rateConditionMin;
      if (!data.rateConditionMax) delete data.rateConditionMax;
      if (!data.rateConditionMin && !data.rateConditionMax)
        delete data.rateCondition;
      // Convert string values to number
      if (data.rateConditionMin) data.rateConditionMin = +data.rateConditionMin;
      if (data.rateConditionMax) data.rateConditionMax = +data.rateConditionMax;
      data.price = +data.price;
      handleRateForm(data, index);
      dismiss();
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonTitle>{rate ? "Edit" : "Add"} Rate</IonTitle>
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
            <IonButton disabled={!isValid} color="dark" onClick={handleSubmit}>
              Done
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="modal-form ion-padding">
          <IonItem
            className={`input mt-4 ${
              errors.customRateName ? "ion-invalid" : ""
            }`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Transit time</IonLabel>
            <Controller
              name="transitTime"
              control={control}
              rules={{ required: "Please select an option" }}
              render={({ field: { onChange, onBlur, value } }) => (
                // TODO: .select-text overflowing
                <IonSelect
                  interface="action-sheet"
                  interfaceOptions={{
                    translucent: true,
                    mode: "ios",
                    size: "auto",
                  }}
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                  value={value}
                >
                  {domestic ? (
                    <>
                      <IonSelectOption value="economy">
                        Economy (5 to 8 business days)
                      </IonSelectOption>
                      <IonSelectOption value="standard">
                        Standard (3 to 4 business days)
                      </IonSelectOption>
                      <IonSelectOption value="express">
                        Express (1 to 2 business days)
                      </IonSelectOption>
                    </>
                  ) : (
                    <>
                      <IonSelectOption value="economyInternational">
                        Economy International (6 to 18 business days)
                      </IonSelectOption>
                      <IonSelectOption value="standardInternational">
                        Standard International (6 to 12 business days)
                      </IonSelectOption>
                      <IonSelectOption value="expressInternational">
                        Express International (1 to 5 business days)
                      </IonSelectOption>
                    </>
                  )}
                  <IonSelectOption value="custom">
                    Custom flat rate (no transit time)
                  </IonSelectOption>
                </IonSelect>
              )}
            />
            <IonNote slot="helper">
              Select the time interval it takes to ship your products
            </IonNote>
            <IonNote slot="error">{errors.transitTime?.message}</IonNote>
          </IonItem>
          {transitTime === "custom" && (
            <IonItem
              className={`input mt-4 ${
                errors.customRateName ? "ion-invalid" : ""
              }`}
              fill="outline"
              mode="md"
            >
              <IonLabel position="floating">Name</IonLabel>
              <Controller
                name="customRateName"
                control={control}
                shouldUnregister={true}
                rules={{ required: "Please enter a name for this rate" }}
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
                This will be displayed to the customer at checkout.
              </IonNote>
              <IonNote slot="error">{errors.customRateName?.message}</IonNote>
            </IonItem>
          )}
          <IonItem
            className={`input mt-4 ${errors.price ? "ion-invalid" : ""}`}
            fill="outline"
            mode="md"
          >
            <IonLabel position="floating">Price</IonLabel>
            <Controller
              name="price"
              control={control}
              rules={{
                required: "Please enter a price for this rate",
                min: {
                  value: 0,
                  message: "Price must be greater than 0",
                },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <IonInput
                  value={value}
                  type="number"
                  onIonChange={onChange}
                  onIonBlur={onBlur}
                />
              )}
            />
            <IonNote slot="helper">
              Enter a price. "0" means the shipping rate is free.
            </IonNote>
            <IonNote slot="error">{errors.price?.message}</IonNote>
          </IonItem>
          <IonItem lines="none" className="input mt-4 checkbox">
            <IonLabel>{conditions ? "Remove" : "Add"} conditions</IonLabel>
            <IonCheckbox
              onIonChange={() => {
                toggleConditions();
              }}
              checked={conditions}
              slot="start"
            />
          </IonItem>
          {conditions && (
            <>
              <Controller
                name="rateCondition"
                shouldUnregister={true}
                control={control}
                render={({ field: { onChange, value } }) => (
                  <IonRadioGroup value={value} onIonChange={onChange}>
                    <IonItem className="input" lines="none">
                      <IonLabel>Based on order weight</IonLabel>
                      <IonRadio mode="md" slot="start" value="weight" />
                    </IonItem>
                    <IonItem className="input" lines="none">
                      <IonLabel>Based on order price</IonLabel>
                      <IonRadio mode="md" slot="start" value="price" />
                    </IonItem>
                  </IonRadioGroup>
                )}
              />
              <IonItem
                className={`input mt-4 ${
                  errors.rateConditionMin ? "ion-invalid" : ""
                }`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Minimum {rateCondition}</IonLabel>
                <Controller
                  name="rateConditionMin"
                  control={control}
                  shouldUnregister={true}
                  rules={{ min: 0 }}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="number"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                    />
                  )}
                />
                <IonNote slot="helper">
                  Enter a minimum order {rateCondition}.
                </IonNote>
                <IonNote slot="error">
                  {errors.rateConditionMin?.message}
                </IonNote>
              </IonItem>
              <IonItem
                className={`input mt-4 ${
                  errors.rateConditionMax ? "ion-invalid" : ""
                }`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Maximum {rateCondition}</IonLabel>
                <Controller
                  name="rateConditionMax"
                  control={control}
                  shouldUnregister={true}
                  rules={{
                    min: {
                      value: watch("rateConditionMax") || 0,
                      message: `Maximum order ${rateCondition} cannot be less than minimum ${rateCondition}`,
                    },
                  }}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="number"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                    />
                  )}
                />
                <IonNote slot="helper">
                  Enter a maximum order {rateCondition}. Leave blank for no
                  limit.
                </IonNote>
                <IonNote slot="error">
                  {errors.rateConditionMax?.message}
                </IonNote>
              </IonItem>
            </>
          )}
        </div>
      </IonContent>
    </>
  );
}
