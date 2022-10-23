import { IonCard, IonCardContent, IonCol, IonIcon } from "@ionic/react";
import { imagesOutline } from "ionicons/icons";
import { Product } from "../../utils/types";

export default function ProductCard(product: Product) {
  return (
    <IonCol size="6" sizeLg="3" sizeMd="4" key={product.id}>
      <IonCard
        key={product.id}
        className="mt-2 mx-0"
        button
        routerLink={`/products/${product.id}`}
      >
        {product.images?.length ? (
          <img
            src={product.images?.[0]?.url}
            className="aspect-square object-cover object-center"
          />
        ) : (
          <div className="flex items-center justify-center px-2 text-white aspect-square bg-gradient-to-r from-primary to-purple-600">
            <IonIcon icon={imagesOutline} className="text-4xl mr-2" />
            <p>
              No image <br /> uploaded
            </p>
          </div>
        )}
        <IonCardContent className="p-3">
          <p className="text-xs font-medium">{product.title}</p>
          <div>
            <span></span>
          </div>
        </IonCardContent>
      </IonCard>
    </IonCol>
  );
}
