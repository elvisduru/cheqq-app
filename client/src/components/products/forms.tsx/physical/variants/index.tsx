import {
  IonButton,
  IonCheckbox,
  IonIcon,
  IonImg,
  IonInput,
  IonItem,
  IonItemDivider,
  IonItemGroup,
  IonLabel,
  IonNote,
  IonReorder,
  IonReorderGroup,
  IonThumbnail,
  IonToggle,
  useIonModal,
} from "@ionic/react";
import { ellipsisHorizontal, image, trash } from "ionicons/icons";
import React, { useCallback, useEffect, useState } from "react";
import { Controller, useFieldArray, useFormContext } from "react-hook-form";
import { Image } from "../../../../../utils/types";
import withSuspense from "../../../../hoc/withSuspense";
import LottieWrapper from "../../../../lottieWrapper";
import TagInput from "../../../../TagInput";
import Step from "../../Step";
import variantAnimation from "../../../../../assets/json/variants.json";

const ChooseImage = withSuspense(React.lazy(() => import("./choose-image")));
const EditVariant = withSuspense(React.lazy(() => import("./editVariant")));

export type Variant = {
  name: string;
  price?: number;
  sku?: string;
  image?: number;
  inventoryTracking?: boolean;
  inventoryLevel?: number;
  inventoryWarningLevel?: number;
  allowBackorder?: boolean;
  gtin?: string;
  enabled?: boolean;
};

