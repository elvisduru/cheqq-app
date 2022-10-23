import {
  IonButton,
  IonCheckbox,
  IonIcon,
  IonInput,
  IonItem,
  IonItemDivider,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonReorder,
  IonReorderGroup,
  IonSelect,
  IonSelectOption,
  IonTextarea,
  IonToggle,
  useIonAlert,
} from "@ionic/react";
import { trash } from "ionicons/icons";
import { Controller, useFieldArray, useFormContext } from "react-hook-form";
import { useStore } from "../../../../hooks/useStore";
import { ProductInput } from "../../../../utils/types";
import MediaUploader from "../../../MediaUploader";
import TagInput from "../../../TagInput";
import Step from "../Step";
import slugify from "slugify";
import { useEffect, useState } from "react";
import useBoolean from "../../../../hooks/useBoolean";

// const SelectCategory = withSuspense<any>(
//   React.lazy(() => import("../../../SelectCategory"))
// );

export default function General() {
  const user = useStore((state) => state.user);
  const selectedStore = useStore((store) => store.selectedStore);
  const store = user?.stores.find((s) => s.id === selectedStore);

  const {
    formState: { errors },
    control,
    setValue,
    watch,
    getFieldState,
  } = useFormContext<ProductInput>();

  const { fields, append, remove, move } = useFieldArray({
    control,
    name: "customFields",
  });

  const title = watch("title");
  const slug = watch("slug");
  const id = watch("id");

  const { value: disableSlugUpdate, setTrue, setFalse } = useBoolean(!!id);

  const [presentAlert] = useIonAlert();

  useEffect(() => {
    if (
      title &&
      getFieldState("slug").isTouched === false &&
      !disableSlugUpdate
    ) {
      setValue("slug", slugify(title, { lower: true }));
    }
  }, [title]);

  return (
    <Step>
      <IonItem
        className={`input mt-1 ${errors.title ? "ion-invalid" : ""}`}
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

      {/* TODO: Move category input to product's settings. When publishing on Cheqq Marketplace, it's a requirement */}
      {/* <IonItem
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
        <IonNote slot="error">{errors.category?.message}</IonNote>
      </IonItem> */}
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
      <div className="mt-4 relative">
        <IonItem
          className={`input ${errors.slug ? "ion-invalid" : ""}`}
          fill="outline"
          mode="md"
        >
          <IonLabel position="floating">URL Slug</IonLabel>
          <Controller
            name="slug"
            control={control}
            rules={{ required: "Please enter your product's URL slug" }}
            render={({ field: { onChange, onBlur, value } }) => (
              <IonInput
                value={value}
                type="text"
                onIonChange={onChange}
                onIonBlur={onBlur}
                disabled={disableSlugUpdate}
              />
            )}
          />
          <IonNote slot="helper">
            https://cheqq.me/{store?.tag}/{slug}
          </IonNote>
          <IonNote slot="error">{errors.slug?.message}</IonNote>
        </IonItem>
        <div className="absolute z-10 right-0 top-0 mt-3 mr-4">
          {disableSlugUpdate ? (
            <IonButton
              fill="clear"
              size="small"
              onClick={() =>
                presentAlert({
                  header: "Are you sure?",
                  message:
                    "Changing the URL slug will break existing links to this product.",
                  buttons: [
                    {
                      text: "Cancel",
                      role: "cancel",
                    },
                    {
                      text: "Change",
                      handler: setFalse,
                    },
                  ],
                })
              }
            >
              Edit slug
            </IonButton>
          ) : (
            <IonButton
              fill="clear"
              size="small"
              onClick={() =>
                setValue("slug", slugify(title, { lower: true }), {
                  shouldValidate: true,
                })
              }
            >
              Reset
            </IonButton>
          )}
        </div>
      </div>
      <TagInput
        label="Product Tags"
        name="tags"
        control={control}
        setValue={(tags: string[]) => {
          setValue("tags", tags);
        }}
        note="Optional. Enter tags separated by commas ( , ). Limit 20."
      />
      <IonItemGroup className="mt-8">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Media</IonLabel>
        </IonItemDivider>
        <MediaUploader
          setValue={setValue}
          name="images"
          control={control}
          user={user!}
        />
        <IonNote
          className="ion-padding-horizontal text-xs"
          style={{ color: "#999" }}
        >
          Photos · {watch("images")?.length || 0}/10 - Add up to 10 Photos. Drag
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
                message: "Price must be greater than or equal to 0",
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
          className={`input mt-4 ${errors.compareAtPrice ? "ion-invalid" : ""}`}
          fill="outline"
          mode="md"
        >
          <IonLabel position="floating">Old Price</IonLabel>
          <Controller
            control={control}
            name="compareAtPrice"
            rules={{
              min: {
                value: 0,
                message: "Price must be greater than or equal to 0",
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
          <IonLabel color="medium">Specifications</IonLabel>
        </IonItemDivider>
        <IonReorderGroup
          disabled={false}
          onIonItemReorder={(e) => {
            move(e.detail.from, e.detail.to);
            e.detail.complete();
          }}
        >
          {fields.map((field, index) => (
            <div key={field.id} className="mb-2">
              <div className="flex ion-justify-content-between">
                <div className="flex items-center">
                  <IonReorder />
                  <IonNote className="text-sm">Drag to reorder</IonNote>
                </div>
                <IonButton
                  slot="end"
                  fill="clear"
                  color="danger"
                  size="small"
                  onClick={() => {
                    remove(index);
                  }}
                >
                  <IonIcon slot="icon-only" icon={trash} />
                </IonButton>
              </div>
              <IonItem
                className={`input mt-1 ${
                  errors.customFields?.[index]?.label ? "ion-invalid" : ""
                }`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Label</IonLabel>
                <Controller
                  name={`customFields.${index}.label`}
                  control={control}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="text"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                      minlength={3}
                      autoCorrect="on"
                    />
                  )}
                />
                <IonNote slot="error">
                  {errors.customFields?.[index]?.label?.message}
                </IonNote>
              </IonItem>
              <IonItem
                className={`input mt-4 ${
                  errors.customFields?.[index]?.value ? "ion-invalid" : ""
                }`}
                fill="outline"
                mode="md"
              >
                <IonLabel position="floating">Value</IonLabel>
                <Controller
                  name={`customFields.${index}.value`}
                  control={control}
                  render={({ field: { onChange, onBlur, value } }) => (
                    <IonInput
                      value={value}
                      type="text"
                      onIonChange={onChange}
                      onIonBlur={onBlur}
                      minlength={3}
                      autoCorrect="on"
                    />
                  )}
                />
                <IonNote slot="error">
                  {errors.customFields?.[index]?.value?.message}
                </IonNote>
              </IonItem>
            </div>
          ))}
        </IonReorderGroup>
        <IonButton
          fill="solid"
          expand="block"
          color="medium"
          onClick={() => {
            append({ label: undefined, value: undefined });
          }}
        >
          Add new field
        </IonButton>
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
                    message: "Warning level can't be greater than quantity",
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
      {/* TODO: Brand input select component */}
      {/* <IonItem className="input mt-4" fill="outline" mode="md">
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
              autocapitalize="words"
            />
          )}
        />
        <IonNote slot="helper">Optional</IonNote>
      </IonItem> */}
    </Step>
  );
}
