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
  useIonModal,
} from "@ionic/react";
import { caretDown, settings, toggle, trash } from "ionicons/icons";
import React, { useEffect, useRef } from "react";
import { Controller, useFieldArray, useForm } from "react-hook-form";
import shallow from "zustand/shallow";
import { useDeleteImages } from "../../../hooks/mutations/images/deleteImages";
import useUser from "../../../hooks/queries/users/useUser";
import { AppState, ModalState, useStore } from "../../../hooks/useStore";
import useToggle from "../../../hooks/useToggle";
import { Image } from "../../../utils/types";
import MediaUploader from "../../MediaUploader";
import SelectCategory from "../../SelectCategory";
import ShippingZones from "../../shipping/Shipping";
import TagInput from "../../TagInput";

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
// TODO: Split form into sections

export default function PhysicalProductForm() {
  const { data: user } = useUser();
  const { setPhysicalFormData, physicalFormData, physicalModalState } =
    useStore(selector, shallow);

  const deleteImages = useDeleteImages();

  const {
    control,
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
    getValues,
  } = useForm({
    mode: "onBlur",
    defaultValues: { ...physicalFormData, type: "physical" },
  });

  const { fields, append, prepend, remove, swap, move, insert } = useFieldArray(
    {
      control,
      name: "options",
    }
  );

  const onSubmit = (data: any) => console.log(data);
  const onError = (error: any) => console.log(error);

  // Shipping Zones
  const [present, dismiss] = useIonModal(ShippingZones, {
    dismiss: () => {
      dismiss();
    },
  });

  const [dimensions, toggleDimensions] = useToggle();
  const [shippingInfo, toggleShippingInfo] = useToggle();

  const ref = useRef(null);

  // HACK: This is a hack to fix form state if images are already present in store but not in form state.
  // useEffect(() => {
  //   if (physicalFormData && physicalFormData?.savedPhotos)
  //     setValue("savedPhotos", physicalFormData.savedPhotos);
  // }, [physicalFormData]);

  // Save photos to cloud
  useEffect(() => {
    const formValues = getValues();
    if (physicalModalState === ModalState.SAVE) {
      // Save form state
      // let existingImages: Image[] = [];

      // if (formValues?.savedPhotos) {
      //   existingImages = [...formValues.savedPhotos];
      // }

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

  const options = watch("options");

  return (
    <form
      ref={ref}
      onSubmit={handleSubmit(onSubmit, onError)}
      className="ion-padding modal-form"
    >
      {/* TODO: Add a form description */}
      {/* TODO: Save form progress option - save draft to localstorage */}
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
        className={`input mt-1 ${errors.description ? "ion-invalid" : ""}`}
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
        setValue={(tags) => {
          setValue("tags", tags);
        }}
        note="Optional. Enter tags separated by commas. Limit 20."
      />
      <IonItemGroup className="mt-2">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Media</IonLabel>
        </IonItemDivider>
        <MediaUploader
          setValue={setValue}
          name="photos"
          control={control}
          user={user!}
          // deleteFormImage={(id) => {
          //   setPhysicalFormData({
          //     ...physicalFormData,
          //     savedPhotos: physicalFormData.savedPhotos.filter(
          //       (photo: Image) => photo.id !== id
          //     ),
          //   });
          // }}
        />
        <IonNote
          className="ion-padding-horizontal text-xs"
          style={{ color: "#999" }}
        >
          Photos · {watch("photos")?.length || 0}/10 - Add up to 10 Photos. Drag
          to reorder.
        </IonNote>
      </IonItemGroup>
      <IonItemGroup className="mt-2">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Pricing</IonLabel>
        </IonItemDivider>
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
        <IonItem
          className={`input mt-1 ${errors.comparePrice ? "ion-invalid" : ""}`}
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
        {/* <IonItem lines="none" className="input checkbox mt-1">
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
      <IonItemGroup className="mt-2">
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
              className={`input mt-1 ${
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
              className={`input mt-1 ${
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
            <IonItem lines="none" className="input checkbox mt-1">
              <IonLabel>Allow purchase when out of stock</IonLabel>
              <Controller
                control={control}
                name="allowBackOrder"
                shouldUnregister
                render={({ field: { onChange, onBlur, value } }) => (
                  <IonToggle
                    mode="ios"
                    color="primary"
                    onIonChange={(e) => {
                      onChange(e.detail.checked);
                    }}
                    onIonBlur={onBlur}
                    value={value}
                  />
                )}
              />
            </IonItem>
            <IonItem className="input mt-1" fill="outline" mode="md">
              <IonLabel position="floating">SKU</IonLabel>
              <Controller
                name="sku"
                control={control}
                rules={{ required: "Please enter a SKU" }}
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
              <IonNote slot="error">{errors.sku?.message}</IonNote>
            </IonItem>
            <IonItem className="input mt-1" fill="outline" mode="md">
              <IonLabel position="floating">Barcode</IonLabel>
              <Controller
                name="barcode"
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
      <IonItemGroup className="mt-2">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Variants</IonLabel>
        </IonItemDivider>
        <IonItem lines="none" className="input mt-1 checkbox">
          <IonLabel>Create options like size, color, etc</IonLabel>
          <Controller
            control={control}
            name="hasVariants"
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
        {watch("hasVariants") && (
          <>
            <IonReorderGroup
              disabled={false}
              onIonItemReorder={(e) => {
                move(e.detail.from, e.detail.to);
                e.detail.complete();
              }}
            >
              {fields.map((field, index) => (
                <div key={field.id} className="mb-1">
                  <div className="flex ion-justify-content-between">
                    <IonReorder />
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
                      errors.options?.[index]?.name ? "ion-invalid" : ""
                    }`}
                    fill="outline"
                    mode="md"
                  >
                    <IonLabel position="floating">Option name</IonLabel>
                    <Controller
                      name={`options.${index}.name`}
                      rules={{
                        required: "Option name is required",
                        validate: (value) => {
                          // Get value of all options name property except the current one
                          const names = options.map(
                            (option: any) => option.name
                          );
                          names.splice(index, 1);
                          // Check if value is already in the array
                          if (names.includes(value)) {
                            return `You already have an option with the name "${value}"`;
                          }
                          return true;
                        },
                      }}
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
                      {errors.options?.[index]?.name?.message}
                    </IonNote>
                  </IonItem>
                  <TagInput
                    setValue={(val) => {
                      setValue(`options.${index}.values`, val);
                    }}
                    label="Option values"
                    name={`options.${index}.values`}
                    control={control}
                  />
                </div>
              ))}
            </IonReorderGroup>
            <IonButton
              fill="solid"
              expand="block"
              color="medium"
              onClick={() => {
                append({ name: "", values: [] });
              }}
            >
              Add new option
            </IonButton>
            {options.length && options[0].name && options[0].values.length ? (
              <IonButton
                fill="solid"
                expand="block"
                color="medium"
                class="mt-1"
              >
                Manage Variants
              </IonButton>
            ) : null}
          </>
        )}
      </IonItemGroup>
      <IonItemGroup className="mt-2">
        <IonItemDivider className="pl-0">
          <IonLabel color="medium">Shipping</IonLabel>
          <IonButton
            size="small"
            fill="clear"
            slot="end"
            onClick={() => {
              present({
                presentingElement: document.querySelector(
                  "#new-physical-product"
                ) as HTMLElement,
                canDismiss: true,
                id: "shipping-settings",
              });
            }}
          >
            Manage Settings
          </IonButton>
        </IonItemDivider>
        <IonItem lines="none" className="input mt-1 checkbox">
          <IonLabel>Enable Free Shipping</IonLabel>
          <Controller
            control={control}
            name="isFreeShipping"
            render={({ field: { onChange, onBlur, value } }) => (
              <IonToggle
                mode="ios"
                color="primary"
                onIonChange={(e) => {
                  onChange(e.detail.checked);
                }}
                onIonBlur={onBlur}
                value={value}
              />
            )}
          />
        </IonItem>
        {!watch("isFreeShipping") && (
          <IonItem className="input mt-1" fill="outline" mode="md">
            <IonLabel position="floating">Fixed Shipping Rate</IonLabel>
            <Controller
              name="fixedShippingRate"
              control={control}
              shouldUnregister
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
              Optional. This will override your default shipping rate settings.
            </IonNote>
          </IonItem>
        )}
        <IonItem lines="none" className="input mt-1 checkbox">
          <IonLabel>Add Shipping Information</IonLabel>
          <IonCheckbox
            onIonChange={(e) => {
              toggleShippingInfo();
            }}
            checked={shippingInfo}
            slot="start"
          />
        </IonItem>

        {shippingInfo && (
          <>
            <IonItem className="input mt-1" fill="outline" mode="md">
              <IonLabel position="floating">Weight</IonLabel>
              <Controller
                name="weight"
                control={control}
                shouldUnregister
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
                Optional. Used to calculate shipping rates at checkout.
              </IonNote>
            </IonItem>
            <IonItem className="input mt-1" fill="outline" mode="md">
              <IonLabel position="floating">Weight Unit</IonLabel>
              <Controller
                name="weightUnit"
                shouldUnregister
                control={control}
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
                    <IonSelectOption>g</IonSelectOption>
                    <IonSelectOption>kg</IonSelectOption>
                    <IonSelectOption>lb</IonSelectOption>
                    <IonSelectOption>oz</IonSelectOption>
                  </IonSelect>
                )}
              />
            </IonItem>
            <IonItem lines="none" className="input mt-1 checkbox">
              <IonLabel>Add product dimensions</IonLabel>
              <IonCheckbox
                onIonChange={() => {
                  toggleDimensions();
                }}
                checked={dimensions}
                slot="start"
              />
            </IonItem>
            {dimensions && (
              <>
                <IonItem className="input mt-1" fill="outline" mode="md">
                  <IonLabel position="floating">Width</IonLabel>
                  <Controller
                    name="width"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonInput
                        value={value}
                        type="number"
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                      />
                    )}
                  />
                </IonItem>
                <IonItem className="input mt-1" fill="outline" mode="md">
                  <IonLabel position="floating">Height</IonLabel>
                  <Controller
                    name="height"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonInput
                        value={value}
                        type="number"
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                      />
                    )}
                  />
                </IonItem>
                <IonItem className="input mt-1" fill="outline" mode="md">
                  <IonLabel position="floating">Depth</IonLabel>
                  <Controller
                    name="depth"
                    shouldUnregister
                    control={control}
                    render={({ field: { onChange, onBlur, value } }) => (
                      <IonInput
                        value={value}
                        type="number"
                        onIonChange={onChange}
                        onIonBlur={onBlur}
                      />
                    )}
                  />
                </IonItem>
                <IonItem className="input mt-1" fill="outline" mode="md">
                  <IonLabel position="floating">Dimensions Unit</IonLabel>
                  <Controller
                    name="dimensionUnit"
                    shouldUnregister
                    control={control}
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
                        <IonSelectOption>in</IonSelectOption>
                        <IonSelectOption>cm</IonSelectOption>
                        <IonSelectOption>m</IonSelectOption>
                      </IonSelect>
                    )}
                  />
                </IonItem>
              </>
            )}
          </>
        )}
      </IonItemGroup>
      <IonItem className="input mt-1" fill="outline" mode="md">
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
    </form>
  );
}
