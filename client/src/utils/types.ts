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
    name: string;
    tag: string;
    logo: string;
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
  category: string;
  public?: boolean;
  createdAt?: Date;
  updatedAt?: Date;
};
