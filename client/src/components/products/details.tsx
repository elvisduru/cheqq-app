import {
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonContent,
  IonIcon,
  IonImg,
  IonThumbnail,
} from "@ionic/react";
import { chevronBack, chevronDown } from "ionicons/icons";
import { Pagination, Zoom } from "swiper";
import { Swiper, SwiperSlide } from "swiper/react";
import { ProductInput } from "../../utils/types";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/zoom";

type Props = {
  product: ProductInput;
  goBack: () => void;
  isPreview?: boolean;
};

export default function ProductDetails({ product, goBack, isPreview }: Props) {
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
          <IonCardSubtitle>{product?.title}</IonCardSubtitle>
          <IonCardTitle>${product?.price}</IonCardTitle>
        </IonCardHeader>
        <IonCardContent>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
          <p>{product?.description}</p>
        </IonCardContent>
      </IonCard>
    </IonContent>
  );
}
