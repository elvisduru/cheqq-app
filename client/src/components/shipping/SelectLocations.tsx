import {
  IonAccordion,
  IonAccordionGroup,
  IonButton,
  IonButtons,
  IonCheckbox,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonLoading,
  IonSearchbar,
  IonText,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import { polyfillCountryFlagEmojis } from "country-flag-emoji-polyfill";
import { close, filter } from "ionicons/icons";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { Virtuoso } from "react-virtuoso";
import useCountries from "../../hooks/queries/useCountries";

polyfillCountryFlagEmojis();

type Props = {
  dismiss: () => void;
};

type SelectedLocation = {
  type: string;
  iso2?: string;
  name?: string;
  stateId?: number;
};

export default function SelectLocations({ dismiss }: Props) {
  const { data: locations, isLoading, isError } = useCountries();
  const [selectedLocations, setSelectedLocations] = useState<
    SelectedLocation[]
  >([]);
  const [searchString, setSearchString] = useState("");
  const [filtered, setFiltered] = useState<boolean>(false);

  const accordionGroup = useRef<null | HTMLIonAccordionGroupElement>(null);

  useEffect(() => {
    // get all checkboxes with the class accordion-checkbox
    const checkboxes = document.querySelectorAll(".accordion-checkbox");
    const handlePropagation = (e: Event) => {
      e.stopPropagation();
      console.log("checkbox clicked");
      handleSelection((e.target as HTMLInputElement).value, "country");
    };
    // loop through all checkboxes and add the event listener
    checkboxes.forEach((checkbox) => {
      checkbox.addEventListener("click", handlePropagation);
    });
    return () => {
      checkboxes.forEach((checkbox) => {
        checkbox.removeEventListener("click", handlePropagation);
      });
    };
  });

  const filteredLocations = useMemo(() => {
    if (filtered) {
      return locations
        ?.filter((location) => {
          //return selected locations
          return selectedLocations.some(
            (selectedLocation) =>
              selectedLocation.iso2 === location.iso2 ||
              location.states.some(
                (state) =>
                  selectedLocation.name === state.name &&
                  selectedLocation.stateId === state.id
              )
          );
        })
        .map((location) => {
          const filteredStates = location.states.filter((state) =>
            selectedLocations.some(
              (selectedLocation) =>
                selectedLocation.name === state.name &&
                selectedLocation.stateId === state.id
            )
          );
          return {
            ...location,
            states: filteredStates.length ? filteredStates : location.states,
          };
        });
    }
    const toggleAccordion = (value: string) => {
      if (!accordionGroup.current) return;
      if (accordionGroup.current.value === value) {
        accordionGroup.current.value = undefined;
      } else {
        accordionGroup.current.value = value;
      }
    };

    return locations
      ?.filter((location) => {
        const isInCountry = location.name
          .toLowerCase()
          .includes(searchString.toLowerCase());
        const isInStates = location.states.some((state) =>
          state.name.toLowerCase().includes(searchString.toLowerCase())
        );
        if (isInStates) {
          toggleAccordion(location.iso2);
        }
        return isInCountry || isInStates;
      })
      .map((location) => {
        // return location and filtered states
        const filteredStates = location.states.filter((state) =>
          state.name.toLowerCase().includes(searchString.toLowerCase())
        );
        return {
          ...location,
          states: filteredStates.length ? filteredStates : location.states,
        };
      });
  }, [searchString, filtered]);

  const handleSelection = useCallback(
    (selected: string, type: string = "state", stateId?: number) => {
      if (type === "country") {
        // check if country is already selected and remove it
        const index = selectedLocations.findIndex(
          (location) =>
            location.iso2 === selected && location.type === "country"
        );
        if (index > -1) {
          setSelectedLocations(
            selectedLocations.filter((loc) => loc.iso2 !== selected)
          );
        } else {
          const states =
            locations
              ?.find((location) => location.iso2 === selected)
              ?.states.map((state) => {
                return {
                  type: "state",
                  iso2: selected,
                  name: state.name,
                  stateId: state.id,
                };
              })
              .filter((state) => {
                return !selectedLocations.some(
                  (loc) =>
                    loc.name === state.name && loc.stateId === state.stateId
                );
              }) ?? [];

          setSelectedLocations([
            ...selectedLocations,
            ...states!,
            { type: "country", iso2: selected },
          ]);
        }
      } else {
        // check if state is already selected and remove it
        const index = selectedLocations.findIndex(
          (location) => location.name === selected
        );
        if (index > -1) {
          setSelectedLocations(selectedLocations.filter((_, i) => i !== index));
        } else {
          setSelectedLocations([
            ...selectedLocations,
            { type: "state", name: selected, stateId },
          ]);
        }
      }
    },
    [selectedLocations]
  );

  if (isLoading) {
    return <IonLoading isOpen={true} translucent />;
  }
  if (isError) {
    // TODO: Build error page
    return <p>Error fetching data</p>;
  }
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
          <IonButtons slot="end">
            <IonButton
              color="dark"
              onClick={() => {
                setFiltered(!filtered);
              }}
            >
              <IonIcon
                slot="icon-only"
                color={filtered ? "primary" : ""}
                icon={filter}
              />{" "}
              &nbsp; <IonText color={filtered ? "primary" : ""}>Filter</IonText>
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding-vertical">
        <IonSearchbar
          slot="fixed"
          className="backdrop-filter backdrop-blur-lg bg-opacity-30"
          animated
          placeholder="Search countries and regions"
          onIonChange={(e) => setSearchString(e.detail.value!)}
        />
        <IonAccordionGroup
          animated={false}
          ref={accordionGroup}
          className="h-full pt-10 pb-16"
        >
          <Virtuoso
            style={{ height: "100%" }}
            data={filteredLocations || locations}
            itemContent={(index, location) => (
              <IonAccordion key={location.name} value={location.iso2}>
                <IonItem className="accordion-header" slot="header">
                  <IonCheckbox
                    slot="start"
                    className="accordion-checkbox mr-3"
                    onClick={() => {
                      handleSelection(location.iso2, "country");
                    }}
                    checked={selectedLocations.some(
                      (loc) => loc.iso2 === location.iso2
                    )}
                    value={location.iso2}
                  />
                  <IonLabel>
                    <div className="flex items-center">
                      <span className="font-sans mr-2">{location.emoji}</span>
                      <span>{location.name}</span>
                    </div>
                  </IonLabel>
                </IonItem>
                <IonList slot="content">
                  {location.states.map((state) => (
                    <IonItem key={state.id}>
                      <IonCheckbox
                        onClick={() => {
                          handleSelection(state.name, "state", state.id);
                        }}
                        checked={selectedLocations.some(
                          (loc) =>
                            loc.name === state.name && loc.stateId === state.id
                        )}
                        slot="start"
                        className="mr-3"
                      />
                      <IonLabel>{state.name}</IonLabel>
                    </IonItem>
                  ))}
                </IonList>
              </IonAccordion>
            )}
          />
        </IonAccordionGroup>
        <div
          slot="fixed"
          className="bottom-0 w-full ion-padding-horizontal ion-padding-bottom"
        >
          <IonButton
            disabled={selectedLocations.length === 0}
            expand="block"
            className="drop-shadow"
          >
            Continue ({selectedLocations.length} selected)
          </IonButton>
        </div>
      </IonContent>
    </>
  );
}
