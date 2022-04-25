import { ErrorMessage } from "@hookform/error-message";
import {
  IonButton,
  IonInput,
  IonItem,
  IonLabel,
  IonList,
  IonNote,
  IonTextarea,
} from "@ionic/react";
import React from "react";
import { Controller, useForm } from "react-hook-form";

type Props = {};

export default function PhysicalProductForm({}: Props) {
  const {
    control,
    handleSubmit,
    trigger,
    formState: { errors },
  } = useForm({
    mode: "onBlur",
  });
  const onSubmit = (data: any) => console.log(data);
  const onError = (error: any) => console.log(error);

  return (
    <form
      onSubmit={handleSubmit(onSubmit, onError)}
      className="ion-padding modal-form"
    >
      {/* TODO: Add a form description */}
      <IonItem
        className={`input mt-1 ${errors.name ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Name</IonLabel>
        <Controller
          name="name"
          control={control}
          rules={{ required: "Please enter your product's name" }}
          render={({ field: { onChange, onBlur, value } }) => (
            <IonInput
              value={value}
              type="text"
              onIonChange={onChange}
              onIonBlur={onBlur}
              minlength={3}
            />
          )}
        />
        <IonNote slot="helper">
          Give your product a short and clear name.
        </IonNote>
        <IonNote slot="error" color="danger">
          {errors.name?.message}
        </IonNote>
      </IonItem>
      <IonItem
        className={`input mt-1 ${errors.description ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Description</IonLabel>
        <Controller
          name="description"
          control={control}
          rules={{ required: "Please enter a description" }}
          render={({ field: { onChange, onBlur, value } }) => (
            <IonTextarea
              value={value}
              onIonChange={onChange}
              onIonBlur={onBlur}
              minlength={3}
              maxlength={200}
            />
          )}
        />
        <IonNote slot="helper">
          Give your product a short and clear description.
        </IonNote>
        <IonNote slot="error" color="danger">
          {errors.name?.description}
        </IonNote>
      </IonItem>
    </form>
  );
}
