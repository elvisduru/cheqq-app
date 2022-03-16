import {
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonLabel,
  IonSegment,
  IonSegmentButton,
} from "@ionic/react";
import React, { useState } from "react";

type Props = {
  title: string;
};

enum TimeFrame {
  Today = "today",
  Yesterday = "yesterday",
  Week = "week",
  Month = "month",
}

export default function GraphCard({ title }: Props) {
  const [selected, setSelected] = useState<string | undefined>(TimeFrame.Today);
  return (
    <IonCard>
      <IonCardHeader>
        <IonCardTitle className="text-xl font-thin">{title}</IonCardTitle>
        <IonCardSubtitle>
          Sales{" "}
          {selected === "today" || selected === "yesterday"
            ? selected
            : "this " + selected}
        </IonCardSubtitle>
      </IonCardHeader>
      <IonCardContent>
        <IonSegment
          onIonChange={(e) => setSelected(e.detail.value)}
          value={selected}
        >
          <IonSegmentButton value={TimeFrame.Today}>
            <IonLabel>Today</IonLabel>
          </IonSegmentButton>
          <IonSegmentButton value={TimeFrame.Yesterday}>
            <IonLabel>Yesterday</IonLabel>
          </IonSegmentButton>
          <IonSegmentButton value={TimeFrame.Week}>
            <IonLabel>Week</IonLabel>
          </IonSegmentButton>
          <IonSegmentButton value={TimeFrame.Month}>
            <IonLabel>Month</IonLabel>
          </IonSegmentButton>
        </IonSegment>
      </IonCardContent>
    </IonCard>
  );
}
