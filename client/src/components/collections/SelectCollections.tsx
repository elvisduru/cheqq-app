import { IonSearchbar } from "@ionic/react";

type Props = {
  handleSelection: (selection: any) => void;
};

export default function SelectCollections({ handleSelection }: Props) {
  return (
    <div>
      <IonSearchbar
        animated
        className="!px-0"
        placeholder="Search Collections"
      />
    </div>
  );
}
