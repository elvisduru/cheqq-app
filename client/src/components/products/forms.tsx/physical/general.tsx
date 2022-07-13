import {
  IonCheckbox,
  IonIcon,
  IonInput,
  IonItem,
  IonItemDivider,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonSelect,
  IonSelectOption,
  IonTextarea,
  IonToggle,
} from "@ionic/react";
import { caretDown } from "ionicons/icons";
import React from "react";
import { Controller, useFormContext } from "react-hook-form";
import { useStore } from "../../../../hooks/useStore";
import withSuspense from "../../../hoc/withSuspense";
import MediaUploader from "../../../MediaUploader";
import TagInput from "../../../TagInput";
import Step from "../Step";

const SelectCategory = withSuspense<any>(
  React.lazy(() => import("../../../SelectCategory"))
);

export default function General() {
  const user = useStore((state) => state.user);
  const {
    formState: { errors },
    control,
    setValue,
    watch,
  } = useFormContext();
  return (
    <Step>
      <IonItem
        className={`input mt-4 ${errors.title ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Title</IonLabel>
        <Controller
          name="title"
          control={control}
          rules={{ required: "Please enter your product's title" }}
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
          Give your product a short and clear title.
        </IonNote>
        <IonNote slot="error">{errors.title?.message}</IonNote>
      </IonItem>
      <IonItem
        className={`input mt-4 relative ${
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
        {/* TODO: Clean categoryName onSubmit */}
        <Controller
          control={control}
          name="categoryName"
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
        className={`input mt-4 ${errors.condition ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Condition</IonLabel>
        <Controller
          name="condition"
          control={control}
          rules={{ required: "State the condition of the product" }}
          render={({ field: { onChange, onBlur, value } }) => (
            <IonSelect
              interface="popover"
              interfaceOptions={{
                translucent: true,
                mode: "ios",
                size: "auto",
              }}
              onIonChange={onChange}
              onIonBlur={onBlur}
              value={value}
            >
              <IonSelectOption value="new">New</IonSelectOption>
              <IonSelectOption value="used">Used</IonSelectOption>
              <IonSelectOption value="refurbished">Refurbished</IonSelectOption>
            </IonSelect>
          )}
        />
        <IonNote slot="helper">State the condition of the product.</IonNote>
        <IonNote slot="error">{errors.condition?.message}</IonNote>
      </IonItem>
      <IonItem
        className={`input mt-4 ${errors.description ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        {/* TODO: Use tiptap editor */}
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
      <TagInput
        label="Product Tags"
        name="tags"
        control={control}
        setValue={(tags: string[]) => {
          setValue("tags", tags);
        }}
        note="Optional. Enter tags separated by commas. Limit 20."
      />
      <IonItemGroup className="mt-8">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Media</IonLabel>
        </IonItemDivider>
        <MediaUploader
          setValue={setValue}
          name="photos"
          control={control}
          user={user!}
        />
        <IonNote
          className="ion-padding-horizontal text-xs"
          style={{ color: "#999" }}
        >
          Photos · {watch("photos")?.length || 0}/10 - Add up to 10 Photos. Drag
          to reorder.
        </IonNote>
      </IonItemGroup>
      <IonItemGroup className="mt-8">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Pricing</IonLabel>
        </IonItemDivider>
        <IonItem
          className={`input mt-4 ${errors.price ? "ion-invalid" : ""}`}
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
        <IonItem
          className={`input mt-4 ${errors.comparePrice ? "ion-invalid" : ""}`}
          fill="outline"
          mode="md"
        >
          <IonLabel position="floating">Compare at price</IonLabel>
          <Controller
            control={control}
            name="comparePrice"
            rules={{
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
            Optional. Enter an old price shoppers can compare with.
          </IonNote>
          <IonNote slot="error">{errors.price?.message}</IonNote>
        </IonItem>
        {/* TODO: Add Tax support */}
        {/* <IonItem lines="none" className="input checkbox mt-4">
          <IonLabel>Charge tax on this product</IonLabel>
          <Controller
            control={control}
            name="tax"
            render={({ field: { onChange, onBlur, value } }) => (
              <IonCheckbox slot="start" />
            )}
          />
        </IonItem> */}
      </IonItemGroup>
      <IonItemGroup className="mt-8">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Inventory</IonLabel>
        </IonItemDivider>
        <IonItem lines="none" className="input checkbox">
          <IonLabel>Track inventory for this product</IonLabel>
          <Controller
            control={control}
            name="inventoryTracking"
            render={({ field: { onChange, onBlur, value } }) => (
              <IonCheckbox
                onIonChange={(e) => {
                  onChange(e.detail.checked);
                }}
                onIonBlur={onBlur}
                checked={value}
                slot="start"
              />
            )}
          />
        </IonItem>
        {watch("inventoryTracking") && (
          <>
            <IonItem
              className={`input mt-4 ${
                errors.inventoryLevel ? "ion-invalid" : ""
              }`}
              fill="outline"
              mode="md"
            >
              <IonLabel position="floating">Quantity</IonLabel>
              <Controller
                name="inventoryLevel"
                control={control}
                shouldUnregister
                rules={{
                  required: "Please enter a quantity",
                  min: {
                    value: 1,
                    message: "Quantity must be greater than 0",
                  },
                }}
                render={({ field: { onChange, onBlur, value } }) => (
                  <IonInput
                    value={value}
                    type="number"
                    onIonChange={onChange}
                    onIonBlur={onBlur}
                    min={1}
                  />
                )}
              />
              <IonNote slot="helper">
                How many of this product are you selling?
              </IonNote>
              <IonNote slot="error">{errors.inventoryLevel?.message}</IonNote>
            </IonItem>
            <IonItem
              className={`input mt-4 ${
                errors.inventoryWarningLevel ? "ion-invalid" : ""
              }`}
              fill="outline"
              mode="md"
            >
              <IonLabel position="floating">Warning Level</IonLabel>
              <Controller
                name="inventoryWarningLevel"
                control={control}
                shouldUnregister
                rules={{
                  min: {
                    value: 1,
                    message: "Quantity must be greater than 0",
                  },
                  max: {
                    value: watch("inventoryLevel") || 1,
                    message: "Warning level must be less than quantity",
                  },
                }}
                render={({ field: { onChange, onBlur, value } }) => (
                  <IonInput
                    value={value}
                    type="number"
                    onIonChange={onChange}
                    onIonBlur={onBlur}
                    min={1}
                  />
                )}
              />
              <IonNote slot="helper">
                Optional. Set a warning level when low on stock.
              </IonNote>
              <IonNote slot="error">
                {errors.inventoryWarningLevel?.message}
              </IonNote>
            </IonItem>
            <IonItem lines="none" className="input checkbox mt-4">
              <IonLabel>Allow purchase when out of stock</IonLabel>
              <Controller
                control={control}
                name="allowBackOrder"
                shouldUnregister
                render={({ field: { onChange, onBlur, value } }) => (
                  <IonToggle
                    slot="end"
                    color="primary"
                    checked={value}
                    onIonChange={(e) => {
                      onChange(e.detail.checked);
                    }}
                    onIonBlur={onBlur}
                    value={value}
                  />
                )}
              />
            </IonItem>
            <IonItem className="input mt-4" fill="outline" mode="md">
              <IonLabel position="floating">SKU</IonLabel>
              <Controller
                name="sku"
                control={control}
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
                Stock Keeping Unit. Only visible to you.
              </IonNote>
            </IonItem>
            <IonItem className="input mt-4" fill="outline" mode="md">
              <IonLabel position="floating">Barcode</IonLabel>
              <Controller
                name="gtin"
                control={control}
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
                Optional. ISBN, UPC, GTIN, etc. Only visible to you.
              </IonNote>
            </IonItem>
          </>
        )}
      </IonItemGroup>
      <IonItem className="input mt-4" fill="outline" mode="md">
        <IonLabel position="floating">Brand</IonLabel>
        <Controller
          name="brand"
          control={control}
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
        <IonNote slot="helper">Optional</IonNote>
      </IonItem>
    </Step>
  );
}
