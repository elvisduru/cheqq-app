import { IonCard, IonCardContent, IonCol, IonIcon } from "@ionic/react";
import { imagesOutline, pricetag, star } from "ionicons/icons";
import { useMemo } from "react";
import { Product } from "../../utils/types";

export default function ProductCard(product: Product) {
  // Collect all product and variant prices and compareAtPrices in an array and sort them
  const pricesArr = useMemo(() => {
    const variantPricesArr =
      product.variants?.map((v) => v.price!).filter((v) => v !== undefined) ||
      [];
    const productPriceArr = product.price ? [product.price] : [];
    return [
      ...new Set(
        [...variantPricesArr, ...productPriceArr].sort((a, b) => a - b)
      ),
    ];
  }, [product]);

  return (
    <IonCol size="6" sizeLg="3" sizeMd="4" key={product.id}>
      <IonCard
        key={product.id}
        className="m-0 card-product bg-transparent"
        button
        routerLink={`/products/${product.id}`}
      >
        {product.images?.length ? (
          <img
            src={product.images?.find((i) => i.sortOrder === 0)?.url}
            className="aspect-square object-cover object-center w-full rounded-b-lg"
          />
        ) : (
          <div className="flex rounded-b-lg w-full items-center justify-center px-2 text-white aspect-square bg-gradient-to-r from-primary to-purple-600">
            <IonIcon icon={imagesOutline} className="text-4xl mr-2" />
            <p>
              No image <br /> uploaded
            </p>
          </div>
        )}
        <IonCardContent className="py-3 px-1 text-xs font-medium bg-black">
          <p className="line-clamp-1">{product.title}</p>
          <div>
            {product.store?.country?.currency_symbol}
            {pricesArr[0]}{" "}
            {pricesArr.length > 1 && <>- {pricesArr[pricesArr.length - 1]}</>}
          </div>
          <div className="flex items-center">
            <IonIcon icon={star} className="text-[#EE8937]" />
            <span className="mb-0 ml-1">(4.5)</span> &nbsp;
            <span>123 sold</span>
          </div>
        </IonCardContent>
      </IonCard>
    </IonCol>
  );
}
