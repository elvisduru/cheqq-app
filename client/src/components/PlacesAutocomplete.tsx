import { IonInput, IonItem, IonLabel, IonList, IonNote } from "@ionic/react";
import { useRef } from "react";
import usePlacesAutocomplete from "use-places-autocomplete";
import useOnClickOutside from "../hooks/useOnClickOutside";
import useScript from "../hooks/useScript";

type Props = {
  onChange: (value: any) => void;
  onBlur: () => void;
  value: any;
  error?: string;
};

// BUG: Suggestions rendering twice after selection

export default function PlacesAutocomplete({
  onChange,
  onBlur,
  value: formValue,
  error,
}: Props) {
  const {
    ready,
    value,
    suggestions: { status, data },
    setValue,
    clearSuggestions,
  } = usePlacesAutocomplete({
    callbackName: "initMap",
    defaultValue: formValue,
  });

  const scriptStatus = useScript(
    `https://maps.googleapis.com/maps/api/js?key=${process.env.REACT_APP_MAPS_API_KEY}&libraries=places&callback=initMap`
  );

  const ref = useRef<HTMLIonListElement>(null);

  useOnClickOutside(ref, clearSuggestions);

  return scriptStatus !== "ready" ? (
    <IonItem
      className={`input mt-4 ${error ? "ion-invalid" : ""}`}
      fill="outline"
      mode="md"
    >
      <IonLabel position="floating">Address</IonLabel>
      <IonInput
        type="text"
        value={value}
        onIonChange={(e) => {
          setValue(e.detail.value!);
        }}
        onIonBlur={onBlur}
        disabled={!ready}
      />
      <IonNote slot="error">{error}</IonNote>
    </IonItem>
  ) : (
    <div>
      <IonItem
        className={`input mt-4 ${error ? "ion-invalid" : ""}`}
        fill="outline"
        mode="md"
      >
        <IonLabel position="floating">Address</IonLabel>
        <IonInput
          type="text"
          value={value}
          onIonChange={(e) => {
            setValue(e.detail.value!);
          }}
          onIonBlur={onBlur}
          disabled={!ready}
        />
        <IonNote slot="error">{error}</IonNote>
      </IonItem>
      <IonList ref={ref}>
        {status === "OK" &&
          data.map(({ place_id, description }) => (
            <IonItem
              onClick={() => {
                setValue(description, false);
                onChange(description);
                clearSuggestions();
              }}
              button
              detail={false}
              key={place_id}
            >
              {description}
            </IonItem>
          ))}
      </IonList>
    </div>
  );
}
