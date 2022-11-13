import {
  IonAccordion,
  IonAccordionGroup,
  IonAvatar,
  IonButton,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonChip,
  IonContent,
  IonIcon,
  IonImg,
  IonInput,
  IonItem,
  IonLabel,
} from "@ionic/react";
import {
  addCircle,
  chatbubbleOutline,
  chevronBack,
  chevronDown,
  ellipsisHorizontal,
  heart,
  heartOutline,
  imagesOutline,
  removeCircle,
  shareOutline,
  star,
} from "ionicons/icons";
import React, { useCallback, useEffect, useMemo, useState } from "react";
import { Pagination, Zoom } from "swiper";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/zoom";
import { Swiper, SwiperSlide } from "swiper/react";
import { Swiper as SwiperType } from "swiper/types";
import useCounter from "../../hooks/useCounter";
import useToggle from "../../hooks/useToggle";
import { Product, ProductInput } from "../../utils/types";

type Props = {
  product: ProductInput | Product;
  goBack: () => void;
  isPreview?: boolean;
  buttonHandler?: (
    e?: React.BaseSyntheticEvent<object, any, any> | undefined
  ) => Promise<void>;
};

// TODO: Out of stock message, disable qty buttons
// TODO: Select default variant if merchants configured one, else prevent users from adding to cart if no variant is selected.
/*
 TODO: When no variant is selected, find the least and most expensive prices and display the range. 
 If there is only one variant, display the price of that variant. 
 If there are no variants, display the price of the product. 
 If there is no price, display "Free".
*/

