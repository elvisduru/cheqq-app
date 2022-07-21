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
import { UseFormSetValue } from "react-hook-form";
import { Virtuoso } from "react-virtuoso";
import useCountries from "../../hooks/queries/useCountries";
import { CountryStates } from "../../utils/types";
import { LocationFormData } from "./AddShippingZone";

polyfillCountryFlagEmojis();

type Props = {
  dismiss: () => void;
  setValue: UseFormSetValue<LocationFormData>;
  locations?: CountryStates[];
};

export default function SelectLocations({
  dismiss,
  setValue,
  locations: initialLocations,
}: Props) {
  const { data: locations, isLoading, isError } = useCountries();
  const [selectedLocations, setSelectedLocations] = useState<CountryStates[]>(
    initialLocations || []
  );
  const [searchString, setSearchString] = useState("");
  const [filtered, setFiltered] = useState<boolean>(false);

  const accordionGroup = useRef<null | HTMLIonAccordionGroupElement>(null);

  const handleSelection = useCallback(
    (location: CountryStates, state?: CountryStates["states"][0]) => {
      const index = selectedLocations.findIndex(
        (loc) => loc.iso2 === location.iso2
      );
      if (state) {
        if (index === -1) {
          setSelectedLocations((prev) => [
            ...prev,
            { ...location, states: [state] },
          ]);
        } else {
          // check if state is already selected and remove it
          const foundState = selectedLocations[index].states.find(
            (s) => s.id === state.id
          );
          if (foundState) {
            setSelectedLocations((prev) => {
              const newLocations = [...prev];
              newLocations[index].states = newLocations[index].states.filter(
                (s) => s.id !== state.id
              );
              // if no states left, remove country
              if (newLocations[index].states.length === 0) {
                newLocations.splice(index, 1);
              }
              return newLocations;
            });
          } else {
            setSelectedLocations((prev) => {
              const newLocations = [...prev];
              const oldStates = newLocations[index].states;
              newLocations[index].states = [...oldStates, state];
              return newLocations;
            });
          }
        }
      } else {
        if (index > -1) {
          setSelectedLocations(selectedLocations.filter((_, i) => i !== index));
        } else {
          setSelectedLocations([...selectedLocations, location]);
        }
      }
    },
    [selectedLocations, locations]
  );

  useEffect(() => {
    if (locations) {
      // get all checkboxes with the class accordion-checkbox
      const checkboxes = document.querySelectorAll(".accordion-checkbox");
      const handlePropagation = (e: Event) => {
        e.stopPropagation();
        // fetch locations for the selected country
        const location = locations.find(
          (loc) => loc.iso2 === (e.target as HTMLInputElement).value
        );
        handleSelection(location!);
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
    }
  }, [handleSelection, locations]);

  useEffect(() => {
    if (!selectedLocations.length) {
      setFiltered(false);
    }
  }, [selectedLocations.length]);

  useEffect(() => {
    if (initialLocations) {
      setFiltered(true);
    }
  }, [initialLocations]);

  const filteredLocations = useMemo(() => {
    if (filtered) {
      return selectedLocations;
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
          {selectedLocations.length ? (
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
                &nbsp;{" "}
                <IonText color={filtered ? "primary" : ""}>Filter</IonText>
              </IonButton>
            </IonButtons>
          ) : null}
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
                      handleSelection(location);
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

                      {location.states.length ? (
                        <span className="ml-auto text-gray-500">
                          {selectedLocations.find(
                            (loc) => loc.iso2 === location.iso2
                          )?.states.length ?? 0}{" "}
                          of {location.states.length}
                        </span>
                      ) : null}
                    </div>
                  </IonLabel>
                </IonItem>
                <IonList slot="content">
                  {location.states.map((state) => (
                    <IonItem key={state.id}>
                      <IonCheckbox
                        onClick={() => {
                          handleSelection(location, state);
                        }}
                        checked={selectedLocations.some((loc) =>
                          loc.states.some((s) => s.id === state.id)
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
            onClick={() => {
              setValue("locations", selectedLocations);
              dismiss();
            }}
          >
            Continue
          </IonButton>
        </div>
      </IonContent>
    </>
  );
}
