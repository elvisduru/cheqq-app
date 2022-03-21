import { linearGradientDef } from "@nivo/core";
import { ResponsiveLine } from "@nivo/line";
import "./LineChart.scss";

type Props = {
  data: any;
};

export default function LineChart({ data }: Props) {
  return (
    <div style={{ height: 220 }}>
      <ResponsiveLine
        data={data}
        margin={{ bottom: 40, top: 20 }}
        colors={["#F51E63"]}
        theme={{
          axis: {
            ticks: {
              text: {
                fill: "rgb(100, 100, 100)",
                fontFamily: "Roboto",
              },
            },
          },
        }}
        xScale={{
          type: "time",
          format: "%Y-%m-%d",
          precision: "day",
          useUTC: false,
        }}
        xFormat="time:%b %d"
        yScale={{
          type: "linear",
        }}
        axisBottom={{
          format: "%b %d",
          tickValues: "every 2 days",
          tickSize: 0,
        }}
        curve="natural"
        enableGridX={false}
        enableGridY={false}
        enablePoints={false}
        enableArea
        defs={[
          linearGradientDef("gradient", [
            { offset: 0, color: "inherit" },
            { offset: 100, color: "inherit", opacity: 0 },
          ]),
        ]}
        fill={[{ match: "*", id: "gradient" }]}
        useMesh={true}
        crosshairType="bottom"
        tooltip={({ point }) => {
          return (
            <div className="tooltip">
              <div className="title text-xs">{point.data.xFormatted}</div>
              <div className="body text-xl font-medium">
                ${parseFloat(point.data.yFormatted as string).toFixed(2)}
              </div>
            </div>
          );
        }}
      />
    </div>
  );
}
