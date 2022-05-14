import {
  IonBackButton,
  IonButton,
  IonButtons,
  IonCol,
  IonContent,
  IonGrid,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonPage,
  IonRow,
  IonThumbnail,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import {
  barbellOutline,
  carOutline,
  colorPaletteOutline,
  desktopOutline,
  fastFoodOutline,
  flaskOutline,
  gameControllerOutline,
  homeOutline,
  libraryOutline,
  medicalOutline,
  pawOutline,
  planetOutline,
  shirtOutline,
  sparklesOutline,
} from "ionicons/icons";
import { useEffect, useState } from "react";
import { CircularProgressbar } from "react-circular-progressbar";
import "react-circular-progressbar/dist/styles.css";
import { useFormContext } from "react-hook-form";
import { RouteComponentProps } from "react-router";
import "./categories.scss";

type Props = {
  progress: number;
  setProgress: (progress: number) => void;
} & RouteComponentProps;

export default function Categories({ progress, setProgress }: Props) {
  const [selected, setSelected] = useState<string>("");
  const { setValue, watch } = useFormContext();

  useEffect(() => {
    const sub = watch((data) => {
      setSelected(data.category);
    });

    return () => {
      sub.unsubscribe();
    };

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const storeCategories = [
    {
      name: "Fashion",
      icon: shirtOutline,
    },
    {
      name: "Food & Grocery",
      icon: fastFoodOutline,
    },
    {
      name: "Electronics",
      icon: desktopOutline,
    },
    {
      name: "Health & Beauty",
      icon: medicalOutline,
    },
    {
      name: "Home & Office",
      icon: homeOutline,
    },
    {
      name: "Collectibles & Art",
      icon: colorPaletteOutline,
    },
    {
      name: "Sports & Outdoors",
      icon: barbellOutline,
    },
    {
      name: "Books, Movies & Music",
      icon: libraryOutline,
    },
    {
      name: "Toys & Games",
      icon: gameControllerOutline,
    },
    {
      name: "Baby Essentials",
      icon: planetOutline,
    },
    {
      name: "Scientific & Industrial",
      icon: flaskOutline,
    },
    {
      name: "Automotive",
      icon: carOutline,
    },
    {
      name: "Pet Supplies",
      icon: pawOutline,
    },
    {
      name: "Others",
      icon: sparklesOutline,
    },
  ];
  return (
    <IonPage id="store-new-categories">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton />
          </IonButtons>
          <IonTitle>Create your store</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Create your store</IonTitle>
          </IonToolbar>
        </IonHeader>
        <IonItem lines="none">
          <div slot="start">
            <CircularProgressbar
              value={progress}
              maxValue={2}
              text={`${progress}/2`}
            />
          </div>
          <IonLabel>
            <h2>Select store category</h2>
            <p>Start by choosing a category for your store</p>
          </IonLabel>
        </IonItem>

        <div className="ion-padding mb-3">
          <IonGrid>
            <IonRow className="ion-text-center">
              {storeCategories.map((category) => (
                <IonCol
                  size="4"
                  sizeMd="3"
                  sizeLg="2"
                  key={category.name}
                  onClick={() => setValue("category", category.name)}
                >
                  <div
                    className={`flex flex-column ion-align-items-center border-light ion-padding rounded-lg h-full ${
                      selected === category.name ? "selected" : ""
                    }`}
                  >
                    <IonThumbnail>
                      <IonIcon size="large" icon={category.icon} />
                    </IonThumbnail>
                    <IonLabel className="text-sm">{category.name}</IonLabel>
                  </div>
                </IonCol>
              ))}
            </IonRow>
          </IonGrid>
        </div>
        <div slot="fixed" className="bottom-0 ion-padding-horizontal w-full">
          <IonButton
            expand="block"
            routerLink="/store/new/details"
            onClick={() => setProgress(2)}
            hidden={!selected}
            className="bottom-0 w-full"
          >
            Continue
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
