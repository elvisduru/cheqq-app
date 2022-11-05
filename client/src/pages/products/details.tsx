import {
  IonBackButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  useIonActionSheet,
  useIonAlert,
  useIonModal,
  useIonRouter,
  useIonViewWillEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import React from "react";
import { useStore } from "../../hooks/useStore";
import { User } from "../../utils/types";
import ProductDetailsComponent from "../../components/products/details";
import { RouteComponentProps, useParams } from "react-router";
import useProduct from "../../hooks/queries/products/useProduct";
import NewProduct from "../../components/products/new";
import useCanDismiss from "../../hooks/useCanDismiss";
import { Browser } from "@capacitor/browser";
import { Clipboard } from "@capacitor/clipboard";
import { Share } from "@capacitor/share";
import useDeleteProduct from "../../hooks/mutations/products/deleteProduct";

type Props = {
  user: User;
};

const ProductDetails: React.FC<Props> = ({ user }) => {
  const setPhysicalFormData = useStore((state) => state.setPhysicalFormData);
  const setPhysicalModalState = useStore(
    (state) => state.setPhysicalModalState
  );
  const toggleHideTabBar = useStore((store) => store.toggleHideTabBar);
  const router = useIonRouter();
  const { id } = useParams<{ id: string }>();

  const { data: product } = useProduct(parseInt(id));

  const deleteProduct = useDeleteProduct();

  const [presentSheet] = useIonActionSheet();
  const [presentAlert] = useIonAlert();

  const [present, dismiss] = useIonModal(NewProduct, {
    productType: product?.type,
    dismiss: () => {
      dismiss();
    },
  });

  const canDismiss = useCanDismiss(product?.type, true);

  useIonViewWillEnter(() => {
    toggleHideTabBar(true);
  });

  useIonViewWillLeave(() => {
    toggleHideTabBar(false);
  });

  return (
    <IonPage id="product-details">
      {!product ? (
        <p>Loading</p>
      ) : (
        <ProductDetailsComponent
          goBack={router.goBack}
          product={product}
          buttonHandler={() =>
            presentSheet({
              translucent: true,
              buttons: [
                {
                  text: "Delete product",
                  role: "destructive",
                  handler() {
                    presentAlert({
                      header: "Alert!",
                      message: "Are you sure you want to delete this product?",
                      buttons: [
                        {
                          text: "Cancel",
                          role: "cancel",
                        },
                        {
                          text: "Delete",
                          role: "confirm",
                          handler: () => {
                            deleteProduct.mutate(product.id!, {
                              onSuccess: () => {
                                router.goBack();
                              },
                            });
                          },
                        },
                      ],
                    });
                  },
                },
                {
                  text: "Edit product",
                  handler() {
                    setPhysicalFormData(product);
                    present({
                      canDismiss,
                      id: "physical-product-form",
                      onDidDismiss() {
                        setPhysicalModalState(undefined);
                      },
                    });
                  },
                },
                {
                  text: "View in browser",
                  async handler() {
                    await Browser.open({
                      url: `${import.meta.env.VITE_SITE_URL}/${
                        product.store?.tag
                      }/${product.slug}`,
                    });
                  },
                },
                {
                  text: "Copy link",
                  async handler() {
                    await Clipboard.write({
                      url: `${import.meta.env.VITE_SITE_URL}/${
                        product.store?.tag
                      }/${product.slug}`,
                    });
                  },
                },
                {
                  text: "Share",
                  async handler() {
                    await Share.share({
                      title: product.title,
                      text: "Really awesome thing you need to see right meow",
                      url: `${import.meta.env.VITE_SITE_URL}/${
                        product.store?.tag
                      }/${product.slug}`,
                      dialogTitle: "Share with buddies",
                    });
                  },
                },
                {
                  text: "Cancel",
                  role: "cancel",
                },
              ],
            })
          }
        />
      )}
    </IonPage>
  );
};

export default ProductDetails;
