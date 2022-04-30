import {
  IonChip,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonNote,
  IonSelect,
  IonSelectOption,
  IonTextarea,
} from "@ionic/react";
import { caretDown } from "ionicons/icons";
import React from "react";
import { Controller, useForm } from "react-hook-form";
import MediaUploader from "../../MediaUploader";
import SelectCategory from "../../SelectCategory";
import TagInput from "../../TagInput";

type Props = {};

export default function PhysicalProductForm({}: Props) {
  const {
    control,
    handleSubmit,
    setValue,
    watch,
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
        <IonNote slot="error">{errors.name?.message}</IonNote>
      </IonItem>
      <IonItem
        className={`input mt-1 relative ${
          errors.category ? "ion-invalid" : ""
        }`}
        fill="outline"
        mode="md"
      >
        <IonIcon
          icon={caretDown}
          className="absolute right-1"
          style={{ fontSize: 14, top: "calc(50% - 7px)" }}
        />
        <IonLabel position="floating">Category</IonLabel>
        <Controller
          control={control}
          name="category"
          render={({ field: { onChange, onBlur, value } }) => (
            <SelectCategory
              setValue={setValue}
              onChange={onChange}
              onBlur={onBlur}
              value={value}
            />
          )}
        />
        <IonNote slot="helper">Select your product's category</IonNote>
        {/* <IonNote slot="error">{errors.category?.message}</IonNote> */}
      </IonItem>
      <IonItem
        className={`input mt-1 ${errors.condition ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Condition</IonLabel>
        <Controller
          name="condition"
          control={control}
          rules={{ required: "State the condition of the product" }}
          render={({ field: { onChange, onBlur, value } }) => (
            <IonSelect onIonChange={onChange} onIonBlur={onBlur} value={value}>
              <IonSelectOption>New</IonSelectOption>
              <IonSelectOption>Used - like new</IonSelectOption>
              <IonSelectOption>Used - good</IonSelectOption>
              <IonSelectOption>Used - fair</IonSelectOption>
            </IonSelect>
          )}
        />
        <IonNote slot="helper">State the condition of the product.</IonNote>
        <IonNote slot="error">{errors.condition?.message}</IonNote>
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
        <IonNote slot="error">{errors.description?.message}</IonNote>
      </IonItem>
      <IonItem
        className={`input mt-1 ${errors.price ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Price</IonLabel>
        <Controller
          control={control}
          name="price"
          rules={{
            required: "Please enter a price",
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
              min={0}
              step="0.01"
            />
          )}
        />
        <IonNote slot="helper">
          Enter a price. "0" means customers can pay what they want
        </IonNote>
        <IonNote slot="error">{errors.price?.message}</IonNote>
      </IonItem>
      <MediaUploader setValue={setValue} />
      <IonNote
        className="ion-padding-horizontal text-xs"
        style={{ color: "#999" }}
      >
        Photos · {watch("photos")?.length || 0}/10 - You can add up to 10
        Photos.
      </IonNote>
      <TagInput setValue={setValue} />
    </form>
  );
}
