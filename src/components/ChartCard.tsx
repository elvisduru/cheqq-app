import {
  IonButton,
  IonCard,
  IonCardHeader,
  IonContent,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonNote,
  IonPopover,
} from "@ionic/react";
import { ellipsisVerticalSharp } from "ionicons/icons";
import { useState } from "react";
import salesData from "../db/sales.json";
import LineChart from "./LineChart";

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
  const [selected, setSelected] = useState<string | undefined>(TimeFrame.Week);
  return (
    <IonCard>
      <IonCardHeader>
        <div className="flex">
          <div className="mt-0 mb-0 text-white flex ion-justify-content-between ion-align-items-end grow">
            <div>
              <IonNote className="ion-text-capitalize">
                {selected === "today" || selected === "yesterday"
                  ? selected
                  : "this " + selected}
              </IonNote>
              <h3 className="my-0 text-xl">{title}</h3>
            </div>
            <span className="text-2xl font-bold mr-1">
              $
              {salesData[0].data
                .reduce((acc, curr) => acc + curr.y, 0)
                .toFixed(2)}
            </span>
          </div>
          <IonButton size="small" fill="default" id="chart-more">
            <IonIcon slot="icon-only" icon={ellipsisVerticalSharp} />
          </IonButton>
          <IonPopover translucent trigger="chart-more">
            <IonList lines="none">
              <IonItem button detail={false}>
                Today
              </IonItem>
              <IonItem button detail={false}>
                Yesterday
              </IonItem>
              <IonItem button detail={false}>
                This Week
              </IonItem>
              <IonItem button detail={false}>
                Last 30 Days
              </IonItem>
            </IonList>
          </IonPopover>
        </div>
      </IonCardHeader>
      <LineChart data={salesData} />
    </IonCard>
  );
}
