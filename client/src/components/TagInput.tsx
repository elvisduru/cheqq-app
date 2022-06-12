import {
  IonChip,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonNote,
} from "@ionic/react";
import { closeCircle } from "ionicons/icons";
import { useEffect, useState } from "react";
import { FieldValues, UseFormSetValue } from "react-hook-form";

type Props = {
  setValue: UseFormSetValue<FieldValues>;
  value: string[];
};

export default function TagInput({ setValue, value }: Props) {
  const [tags, setTags] = useState<string[]>(value || []);

  useEffect(() => {
    setValue("tags", tags);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [tags]);

  const onChange = (e: any) => {
    if (tags.length === 20) return;
    const value = e.target.value;
    if (value.length > 0) {
      // check if the last character is a comma
      if (value[value.length - 1] === ",") {
        // check if tag already exists
        if (tags.indexOf(value.slice(0, -1)) === -1) {
          setTags([...tags, value.slice(0, -1)]);
        }
        e.target.value = "";
      }
    }
  };

  const handleKeyDown = (e: any) => {
    if (e.key === "Backspace" && e.target.value.length === 0) {
      setTags(tags.slice(0, -1));
    }

    if (e.key === "Enter") {
      const value = e.target.value;
      if (value.length > 0) {
        if (tags.indexOf(value) === -1) {
          setTags([...tags, value]);
        }
        e.target.value = "";
      }
    }
  };

  return (
    <IonItem
      className={`input tags mt-1 ${tags.length ? "item-has-value" : ""}`}
      fill="outline"
      mode="md"
    >
      <IonLabel position="floating">Product Tags</IonLabel>
      <div className="w-full">
        {tags.map((tag: string, index: number) => (
          <IonChip
            key={index}
            onClick={() => {
              setTags(tags.filter((t: string) => t !== tag));
            }}
          >
            <IonLabel>{tag}</IonLabel>
            <IonIcon icon={closeCircle} />
          </IonChip>
        ))}
      </div>
      <IonInput type="text" onIonChange={onChange} onKeyDown={handleKeyDown} />
      <IonNote slot="helper">
        Optional. Enter tags separated by commas. Limit 20.
      </IonNote>
    </IonItem>
  );
}
