import {
  IonAccordion,
  IonAccordionGroup,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonSearchbar,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { close } from "ionicons/icons";
import locations from "../../assets/json/countries-states.json";

type Props = {
  dismiss: () => void;
};

export default function SelectLocations({ dismiss }: Props) {
  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Select Locations</IonTitle>
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
        <IonSearchbar animated placeholder="Search countries and regions" />
        <IonAccordionGroup>
          {locations.map((location) => (
            <IonAccordion key={location.name} value={location.iso2}>
              <IonItem slot="header">
                <IonLabel>{location.name}</IonLabel>
              </IonItem>
              <IonList slot="content">
                {location.states.map((state) => (
                  <IonItem key={state.id}>
                    <IonLabel>{state.name}</IonLabel>
                  </IonItem>
                ))}
              </IonList>
            </IonAccordion>
          ))}
        </IonAccordionGroup>
      </IonContent>
    </>
  );
}
