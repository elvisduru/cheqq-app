export class CreateStoreDto {
  id?: number;
  ownerId: number;
  name: string;
  status: boolean;
  domain?: string | null;
  address: string;
  country: string;
  phone: string;
  order_email: string;
  language: string;
  currency: string;
  logo: string;
  category: string;
  public: boolean;
}