export default function Variants() {
  const {
    watch,
    setValue,
    control,
    formState: { errors },
  } = useFormContext();
  const hasVariants = watch("hasVariants");
  const options = watch("options") || [];
  const variants = watch("variants") || [];
  const photos = watch("photos") || [];

  const { fields, append, remove, move } = useFieldArray({
    control,
    name: "options",
  });

  const { fields: variantFields } = useFieldArray({
    control,
    name: "variants",
  });

  const [variant, setVariant] = useState<Variant>();
  const [variantIndex, setVariantIndex] = useState<number>();

  const [present, dismiss] = useIonModal(EditVariant, {
    dismiss: () => {
      dismiss();
    },
    variant,
    variantIndex,
    errors,
    watch,
    setValue,
    control,
  });

  const [presentSelectImage, dismissSelectImage] = useIonModal(ChooseImage, {
    dismiss: () => {
      dismissSelectImage();
    },
    variant,
    variantIndex,
    setValue,
    control,
  });

  const cartesianProduct = (...arrays: any[]) => {
    return arrays.reduce(
      (acc, array) => {
        return acc.reduce(
          (a: string[], v: string[]) =>
            a.concat(array.map((w: string) => [...v, w])),
          []
        );
      },
      [[]]
    );
  };

  const generateVariants = useCallback(
    (options: { name: string; values: string[] }[]): Variant[] => {
      const values = options
        .filter((option) => option.values.length > 0)
        .map((option) => option.values);
      const newVariants: Variant[] = cartesianProduct(...values).map(
        (variant: string[]): Variant => {
          // check if variant already exists
          const variantExists = variants.find((v: Variant) =>
            v.name.split("-").every((el: string) => {
              return variant.includes(el);
            })
          );
          if (variantExists) {
            return { ...variantExists, name: variant.join("-") };
          }
          return {
            name: variant.join("-"),
            price: undefined,
            sku: undefined,
            image: undefined,
            inventoryLevel: undefined,
            inventoryWarningLevel: undefined,
            inventoryTracking: undefined,
            gtin: undefined,
            enabled: true,
          };
        }
      );
      return newVariants;
    },
    [watch]
  );

  const variantsLength = options?.reduce(
    (acc: any, option: any) => acc + option?.values?.length,
    0
  );

  useEffect(() => {
    if (!options.length) {
      setValue("hasVariants", false);
    }
  }, [options.length]);

  useEffect(() => {
    if (options?.length && options[0].name && options[0].values.length) {
      // Generate variant combinations from options array
      const variants = generateVariants(options);
      // Add variants to form
      setValue("variants", variants);
    } else {
      setValue("variants", undefined);
    }
  }, [generateVariants, options, setValue, variantsLength]);

  const handleEditVariant = useCallback(
    (index: number) => {
      const variant = variants[index];
      setVariant(variant);
      setVariantIndex(index);
      present({
        id: "edit-variant",
        breakpoints: [0, 0.65, 1],
        initialBreakpoint: variants[index].inventoryTracking ? 1 : 0.65,
      });
    },
    [variants, present]
  );

  return (
    <Step>
      {!hasVariants ? (
        <LottieWrapper
          title="Create Variants"
          animationData={variantAnimation}
          description="Create multiple variations (color, size, etc.) for your product. You can also set inventory levels and backorder settings for each variant."
          // loop={false}
          // initialSegment={[0, 130]}
          buttonHandler={() => {
            setValue("hasVariants", true);
            append({ name: "", values: [] });
          }}
          buttonText="Create Variants"
        />
      ) : (
        <IonItemGroup>
          <IonItemDivider className="pl-0">
            <IonLabel color="medium">Variants</IonLabel>
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
                        const names = options?.map(
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
                    {String(errors.options?.[index]?.name?.message)}
                  </IonNote>
                </IonItem>
                <TagInput
                  setValue={(val: string[]) => {
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
          {watch("variants") ? (
            <div className="mt-8">
              <IonItemDivider className="pl-0 mb-4">
                <IonLabel color="medium">
                  <div className="text-lg text-left">Manage Variants</div>
                  <IonNote className="text-sm font-normal text-helper">
                    Set image, price, quantity, etc for each product variant.
                  </IonNote>
                </IonLabel>
              </IonItemDivider>
              {variantFields.map((field, index) => (
                <IonItem
                  lines="none"
                  className={`px-0 mt-2`}
                  key={field.id}
                  shape="round"
                >
                  <div
                    className={`flex ${
                      !variants[index].enabled ? "item-disabled" : ""
                    }`}
                  >
                    <IonThumbnail
                      onClick={() => {
                        const variant = variants[index];
                        setVariant(variant);
                        setVariantIndex(index);
                        presentSelectImage({
                          id: "select-image",
                          breakpoints: [0, 0.5],
                          initialBreakpoint: 0.5,
                        });
                      }}
                      className="bg-light mr-1 flex items-center ion-justify-content-center rounded"
                    >
                      {photos.find(
                        (p: Image) => p.id === watch(`variants.${index}.image`)
                      ) ? (
                        <IonImg
                          src={
                            photos.find(
                              (p: Image) => p.id === variants[index].image
                            )?.url
                          }
                        />
                      ) : (
                        <IonIcon icon={image} />
                      )}
                    </IonThumbnail>
                    <IonLabel onClick={() => handleEditVariant(index)}>
                      <h2>{variants[index].name}</h2>
                      <p>
                        {Intl.NumberFormat("en-US", {
                          style: "currency",
                          currency: "USD",
                        }).format(variants[index].price || 0)}
                        &nbsp;• {variants[index].inventoryLevel || 0} available
                      </p>
                    </IonLabel>
                  </div>
                  <div slot="end" className="flex items-center">
                    <IonButton
                      onClick={() => handleEditVariant(index)}
                      fill="clear"
                      color="dark"
                    >
                      <IonIcon slot="icon-only" icon={ellipsisHorizontal} />
                    </IonButton>
                    <Controller
                      control={control}
                      name={`variants.${index}.enabled`}
                      render={({ field: { onChange, onBlur, value } }) => (
                        <IonToggle
                          checked={value}
                          onIonBlur={onBlur}
                          value={value}
                          onIonChange={(e) => {
                            onChange(e.detail.checked);
                          }}
                        />
                      )}
                    />
                  </div>
                </IonItem>
              ))}
            </div>
          ) : null}
        </IonItemGroup>
      )}
    </Step>
  );
}
