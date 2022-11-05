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
import { useStore } from "../hooks/useStore";

type Props = {
  label: string;
  note?: string;
  onChange: (value: string[]) => void;
  onBlur: () => void;
  value: any;
};

export default function TagInput({
  label,
  note,
  value,
  onBlur,
  onChange,
}: Props) {
  const [tags, setTags] = useState<string[]>(value || []);
  const physicalFormData = useStore((state) => state.physicalFormData);
  useEffect(() => {
    onChange(tags);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [tags.length]);

  useEffect(() => {
    if (!physicalFormData) {
      setTags([]);
    }
  }, [physicalFormData]);

  const handleChange = (e: any) => {
    if (tags.length === 20) return;
    const value = e.target.value.trim();
    if (value.length > 1) {
      // Prevent tag from starting with ","
      if (value.startsWith(",")) return;
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
    // prevent hyphen from being entered
    if (e.key === "-") {
      e.preventDefault();
    }

    if (e.key === "Backspace" && e.target.value.length === 0) {
      setTags(tags.slice(0, -1));
    }

    if (e.key === "Enter") {
      const value = e.target.value.trim();
      if (value.startsWith(",")) return;
      if (value.length >= 1) {
        if (tags.indexOf(value) === -1) {
          setTags([...tags, value]);
        }
        e.target.value = "";
      }
    }
  };

  return (
    <IonItem
      className={`input tags mt-4 ${tags.length ? "item-has-value" : ""}`}
      fill="outline"
      mode="md"
    >
      <IonLabel position="floating">{label}</IonLabel>
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
      <IonInput
        type="text"
        enterkeyhint="enter"
        onIonChange={handleChange}
        onKeyDown={handleKeyDown}
        onIonBlur={onBlur}
      />
      <IonNote slot="helper">{note}</IonNote>
    </IonItem>
  );
}
