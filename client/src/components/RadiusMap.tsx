import L, { Map } from "leaflet";
import { useEffect } from "react";
import {
  Circle,
  MapContainer,
  Marker,
  Popup,
  TileLayer,
  useMap,
} from "react-leaflet";
import locationIcon from "../assets/images/location-sharp.svg";

type Props = {
  addressCoordinates: { lat: number; lng: number };
  radius: number;
};

const setMap = (map: Map) => {
  const resizeObserver = new ResizeObserver(() => {
    map.invalidateSize();
  });
  const container = document.getElementById("map-container");
  resizeObserver.observe(container!);
};

type MapProps = {
  radius: number;
};

const MapComponent = ({ radius }: MapProps) => {
  const map = useMap();
  useEffect(() => {
    setMap(map);
  }, []);

  useEffect(() => {
    map.eachLayer((layer) => {
      // check for circle layer
      if (layer instanceof L.Circle) {
        map.fitBounds(layer.getBounds());
      }
    });
  }, [radius]);
  return null;
};

export default function RadiusMap({ addressCoordinates, radius }: Props) {
  const markerIcon = new L.Icon({
    iconUrl: locationIcon,
    iconRetinaUrl: locationIcon,
    iconSize: [30.6, 43],
  });

  return addressCoordinates ? (
    <MapContainer
      center={[addressCoordinates.lat, addressCoordinates.lng]}
      zoom={13}
      scrollWheelZoom={false}
      className="h-80"
      id="map-container"
    >
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png"
      />
      <Circle
        center={[addressCoordinates.lat, addressCoordinates.lng]}
        radius={radius}
        pathOptions={{ fillColor: "#FE0E7E", color: "#FE0E7E" }}
      />
      <Marker
        icon={markerIcon}
        position={[addressCoordinates.lat, addressCoordinates.lng]}
      >
        <Popup closeButton={false}>
          <div className="text-center">
            <span className="font-bold">Your store's location</span> <br />
            <span>Lorem uip</span>
          </div>
        </Popup>
      </Marker>
      <MapComponent radius={radius} />
    </MapContainer>
  ) : null;
}
