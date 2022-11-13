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
    countryId: number;
    country: Country;
    processingTime: string;
    localPickup: boolean;
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
  countryId: number;
  country?: Country;
  phone?: string;
  order_email?: string | null;
  processingTime?: string;
  localPickup?: boolean;
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
  country?: {
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
  };
  states: {
    id: number;
    name: string;
    state_code: string;
    latitude: string;
    longitude: string;
    type: string | null;
  }[];
};

export type Country = {
  id: number;
  name: string;
  iso3: string | null;
  numeric_code: string | null;
  iso2: string | null;
  phone_code: string | null;
  capital: string | null;
  currency: string | null;
  currency_name: string | null;
  currency_symbol: string | null;
  tld: string | null;
  native: string | null;
  region: string | null;
  subregion: string | null;
  timezones: [
    {
      zoneName: string;
      gmtOffset: number;
      gmtOffsetName: string;
      abbreviation: string;
      tzName: string;
    }
  ];
  translations: { [x: string]: string } | null;
  latitude: number | null;
  longitude: number | null;
  emoji: string | null;
  emojiU: string | null;
};

export type Rate = {
  id?: number;
  shippingZoneId?: number;
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
  id?: number;
  storeId?: number;
  name: string;
  locations: CountryStates[];
  rates: Rate[];
};

export type FulfillmentService = {
  id?: number;
  storeId?: number;
  name: string;
  email: string;
};

export type Product = {
  id?: number;
  storeId?: number;
  store?: Store;
  brand?: Brand;
  tax?: Tax;
  type: ProductType;
  title: string;
  description?: string;
  price: number;
  compareAtPrice?: number;
  categories?: number[];
  collections?: number[];
  tags?: string[];
  weight?: number;
  weightUnit?: WeightUnit;
  width?: number;
  height?: number;
  depth?: number;
  dimensionUnit?: DimensionUnit;
  brandId?: number;
  options?: ProductOption[];
  variants?: ProductVariant[];
  images?: Image[];
  videos?: Video[];
  inventoryTracking?: boolean;
  allowBackOrder?: boolean;
  inventoryLevel?: number;
  inventoryWarningLevel?: number;
  sku?: string;
  gtin?: string;
  isFreeShipping?: boolean;
  fixedShippingRate?: number;
  public?: boolean;
  featured?: boolean;
  relatedProducts?: number[];
  warranty?: string;
  layout?: string;
  availability?: ProductAvailability;
  availabilityLabel?: string;
  preOrderReleaseDate?: Date;
  preOrderMessage?: string;
  preOrderOnly?: boolean;
  redirectUrl?: string;
  condition: Condition;
  showCondition?: boolean;
  slug: string;
  totalSold?: number;
  reviewCount?: number;
  reviewAverage?: number;
  customFields?: CustomField[];
  subscriptionInterval?: SubscriptionInterval;
  openGraphType?: OpenGraphType;
  createdAt?: Date;
  updatedAt?: Date;
};

export type Brand = {
  id?: number;
  name: string;
  products?: any[];
  createdAt?: Date;
  updatedAt?: Date;
};

export type Tax = {
  id?: number;
  name: string;
  products?: any[];
  rate: number;
  createdAt?: Date;
  updatedAt?: Date;
};

export type CustomField = {
  label?: string;
  value?: string;
};

export type ProductInput = {
  hasVariants: boolean;
  shippingInfo: boolean;
  dimensions: boolean;
  flatShipping: boolean;
  redirect: boolean;
} & Product;

export type ProductOption = {
  id?: number;
  productId?: number;
  name: string;
  values: string[];
};

export type ProductVariant = {
  id?: number;
  productId?: number;
  title: string;
  price?: number;
  compareAtPrice?: number;
  currency: string;
  inventoryTracking?: boolean;
  allowBackOrder: boolean;
  inventoryLevel?: number;
  inventoryWarningLevel?: number;
  sku?: string;
  gtin?: string;
  isFreeShipping: boolean;
  fixedShippingRate?: number;
  imageId?: number;
  videoId?: number;
  enabled: boolean;
  pricingRuleId?: number;
  createdAt?: Date;
  updatedAt?: Date;
};

const Condition = {
  new: "new",
  used: "used",
  refurbished: "refurbished",
} as const;

export type Condition = typeof Condition[keyof typeof Condition];

const ProductAvailability = {
  available: "available",
  disabled: "disabled",
  preorder: "preorder",
} as const;
export type ProductAvailability =
  typeof ProductAvailability[keyof typeof ProductAvailability];

const ProductType = {
  physical: "physical",
  digital: "digital",
} as const;

export type ProductType = typeof ProductType[keyof typeof ProductType];

const WeightUnit = {
  lb: "lb",
  kg: "kg",
  oz: "oz",
  g: "g",
} as const;

export type WeightUnit = typeof WeightUnit[keyof typeof WeightUnit];

const DimensionUnit = {
  in: "in",
  cm: "cm",
  m: "m",
} as const;

export type DimensionUnit = typeof DimensionUnit[keyof typeof DimensionUnit];

const OpenGraphType = {
  product: "product",
  album: "album",
  book: "book",
  drink: "drink",
  food: "food",
  game: "game",
  movie: "movie",
  song: "song",
  tv_show: "tv_show",
} as const;

export type OpenGraphType = typeof OpenGraphType[keyof typeof OpenGraphType];

const SubscriptionInterval = {
  day: "day",
  week: "week",
  month: "month",
  year: "year",
} as const;

export type SubscriptionInterval =
  typeof SubscriptionInterval[keyof typeof SubscriptionInterval];

// Utility to make fields nullable
export type Nullable<T> = { [P in keyof T]: T[P] | null };
