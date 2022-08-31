import {
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonImg,
  IonThumbnail,
} from "@ionic/react";
import React from "react";
import { useFormContext } from "react-hook-form";
import { ProductInput } from "../../../../utils/types";
import Step from "../Step";

type Props = {};

export default function Preview({}: Props) {
  const { getValues } = useFormContext<ProductInput>();
  const product = getValues();
  console.log(product);
  return (
    <Step noXPadding>
      <IonCard>
        <IonThumbnail className="w-full h-96">
          <IonImg className="" src={product?.images?.[0].url} />
        </IonThumbnail>
        <IonCardHeader>
          <IonCardSubtitle>{product?.title}</IonCardSubtitle>
          <IonCardTitle>${product.price}</IonCardTitle>
        </IonCardHeader>
        <IonCardContent>
          <p>{product?.description}</p>
        </IonCardContent>
      </IonCard>
    </Step>
  );
}
