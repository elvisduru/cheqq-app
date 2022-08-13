export type JsonObject = { [Key in string]?: JsonValue };

export interface JsonArray extends Array<JsonValue> {}

export type JsonValue =
  | string
  | number
  | boolean
  | JsonObject
  | JsonArray
  | null;

export enum Plan {
  FREE = "FREE",
  PRO = "PRO",
}

export type User = {
  id: number;
  name: string | null;
  email: string;
  emailVerified: boolean;
  active: boolean;
  avatarUrl: string | null;
  passwordUpdatedAt: Date | null;
  plan: Plan;
  stores: {
    id: number;
    name: string;
    tag: string;
    logo: string;
    currency: string;
    address: string;
    addressCoordinates: { lat: number; lng: number };
    country: string;
  }[];
  prefs: JsonObject;
  createdAt: Date;
  updatedAt: Date;
};

export type Store = {
  id?: number;
  ownerId: number;
  name: string;
  tag: string;
  status?: boolean;
  domain?: string | null;
  address: string;
  country: string;
  phone?: string;
  order_email?: string | null;
  language: string;
  currency: string;
  logo: string | null;
  banner: string | null;
  description: string | null;
  categories: number[];
  public?: boolean;
  createdAt?: Date;
  updatedAt?: Date;
};

export type Category = {
  id: number;
  name: string;
  subCategories?: {
    id: number;
    name: string;
    parentCategoryId: number;
  }[];
};

export type Image = {
  id?: number;
  userId?: number;
  productId?: number;
  url: string;
  description?: string;
  sortOrder: number;
  createdAt?: Date;
  updatedAt?: Date;
};

export type ImageWithRequiredId = Image & { id: number };

export type Video = {
  id?: number;
  userId?: number;
  productId?: number;
  url: string;
  description?: string;
  sortOrder: number;
  createdAt?: Date;
  updatedAt?: Date;
};

export type CountryStates = {
  id?: number;
  name: string;
  iso3: string;
  iso2: string;
  numeric_code: string;
  phone_code: string;
  capital: string;
  currency: string;
  currency_name: string;
  currency_symbol: string;
  tld: string;
  native: string;
  region: string;
  subregion: string;
  timezones: [
    {
      zoneName: string;
      gmtOffset: number;
      gmtOffsetName: string;
      abbreviation: string;
      tzName: string;
    }
  ];
  translations: { [x: string]: string };
  latitude: string;
  longitude: string;
  emoji: string;
  emojiU: string;
  states: {
    id: number;
    name: string;
    state_code: string;
    latitude: string;
    longitude: string;
    type: string | null;
  }[];
};

export type Rate = {
  id?: number;
  shippingZoneId: number;
  type: "custom" | "carrier";
  transitTime:
    | "economy"
    | "standard"
    | "express"
    | "economyInternational"
    | "standardInternational"
    | "expressInternational"
    | "custom";
  customRateName: string;
  price: number;
  rateCondition?: "weight" | "price";
  rateConditionMin?: number;
  rateConditionMax?: number;
  carrier?: string; // TODO: Carrier enum
  services?: string[];
  handlingFeePercent?: number;
  handlingFeeFlat?: number;
};

export type ShippingZone = {
  storeId?: number;
  name: string;
  locations: CountryStates[];
  rates: Rate[];
};
