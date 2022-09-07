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
import { useEffect, useState } from "react";
import { CircularProgressbar } from "react-circular-progressbar";
import "react-circular-progressbar/dist/styles.css";
import { useFormContext } from "react-hook-form";
import useCategories from "../../hooks/queries/categories/useCategories";
import { categoryIcons } from "../../utils";
import "./categories.scss";

type Props = {
  progress: number;
  setProgress: (progress: number) => void;
};

export default function Categories({ progress, setProgress }: Props) {
  const { data: categories, isLoading } = useCategories({ root: true });
  const [selected, setSelected] = useState<number[]>([]);
  const { setValue } = useFormContext();

  useEffect(() => {
    setValue("categories", selected);
  }, [selected, setValue]);

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
            <h2>Select store categories</h2>
            <p>Start by selecting categories for your store</p>
          </IonLabel>
        </IonItem>

        <div className="ion-padding mb-12">
          <IonGrid>
            <IonRow className="ion-text-center">
              {categories?.map(({ id, name }) => (
                <IonCol
                  size="4"
                  sizeMd="3"
                  sizeLg="2"
                  key={id}
                  onClick={() =>
                    setSelected(
                      selected?.includes(id)
                        ? selected.filter((item) => item !== id)
                        : [...selected, id]
                    )
                  }
                >
                  <div
                    className={`flex flex-col items-center border border-solid border-gray-400 border-opacity-20 ion-padding rounded-lg h-full ${
                      selected?.includes(id) ? "selected" : ""
                    }`}
                  >
                    <IonThumbnail>
                      <IonIcon size="large" icon={categoryIcons[name]} />
                    </IonThumbnail>
                    <IonLabel className="text-sm">{name}</IonLabel>
                  </div>
                </IonCol>
              ))}
            </IonRow>
          </IonGrid>
        </div>
        <div
          slot="fixed"
          className={`${
            selected.length ? "opacity-100" : "opacity-0"
          } transition-opacity backdrop-filter backdrop-blur-lg bg-opacity-30 bottom-0 ion-padding-horizontal pb-4 w-full`}
        >
          <IonButton
            expand="block"
            routerLink="/store/new/details"
            onClick={() => setProgress(2)}
            disabled={!selected.length}
            className="bottom-0 w-full"
          >
            Continue
          </IonButton>
        </div>
      </IonContent>
    </IonPage>
  );
}
