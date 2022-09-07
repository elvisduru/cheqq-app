import {
  IonAvatar,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonChip,
  IonContent,
  IonIcon,
  IonImg,
  IonThumbnail,
} from "@ionic/react";
import {
  chatbubbleOutline,
  chevronBack,
  chevronDown,
  heartOutline,
  shareOutline,
  star,
} from "ionicons/icons";
import { useCallback, useEffect, useMemo, useState } from "react";
import { Pagination, Zoom } from "swiper";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/zoom";
import { Swiper, SwiperSlide } from "swiper/react";
import { ProductInput } from "../../utils/types";

type Props = {
  product: ProductInput;
  goBack: () => void;
  isPreview?: boolean;
};

export default function ProductDetails({ product, goBack, isPreview }: Props) {
  const [productOptions, setProductOptions] = useState<
    typeof defaultProductOptions
  >([]);
  const [selectedValues, setSelectedValues] = useState<{ [x: string]: string }>(
    {}
  );

  const [selectedVariant, setSelectedVariant] = useState<number>(-1);
  const [selectedImage, setSelectedImage] = useState<number>(-1);

  const handleSelectedValues = useCallback(
    (option: string, value: string) => {
      // if value exists already, delete key
      if (Object.values(selectedValues).includes(value)) {
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
      const variant = product?.variants?.findIndex((variant) => {
        const values: string[] = Object.values(selectedValues);
        const variantTitleArray = variant.title.split("-");
        return values.every((value) => variantTitleArray.includes(value));
      });
      setSelectedVariant(variant!);
    } else {
      setSelectedVariant(-1);
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

  return (
    <IonContent fullscreen>
      <div className="fixed z-20 top-0 left-0 w-full ion-padding">
        <button
          onClick={() => {
            goBack();
          }}
          className="w-10 h-10 bg-black flex justify-center items-center rounded-full backdrop-filter backdrop-blur-sm bg-opacity-50"
        >
          <IonIcon size="small" icon={isPreview ? chevronDown : chevronBack} />
        </button>
      </div>
      <div className="h-1/2 flex-shrink-0">
        <Swiper
          zoom
          pagination={{ clickable: true }}
          modules={[Pagination, Zoom]}
          className="h-full"
        >
          {product?.images?.map((image) => (
            <SwiperSlide key={image.id}>
              <IonThumbnail className="w-full h-full">
                <IonImg src={image.url} />
              </IonThumbnail>
            </SwiperSlide>
          ))}
        </Swiper>
      </div>
      <IonCard className="m-0 -mt-4 z-10">
        <IonCardHeader>
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center pr-4">
              <IonAvatar className="w-6 h-6">
                <IonImg src={product?.store?.logo!} />
              </IonAvatar>
              <span className="text-white ml-1 text-base">
                {product.store.name}
              </span>
            </div>
            <div className="flex items-center text-2xl text-white space-x-5">
              <IonIcon
                icon={heartOutline}
                className="text-[calc(1.5rem+12%)]"
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
              <span>${variant?.price || product?.price}</span>
              {variant?.price || product?.compareAtPrice ? (
                <div className="text-sm font-light font-sans ml-1">
                  <span className="text-gray-400 ml-1 line-through">
                    ${variant?.compareAtPrice || product?.compareAtPrice}
                  </span>{" "}
                  <span
                    className={
                      (variant?.compareAtPrice || product?.compareAtPrice!) >
                      (variant?.price || product?.price)
                        ? "text-green-400"
                        : "text-red-500"
                    }
                  >
                    {(
                      (((variant?.price || product?.price) -
                        (variant?.compareAtPrice || product?.compareAtPrice!)) /
                        (variant?.compareAtPrice || product?.compareAtPrice!)) *
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
          <div className="flex items-center">
            <IonIcon icon={star} className="text-[#EE8937]" />
            <IonCardSubtitle className="mb-0 ml-1">(4.5)</IonCardSubtitle>{" "}
            &nbsp;<span>123 reviews</span>
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
          <Section title="Description">
            <p>{product?.description}</p>
          </Section>
        </IonCardContent>
      </IonCard>
    </IonContent>
  );
}

type OptionValuesProps = {
  option: string;
  values: { label: string; disabled: boolean }[];
  handleSelectedValues: (option: string, value: string) => void;
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
            handleSelection(value.label);
          }}
          color={selected === value.label ? "" : "null"}
          outline={selected !== value.label}
          key={value.label + index}
          disabled={value.disabled}
        >
          {value.label}
        </IonChip>
      ))}
    </div>
  );
};

function Section({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <div>
      <h2 className="text-xl font-medium mb-2">{title}</h2>
      {children}
    </div>
  );
}