export default function ProductDetails({
  product,
  goBack,
  isPreview,
  buttonHandler,
}: Props) {
  const [productOptions, setProductOptions] = useState<
    typeof defaultProductOptions
  >([]);
  const [selectedValues, setSelectedValues] = useState<{ [x: string]: string }>(
    {}
  );

  const [selectedVariant, setSelectedVariant] = useState<number>(-1);

  const [liked, toggleLike] = useToggle();
  const { count, increment, decrement, setCount } = useCounter(1);

  const [swiper, setSwiper] = useState<SwiperType | null>(null);

  const handleSelectedValues = useCallback(
    (option: string, value?: string) => {
      // if no value is selected, remove the option from the selectedValues object
      if (!value) {
        setSelectedValues((prev) => {
          const newSelectedValues = { ...prev };
          delete newSelectedValues[option];
          return newSelectedValues;
        });
      } else if (Object.values(selectedValues).includes(value)) {
        // if value exists already, delete key
        const newSelectedValues = { ...selectedValues };
        delete newSelectedValues[option];
        setSelectedValues(newSelectedValues);
      } else {
        setSelectedValues((prev: any) => {
          return {
            ...prev,
            [option]: value,
          };
        });
      }
    },
    [selectedValues]
  );

  useEffect(() => {
    if (Object.keys(selectedValues).length === product.options?.length) {
      // When variant combination is matched
      const variant = product?.variants?.findIndex((variant) => {
        const values: string[] = Object.values(selectedValues);
        const variantTitleArray = variant.title.split("-");
        return values.every((value) => variantTitleArray.includes(value));
      });
      setSelectedVariant(variant!);
      // check count and update if necessary
      const inventoryLevel = product.variants?.[variant!]?.inventoryLevel;
      if (inventoryLevel && count > inventoryLevel) {
        setCount(inventoryLevel);
      }
      // Update slider index if images are available
      if (product.images) {
        const imagePos = product.images.findIndex(
          (img) => img.id === product.variants?.[variant!]?.imageId
        );
        if (swiper && imagePos !== -1) {
          swiper.slideTo(imagePos);
        }
      }
    } else {
      // Variant combination is not matched
      setSelectedVariant(-1);
      if (product.inventoryLevel && count > product.inventoryLevel) {
        setCount(product.inventoryLevel);
      }
    }
  }, [selectedValues]);

  const defaultProductOptions = useMemo(
    () =>
      product.options?.map((option) => ({
        ...option,
        values: option.values.map((value) => ({
          label: value,
          disabled: false,
        })),
      })),
    [product.options]
  );

  useEffect(() => {
    // if selectedValues is empty (first time or if item is cleared)
    // set proper options
    if (Object.keys(selectedValues).length === 0) {
      setProductOptions(defaultProductOptions || []);
      return;
    }

    const selected = Object.values(selectedValues);

    // filter variants that have at least one of the selected values
    const availableVariants = product.variants
      ?.filter(({ enabled }) => enabled)
      ?.filter((variant) => {
        const variantTitleArray = variant.title.split("-");
        return selected.every((value) =>
          variantTitleArray.includes(value as string)
        );
      })
      .flatMap((variant) => variant.title.split("-"));

    // set product options
    setProductOptions((productOptions) =>
      productOptions?.map((option) => {
        return {
          ...option,
          values: option.values.map((value) => ({
            ...value,
            disabled: !availableVariants?.includes(value.label),
          })),
        };
      })
    );
  }, [selectedValues, defaultProductOptions]);

  const variant = useMemo(
    () => product?.variants?.[selectedVariant],
    [selectedVariant]
  );

  const price = useMemo(() => {
    if (variant?.price) {
      return variant.price;
    }
    return +product.price;
  }, [variant?.price, product.price]);

  const compareAtPrice = useMemo(() => {
    if (variant?.compareAtPrice) {
      return +variant.compareAtPrice;
    }
    return product.compareAtPrice ? +product.compareAtPrice : undefined;
  }, [variant?.compareAtPrice, product.compareAtPrice]);
  return (
    <IonContent fullscreen>
      <div className="fixed flex items-center justify-between z-20 top-0 left-0 w-full ion-padding">
        <button
          onClick={() => {
            goBack();
          }}
          className="w-10 h-10 flex justify-center items-center rounded-full backdrop-filter backdrop-blur-sm bg-opacity-50"
        >
          <IonIcon size="small" icon={isPreview ? chevronDown : chevronBack} />
        </button>
        {!isPreview ? (
          <button
            onClick={buttonHandler}
            className="w-10 h-10 flex justify-center items-center rounded-full backdrop-filter backdrop-blur-sm bg-opacity-50"
          >
            <IonIcon size="small" icon={ellipsisHorizontal} />
          </button>
        ) : null}
      </div>
      <div className="flex flex-col pb-16">
        <div className="flex-shrink-0">
          {product.images?.length ? (
            <Swiper
              zoom={true}
              pagination={{ clickable: true }}
              modules={[Pagination, Zoom]}
              className="h-[500px]"
              onSwiper={setSwiper}
            >
              {product?.images
                ?.sort((a, b) => a.sortOrder - b.sortOrder)
                ?.map((image) => (
                  <SwiperSlide key={image.id}>
                    <div className="swiper-zoom-container">
                      <IonImg className="swiper-zoom-target" src={image.url} />
                    </div>
                  </SwiperSlide>
                ))}
            </Swiper>
          ) : (
            <div className="flex w-full items-center justify-center px-2 text-white h-[500px] bg-gradient-to-r from-primary to-purple-600">
              <IonIcon icon={imagesOutline} className="text-4xl mr-2" />
              <p>
                No image <br /> uploaded
              </p>
            </div>
          )}
        </div>
        <IonCard className="m-0 -mt-4 z-10 flex-1">
          <IonCardHeader>
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center pr-4">
                <IonAvatar className="w-6 h-6">
                  <IonImg src={product?.store?.logo!} />
                </IonAvatar>
                <span className="text-white ml-1 text-base">
                  {product?.store?.name}
                </span>
              </div>
              <div className="flex items-center text-[1.6rem] text-white space-x-5 [&>*]:cursor-pointer">
                <IonIcon
                  icon={liked ? heart : heartOutline}
                  onClick={toggleLike}
                  className={`${liked ? "like" : ""} text-[calc(1.6rem+15%)]`}
                />
                <IonIcon icon={chatbubbleOutline} />
                <IonIcon icon={shareOutline} />
              </div>
            </div>
            <div className="flex flex-wrap">
              <IonCardTitle className="text-xl font-normal pr-4 mr-auto line-clamp-2">
                {product?.title}
              </IonCardTitle>
              <IonCardTitle className="text-xl flex-shrink-0 font-medium flex items-center mb-2">
                <span>
                  {product.store?.country?.currency_symbol}
                  {price}
                </span>
                {compareAtPrice && compareAtPrice !== price ? (
                  <div className="text-sm font-light font-sans ml-1">
                    <span className="text-gray-400 ml-1 line-through">
                      {product.store?.country?.currency_symbol}
                      {compareAtPrice}
                    </span>{" "}
                    <span
                      className={
                        compareAtPrice > price
                          ? "text-green-400"
                          : "text-red-500"
                      }
                    >
                      {(
                        ((price - compareAtPrice) / compareAtPrice) *
                        100
                      ).toFixed(2)}
                      %
                    </span>
                  </div>
                ) : (
                  ""
                )}
              </IonCardTitle>
            </div>
            <div className="flex justify-between">
              <div className="flex items-center">
                <IonIcon icon={star} className="text-[#EE8937]" />
                <IonCardSubtitle className="mb-0 ml-1">
                  (4.5)
                </IonCardSubtitle>{" "}
                &nbsp;<span>123 reviews</span>
              </div>
              <div className="flex items-center text-2xl">
                <IonIcon
                  onClick={() => {
                    if (count >= 2) decrement();
                  }}
                  icon={removeCircle}
                  className="active:text-primary"
                />
                <IonInput
                  type="number"
                  value={count}
                  onIonChange={(e) => {
                    const value = parseInt(e.detail.value!);
                    // If the value is more than inventoryLevel, set it to inventoryLevel
                    let inventoryLevel =
                      variant?.inventoryLevel || product.inventoryLevel;
                    if (inventoryLevel && value > inventoryLevel) {
                      setCount(inventoryLevel);
                      return;
                    }
                    setCount(value);
                  }}
                  className="w-12 text-center text-base appearance-none qty"
                />
                <IonIcon
                  onClick={() => {
                    if (
                      count < (product?.inventoryLevel || Infinity) ||
                      product.allowBackOrder
                    )
                      increment();
                  }}
                  icon={addCircle}
                  className="active:text-primary"
                />
              </div>
            </div>
          </IonCardHeader>
          <IonCardContent>
            {productOptions?.map((option) => (
              <div key={option.id || option.name} className="mb-2">
                <div className="text-sm font-medium text-gray-400 mb-1">
                  {option.name}
                </div>
                <div className="flex flex-wrap">
                  <OptionValues
                    option={option.name}
                    values={option.values}
                    handleSelectedValues={handleSelectedValues}
                  />
                </div>
              </div>
            ))}
            <IonAccordionGroup>
              <IonAccordion className="bg-inherit">
                <IonItem
                  slot="header"
                  lines="inset"
                  className="px-0 text-gray-400"
                >
                  <IonLabel>Description</IonLabel>
                </IonItem>
                <div slot="content" className="py-3">
                  {product?.description}
                </div>
              </IonAccordion>
              <IonAccordion className="bg-inherit">
                <IonItem
                  slot="header"
                  lines="inset"
                  className="px-0 text-gray-400"
                >
                  <IonLabel>Specifications</IonLabel>
                </IonItem>
                <div slot="content" className="py-3 grid grid-cols-2 gap-y-2">
                  {product?.customFields?.map((field, index) => (
                    <React.Fragment key={index}>
                      <div className="font-medium capitalize">
                        {field.label}
                      </div>
                      <div className="font-normal">{field.value}</div>
                    </React.Fragment>
                  ))}
                </div>
              </IonAccordion>
            </IonAccordionGroup>
          </IonCardContent>
        </IonCard>
      </div>
      {isPreview ? (
        <div
          slot="fixed"
          className="bottom-0 ion-padding-horizontal pb-4 w-full"
        >
          <IonButton
            expand="block"
            className="bottom-0 w-full"
            onClick={buttonHandler}
          >
            Publish
          </IonButton>
        </div>
      ) : null}
    </IonContent>
  );
}

type OptionValuesProps = {
  option: string;
  values: { label: string; disabled: boolean }[];
  handleSelectedValues: (option: string, value?: string) => void;
};

const OptionValues = ({
  option,
  values,
  handleSelectedValues,
}: OptionValuesProps) => {
  const [selected, setSelected] = useState<string>();

  const handleSelection = (value: string) => {
    if (selected === value) {
      setSelected(undefined);
    } else {
      setSelected(value);
    }
    handleSelectedValues(option, value);
  };

  return (
    <div className="flex flex-wrap">
      {values.map((value, index) => (
        <IonChip
          onClick={() => {
            if (value.disabled) {
              setSelected(undefined);
              handleSelectedValues(option);
            } else {
              handleSelection(value.label);
            }
          }}
          color={
            selected === value.label ? "" : value.disabled ? "medium" : "null"
          }
          outline={selected !== value.label}
          key={value.label + index}
        >
          {value.label}
        </IonChip>
      ))}
    </div>
  );
};
