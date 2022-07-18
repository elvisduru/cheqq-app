import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonLoading,
  IonText,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import React from "react";
import useCategories from "../hooks/queries/categories/useCategories";
import { categoryIcons } from "../utils";

type Props = {
  dismiss: () => void;
  handleSelect: (item: number, name: string) => void;
};

export default function ChooseCategory({ dismiss, handleSelect }: Props) {
  const { data: categories, isLoading } = useCategories({
    subCategories: true,
  });

  if (isLoading) {
    return <IonLoading isOpen={true} translucent />;
  }

  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Choose Category</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismiss();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding-vertical">
        <IonList className="bg-transparent" lines="none">
          {categories?.map(({ id, name, subCategories }) => (
            <React.Fragment key={id}>
              <IonItem>
                <div
                  className="rounded-full bg-light flex items-center ion-justify-content-center"
                  style={{
                    padding: "0.5rem",
                    fontSize: 25,
                    width: 45,
                    height: 45,
                  }}
                  slot="start"
                >
                  <IonIcon icon={categoryIcons[name]} />
                </div>
                <IonLabel>
                  <IonText className="font-medium">{name}</IonText>
                </IonLabel>
              </IonItem>
              {subCategories?.map(({ id, name }) => (
                <IonItem
                  onClick={() => {
                    handleSelect(id, name);
                  }}
                  key={id}
                >
                  <div
                    slot="start"
                    style={{
                      padding: "0.5rem",
                      fontSize: 25,
                      width: 45,
                      height: 45,
                    }}
                  ></div>
                  <IonLabel>
                    <IonText>{name}</IonText>
                  </IonLabel>
                </IonItem>
              ))}
            </React.Fragment>
          ))}
        </IonList>
      </IonContent>
    </>
  );
}
