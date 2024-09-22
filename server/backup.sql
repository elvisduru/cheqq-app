--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Debian 14.13-1.pgdg120+1)
-- Dumped by pg_dump version 14.13 (Debian 14.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: Carrier; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Carrier" AS ENUM (
    'DHL',
    'UPS',
    'USPS'
);


ALTER TYPE public."Carrier" OWNER TO postgres;

--
-- Name: Condition; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Condition" AS ENUM (
    'new',
    'used',
    'refurbished'
);


ALTER TYPE public."Condition" OWNER TO postgres;

--
-- Name: DimensionUnit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DimensionUnit" AS ENUM (
    'in',
    'cm',
    'm'
);


ALTER TYPE public."DimensionUnit" OWNER TO postgres;

--
-- Name: OpenGraphType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OpenGraphType" AS ENUM (
    'product',
    'album',
    'book',
    'drink',
    'food',
    'game',
    'movie',
    'song',
    'tv_show'
);


ALTER TYPE public."OpenGraphType" OWNER TO postgres;

--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'PROCESSING',
    'CANCELLED',
    'PENDING_SHIPMENT',
    'PARTIALLY_SHIPPED',
    'SHIPPED',
    'PARTIALLY_DELIVERED',
    'DELIVERED',
    'PARTIALLY_RETURNED',
    'RETURNED'
);


ALTER TYPE public."OrderStatus" OWNER TO postgres;

--
-- Name: Plan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Plan" AS ENUM (
    'FREE',
    'PRO'
);


ALTER TYPE public."Plan" OWNER TO postgres;

--
-- Name: PriceAdjustmentType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PriceAdjustmentType" AS ENUM (
    'fixed',
    'percent'
);


ALTER TYPE public."PriceAdjustmentType" OWNER TO postgres;

--
-- Name: ProcessingTime; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProcessingTime" AS ENUM (
    'none',
    'sameDay',
    'nextDay',
    'twoDays'
);


ALTER TYPE public."ProcessingTime" OWNER TO postgres;

--
-- Name: ProductAvailability; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProductAvailability" AS ENUM (
    'available',
    'disabled',
    'preorder'
);


ALTER TYPE public."ProductAvailability" OWNER TO postgres;

--
-- Name: ProductType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProductType" AS ENUM (
    'physical',
    'digital'
);


ALTER TYPE public."ProductType" OWNER TO postgres;

--
-- Name: RateCondition; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."RateCondition" AS ENUM (
    'weight',
    'price'
);


ALTER TYPE public."RateCondition" OWNER TO postgres;

--
-- Name: ShippingRateType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ShippingRateType" AS ENUM (
    'custom',
    'carrier'
);


ALTER TYPE public."ShippingRateType" OWNER TO postgres;

--
-- Name: SubscriptionInterval; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SubscriptionInterval" AS ENUM (
    'day',
    'week',
    'month',
    'year'
);


ALTER TYPE public."SubscriptionInterval" OWNER TO postgres;

--
-- Name: TransitTime; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TransitTime" AS ENUM (
    'economy',
    'standard',
    'express',
    'economyInternational',
    'standardInternational',
    'expressInternational',
    'custom'
);


ALTER TYPE public."TransitTime" OWNER TO postgres;

--
-- Name: WeightUnit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."WeightUnit" AS ENUM (
    'lb',
    'kg',
    'oz',
    'g'
);


ALTER TYPE public."WeightUnit" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Address" (
    id integer NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    address1 text NOT NULL,
    address2 text,
    city text NOT NULL,
    state text,
    zip text NOT NULL,
    phone text NOT NULL,
    "userId" integer,
    "countryId" integer NOT NULL
);


ALTER TABLE public."Address" OWNER TO postgres;

--
-- Name: Address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Address_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Address_id_seq" OWNER TO postgres;

--
-- Name: Address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Address_id_seq" OWNED BY public."Address".id;


--
-- Name: Brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Brand" (
    id integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Brand" OWNER TO postgres;

--
-- Name: Brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Brand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Brand_id_seq" OWNER TO postgres;

--
-- Name: Brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Brand_id_seq" OWNED BY public."Brand".id;


--
-- Name: Cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cart" (
    id integer NOT NULL,
    "customerId" integer,
    currency text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    currency_symbol text NOT NULL
);


ALTER TABLE public."Cart" OWNER TO postgres;

--
-- Name: CartItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CartItem" (
    id integer NOT NULL,
    "cartId" integer NOT NULL,
    "productId" integer NOT NULL,
    "variantId" integer,
    quantity integer DEFAULT 1 NOT NULL,
    coupon text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."CartItem" OWNER TO postgres;

--
-- Name: CartItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CartItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CartItem_id_seq" OWNER TO postgres;

--
-- Name: CartItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CartItem_id_seq" OWNED BY public."CartItem".id;


--
-- Name: Cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cart_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cart_id_seq" OWNER TO postgres;

--
-- Name: Cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cart_id_seq" OWNED BY public."Cart".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    "parentCategoryId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Collection" (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    "pricingRuleId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Collection" OWNER TO postgres;

--
-- Name: Collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Collection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Collection_id_seq" OWNER TO postgres;

--
-- Name: Collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Collection_id_seq" OWNED BY public."Collection".id;


--
-- Name: Country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Country" (
    id integer NOT NULL,
    name text NOT NULL,
    iso3 text,
    numeric_code text,
    iso2 text,
    phone_code text,
    capital text,
    currency text,
    currency_name text,
    currency_symbol text,
    tld text,
    native text,
    region text,
    subregion text,
    timezones jsonb[],
    translations jsonb,
    latitude double precision,
    longitude double precision,
    emoji text,
    "emojiU" text
);


ALTER TABLE public."Country" OWNER TO postgres;

--
-- Name: Country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Country_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Country_id_seq" OWNER TO postgres;

--
-- Name: Country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Country_id_seq" OWNED BY public."Country".id;


--
-- Name: DeliveryZone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DeliveryZone" (
    id integer NOT NULL,
    "storeId" integer NOT NULL,
    name text NOT NULL,
    zipcodes text[],
    states text[],
    "minOrderPrice" double precision DEFAULT 0 NOT NULL,
    "deliveryPrice" double precision DEFAULT 0 NOT NULL,
    "conditionalPricing" jsonb[],
    "deliveryInformation" text,
    price integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."DeliveryZone" OWNER TO postgres;

--
-- Name: DeliveryZone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."DeliveryZone_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."DeliveryZone_id_seq" OWNER TO postgres;

--
-- Name: DeliveryZone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."DeliveryZone_id_seq" OWNED BY public."DeliveryZone".id;


--
-- Name: Follows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Follows" (
    "followerId" integer NOT NULL,
    "followingId" integer NOT NULL
);


ALTER TABLE public."Follows" OWNER TO postgres;

--
-- Name: FulfillmentService; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FulfillmentService" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "storeId" integer NOT NULL
);


ALTER TABLE public."FulfillmentService" OWNER TO postgres;

--
-- Name: FulfillmentService_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FulfillmentService_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FulfillmentService_id_seq" OWNER TO postgres;

--
-- Name: FulfillmentService_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FulfillmentService_id_seq" OWNED BY public."FulfillmentService".id;


--
-- Name: GiftWrapOption; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GiftWrapOption" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    name text NOT NULL,
    message text NOT NULL,
    price double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."GiftWrapOption" OWNER TO postgres;

--
-- Name: GiftWrapOption_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."GiftWrapOption_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."GiftWrapOption_id_seq" OWNER TO postgres;

--
-- Name: GiftWrapOption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."GiftWrapOption_id_seq" OWNED BY public."GiftWrapOption".id;


--
-- Name: Image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Image" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "productId" integer,
    url text NOT NULL,
    description text,
    "sortOrder" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Image" OWNER TO postgres;

--
-- Name: Image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Image_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Image_id_seq" OWNER TO postgres;

--
-- Name: Image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Image_id_seq" OWNED BY public."Image".id;


--
-- Name: LineItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LineItem" (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "quantityOrdered" integer NOT NULL,
    "quantityShipped" integer,
    "quantityPending" integer,
    "quantityCancelled" integer,
    "quantityReturned" integer,
    "quantityDelivered" integer,
    "shippingMethod" text NOT NULL,
    "shippingCarrier" text,
    "minDaysInTransit" integer NOT NULL,
    "maxDaysInTransit" integer NOT NULL,
    "isReturnable" boolean NOT NULL,
    "daysToReturn" integer,
    "policyUrl" text,
    "targetCountry" text,
    price integer NOT NULL,
    currency text NOT NULL,
    "imageLink" text,
    title text NOT NULL,
    gtin text,
    brand text,
    mpn text,
    condition public."Condition" NOT NULL,
    attributes jsonb[],
    "additionalFees" jsonb[],
    returns jsonb[],
    cancellations jsonb[],
    annotations jsonb[],
    adjustments jsonb[]
);


ALTER TABLE public."LineItem" OWNER TO postgres;

--
-- Name: LineItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."LineItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."LineItem_id_seq" OWNER TO postgres;

--
-- Name: LineItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."LineItem_id_seq" OWNED BY public."LineItem".id;


--
-- Name: Location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Location" (
    id integer NOT NULL,
    "countryId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "shippingZoneId" integer
);


ALTER TABLE public."Location" OWNER TO postgres;

--
-- Name: Location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Location_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Location_id_seq" OWNER TO postgres;

--
-- Name: Location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Location_id_seq" OWNED BY public."Location".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    "storeId" integer NOT NULL,
    "customerId" integer NOT NULL,
    "billingAddressId" integer NOT NULL,
    "shippingAddressId" integer,
    "ipAddress" text,
    "cancelledAt" timestamp(3) without time zone,
    note text,
    annotations jsonb[],
    status public."OrderStatus" DEFAULT 'PROCESSING'::public."OrderStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq" OWNER TO postgres;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: PricingRule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PricingRule" (
    id integer NOT NULL,
    "storeId" integer NOT NULL,
    title text,
    code text,
    shipping boolean DEFAULT false NOT NULL,
    "order" boolean DEFAULT false NOT NULL,
    "quantityMin" integer DEFAULT 1 NOT NULL,
    "adjusmentType" public."PriceAdjustmentType" DEFAULT 'fixed'::public."PriceAdjustmentType" NOT NULL,
    "adjustmentValue" double precision NOT NULL,
    "allocationLimit" integer,
    "usageLimit" integer,
    "usageCount" integer DEFAULT 0 NOT NULL,
    "startsAt" timestamp(3) without time zone,
    "endsAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."PricingRule" OWNER TO postgres;

--
-- Name: PricingRule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PricingRule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PricingRule_id_seq" OWNER TO postgres;

--
-- Name: PricingRule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PricingRule_id_seq" OWNED BY public."PricingRule".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    "storeId" integer NOT NULL,
    type public."ProductType" NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    tags text[],
    weight double precision,
    "weightUnit" public."WeightUnit",
    width double precision,
    height double precision,
    depth double precision,
    "dimensionUnit" public."DimensionUnit",
    price double precision DEFAULT 0 NOT NULL,
    "compareAtPrice" double precision,
    "costPrice" double precision,
    taxable boolean DEFAULT false NOT NULL,
    "taxId" integer,
    "brandId" integer,
    "inventoryTracking" boolean DEFAULT false NOT NULL,
    "allowBackOrder" boolean DEFAULT false NOT NULL,
    "inventoryLevel" integer,
    "inventoryWarningLevel" integer,
    sku text,
    gtin text,
    "isFreeShipping" boolean DEFAULT true NOT NULL,
    "fixedShippingRate" double precision,
    public boolean DEFAULT false NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    warranty text,
    layout text DEFAULT 'default'::text NOT NULL,
    availability public."ProductAvailability" DEFAULT 'available'::public."ProductAvailability" NOT NULL,
    "availabilityLabel" text,
    "preOrderMessage" text,
    "preOrderOnly" boolean DEFAULT false NOT NULL,
    "redirectUrl" text,
    condition public."Condition",
    "showCondition" boolean DEFAULT false NOT NULL,
    "searchKeywords" text[],
    "pageTitle" text,
    "metaDescription" text,
    "metaKeywords" text[],
    "viewCount" integer DEFAULT 0 NOT NULL,
    "customUrl" text,
    "openGraphTitle" text,
    "openGraphDescription" text,
    "openGraphType" public."OpenGraphType" DEFAULT 'product'::public."OpenGraphType" NOT NULL,
    "totalSold" integer DEFAULT 0 NOT NULL,
    "reviewCount" integer DEFAULT 0 NOT NULL,
    "reviewAverage" double precision DEFAULT 0 NOT NULL,
    "customFields" jsonb[],
    subscription boolean DEFAULT false NOT NULL,
    "subscriptionInterval" public."SubscriptionInterval",
    "subscriptionLength" integer,
    "subscriptionPrice" double precision,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "preOrderReleaseDate" timestamp(3) without time zone,
    currency text NOT NULL,
    slug text NOT NULL,
    "openGraphImageUrl" text,
    "shortUrl" text,
    currency_symbol text NOT NULL
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- Name: ProductOption; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductOption" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    name text NOT NULL,
    "values" text[]
);


ALTER TABLE public."ProductOption" OWNER TO postgres;

--
-- Name: ProductOption_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductOption_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductOption_id_seq" OWNER TO postgres;

--
-- Name: ProductOption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductOption_id_seq" OWNED BY public."ProductOption".id;


--
-- Name: ProductVariant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductVariant" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    price double precision,
    "compareAtPrice" double precision,
    "costPrice" double precision,
    "inventoryTracking" boolean DEFAULT false NOT NULL,
    "allowBackOrder" boolean DEFAULT false NOT NULL,
    "inventoryLevel" integer DEFAULT 0 NOT NULL,
    "inventoryWarningLevel" integer,
    sku text,
    gtin text,
    "isFreeShipping" boolean DEFAULT true NOT NULL,
    "fixedShippingRate" double precision,
    "imageId" integer,
    "videoId" integer,
    enabled boolean DEFAULT true NOT NULL,
    "pricingRuleId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    title text NOT NULL
);


ALTER TABLE public."ProductVariant" OWNER TO postgres;

--
-- Name: ProductVariant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductVariant_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductVariant_id_seq" OWNER TO postgres;

--
-- Name: ProductVariant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductVariant_id_seq" OWNED BY public."ProductVariant".id;


--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Product_id_seq" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- Name: ShippingRate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShippingRate" (
    id integer NOT NULL,
    "shippingZoneId" integer NOT NULL,
    type public."ShippingRateType" DEFAULT 'custom'::public."ShippingRateType" NOT NULL,
    "transitTime" public."TransitTime" NOT NULL,
    "customRateName" text,
    price double precision NOT NULL,
    "rateCondition" public."RateCondition",
    "rateConditionMin" double precision,
    "rateConditionMax" double precision,
    carrier public."Carrier",
    services text[],
    "handlingFeePercent" double precision,
    "handlingFeeFlat" double precision,
    currency text NOT NULL,
    currency_symbol text NOT NULL
);


ALTER TABLE public."ShippingRate" OWNER TO postgres;

--
-- Name: ShippingRate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ShippingRate_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ShippingRate_id_seq" OWNER TO postgres;

--
-- Name: ShippingRate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ShippingRate_id_seq" OWNED BY public."ShippingRate".id;


--
-- Name: ShippingZone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShippingZone" (
    id integer NOT NULL,
    "storeId" integer NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ShippingZone" OWNER TO postgres;

--
-- Name: ShippingZone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ShippingZone_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ShippingZone_id_seq" OWNER TO postgres;

--
-- Name: ShippingZone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ShippingZone_id_seq" OWNED BY public."ShippingZone".id;


--
-- Name: State; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."State" (
    id integer NOT NULL,
    name text NOT NULL,
    country_id integer NOT NULL,
    country_code text NOT NULL,
    country_name text NOT NULL,
    state_code text NOT NULL,
    type text,
    latitude double precision,
    longitude double precision,
    "locationId" integer
);


ALTER TABLE public."State" OWNER TO postgres;

--
-- Name: State_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."State_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."State_id_seq" OWNER TO postgres;

--
-- Name: State_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."State_id_seq" OWNED BY public."State".id;


--
-- Name: Store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Store" (
    id integer NOT NULL,
    "ownerId" integer NOT NULL,
    name text NOT NULL,
    tag text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    domain text,
    address text NOT NULL,
    "addressCoordinates" jsonb,
    phone text NOT NULL,
    order_email text,
    language text NOT NULL,
    currency text NOT NULL,
    logo text,
    banner text,
    description text,
    public boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "processingTime" public."ProcessingTime" DEFAULT 'none'::public."ProcessingTime" NOT NULL,
    "localPickup" boolean DEFAULT false NOT NULL,
    "countryId" integer NOT NULL,
    currency_symbol text NOT NULL
);


ALTER TABLE public."Store" OWNER TO postgres;

--
-- Name: Store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Store_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Store_id_seq" OWNER TO postgres;

--
-- Name: Store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Store_id_seq" OWNED BY public."Store".id;


--
-- Name: Tax; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tax" (
    id integer NOT NULL,
    name text NOT NULL,
    rate double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Tax" OWNER TO postgres;

--
-- Name: Tax_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tax_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tax_id_seq" OWNER TO postgres;

--
-- Name: Tax_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tax_id_seq" OWNED BY public."Tax".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text,
    email text NOT NULL,
    "emailVerified" boolean DEFAULT false NOT NULL,
    active boolean DEFAULT false NOT NULL,
    "avatarUrl" text,
    password text,
    "passwordUpdatedAt" timestamp(3) without time zone,
    plan public."Plan" DEFAULT 'FREE'::public."Plan" NOT NULL,
    "hashedRefreshToken" text,
    prefs jsonb DEFAULT '{}'::jsonb NOT NULL,
    "magicSecret" text,
    "magicSecretExpiry" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: Video; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Video" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "productId" integer,
    url text NOT NULL,
    description text,
    "sortOrder" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Video" OWNER TO postgres;

--
-- Name: Video_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Video_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Video_id_seq" OWNER TO postgres;

--
-- Name: Video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Video_id_seq" OWNED BY public."Video".id;


--
-- Name: _CategoryToProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_CategoryToProduct" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_CategoryToProduct" OWNER TO postgres;

--
-- Name: _CategoryToStore; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_CategoryToStore" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_CategoryToStore" OWNER TO postgres;

--
-- Name: _CollectionToProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_CollectionToProduct" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_CollectionToProduct" OWNER TO postgres;

--
-- Name: _PricingRuleToProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_PricingRuleToProduct" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_PricingRuleToProduct" OWNER TO postgres;

--
-- Name: _RelatedProducts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_RelatedProducts" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_RelatedProducts" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address" ALTER COLUMN id SET DEFAULT nextval('public."Address_id_seq"'::regclass);


--
-- Name: Brand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Brand" ALTER COLUMN id SET DEFAULT nextval('public."Brand_id_seq"'::regclass);


--
-- Name: Cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart" ALTER COLUMN id SET DEFAULT nextval('public."Cart_id_seq"'::regclass);


--
-- Name: CartItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem" ALTER COLUMN id SET DEFAULT nextval('public."CartItem_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Collection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Collection" ALTER COLUMN id SET DEFAULT nextval('public."Collection_id_seq"'::regclass);


--
-- Name: Country id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Country" ALTER COLUMN id SET DEFAULT nextval('public."Country_id_seq"'::regclass);


--
-- Name: DeliveryZone id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeliveryZone" ALTER COLUMN id SET DEFAULT nextval('public."DeliveryZone_id_seq"'::regclass);


--
-- Name: FulfillmentService id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FulfillmentService" ALTER COLUMN id SET DEFAULT nextval('public."FulfillmentService_id_seq"'::regclass);


--
-- Name: GiftWrapOption id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GiftWrapOption" ALTER COLUMN id SET DEFAULT nextval('public."GiftWrapOption_id_seq"'::regclass);


--
-- Name: Image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image" ALTER COLUMN id SET DEFAULT nextval('public."Image_id_seq"'::regclass);


--
-- Name: LineItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LineItem" ALTER COLUMN id SET DEFAULT nextval('public."LineItem_id_seq"'::regclass);


--
-- Name: Location id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location" ALTER COLUMN id SET DEFAULT nextval('public."Location_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: PricingRule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PricingRule" ALTER COLUMN id SET DEFAULT nextval('public."PricingRule_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: ProductOption id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductOption" ALTER COLUMN id SET DEFAULT nextval('public."ProductOption_id_seq"'::regclass);


--
-- Name: ProductVariant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductVariant" ALTER COLUMN id SET DEFAULT nextval('public."ProductVariant_id_seq"'::regclass);


--
-- Name: ShippingRate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingRate" ALTER COLUMN id SET DEFAULT nextval('public."ShippingRate_id_seq"'::regclass);


--
-- Name: ShippingZone id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingZone" ALTER COLUMN id SET DEFAULT nextval('public."ShippingZone_id_seq"'::regclass);


--
-- Name: State id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State" ALTER COLUMN id SET DEFAULT nextval('public."State_id_seq"'::regclass);


--
-- Name: Store id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Store" ALTER COLUMN id SET DEFAULT nextval('public."Store_id_seq"'::regclass);


--
-- Name: Tax id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tax" ALTER COLUMN id SET DEFAULT nextval('public."Tax_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: Video id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video" ALTER COLUMN id SET DEFAULT nextval('public."Video_id_seq"'::regclass);


--
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Address" (id, "firstName", "lastName", address1, address2, city, state, zip, phone, "userId", "countryId") FROM stdin;
\.


--
-- Data for Name: Brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Brand" (id, name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cart" (id, "customerId", currency, "createdAt", "updatedAt", currency_symbol) FROM stdin;
\.


--
-- Data for Name: CartItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CartItem" (id, "cartId", "productId", "variantId", quantity, coupon, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, name, description, "parentCategoryId", "createdAt", "updatedAt") FROM stdin;
1	Food & Grocery	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
2	Breakfast	\N	1	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
3	Beverages	\N	1	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
4	Coffee	\N	1	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
5	Snacks	\N	1	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
6	Canned & Packaged Foods	\N	1	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
7	Baby Food	\N	1	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
8	Fashion	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
9	Men's Clothing and Shoes	\N	8	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
10	Women's Clothing and Shoes	\N	8	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
11	Babies Clothing and Shoes	\N	8	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
12	Bags and Luggage	\N	8	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
13	Jewellery & Accessories	\N	8	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
14	Pet Supplies	\N	\N	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
15	Dog Supplies	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
16	Dog Food	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
17	Cat Supplies	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
18	Cat Food	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
19	Fish & Aquatic Pets	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
20	Small Animals	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
21	Birds	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
22	Others	\N	14	2024-09-22 17:27:29.439	2024-09-22 17:27:29.439
23	Baby Essentials	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
24	Baby & Toddler Clothing & Shoes	\N	23	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
25	Baby Accessories	\N	23	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
26	Baby Feeding Supplies	\N	23	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
27	Sports & Outdoors	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
28	Athletic Clothing	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
29	Exercise & Fitness	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
30	Hunting	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
31	Fishing	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
32	Team Sports	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
33	Golf	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
34	Fan Shop	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
35	The Ride Shop	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
36	Leisure Sports & Game Room	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
37	Collectibles	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
38	Sport Memorabilia, Fan Shop & Sport Cards	\N	27	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
39	Others	\N	\N	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
40	Miscellaneous	\N	39	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
41	Books, Movies & Music	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
42	Automotive	\N	\N	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
43	Musical Instruments & Gear	\N	41	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
44	Books & Magazines	\N	41	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
45	Movies & TV	\N	41	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
46	Music	\N	41	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
47	Home & Office	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
48	Toys & Games	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
49	Automotive Parts & Accessories	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
50	Automotive Tools & Equipment	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
51	Car/Vehicle Electronics & GPS	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
52	Tires & Wheels	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
53	Motorcycle & Powersports	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
54	RV Parts & Accessories	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
55	Your Garage	\N	42	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
56	Home Décor	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
57	Furniture	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
58	Kitchen & Dining	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
59	Bed & Bath	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
60	Garden & Outdoor	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
61	Mattresses	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
62	Lighting	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
63	Storage & Organization	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
64	Home Appliances	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
65	Event & Party Supplies	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
66	Home Improvement	\N	47	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
67	Collectibles & Art	\N	\N	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
68	Collectible Card Games	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
69	Video Games	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
70	Action Figures	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
71	Diecast & Toy Vehicles	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
72	Board & Traditional Games	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
73	Building Toys	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
74	Model Trains	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
75	Toy Models & Kits	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
76	Preschool Toys & Pretend Play	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
77	Vintage & Antique Toys	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
78	Outdoor Toys & Play Structures	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
79	Slot Cars	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
80	Stuffed Animals	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
81	Puzzles	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
82	Beanbag Plushies	\N	48	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
83	Art	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
84	Collectibles	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
85	Sport Memorabilia, Fan Shop & Sport Cards	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
86	Coins & Paper Money	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
87	Antiques	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
88	Art & Craft Supplies	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
89	Dolls & Teddy Bears	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
90	Pottery & Glass	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
91	Entertainment Memorabilia	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
92	Stamps	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
93	Vintage & Antique Jewelry	\N	67	2024-09-22 17:27:29.441	2024-09-22 17:27:29.441
94	Electronics	\N	\N	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
95	Health & Beauty	\N	\N	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
96	Scientific & Industrial	\N	\N	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
97	Computers & Accessories	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
98	Cell Phones & Accessories	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
99	TV & Video	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
100	Home Audio & Theater	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
101	Camera, Photo & Video	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
102	Headphones	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
103	Video Games	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
104	Bluetooth & Wireless Speakers	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
105	Car Electronics	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
106	Musical Instruments	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
107	Wearable Technology	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
108	Electronics	\N	94	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
109	All Beauty	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
110	Premium Beauty	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
111	Professional Skin Care	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
112	Salon & Spa	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
113	Men's Grooming	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
114	Women's Grooming	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
115	Health, Household & Baby Care	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
116	Vitamins & Dietary Supplements	\N	95	2024-09-22 17:27:29.438	2024-09-22 17:27:29.438
117	Industrial and Scientific	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
118	Doctors and Medical Staff	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
119	Teachers and Educators	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
120	Restaurant Owners and Chefs	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
121	Retailers and Small Business	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
122	Movers, Packers, Organizers	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
123	Property Managers	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
124	Dentists and Hygienists	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
125	Scientists and Lab Technicians	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
126	MRO Professionals	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
127	Product Designers and Engineers	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
128	Automotive and Fleet Maintenance	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
129	Construction and General Contractors	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
130	Beauty Professionals	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
131	Hoteliers and Hospitality	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
132	Fitness and Nutrition	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
133	Landscaping Professionals	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
134	Farmers and Agriculturalists	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
135	Breakroom Essentials	\N	96	2024-09-22 17:27:29.44	2024-09-22 17:27:29.44
\.


--
-- Data for Name: Collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Collection" (id, name, slug, description, "pricingRuleId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Country" (id, name, iso3, numeric_code, iso2, phone_code, capital, currency, currency_name, currency_symbol, tld, native, region, subregion, timezones, translations, latitude, longitude, emoji, "emojiU") FROM stdin;
1	Afghanistan	AFG	004	AF	93	Kabul	AFN	Afghan afghani	؋	.af	افغانستان	Asia	Southern Asia	{"{\\"tzName\\": \\"Afghanistan Time\\", \\"zoneName\\": \\"Asia/Kabul\\", \\"gmtOffset\\": 16200, \\"abbreviation\\": \\"AFT\\", \\"gmtOffsetName\\": \\"UTC+04:30\\"}"}	{"cn": "阿富汗", "de": "Afghanistan", "es": "Afganistán", "fa": "افغانستان", "fr": "Afghanistan", "hr": "Afganistan", "it": "Afghanistan", "ja": "アフガニスタン", "kr": "아프가니스탄", "nl": "Afghanistan", "pt": "Afeganistão", "tr": "Afganistan", "pt-BR": "Afeganistão"}	33	65	🇦🇫	U+1F1E6 U+1F1EB
2	Aland Islands	ALA	248	AX	+358-18	Mariehamn	EUR	Euro	€	.ax	Åland	Europe	Northern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Mariehamn\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "奥兰群岛", "de": "Åland", "es": "Alandia", "fa": "جزایر الند", "fr": "Åland", "hr": "Ålandski otoci", "it": "Isole Aland", "ja": "オーランド諸島", "kr": "올란드 제도", "nl": "Ålandeilanden", "pt": "Ilhas de Aland", "tr": "Åland Adalari", "pt-BR": "Ilhas de Aland"}	60.116667	19.9	🇦🇽	U+1F1E6 U+1F1FD
3	Albania	ALB	008	AL	355	Tirana	ALL	Albanian lek	Lek	.al	Shqipëria	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Tirane\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "阿尔巴尼亚", "de": "Albanien", "es": "Albania", "fa": "آلبانی", "fr": "Albanie", "hr": "Albanija", "it": "Albania", "ja": "アルバニア", "kr": "알바니아", "nl": "Albanië", "pt": "Albânia", "tr": "Arnavutluk", "pt-BR": "Albânia"}	41	20	🇦🇱	U+1F1E6 U+1F1F1
4	Algeria	DZA	012	DZ	213	Algiers	DZD	Algerian dinar	دج	.dz	الجزائر	Africa	Northern Africa	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Africa/Algiers\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "阿尔及利亚", "de": "Algerien", "es": "Argelia", "fa": "الجزایر", "fr": "Algérie", "hr": "Alžir", "it": "Algeria", "ja": "アルジェリア", "kr": "알제리", "nl": "Algerije", "pt": "Argélia", "tr": "Cezayir", "pt-BR": "Argélia"}	28	3	🇩🇿	U+1F1E9 U+1F1FF
5	American Samoa	ASM	016	AS	+1-684	Pago Pago	USD	US Dollar	$	.as	American Samoa	Oceania	Polynesia	{"{\\"tzName\\": \\"Samoa Standard Time\\", \\"zoneName\\": \\"Pacific/Pago_Pago\\", \\"gmtOffset\\": -39600, \\"abbreviation\\": \\"SST\\", \\"gmtOffsetName\\": \\"UTC-11:00\\"}"}	{"cn": "美属萨摩亚", "de": "Amerikanisch-Samoa", "es": "Samoa Americana", "fa": "ساموآی آمریکا", "fr": "Samoa américaines", "hr": "Američka Samoa", "it": "Samoa Americane", "ja": "アメリカ領サモア", "kr": "아메리칸사모아", "nl": "Amerikaans Samoa", "pt": "Samoa Americana", "tr": "Amerikan Samoasi", "pt-BR": "Samoa Americana"}	-14.33333333	-170	🇦🇸	U+1F1E6 U+1F1F8
6	Andorra	AND	020	AD	376	Andorra la Vella	EUR	Euro	€	.ad	Andorra	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Andorra\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "安道尔", "de": "Andorra", "es": "Andorra", "fa": "آندورا", "fr": "Andorre", "hr": "Andora", "it": "Andorra", "ja": "アンドラ", "kr": "안도라", "nl": "Andorra", "pt": "Andorra", "tr": "Andorra", "pt-BR": "Andorra"}	42.5	1.5	🇦🇩	U+1F1E6 U+1F1E9
7	Angola	AGO	024	AO	244	Luanda	AOA	Angolan kwanza	Kz	.ao	Angola	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Luanda\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "安哥拉", "de": "Angola", "es": "Angola", "fa": "آنگولا", "fr": "Angola", "hr": "Angola", "it": "Angola", "ja": "アンゴラ", "kr": "앙골라", "nl": "Angola", "pt": "Angola", "tr": "Angola", "pt-BR": "Angola"}	-12.5	18.5	🇦🇴	U+1F1E6 U+1F1F4
8	Anguilla	AIA	660	AI	+1-264	The Valley	XCD	East Caribbean dollar	$	.ai	Anguilla	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Anguilla\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "安圭拉", "de": "Anguilla", "es": "Anguilla", "fa": "آنگویلا", "fr": "Anguilla", "hr": "Angvila", "it": "Anguilla", "ja": "アンギラ", "kr": "앵귈라", "nl": "Anguilla", "pt": "Anguila", "tr": "Anguilla", "pt-BR": "Anguila"}	18.25	-63.16666666	🇦🇮	U+1F1E6 U+1F1EE
10	Antigua And Barbuda	ATG	028	AG	+1-268	St. John's	XCD	Eastern Caribbean dollar	$	.ag	Antigua and Barbuda	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Antigua\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "安提瓜和巴布达", "de": "Antigua und Barbuda", "es": "Antigua y Barbuda", "fa": "آنتیگوا و باربودا", "fr": "Antigua-et-Barbuda", "hr": "Antigva i Barbuda", "it": "Antigua e Barbuda", "ja": "アンティグア・バーブーダ", "kr": "앤티가 바부다", "nl": "Antigua en Barbuda", "pt": "Antígua e Barbuda", "tr": "Antigua Ve Barbuda", "pt-BR": "Antígua e Barbuda"}	17.05	-61.8	🇦🇬	U+1F1E6 U+1F1EC
11	Argentina	ARG	032	AR	54	Buenos Aires	ARS	Argentine peso	$	.ar	Argentina	Americas	South America	{"{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Buenos_Aires\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Catamarca\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Cordoba\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Jujuy\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/La_Rioja\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Mendoza\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Rio_Gallegos\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Salta\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/San_Juan\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/San_Luis\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Tucuman\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Argentina Time\\", \\"zoneName\\": \\"America/Argentina/Ushuaia\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"ART\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "阿根廷", "de": "Argentinien", "es": "Argentina", "fa": "آرژانتین", "fr": "Argentine", "hr": "Argentina", "it": "Argentina", "ja": "アルゼンチン", "kr": "아르헨티나", "nl": "Argentinië", "pt": "Argentina", "tr": "Arjantin", "pt-BR": "Argentina"}	-34	-64	🇦🇷	U+1F1E6 U+1F1F7
12	Armenia	ARM	051	AM	374	Yerevan	AMD	Armenian dram	֏	.am	Հայաստան	Asia	Western Asia	{"{\\"tzName\\": \\"Armenia Time\\", \\"zoneName\\": \\"Asia/Yerevan\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"AMT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "亚美尼亚", "de": "Armenien", "es": "Armenia", "fa": "ارمنستان", "fr": "Arménie", "hr": "Armenija", "it": "Armenia", "ja": "アルメニア", "kr": "아르메니아", "nl": "Armenië", "pt": "Arménia", "tr": "Ermenistan", "pt-BR": "Armênia"}	40	45	🇦🇲	U+1F1E6 U+1F1F2
13	Aruba	ABW	533	AW	297	Oranjestad	AWG	Aruban florin	ƒ	.aw	Aruba	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Aruba\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "阿鲁巴", "de": "Aruba", "es": "Aruba", "fa": "آروبا", "fr": "Aruba", "hr": "Aruba", "it": "Aruba", "ja": "アルバ", "kr": "아루바", "nl": "Aruba", "pt": "Aruba", "tr": "Aruba", "pt-BR": "Aruba"}	12.5	-69.96666666	🇦🇼	U+1F1E6 U+1F1FC
14	Australia	AUS	036	AU	61	Canberra	AUD	Australian dollar	$	.au	Australia	Oceania	Australia and New Zealand	{"{\\"tzName\\": \\"Macquarie Island Station Time\\", \\"zoneName\\": \\"Antarctica/Macquarie\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"MIST\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Australian Central Daylight Saving Time\\", \\"zoneName\\": \\"Australia/Adelaide\\", \\"gmtOffset\\": 37800, \\"abbreviation\\": \\"ACDT\\", \\"gmtOffsetName\\": \\"UTC+10:30\\"}","{\\"tzName\\": \\"Australian Eastern Standard Time\\", \\"zoneName\\": \\"Australia/Brisbane\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"AEST\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}","{\\"tzName\\": \\"Australian Central Daylight Saving Time\\", \\"zoneName\\": \\"Australia/Broken_Hill\\", \\"gmtOffset\\": 37800, \\"abbreviation\\": \\"ACDT\\", \\"gmtOffsetName\\": \\"UTC+10:30\\"}","{\\"tzName\\": \\"Australian Eastern Daylight Saving Time\\", \\"zoneName\\": \\"Australia/Currie\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"AEDT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Australian Central Standard Time\\", \\"zoneName\\": \\"Australia/Darwin\\", \\"gmtOffset\\": 34200, \\"abbreviation\\": \\"ACST\\", \\"gmtOffsetName\\": \\"UTC+09:30\\"}","{\\"tzName\\": \\"Australian Central Western Standard Time (Unofficial)\\", \\"zoneName\\": \\"Australia/Eucla\\", \\"gmtOffset\\": 31500, \\"abbreviation\\": \\"ACWST\\", \\"gmtOffsetName\\": \\"UTC+08:45\\"}","{\\"tzName\\": \\"Australian Eastern Daylight Saving Time\\", \\"zoneName\\": \\"Australia/Hobart\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"AEDT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Australian Eastern Standard Time\\", \\"zoneName\\": \\"Australia/Lindeman\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"AEST\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}","{\\"tzName\\": \\"Lord Howe Summer Time\\", \\"zoneName\\": \\"Australia/Lord_Howe\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"LHST\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Australian Eastern Daylight Saving Time\\", \\"zoneName\\": \\"Australia/Melbourne\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"AEDT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Australian Western Standard Time\\", \\"zoneName\\": \\"Australia/Perth\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"AWST\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}","{\\"tzName\\": \\"Australian Eastern Daylight Saving Time\\", \\"zoneName\\": \\"Australia/Sydney\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"AEDT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}"}	{"cn": "澳大利亚", "de": "Australien", "es": "Australia", "fa": "استرالیا", "fr": "Australie", "hr": "Australija", "it": "Australia", "ja": "オーストラリア", "kr": "호주", "nl": "Australië", "pt": "Austrália", "tr": "Avustralya", "pt-BR": "Austrália"}	-27	133	🇦🇺	U+1F1E6 U+1F1FA
15	Austria	AUT	040	AT	43	Vienna	EUR	Euro	€	.at	Österreich	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Vienna\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "奥地利", "de": "Österreich", "es": "Austria", "fa": "اتریش", "fr": "Autriche", "hr": "Austrija", "it": "Austria", "ja": "オーストリア", "kr": "오스트리아", "nl": "Oostenrijk", "pt": "áustria", "tr": "Avusturya", "pt-BR": "áustria"}	47.33333333	13.33333333	🇦🇹	U+1F1E6 U+1F1F9
16	Azerbaijan	AZE	031	AZ	994	Baku	AZN	Azerbaijani manat	m	.az	Azərbaycan	Asia	Western Asia	{"{\\"tzName\\": \\"Azerbaijan Time\\", \\"zoneName\\": \\"Asia/Baku\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"AZT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "阿塞拜疆", "de": "Aserbaidschan", "es": "Azerbaiyán", "fa": "آذربایجان", "fr": "Azerbaïdjan", "hr": "Azerbajdžan", "it": "Azerbaijan", "ja": "アゼルバイジャン", "kr": "아제르바이잔", "nl": "Azerbeidzjan", "pt": "Azerbaijão", "tr": "Azerbaycan", "pt-BR": "Azerbaijão"}	40.5	47.5	🇦🇿	U+1F1E6 U+1F1FF
18	Bahrain	BHR	048	BH	973	Manama	BHD	Bahraini dinar	.د.ب	.bh	‏البحرين	Asia	Western Asia	{"{\\"tzName\\": \\"Arabia Standard Time\\", \\"zoneName\\": \\"Asia/Bahrain\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "巴林", "de": "Bahrain", "es": "Bahrein", "fa": "بحرین", "fr": "Bahreïn", "hr": "Bahrein", "it": "Bahrein", "ja": "バーレーン", "kr": "바레인", "nl": "Bahrein", "pt": "Barém", "tr": "Bahreyn", "pt-BR": "Bahrein"}	26	50.55	🇧🇭	U+1F1E7 U+1F1ED
19	Bangladesh	BGD	050	BD	880	Dhaka	BDT	Bangladeshi taka	৳	.bd	Bangladesh	Asia	Southern Asia	{"{\\"tzName\\": \\"Bangladesh Standard Time\\", \\"zoneName\\": \\"Asia/Dhaka\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"BDT\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}"}	{"cn": "孟加拉", "de": "Bangladesch", "es": "Bangladesh", "fa": "بنگلادش", "fr": "Bangladesh", "hr": "Bangladeš", "it": "Bangladesh", "ja": "バングラデシュ", "kr": "방글라데시", "nl": "Bangladesh", "pt": "Bangladeche", "tr": "Bangladeş", "pt-BR": "Bangladesh"}	24	90	🇧🇩	U+1F1E7 U+1F1E9
20	Barbados	BRB	052	BB	+1-246	Bridgetown	BBD	Barbadian dollar	Bds$	.bb	Barbados	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Barbados\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "巴巴多斯", "de": "Barbados", "es": "Barbados", "fa": "باربادوس", "fr": "Barbade", "hr": "Barbados", "it": "Barbados", "ja": "バルバドス", "kr": "바베이도스", "nl": "Barbados", "pt": "Barbados", "tr": "Barbados", "pt-BR": "Barbados"}	13.16666666	-59.53333333	🇧🇧	U+1F1E7 U+1F1E7
21	Belarus	BLR	112	BY	375	Minsk	BYN	Belarusian ruble	Br	.by	Белару́сь	Europe	Eastern Europe	{"{\\"tzName\\": \\"Moscow Time\\", \\"zoneName\\": \\"Europe/Minsk\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"MSK\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "白俄罗斯", "de": "Weißrussland", "es": "Bielorrusia", "fa": "بلاروس", "fr": "Biélorussie", "hr": "Bjelorusija", "it": "Bielorussia", "ja": "ベラルーシ", "kr": "벨라루스", "nl": "Wit-Rusland", "pt": "Bielorrússia", "tr": "Belarus", "pt-BR": "Bielorrússia"}	53	28	🇧🇾	U+1F1E7 U+1F1FE
22	Belgium	BEL	056	BE	32	Brussels	EUR	Euro	€	.be	België	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Brussels\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "比利时", "de": "Belgien", "es": "Bélgica", "fa": "بلژیک", "fr": "Belgique", "hr": "Belgija", "it": "Belgio", "ja": "ベルギー", "kr": "벨기에", "nl": "België", "pt": "Bélgica", "tr": "Belçika", "pt-BR": "Bélgica"}	50.83333333	4	🇧🇪	U+1F1E7 U+1F1EA
23	Belize	BLZ	084	BZ	501	Belmopan	BZD	Belize dollar	$	.bz	Belize	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America)\\", \\"zoneName\\": \\"America/Belize\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "伯利兹", "de": "Belize", "es": "Belice", "fa": "بلیز", "fr": "Belize", "hr": "Belize", "it": "Belize", "ja": "ベリーズ", "kr": "벨리즈", "nl": "Belize", "pt": "Belize", "tr": "Belize", "pt-BR": "Belize"}	17.25	-88.75	🇧🇿	U+1F1E7 U+1F1FF
24	Benin	BEN	204	BJ	229	Porto-Novo	XOF	West African CFA franc	CFA	.bj	Bénin	Africa	Western Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Porto-Novo\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "贝宁", "de": "Benin", "es": "Benín", "fa": "بنین", "fr": "Bénin", "hr": "Benin", "it": "Benin", "ja": "ベナン", "kr": "베냉", "nl": "Benin", "pt": "Benim", "tr": "Benin", "pt-BR": "Benin"}	9.5	2.25	🇧🇯	U+1F1E7 U+1F1EF
25	Bermuda	BMU	060	BM	+1-441	Hamilton	BMD	Bermudian dollar	$	.bm	Bermuda	Americas	Northern America	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"Atlantic/Bermuda\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "百慕大", "de": "Bermuda", "es": "Bermudas", "fa": "برمودا", "fr": "Bermudes", "hr": "Bermudi", "it": "Bermuda", "ja": "バミューダ", "kr": "버뮤다", "nl": "Bermuda", "pt": "Bermudas", "tr": "Bermuda", "pt-BR": "Bermudas"}	32.33333333	-64.75	🇧🇲	U+1F1E7 U+1F1F2
26	Bhutan	BTN	064	BT	975	Thimphu	BTN	Bhutanese ngultrum	Nu.	.bt	ʼbrug-yul	Asia	Southern Asia	{"{\\"tzName\\": \\"Bhutan Time\\", \\"zoneName\\": \\"Asia/Thimphu\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"BTT\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}"}	{"cn": "不丹", "de": "Bhutan", "es": "Bután", "fa": "بوتان", "fr": "Bhoutan", "hr": "Butan", "it": "Bhutan", "ja": "ブータン", "kr": "부탄", "nl": "Bhutan", "pt": "Butão", "tr": "Butan", "pt-BR": "Butão"}	27.5	90.5	🇧🇹	U+1F1E7 U+1F1F9
27	Bolivia	BOL	068	BO	591	Sucre	BOB	Bolivian boliviano	Bs.	.bo	Bolivia	Americas	South America	{"{\\"tzName\\": \\"Bolivia Time\\", \\"zoneName\\": \\"America/La_Paz\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"BOT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "玻利维亚", "de": "Bolivien", "es": "Bolivia", "fa": "بولیوی", "fr": "Bolivie", "hr": "Bolivija", "it": "Bolivia", "ja": "ボリビア多民族国", "kr": "볼리비아", "nl": "Bolivia", "pt": "Bolívia", "tr": "Bolivya", "pt-BR": "Bolívia"}	-17	-65	🇧🇴	U+1F1E7 U+1F1F4
155	Bonaire, Sint Eustatius and Saba	BES	535	BQ	599	Kralendijk	USD	United States dollar	$	.an	Caribisch Nederland	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Anguilla\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "博内尔岛、圣尤斯特歇斯和萨巴岛", "de": "Bonaire, Sint Eustatius und Saba", "fa": "بونیر", "fr": "Bonaire, Saint-Eustache et Saba", "it": "Bonaire, Saint-Eustache e Saba", "kr": "보네르 섬", "pt": "Bonaire", "tr": "Karayip Hollandasi", "pt-BR": "Bonaire"}	12.15	-68.266667	🇧🇶	U+1F1E7 U+1F1F6
28	Bosnia and Herzegovina	BIH	070	BA	387	Sarajevo	BAM	Bosnia and Herzegovina convertible mark	KM	.ba	Bosna i Hercegovina	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Sarajevo\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "波斯尼亚和黑塞哥维那", "de": "Bosnien und Herzegowina", "es": "Bosnia y Herzegovina", "fa": "بوسنی و هرزگوین", "fr": "Bosnie-Herzégovine", "hr": "Bosna i Hercegovina", "it": "Bosnia ed Erzegovina", "ja": "ボスニア・ヘルツェゴビナ", "kr": "보스니아 헤르체고비나", "nl": "Bosnië en Herzegovina", "pt": "Bósnia e Herzegovina", "tr": "Bosna Hersek", "pt-BR": "Bósnia e Herzegovina"}	44	18	🇧🇦	U+1F1E7 U+1F1E6
29	Botswana	BWA	072	BW	267	Gaborone	BWP	Botswana pula	P	.bw	Botswana	Africa	Southern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Gaborone\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "博茨瓦纳", "de": "Botswana", "es": "Botswana", "fa": "بوتسوانا", "fr": "Botswana", "hr": "Bocvana", "it": "Botswana", "ja": "ボツワナ", "kr": "보츠와나", "nl": "Botswana", "pt": "Botsuana", "tr": "Botsvana", "pt-BR": "Botsuana"}	-22	24	🇧🇼	U+1F1E7 U+1F1FC
30	Bouvet Island	BVT	074	BV	0055		NOK	Norwegian Krone	kr	.bv	Bouvetøya			{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Oslo\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "布维岛", "de": "Bouvetinsel", "es": "Isla Bouvet", "fa": "جزیره بووه", "fr": "Île Bouvet", "hr": "Otok Bouvet", "it": "Isola Bouvet", "ja": "ブーベ島", "kr": "부벳 섬", "nl": "Bouveteiland", "pt": "Ilha Bouvet", "tr": "Bouvet Adasi", "pt-BR": "Ilha Bouvet"}	-54.43333333	3.4	🇧🇻	U+1F1E7 U+1F1FB
31	Brazil	BRA	076	BR	55	Brasilia	BRL	Brazilian real	R$	.br	Brasil	Americas	South America	{"{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Araguaina\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Bahia\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Belem\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Amazon Time (Brazil)[3\\", \\"zoneName\\": \\"America/Boa_Vista\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AMT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Amazon Time (Brazil)[3\\", \\"zoneName\\": \\"America/Campo_Grande\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AMT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Brasilia Time\\", \\"zoneName\\": \\"America/Cuiaba\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Acre Time\\", \\"zoneName\\": \\"America/Eirunepe\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"ACT\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Fortaleza\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Maceio\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Amazon Time (Brazil)\\", \\"zoneName\\": \\"America/Manaus\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AMT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Fernando de Noronha Time\\", \\"zoneName\\": \\"America/Noronha\\", \\"gmtOffset\\": -7200, \\"abbreviation\\": \\"FNT\\", \\"gmtOffsetName\\": \\"UTC-02:00\\"}","{\\"tzName\\": \\"Amazon Time (Brazil)[3\\", \\"zoneName\\": \\"America/Porto_Velho\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AMT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Recife\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Acre Time\\", \\"zoneName\\": \\"America/Rio_Branco\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"ACT\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Santarem\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Brasília Time\\", \\"zoneName\\": \\"America/Sao_Paulo\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"BRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "巴西", "de": "Brasilien", "es": "Brasil", "fa": "برزیل", "fr": "Brésil", "hr": "Brazil", "it": "Brasile", "ja": "ブラジル", "kr": "브라질", "nl": "Brazilië", "pt": "Brasil", "tr": "Brezilya", "pt-BR": "Brasil"}	-10	-55	🇧🇷	U+1F1E7 U+1F1F7
32	British Indian Ocean Territory	IOT	086	IO	246	Diego Garcia	USD	United States dollar	$	.io	British Indian Ocean Territory	Africa	Eastern Africa	{"{\\"tzName\\": \\"Indian Ocean Time\\", \\"zoneName\\": \\"Indian/Chagos\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"IOT\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}"}	{"cn": "英属印度洋领地", "de": "Britisches Territorium im Indischen Ozean", "es": "Territorio Británico del Océano Índico", "fa": "قلمرو بریتانیا در اقیانوس هند", "fr": "Territoire britannique de l'océan Indien", "hr": "Britanski Indijskooceanski teritorij", "it": "Territorio britannico dell'oceano indiano", "ja": "イギリス領インド洋地域", "kr": "영국령 인도양 지역", "nl": "Britse Gebieden in de Indische Oceaan", "pt": "Território Britânico do Oceano Índico", "tr": "Britanya Hint Okyanusu Topraklari", "pt-BR": "Território Britânico do Oceano íÍdico"}	-6	71.5	🇮🇴	U+1F1EE U+1F1F4
33	Brunei	BRN	096	BN	673	Bandar Seri Begawan	BND	Brunei dollar	B$	.bn	Negara Brunei Darussalam	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Brunei Darussalam Time\\", \\"zoneName\\": \\"Asia/Brunei\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"BNT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "文莱", "de": "Brunei", "es": "Brunei", "fa": "برونئی", "fr": "Brunei", "hr": "Brunej", "it": "Brunei", "ja": "ブルネイ・ダルサラーム", "kr": "브루나이", "nl": "Brunei", "pt": "Brunei", "tr": "Brunei", "pt-BR": "Brunei"}	4.5	114.66666666	🇧🇳	U+1F1E7 U+1F1F3
34	Bulgaria	BGR	100	BG	359	Sofia	BGN	Bulgarian lev	Лв.	.bg	България	Europe	Eastern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Sofia\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "保加利亚", "de": "Bulgarien", "es": "Bulgaria", "fa": "بلغارستان", "fr": "Bulgarie", "hr": "Bugarska", "it": "Bulgaria", "ja": "ブルガリア", "kr": "불가리아", "nl": "Bulgarije", "pt": "Bulgária", "tr": "Bulgaristan", "pt-BR": "Bulgária"}	43	25	🇧🇬	U+1F1E7 U+1F1EC
35	Burkina Faso	BFA	854	BF	226	Ouagadougou	XOF	West African CFA franc	CFA	.bf	Burkina Faso	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Ouagadougou\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "布基纳法索", "de": "Burkina Faso", "es": "Burkina Faso", "fa": "بورکینافاسو", "fr": "Burkina Faso", "hr": "Burkina Faso", "it": "Burkina Faso", "ja": "ブルキナファソ", "kr": "부르키나 파소", "nl": "Burkina Faso", "pt": "Burquina Faso", "tr": "Burkina Faso", "pt-BR": "Burkina Faso"}	13	-2	🇧🇫	U+1F1E7 U+1F1EB
36	Burundi	BDI	108	BI	257	Bujumbura	BIF	Burundian franc	FBu	.bi	Burundi	Africa	Eastern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Bujumbura\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "布隆迪", "de": "Burundi", "es": "Burundi", "fa": "بوروندی", "fr": "Burundi", "hr": "Burundi", "it": "Burundi", "ja": "ブルンジ", "kr": "부룬디", "nl": "Burundi", "pt": "Burúndi", "tr": "Burundi", "pt-BR": "Burundi"}	-3.5	30	🇧🇮	U+1F1E7 U+1F1EE
37	Cambodia	KHM	116	KH	855	Phnom Penh	KHR	Cambodian riel	KHR	.kh	Kâmpŭchéa	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Indochina Time\\", \\"zoneName\\": \\"Asia/Phnom_Penh\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"ICT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}"}	{"cn": "柬埔寨", "de": "Kambodscha", "es": "Camboya", "fa": "کامبوج", "fr": "Cambodge", "hr": "Kambodža", "it": "Cambogia", "ja": "カンボジア", "kr": "캄보디아", "nl": "Cambodja", "pt": "Camboja", "tr": "Kamboçya", "pt-BR": "Camboja"}	13	105	🇰🇭	U+1F1F0 U+1F1ED
38	Cameroon	CMR	120	CM	237	Yaounde	XAF	Central African CFA franc	FCFA	.cm	Cameroon	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Douala\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "喀麦隆", "de": "Kamerun", "es": "Camerún", "fa": "کامرون", "fr": "Cameroun", "hr": "Kamerun", "it": "Camerun", "ja": "カメルーン", "kr": "카메룬", "nl": "Kameroen", "pt": "Camarões", "tr": "Kamerun", "pt-BR": "Camarões"}	6	12	🇨🇲	U+1F1E8 U+1F1F2
39	Canada	CAN	124	CA	1	Ottawa	CAD	Canadian dollar	$	.ca	Canada	Americas	Northern America	{"{\\"tzName\\": \\"Eastern Standard Time (North America)\\", \\"zoneName\\": \\"America/Atikokan\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Blanc-Sablon\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America)\\", \\"zoneName\\": \\"America/Cambridge_Bay\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America)\\", \\"zoneName\\": \\"America/Creston\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America)\\", \\"zoneName\\": \\"America/Dawson\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America)\\", \\"zoneName\\": \\"America/Dawson_Creek\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America)\\", \\"zoneName\\": \\"America/Edmonton\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America)\\", \\"zoneName\\": \\"America/Fort_Nelson\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Glace_Bay\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Goose_Bay\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Halifax\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Inuvik\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Iqaluit\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Moncton\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Nipigon\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Pangnirtung\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Rainy_River\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Rankin_Inlet\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Regina\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Resolute\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Newfoundland Standard Time\\", \\"zoneName\\": \\"America/St_Johns\\", \\"gmtOffset\\": -12600, \\"abbreviation\\": \\"NST\\", \\"gmtOffsetName\\": \\"UTC-03:30\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Swift_Current\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Thunder_Bay\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Toronto\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Pacific Standard Time (North America\\", \\"zoneName\\": \\"America/Vancouver\\", \\"gmtOffset\\": -28800, \\"abbreviation\\": \\"PST\\", \\"gmtOffsetName\\": \\"UTC-08:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Whitehorse\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Winnipeg\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Yellowknife\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}"}	{"cn": "加拿大", "de": "Kanada", "es": "Canadá", "fa": "کانادا", "fr": "Canada", "hr": "Kanada", "it": "Canada", "ja": "カナダ", "kr": "캐나다", "nl": "Canada", "pt": "Canadá", "tr": "Kanada", "pt-BR": "Canadá"}	60	-95	🇨🇦	U+1F1E8 U+1F1E6
40	Cape Verde	CPV	132	CV	238	Praia	CVE	Cape Verdean escudo	$	.cv	Cabo Verde	Africa	Western Africa	{"{\\"tzName\\": \\"Cape Verde Time\\", \\"zoneName\\": \\"Atlantic/Cape_Verde\\", \\"gmtOffset\\": -3600, \\"abbreviation\\": \\"CVT\\", \\"gmtOffsetName\\": \\"UTC-01:00\\"}"}	{"cn": "佛得角", "de": "Kap Verde", "es": "Cabo Verde", "fa": "کیپ ورد", "fr": "Cap Vert", "hr": "Zelenortska Republika", "it": "Capo Verde", "ja": "カーボベルデ", "kr": "카보베르데", "nl": "Kaapverdië", "pt": "Cabo Verde", "tr": "Cabo Verde", "pt-BR": "Cabo Verde"}	16	-24	🇨🇻	U+1F1E8 U+1F1FB
41	Cayman Islands	CYM	136	KY	+1-345	George Town	KYD	Cayman Islands dollar	$	.ky	Cayman Islands	Americas	Caribbean	{"{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Cayman\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "开曼群岛", "de": "Kaimaninseln", "es": "Islas Caimán", "fa": "جزایر کیمن", "fr": "Îles Caïmans", "hr": "Kajmanski otoci", "it": "Isole Cayman", "ja": "ケイマン諸島", "kr": "케이먼 제도", "nl": "Caymaneilanden", "pt": "Ilhas Caimão", "tr": "Cayman Adalari", "pt-BR": "Ilhas Cayman"}	19.5	-80.5	🇰🇾	U+1F1F0 U+1F1FE
42	Central African Republic	CAF	140	CF	236	Bangui	XAF	Central African CFA franc	FCFA	.cf	Ködörösêse tî Bêafrîka	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Bangui\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "中非", "de": "Zentralafrikanische Republik", "es": "República Centroafricana", "fa": "جمهوری آفریقای مرکزی", "fr": "République centrafricaine", "hr": "Srednjoafrička Republika", "it": "Repubblica Centrafricana", "ja": "中央アフリカ共和国", "kr": "중앙아프리카 공화국", "nl": "Centraal-Afrikaanse Republiek", "pt": "República Centro-Africana", "tr": "Orta Afrika Cumhuriyeti", "pt-BR": "República Centro-Africana"}	7	21	🇨🇫	U+1F1E8 U+1F1EB
43	Chad	TCD	148	TD	235	N'Djamena	XAF	Central African CFA franc	FCFA	.td	Tchad	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Ndjamena\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "乍得", "de": "Tschad", "es": "Chad", "fa": "چاد", "fr": "Tchad", "hr": "Čad", "it": "Ciad", "ja": "チャド", "kr": "차드", "nl": "Tsjaad", "pt": "Chade", "tr": "Çad", "pt-BR": "Chade"}	15	19	🇹🇩	U+1F1F9 U+1F1E9
44	Chile	CHL	152	CL	56	Santiago	CLP	Chilean peso	$	.cl	Chile	Americas	South America	{"{\\"tzName\\": \\"Chile Summer Time\\", \\"zoneName\\": \\"America/Punta_Arenas\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"CLST\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Chile Summer Time\\", \\"zoneName\\": \\"America/Santiago\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"CLST\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Easter Island Summer Time\\", \\"zoneName\\": \\"Pacific/Easter\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EASST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "智利", "de": "Chile", "es": "Chile", "fa": "شیلی", "fr": "Chili", "hr": "Čile", "it": "Cile", "ja": "チリ", "kr": "칠리", "nl": "Chili", "pt": "Chile", "tr": "Şili", "pt-BR": "Chile"}	-30	-71	🇨🇱	U+1F1E8 U+1F1F1
45	China	CHN	156	CN	86	Beijing	CNY	Chinese yuan	¥	.cn	中国	Asia	Eastern Asia	{"{\\"tzName\\": \\"China Standard Time\\", \\"zoneName\\": \\"Asia/Shanghai\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}","{\\"tzName\\": \\"China Standard Time\\", \\"zoneName\\": \\"Asia/Urumqi\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"XJT\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}"}	{"cn": "中国", "de": "China", "es": "China", "fa": "چین", "fr": "Chine", "hr": "Kina", "it": "Cina", "ja": "中国", "kr": "중국", "nl": "China", "pt": "China", "tr": "Çin", "pt-BR": "China"}	35	105	🇨🇳	U+1F1E8 U+1F1F3
46	Christmas Island	CXR	162	CX	61	Flying Fish Cove	AUD	Australian dollar	$	.cx	Christmas Island	Oceania	Australia and New Zealand	{"{\\"tzName\\": \\"Christmas Island Time\\", \\"zoneName\\": \\"Indian/Christmas\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"CXT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}"}	{"cn": "圣诞岛", "de": "Weihnachtsinsel", "es": "Isla de Navidad", "fa": "جزیره کریسمس", "fr": "Île Christmas", "hr": "Božićni otok", "it": "Isola di Natale", "ja": "クリスマス島", "kr": "크리스마스 섬", "nl": "Christmaseiland", "pt": "Ilha do Natal", "tr": "Christmas Adasi", "pt-BR": "Ilha Christmas"}	-10.5	105.66666666	🇨🇽	U+1F1E8 U+1F1FD
47	Cocos (Keeling) Islands	CCK	166	CC	61	West Island	AUD	Australian dollar	$	.cc	Cocos (Keeling) Islands	Oceania	Australia and New Zealand	{"{\\"tzName\\": \\"Cocos Islands Time\\", \\"zoneName\\": \\"Indian/Cocos\\", \\"gmtOffset\\": 23400, \\"abbreviation\\": \\"CCT\\", \\"gmtOffsetName\\": \\"UTC+06:30\\"}"}	{"cn": "科科斯（基林）群岛", "de": "Kokosinseln", "es": "Islas Cocos o Islas Keeling", "fa": "جزایر کوکوس", "fr": "Îles Cocos", "hr": "Kokosovi Otoci", "it": "Isole Cocos e Keeling", "ja": "ココス（キーリング）諸島", "kr": "코코스 제도", "nl": "Cocoseilanden", "pt": "Ilhas dos Cocos", "tr": "Cocos Adalari", "pt-BR": "Ilhas Cocos"}	-12.5	96.83333333	🇨🇨	U+1F1E8 U+1F1E8
48	Colombia	COL	170	CO	57	Bogotá	COP	Colombian peso	$	.co	Colombia	Americas	South America	{"{\\"tzName\\": \\"Colombia Time\\", \\"zoneName\\": \\"America/Bogota\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"COT\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "哥伦比亚", "de": "Kolumbien", "es": "Colombia", "fa": "کلمبیا", "fr": "Colombie", "hr": "Kolumbija", "it": "Colombia", "ja": "コロンビア", "kr": "콜롬비아", "nl": "Colombia", "pt": "Colômbia", "tr": "Kolombiya", "pt-BR": "Colômbia"}	4	-72	🇨🇴	U+1F1E8 U+1F1F4
49	Comoros	COM	174	KM	269	Moroni	KMF	Comorian franc	CF	.km	Komori	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Indian/Comoro\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "科摩罗", "de": "Union der Komoren", "es": "Comoras", "fa": "کومور", "fr": "Comores", "hr": "Komori", "it": "Comore", "ja": "コモロ", "kr": "코모로", "nl": "Comoren", "pt": "Comores", "tr": "Komorlar", "pt-BR": "Comores"}	-12.16666666	44.25	🇰🇲	U+1F1F0 U+1F1F2
50	Congo	COG	178	CG	242	Brazzaville	XAF	Central African CFA franc	FC	.cg	République du Congo	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Brazzaville\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "刚果", "de": "Kongo", "es": "Congo", "fa": "کنگو", "fr": "Congo", "hr": "Kongo", "it": "Congo", "ja": "コンゴ共和国", "kr": "콩고", "nl": "Congo [Republiek]", "pt": "Congo", "tr": "Kongo", "pt-BR": "Congo"}	-1	15	🇨🇬	U+1F1E8 U+1F1EC
52	Cook Islands	COK	184	CK	682	Avarua	NZD	Cook Islands dollar	$	.ck	Cook Islands	Oceania	Polynesia	{"{\\"tzName\\": \\"Cook Island Time\\", \\"zoneName\\": \\"Pacific/Rarotonga\\", \\"gmtOffset\\": -36000, \\"abbreviation\\": \\"CKT\\", \\"gmtOffsetName\\": \\"UTC-10:00\\"}"}	{"cn": "库克群岛", "de": "Cookinseln", "es": "Islas Cook", "fa": "جزایر کوک", "fr": "Îles Cook", "hr": "Cookovo Otočje", "it": "Isole Cook", "ja": "クック諸島", "kr": "쿡 제도", "nl": "Cookeilanden", "pt": "Ilhas Cook", "tr": "Cook Adalari", "pt-BR": "Ilhas Cook"}	-21.23333333	-159.76666666	🇨🇰	U+1F1E8 U+1F1F0
53	Costa Rica	CRI	188	CR	506	San Jose	CRC	Costa Rican colón	₡	.cr	Costa Rica	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Costa_Rica\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "哥斯达黎加", "de": "Costa Rica", "es": "Costa Rica", "fa": "کاستاریکا", "fr": "Costa Rica", "hr": "Kostarika", "it": "Costa Rica", "ja": "コスタリカ", "kr": "코스타리카", "nl": "Costa Rica", "pt": "Costa Rica", "tr": "Kosta Rika", "pt-BR": "Costa Rica"}	10	-84	🇨🇷	U+1F1E8 U+1F1F7
54	Cote D'Ivoire (Ivory Coast)	CIV	384	CI	225	Yamoussoukro	XOF	West African CFA franc	CFA	.ci	\N	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Abidjan\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "科特迪瓦", "de": "Elfenbeinküste", "es": "Costa de Marfil", "fa": "ساحل عاج", "fr": "Côte d'Ivoire", "hr": "Obala Bjelokosti", "it": "Costa D'Avorio", "ja": "コートジボワール", "kr": "코트디부아르", "nl": "Ivoorkust", "pt": "Costa do Marfim", "tr": "Kotdivuar", "pt-BR": "Costa do Marfim"}	8	-5	🇨🇮	U+1F1E8 U+1F1EE
55	Croatia	HRV	191	HR	385	Zagreb	HRK	Croatian kuna	kn	.hr	Hrvatska	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Zagreb\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "克罗地亚", "de": "Kroatien", "es": "Croacia", "fa": "کرواسی", "fr": "Croatie", "hr": "Hrvatska", "it": "Croazia", "ja": "クロアチア", "kr": "크로아티아", "nl": "Kroatië", "pt": "Croácia", "tr": "Hirvatistan", "pt-BR": "Croácia"}	45.16666666	15.5	🇭🇷	U+1F1ED U+1F1F7
56	Cuba	CUB	192	CU	53	Havana	CUP	Cuban peso	$	.cu	Cuba	Americas	Caribbean	{"{\\"tzName\\": \\"Cuba Standard Time\\", \\"zoneName\\": \\"America/Havana\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "古巴", "de": "Kuba", "es": "Cuba", "fa": "کوبا", "fr": "Cuba", "hr": "Kuba", "it": "Cuba", "ja": "キューバ", "kr": "쿠바", "nl": "Cuba", "pt": "Cuba", "tr": "Küba", "pt-BR": "Cuba"}	21.5	-80	🇨🇺	U+1F1E8 U+1F1FA
249	Curaçao	CUW	531	CW	599	Willemstad	ANG	Netherlands Antillean guilder	ƒ	.cw	Curaçao	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Curacao\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "库拉索", "de": "Curaçao", "fa": "کوراسائو", "fr": "Curaçao", "it": "Curaçao", "kr": "퀴라소", "nl": "Curaçao", "pt": "Curaçao", "tr": "Curaçao", "pt-BR": "Curaçao"}	12.116667	-68.933333	🇨🇼	U+1F1E8 U+1F1FC
57	Cyprus	CYP	196	CY	357	Nicosia	EUR	Euro	€	.cy	Κύπρος	Europe	Southern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Famagusta\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}","{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Nicosia\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "塞浦路斯", "de": "Zypern", "es": "Chipre", "fa": "قبرس", "fr": "Chypre", "hr": "Cipar", "it": "Cipro", "ja": "キプロス", "kr": "키프로스", "nl": "Cyprus", "pt": "Chipre", "tr": "Kuzey Kıbrıs Türk Cumhuriyeti", "pt-BR": "Chipre"}	35	33	🇨🇾	U+1F1E8 U+1F1FE
58	Czech Republic	CZE	203	CZ	420	Prague	CZK	Czech koruna	Kč	.cz	Česká republika	Europe	Eastern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Prague\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "捷克", "de": "Tschechische Republik", "es": "República Checa", "fa": "جمهوری چک", "fr": "République tchèque", "hr": "Češka", "it": "Repubblica Ceca", "ja": "チェコ", "kr": "체코", "nl": "Tsjechië", "pt": "República Checa", "tr": "Çekya", "pt-BR": "República Tcheca"}	49.75	15.5	🇨🇿	U+1F1E8 U+1F1FF
51	Democratic Republic of the Congo	COD	180	CD	243	Kinshasa	CDF	Congolese Franc	FC	.cd	République démocratique du Congo	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Kinshasa\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}","{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Lubumbashi\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "刚果（金）", "de": "Kongo (Dem. Rep.)", "es": "Congo (Rep. Dem.)", "fa": "جمهوری کنگو", "fr": "Congo (Rép. dém.)", "hr": "Kongo, Demokratska Republika", "it": "Congo (Rep. Dem.)", "ja": "コンゴ民主共和国", "kr": "콩고 민주 공화국", "nl": "Congo [DRC]", "pt": "RD Congo", "tr": "Kongo Demokratik Cumhuriyeti", "pt-BR": "RD Congo"}	0	25	🇨🇩	U+1F1E8 U+1F1E9
59	Denmark	DNK	208	DK	45	Copenhagen	DKK	Danish krone	Kr.	.dk	Danmark	Europe	Northern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Copenhagen\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "丹麦", "de": "Dänemark", "es": "Dinamarca", "fa": "دانمارک", "fr": "Danemark", "hr": "Danska", "it": "Danimarca", "ja": "デンマーク", "kr": "덴마크", "nl": "Denemarken", "pt": "Dinamarca", "tr": "Danimarka", "pt-BR": "Dinamarca"}	56	10	🇩🇰	U+1F1E9 U+1F1F0
60	Djibouti	DJI	262	DJ	253	Djibouti	DJF	Djiboutian franc	Fdj	.dj	Djibouti	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Djibouti\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "吉布提", "de": "Dschibuti", "es": "Yibuti", "fa": "جیبوتی", "fr": "Djibouti", "hr": "Džibuti", "it": "Gibuti", "ja": "ジブチ", "kr": "지부티", "nl": "Djibouti", "pt": "Djibuti", "tr": "Cibuti", "pt-BR": "Djibuti"}	11.5	43	🇩🇯	U+1F1E9 U+1F1EF
61	Dominica	DMA	212	DM	+1-767	Roseau	XCD	Eastern Caribbean dollar	$	.dm	Dominica	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Dominica\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "多米尼加", "de": "Dominica", "es": "Dominica", "fa": "دومینیکا", "fr": "Dominique", "hr": "Dominika", "it": "Dominica", "ja": "ドミニカ国", "kr": "도미니카 연방", "nl": "Dominica", "pt": "Dominica", "tr": "Dominika", "pt-BR": "Dominica"}	15.41666666	-61.33333333	🇩🇲	U+1F1E9 U+1F1F2
62	Dominican Republic	DOM	214	DO	+1-809 and 1-829	Santo Domingo	DOP	Dominican peso	$	.do	República Dominicana	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Santo_Domingo\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "多明尼加共和国", "de": "Dominikanische Republik", "es": "República Dominicana", "fa": "جمهوری دومینیکن", "fr": "République dominicaine", "hr": "Dominikanska Republika", "it": "Repubblica Dominicana", "ja": "ドミニカ共和国", "kr": "도미니카 공화국", "nl": "Dominicaanse Republiek", "pt": "República Dominicana", "tr": "Dominik Cumhuriyeti", "pt-BR": "República Dominicana"}	19	-70.66666666	🇩🇴	U+1F1E9 U+1F1F4
63	East Timor	TLS	626	TL	670	Dili	USD	United States dollar	$	.tl	Timor-Leste	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Timor Leste Time\\", \\"zoneName\\": \\"Asia/Dili\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"TLT\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}"}	{"cn": "东帝汶", "de": "Timor-Leste", "es": "Timor Oriental", "fa": "تیمور شرقی", "fr": "Timor oriental", "hr": "Istočni Timor", "it": "Timor Est", "ja": "東ティモール", "kr": "동티모르", "nl": "Oost-Timor", "pt": "Timor Leste", "tr": "Doğu Timor", "pt-BR": "Timor Leste"}	-8.83333333	125.91666666	🇹🇱	U+1F1F9 U+1F1F1
64	Ecuador	ECU	218	EC	593	Quito	USD	United States dollar	$	.ec	Ecuador	Americas	South America	{"{\\"tzName\\": \\"Ecuador Time\\", \\"zoneName\\": \\"America/Guayaquil\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"ECT\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Galápagos Time\\", \\"zoneName\\": \\"Pacific/Galapagos\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"GALT\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "厄瓜多尔", "de": "Ecuador", "es": "Ecuador", "fa": "اکوادور", "fr": "Équateur", "hr": "Ekvador", "it": "Ecuador", "ja": "エクアドル", "kr": "에콰도르", "nl": "Ecuador", "pt": "Equador", "tr": "Ekvator", "pt-BR": "Equador"}	-2	-77.5	🇪🇨	U+1F1EA U+1F1E8
65	Egypt	EGY	818	EG	20	Cairo	EGP	Egyptian pound	ج.م	.eg	مصر‎	Africa	Northern Africa	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Africa/Cairo\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "埃及", "de": "Ägypten", "es": "Egipto", "fa": "مصر", "fr": "Égypte", "hr": "Egipat", "it": "Egitto", "ja": "エジプト", "kr": "이집트", "nl": "Egypte", "pt": "Egipto", "tr": "Mısır", "pt-BR": "Egito"}	27	30	🇪🇬	U+1F1EA U+1F1EC
66	El Salvador	SLV	222	SV	503	San Salvador	USD	United States dollar	$	.sv	El Salvador	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/El_Salvador\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "萨尔瓦多", "de": "El Salvador", "es": "El Salvador", "fa": "السالوادور", "fr": "Salvador", "hr": "Salvador", "it": "El Salvador", "ja": "エルサルバドル", "kr": "엘살바도르", "nl": "El Salvador", "pt": "El Salvador", "tr": "El Salvador", "pt-BR": "El Salvador"}	13.83333333	-88.91666666	🇸🇻	U+1F1F8 U+1F1FB
67	Equatorial Guinea	GNQ	226	GQ	240	Malabo	XAF	Central African CFA franc	FCFA	.gq	Guinea Ecuatorial	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Malabo\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "赤道几内亚", "de": "Äquatorial-Guinea", "es": "Guinea Ecuatorial", "fa": "گینه استوایی", "fr": "Guinée-Équatoriale", "hr": "Ekvatorijalna Gvineja", "it": "Guinea Equatoriale", "ja": "赤道ギニア", "kr": "적도 기니", "nl": "Equatoriaal-Guinea", "pt": "Guiné Equatorial", "tr": "Ekvator Ginesi", "pt-BR": "Guiné Equatorial"}	2	10	🇬🇶	U+1F1EC U+1F1F6
68	Eritrea	ERI	232	ER	291	Asmara	ERN	Eritrean nakfa	Nfk	.er	ኤርትራ	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Asmara\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "厄立特里亚", "de": "Eritrea", "es": "Eritrea", "fa": "اریتره", "fr": "Érythrée", "hr": "Eritreja", "it": "Eritrea", "ja": "エリトリア", "kr": "에리트레아", "nl": "Eritrea", "pt": "Eritreia", "tr": "Eritre", "pt-BR": "Eritreia"}	15	39	🇪🇷	U+1F1EA U+1F1F7
69	Estonia	EST	233	EE	372	Tallinn	EUR	Euro	€	.ee	Eesti	Europe	Northern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Tallinn\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "爱沙尼亚", "de": "Estland", "es": "Estonia", "fa": "استونی", "fr": "Estonie", "hr": "Estonija", "it": "Estonia", "ja": "エストニア", "kr": "에스토니아", "nl": "Estland", "pt": "Estónia", "tr": "Estonya", "pt-BR": "Estônia"}	59	26	🇪🇪	U+1F1EA U+1F1EA
70	Ethiopia	ETH	231	ET	251	Addis Ababa	ETB	Ethiopian birr	Nkf	.et	ኢትዮጵያ	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Addis_Ababa\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "埃塞俄比亚", "de": "Äthiopien", "es": "Etiopía", "fa": "اتیوپی", "fr": "Éthiopie", "hr": "Etiopija", "it": "Etiopia", "ja": "エチオピア", "kr": "에티오피아", "nl": "Ethiopië", "pt": "Etiópia", "tr": "Etiyopya", "pt-BR": "Etiópia"}	8	38	🇪🇹	U+1F1EA U+1F1F9
71	Falkland Islands	FLK	238	FK	500	Stanley	FKP	Falkland Islands pound	£	.fk	Falkland Islands	Americas	South America	{"{\\"tzName\\": \\"Falkland Islands Summer Time\\", \\"zoneName\\": \\"Atlantic/Stanley\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"FKST\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "福克兰群岛", "de": "Falklandinseln", "es": "Islas Malvinas", "fa": "جزایر فالکلند", "fr": "Îles Malouines", "hr": "Falklandski Otoci", "it": "Isole Falkland o Isole Malvine", "ja": "フォークランド（マルビナス）諸島", "kr": "포클랜드 제도", "nl": "Falklandeilanden [Islas Malvinas]", "pt": "Ilhas Falkland", "tr": "Falkland Adalari", "pt-BR": "Ilhas Malvinas"}	-51.75	-59	🇫🇰	U+1F1EB U+1F1F0
72	Faroe Islands	FRO	234	FO	298	Torshavn	DKK	Danish krone	Kr.	.fo	Føroyar	Europe	Northern Europe	{"{\\"tzName\\": \\"Western European Time\\", \\"zoneName\\": \\"Atlantic/Faroe\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"WET\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "法罗群岛", "de": "Färöer-Inseln", "es": "Islas Faroe", "fa": "جزایر فارو", "fr": "Îles Féroé", "hr": "Farski Otoci", "it": "Isole Far Oer", "ja": "フェロー諸島", "kr": "페로 제도", "nl": "Faeröer", "pt": "Ilhas Faroé", "tr": "Faroe Adalari", "pt-BR": "Ilhas Faroé"}	62	-7	🇫🇴	U+1F1EB U+1F1F4
73	Fiji Islands	FJI	242	FJ	679	Suva	FJD	Fijian dollar	FJ$	.fj	Fiji	Oceania	Melanesia	{"{\\"tzName\\": \\"Fiji Time\\", \\"zoneName\\": \\"Pacific/Fiji\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"FJT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "斐济", "de": "Fidschi", "es": "Fiyi", "fa": "فیجی", "fr": "Fidji", "hr": "Fiđi", "it": "Figi", "ja": "フィジー", "kr": "피지", "nl": "Fiji", "pt": "Fiji", "tr": "Fiji", "pt-BR": "Fiji"}	-18	175	🇫🇯	U+1F1EB U+1F1EF
74	Finland	FIN	246	FI	358	Helsinki	EUR	Euro	€	.fi	Suomi	Europe	Northern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Helsinki\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "芬兰", "de": "Finnland", "es": "Finlandia", "fa": "فنلاند", "fr": "Finlande", "hr": "Finska", "it": "Finlandia", "ja": "フィンランド", "kr": "핀란드", "nl": "Finland", "pt": "Finlândia", "tr": "Finlandiya", "pt-BR": "Finlândia"}	64	26	🇫🇮	U+1F1EB U+1F1EE
75	France	FRA	250	FR	33	Paris	EUR	Euro	€	.fr	France	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Paris\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "法国", "de": "Frankreich", "es": "Francia", "fa": "فرانسه", "fr": "France", "hr": "Francuska", "it": "Francia", "ja": "フランス", "kr": "프랑스", "nl": "Frankrijk", "pt": "França", "tr": "Fransa", "pt-BR": "França"}	46	2	🇫🇷	U+1F1EB U+1F1F7
76	French Guiana	GUF	254	GF	594	Cayenne	EUR	Euro	€	.gf	Guyane française	Americas	South America	{"{\\"tzName\\": \\"French Guiana Time\\", \\"zoneName\\": \\"America/Cayenne\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"GFT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "法属圭亚那", "de": "Französisch Guyana", "es": "Guayana Francesa", "fa": "گویان فرانسه", "fr": "Guayane", "hr": "Francuska Gvajana", "it": "Guyana francese", "ja": "フランス領ギアナ", "kr": "프랑스령 기아나", "nl": "Frans-Guyana", "pt": "Guiana Francesa", "tr": "Fransiz Guyanasi", "pt-BR": "Guiana Francesa"}	4	-53	🇬🇫	U+1F1EC U+1F1EB
77	French Polynesia	PYF	258	PF	689	Papeete	XPF	CFP franc	₣	.pf	Polynésie française	Oceania	Polynesia	{"{\\"tzName\\": \\"Gambier Islands Time\\", \\"zoneName\\": \\"Pacific/Gambier\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"GAMT\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Marquesas Islands Time\\", \\"zoneName\\": \\"Pacific/Marquesas\\", \\"gmtOffset\\": -34200, \\"abbreviation\\": \\"MART\\", \\"gmtOffsetName\\": \\"UTC-09:30\\"}","{\\"tzName\\": \\"Tahiti Time\\", \\"zoneName\\": \\"Pacific/Tahiti\\", \\"gmtOffset\\": -36000, \\"abbreviation\\": \\"TAHT\\", \\"gmtOffsetName\\": \\"UTC-10:00\\"}"}	{"cn": "法属波利尼西亚", "de": "Französisch-Polynesien", "es": "Polinesia Francesa", "fa": "پلی‌نزی فرانسه", "fr": "Polynésie française", "hr": "Francuska Polinezija", "it": "Polinesia Francese", "ja": "フランス領ポリネシア", "kr": "프랑스령 폴리네시아", "nl": "Frans-Polynesië", "pt": "Polinésia Francesa", "tr": "Fransiz Polinezyasi", "pt-BR": "Polinésia Francesa"}	-15	-140	🇵🇫	U+1F1F5 U+1F1EB
78	French Southern Territories	ATF	260	TF	262	Port-aux-Francais	EUR	Euro	€	.tf	Territoire des Terres australes et antarctiques fr	Africa	Southern Africa	{"{\\"tzName\\": \\"French Southern and Antarctic Time\\", \\"zoneName\\": \\"Indian/Kerguelen\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"TFT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "法属南部领地", "de": "Französische Süd- und Antarktisgebiete", "es": "Tierras Australes y Antárticas Francesas", "fa": "سرزمین‌های جنوبی و جنوبگانی فرانسه", "fr": "Terres australes et antarctiques françaises", "hr": "Francuski južni i antarktički teritoriji", "it": "Territori Francesi del Sud", "ja": "フランス領南方・南極地域", "kr": "프랑스령 남방 및 남극", "nl": "Franse Gebieden in de zuidelijke Indische Oceaan", "pt": "Terras Austrais e Antárticas Francesas", "tr": "Fransiz Güney Topraklari", "pt-BR": "Terras Austrais e Antárticas Francesas"}	-49.25	69.167	🇹🇫	U+1F1F9 U+1F1EB
79	Gabon	GAB	266	GA	241	Libreville	XAF	Central African CFA franc	FCFA	.ga	Gabon	Africa	Middle Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Libreville\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "加蓬", "de": "Gabun", "es": "Gabón", "fa": "گابن", "fr": "Gabon", "hr": "Gabon", "it": "Gabon", "ja": "ガボン", "kr": "가봉", "nl": "Gabon", "pt": "Gabão", "tr": "Gabon", "pt-BR": "Gabão"}	-1	11.75	🇬🇦	U+1F1EC U+1F1E6
80	Gambia The	GMB	270	GM	220	Banjul	GMD	Gambian dalasi	D	.gm	Gambia	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Banjul\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "冈比亚", "de": "Gambia", "es": "Gambia", "fa": "گامبیا", "fr": "Gambie", "hr": "Gambija", "it": "Gambia", "ja": "ガンビア", "kr": "감비아", "nl": "Gambia", "pt": "Gâmbia", "tr": "Gambiya", "pt-BR": "Gâmbia"}	13.46666666	-16.56666666	🇬🇲	U+1F1EC U+1F1F2
81	Georgia	GEO	268	GE	995	Tbilisi	GEL	Georgian lari	ლ	.ge	საქართველო	Asia	Western Asia	{"{\\"tzName\\": \\"Georgia Standard Time\\", \\"zoneName\\": \\"Asia/Tbilisi\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"GET\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "格鲁吉亚", "de": "Georgien", "es": "Georgia", "fa": "گرجستان", "fr": "Géorgie", "hr": "Gruzija", "it": "Georgia", "ja": "グルジア", "kr": "조지아", "nl": "Georgië", "pt": "Geórgia", "tr": "Gürcistan", "pt-BR": "Geórgia"}	42	43.5	🇬🇪	U+1F1EC U+1F1EA
82	Germany	DEU	276	DE	49	Berlin	EUR	Euro	€	.de	Deutschland	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Berlin\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}","{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Busingen\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "德国", "de": "Deutschland", "es": "Alemania", "fa": "آلمان", "fr": "Allemagne", "hr": "Njemačka", "it": "Germania", "ja": "ドイツ", "kr": "독일", "nl": "Duitsland", "pt": "Alemanha", "tr": "Almanya", "pt-BR": "Alemanha"}	51	9	🇩🇪	U+1F1E9 U+1F1EA
83	Ghana	GHA	288	GH	233	Accra	GHS	Ghanaian cedi	GH₵	.gh	Ghana	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Accra\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "加纳", "de": "Ghana", "es": "Ghana", "fa": "غنا", "fr": "Ghana", "hr": "Gana", "it": "Ghana", "ja": "ガーナ", "kr": "가나", "nl": "Ghana", "pt": "Gana", "tr": "Gana", "pt-BR": "Gana"}	8	-2	🇬🇭	U+1F1EC U+1F1ED
84	Gibraltar	GIB	292	GI	350	Gibraltar	GIP	Gibraltar pound	£	.gi	Gibraltar	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Gibraltar\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "直布罗陀", "de": "Gibraltar", "es": "Gibraltar", "fa": "جبل‌طارق", "fr": "Gibraltar", "hr": "Gibraltar", "it": "Gibilterra", "ja": "ジブラルタル", "kr": "지브롤터", "nl": "Gibraltar", "pt": "Gibraltar", "tr": "Cebelitarik", "pt-BR": "Gibraltar"}	36.13333333	-5.35	🇬🇮	U+1F1EC U+1F1EE
85	Greece	GRC	300	GR	30	Athens	EUR	Euro	€	.gr	Ελλάδα	Europe	Southern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Athens\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "希腊", "de": "Griechenland", "es": "Grecia", "fa": "یونان", "fr": "Grèce", "hr": "Grčka", "it": "Grecia", "ja": "ギリシャ", "kr": "그리스", "nl": "Griekenland", "pt": "Grécia", "tr": "Yunanistan", "pt-BR": "Grécia"}	39	22	🇬🇷	U+1F1EC U+1F1F7
86	Greenland	GRL	304	GL	299	Nuuk	DKK	Danish krone	Kr.	.gl	Kalaallit Nunaat	Americas	Northern America	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"America/Danmarkshavn\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}","{\\"tzName\\": \\"West Greenland Time\\", \\"zoneName\\": \\"America/Nuuk\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"WGT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}","{\\"tzName\\": \\"Eastern Greenland Time\\", \\"zoneName\\": \\"America/Scoresbysund\\", \\"gmtOffset\\": -3600, \\"abbreviation\\": \\"EGT\\", \\"gmtOffsetName\\": \\"UTC-01:00\\"}","{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Thule\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "格陵兰岛", "de": "Grönland", "es": "Groenlandia", "fa": "گرینلند", "fr": "Groenland", "hr": "Grenland", "it": "Groenlandia", "ja": "グリーンランド", "kr": "그린란드", "nl": "Groenland", "pt": "Gronelândia", "tr": "Grönland", "pt-BR": "Groelândia"}	72	-40	🇬🇱	U+1F1EC U+1F1F1
87	Grenada	GRD	308	GD	+1-473	St. George's	XCD	Eastern Caribbean dollar	$	.gd	Grenada	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Grenada\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "格林纳达", "de": "Grenada", "es": "Grenada", "fa": "گرنادا", "fr": "Grenade", "hr": "Grenada", "it": "Grenada", "ja": "グレナダ", "kr": "그레나다", "nl": "Grenada", "pt": "Granada", "tr": "Grenada", "pt-BR": "Granada"}	12.11666666	-61.66666666	🇬🇩	U+1F1EC U+1F1E9
88	Guadeloupe	GLP	312	GP	590	Basse-Terre	EUR	Euro	€	.gp	Guadeloupe	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Guadeloupe\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "瓜德罗普岛", "de": "Guadeloupe", "es": "Guadalupe", "fa": "جزیره گوادلوپ", "fr": "Guadeloupe", "hr": "Gvadalupa", "it": "Guadeloupa", "ja": "グアドループ", "kr": "과들루프", "nl": "Guadeloupe", "pt": "Guadalupe", "tr": "Guadeloupe", "pt-BR": "Guadalupe"}	16.25	-61.583333	🇬🇵	U+1F1EC U+1F1F5
89	Guam	GUM	316	GU	+1-671	Hagatna	USD	US Dollar	$	.gu	Guam	Oceania	Micronesia	{"{\\"tzName\\": \\"Chamorro Standard Time\\", \\"zoneName\\": \\"Pacific/Guam\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"CHST\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}"}	{"cn": "关岛", "de": "Guam", "es": "Guam", "fa": "گوام", "fr": "Guam", "hr": "Guam", "it": "Guam", "ja": "グアム", "kr": "괌", "nl": "Guam", "pt": "Guame", "tr": "Guam", "pt-BR": "Guam"}	13.46666666	144.78333333	🇬🇺	U+1F1EC U+1F1FA
90	Guatemala	GTM	320	GT	502	Guatemala City	GTQ	Guatemalan quetzal	Q	.gt	Guatemala	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Guatemala\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "危地马拉", "de": "Guatemala", "es": "Guatemala", "fa": "گواتمالا", "fr": "Guatemala", "hr": "Gvatemala", "it": "Guatemala", "ja": "グアテマラ", "kr": "과테말라", "nl": "Guatemala", "pt": "Guatemala", "tr": "Guatemala", "pt-BR": "Guatemala"}	15.5	-90.25	🇬🇹	U+1F1EC U+1F1F9
91	Guernsey and Alderney	GGY	831	GG	+44-1481	St Peter Port	GBP	British pound	£	.gg	Guernsey	Europe	Northern Europe	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Europe/Guernsey\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "根西岛", "de": "Guernsey", "es": "Guernsey", "fa": "گرنزی", "fr": "Guernesey", "hr": "Guernsey", "it": "Guernsey", "ja": "ガーンジー", "kr": "건지, 올더니", "nl": "Guernsey", "pt": "Guernsey", "tr": "Alderney", "pt-BR": "Guernsey"}	49.46666666	-2.58333333	🇬🇬	U+1F1EC U+1F1EC
92	Guinea	GIN	324	GN	224	Conakry	GNF	Guinean franc	FG	.gn	Guinée	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Conakry\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "几内亚", "de": "Guinea", "es": "Guinea", "fa": "گینه", "fr": "Guinée", "hr": "Gvineja", "it": "Guinea", "ja": "ギニア", "kr": "기니", "nl": "Guinee", "pt": "Guiné", "tr": "Gine", "pt-BR": "Guiné"}	11	-10	🇬🇳	U+1F1EC U+1F1F3
93	Guinea-Bissau	GNB	624	GW	245	Bissau	XOF	West African CFA franc	CFA	.gw	Guiné-Bissau	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Bissau\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "几内亚比绍", "de": "Guinea-Bissau", "es": "Guinea-Bisáu", "fa": "گینه بیسائو", "fr": "Guinée-Bissau", "hr": "Gvineja Bisau", "it": "Guinea-Bissau", "ja": "ギニアビサウ", "kr": "기니비사우", "nl": "Guinee-Bissau", "pt": "Guiné-Bissau", "tr": "Gine-bissau", "pt-BR": "Guiné-Bissau"}	12	-15	🇬🇼	U+1F1EC U+1F1FC
94	Guyana	GUY	328	GY	592	Georgetown	GYD	Guyanese dollar	$	.gy	Guyana	Americas	South America	{"{\\"tzName\\": \\"Guyana Time\\", \\"zoneName\\": \\"America/Guyana\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"GYT\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圭亚那", "de": "Guyana", "es": "Guyana", "fa": "گویان", "fr": "Guyane", "hr": "Gvajana", "it": "Guyana", "ja": "ガイアナ", "kr": "가이아나", "nl": "Guyana", "pt": "Guiana", "tr": "Guyana", "pt-BR": "Guiana"}	5	-59	🇬🇾	U+1F1EC U+1F1FE
95	Haiti	HTI	332	HT	509	Port-au-Prince	HTG	Haitian gourde	G	.ht	Haïti	Americas	Caribbean	{"{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Port-au-Prince\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "海地", "de": "Haiti", "es": "Haiti", "fa": "هائیتی", "fr": "Haïti", "hr": "Haiti", "it": "Haiti", "ja": "ハイチ", "kr": "아이티", "nl": "Haïti", "pt": "Haiti", "tr": "Haiti", "pt-BR": "Haiti"}	19	-72.41666666	🇭🇹	U+1F1ED U+1F1F9
96	Heard Island and McDonald Islands	HMD	334	HM	672		AUD	Australian dollar	$	.hm	Heard Island and McDonald Islands			{"{\\"tzName\\": \\"French Southern and Antarctic Time\\", \\"zoneName\\": \\"Indian/Kerguelen\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"TFT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "赫德·唐纳岛及麦唐纳岛", "de": "Heard und die McDonaldinseln", "es": "Islas Heard y McDonald", "fa": "جزیره هرد و جزایر مک‌دونالد", "fr": "Îles Heard-et-MacDonald", "hr": "Otok Heard i otočje McDonald", "it": "Isole Heard e McDonald", "ja": "ハード島とマクドナルド諸島", "kr": "허드 맥도날드 제도", "nl": "Heard- en McDonaldeilanden", "pt": "Ilha Heard e Ilhas McDonald", "tr": "Heard Adasi Ve Mcdonald Adalari", "pt-BR": "Ilha Heard e Ilhas McDonald"}	-53.1	72.51666666	🇭🇲	U+1F1ED U+1F1F2
97	Honduras	HND	340	HN	504	Tegucigalpa	HNL	Honduran lempira	L	.hn	Honduras	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Tegucigalpa\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "洪都拉斯", "de": "Honduras", "es": "Honduras", "fa": "هندوراس", "fr": "Honduras", "hr": "Honduras", "it": "Honduras", "ja": "ホンジュラス", "kr": "온두라스", "nl": "Honduras", "pt": "Honduras", "tr": "Honduras", "pt-BR": "Honduras"}	15	-86.5	🇭🇳	U+1F1ED U+1F1F3
98	Hong Kong S.A.R.	HKG	344	HK	852	Hong Kong	HKD	Hong Kong dollar	$	.hk	香港	Asia	Eastern Asia	{"{\\"tzName\\": \\"Hong Kong Time\\", \\"zoneName\\": \\"Asia/Hong_Kong\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"HKT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "中国香港", "de": "Hong Kong", "es": "Hong Kong", "fa": "هنگ‌کنگ", "fr": "Hong Kong", "hr": "Hong Kong", "it": "Hong Kong", "ja": "香港", "kr": "홍콩", "nl": "Hongkong", "pt": "Hong Kong", "tr": "Hong Kong", "pt-BR": "Hong Kong"}	22.25	114.16666666	🇭🇰	U+1F1ED U+1F1F0
99	Hungary	HUN	348	HU	36	Budapest	HUF	Hungarian forint	Ft	.hu	Magyarország	Europe	Eastern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Budapest\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "匈牙利", "de": "Ungarn", "es": "Hungría", "fa": "مجارستان", "fr": "Hongrie", "hr": "Mađarska", "it": "Ungheria", "ja": "ハンガリー", "kr": "헝가리", "nl": "Hongarije", "pt": "Hungria", "tr": "Macaristan", "pt-BR": "Hungria"}	47	20	🇭🇺	U+1F1ED U+1F1FA
100	Iceland	ISL	352	IS	354	Reykjavik	ISK	Icelandic króna	kr	.is	Ísland	Europe	Northern Europe	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Atlantic/Reykjavik\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "冰岛", "de": "Island", "es": "Islandia", "fa": "ایسلند", "fr": "Islande", "hr": "Island", "it": "Islanda", "ja": "アイスランド", "kr": "아이슬란드", "nl": "IJsland", "pt": "Islândia", "tr": "İzlanda", "pt-BR": "Islândia"}	65	-18	🇮🇸	U+1F1EE U+1F1F8
101	India	IND	356	IN	91	New Delhi	INR	Indian rupee	₹	.in	भारत	Asia	Southern Asia	{"{\\"tzName\\": \\"Indian Standard Time\\", \\"zoneName\\": \\"Asia/Kolkata\\", \\"gmtOffset\\": 19800, \\"abbreviation\\": \\"IST\\", \\"gmtOffsetName\\": \\"UTC+05:30\\"}"}	{"cn": "印度", "de": "Indien", "es": "India", "fa": "هند", "fr": "Inde", "hr": "Indija", "it": "India", "ja": "インド", "kr": "인도", "nl": "India", "pt": "Índia", "tr": "Hindistan", "pt-BR": "Índia"}	20	77	🇮🇳	U+1F1EE U+1F1F3
102	Indonesia	IDN	360	ID	62	Jakarta	IDR	Indonesian rupiah	Rp	.id	Indonesia	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Western Indonesian Time\\", \\"zoneName\\": \\"Asia/Jakarta\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"WIB\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Eastern Indonesian Time\\", \\"zoneName\\": \\"Asia/Jayapura\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"WIT\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}","{\\"tzName\\": \\"Central Indonesia Time\\", \\"zoneName\\": \\"Asia/Makassar\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"WITA\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}","{\\"tzName\\": \\"Western Indonesian Time\\", \\"zoneName\\": \\"Asia/Pontianak\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"WIB\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}"}	{"cn": "印度尼西亚", "de": "Indonesien", "es": "Indonesia", "fa": "اندونزی", "fr": "Indonésie", "hr": "Indonezija", "it": "Indonesia", "ja": "インドネシア", "kr": "인도네시아", "nl": "Indonesië", "pt": "Indonésia", "tr": "Endonezya", "pt-BR": "Indonésia"}	-5	120	🇮🇩	U+1F1EE U+1F1E9
103	Iran	IRN	364	IR	98	Tehran	IRR	Iranian rial	﷼	.ir	ایران	Asia	Southern Asia	{"{\\"tzName\\": \\"Iran Daylight Time\\", \\"zoneName\\": \\"Asia/Tehran\\", \\"gmtOffset\\": 12600, \\"abbreviation\\": \\"IRDT\\", \\"gmtOffsetName\\": \\"UTC+03:30\\"}"}	{"cn": "伊朗", "de": "Iran", "es": "Iran", "fa": "ایران", "fr": "Iran", "hr": "Iran", "ja": "イラン・イスラム共和国", "kr": "이란", "nl": "Iran", "pt": "Irão", "tr": "İran", "pt-BR": "Irã"}	32	53	🇮🇷	U+1F1EE U+1F1F7
104	Iraq	IRQ	368	IQ	964	Baghdad	IQD	Iraqi dinar	د.ع	.iq	العراق	Asia	Western Asia	{"{\\"tzName\\": \\"Arabia Standard Time\\", \\"zoneName\\": \\"Asia/Baghdad\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "伊拉克", "de": "Irak", "es": "Irak", "fa": "عراق", "fr": "Irak", "hr": "Irak", "it": "Iraq", "ja": "イラク", "kr": "이라크", "nl": "Irak", "pt": "Iraque", "tr": "Irak", "pt-BR": "Iraque"}	33	44	🇮🇶	U+1F1EE U+1F1F6
105	Ireland	IRL	372	IE	353	Dublin	EUR	Euro	€	.ie	Éire	Europe	Northern Europe	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Europe/Dublin\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "爱尔兰", "de": "Irland", "es": "Irlanda", "fa": "ایرلند", "fr": "Irlande", "hr": "Irska", "it": "Irlanda", "ja": "アイルランド", "kr": "아일랜드", "nl": "Ierland", "pt": "Irlanda", "tr": "İrlanda", "pt-BR": "Irlanda"}	53	-8	🇮🇪	U+1F1EE U+1F1EA
106	Israel	ISR	376	IL	972	Jerusalem	ILS	Israeli new shekel	₪	.il	יִשְׂרָאֵל	Asia	Western Asia	{"{\\"tzName\\": \\"Israel Standard Time\\", \\"zoneName\\": \\"Asia/Jerusalem\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"IST\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "以色列", "de": "Israel", "es": "Israel", "fa": "اسرائیل", "fr": "Israël", "hr": "Izrael", "it": "Israele", "ja": "イスラエル", "kr": "이스라엘", "nl": "Israël", "pt": "Israel", "tr": "İsrail", "pt-BR": "Israel"}	31.5	34.75	🇮🇱	U+1F1EE U+1F1F1
107	Italy	ITA	380	IT	39	Rome	EUR	Euro	€	.it	Italia	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Rome\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "意大利", "de": "Italien", "es": "Italia", "fa": "ایتالیا", "fr": "Italie", "hr": "Italija", "it": "Italia", "ja": "イタリア", "kr": "이탈리아", "nl": "Italië", "pt": "Itália", "tr": "İtalya", "pt-BR": "Itália"}	42.83333333	12.83333333	🇮🇹	U+1F1EE U+1F1F9
108	Jamaica	JAM	388	JM	+1-876	Kingston	JMD	Jamaican dollar	J$	.jm	Jamaica	Americas	Caribbean	{"{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Jamaica\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "牙买加", "de": "Jamaika", "es": "Jamaica", "fa": "جامائیکا", "fr": "Jamaïque", "hr": "Jamajka", "it": "Giamaica", "ja": "ジャマイカ", "kr": "자메이카", "nl": "Jamaica", "pt": "Jamaica", "tr": "Jamaika", "pt-BR": "Jamaica"}	18.25	-77.5	🇯🇲	U+1F1EF U+1F1F2
109	Japan	JPN	392	JP	81	Tokyo	JPY	Japanese yen	¥	.jp	日本	Asia	Eastern Asia	{"{\\"tzName\\": \\"Japan Standard Time\\", \\"zoneName\\": \\"Asia/Tokyo\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"JST\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}"}	{"cn": "日本", "de": "Japan", "es": "Japón", "fa": "ژاپن", "fr": "Japon", "hr": "Japan", "it": "Giappone", "ja": "日本", "kr": "일본", "nl": "Japan", "pt": "Japão", "tr": "Japonya", "pt-BR": "Japão"}	36	138	🇯🇵	U+1F1EF U+1F1F5
110	Jersey	JEY	832	JE	+44-1534	Saint Helier	GBP	British pound	£	.je	Jersey	Europe	Northern Europe	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Europe/Jersey\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "泽西岛", "de": "Jersey", "es": "Jersey", "fa": "جرزی", "fr": "Jersey", "hr": "Jersey", "it": "Isola di Jersey", "ja": "ジャージー", "kr": "저지 섬", "nl": "Jersey", "pt": "Jersey", "tr": "Jersey", "pt-BR": "Jersey"}	49.25	-2.16666666	🇯🇪	U+1F1EF U+1F1EA
111	Jordan	JOR	400	JO	962	Amman	JOD	Jordanian dinar	ا.د	.jo	الأردن	Asia	Western Asia	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Amman\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "约旦", "de": "Jordanien", "es": "Jordania", "fa": "اردن", "fr": "Jordanie", "hr": "Jordan", "it": "Giordania", "ja": "ヨルダン", "kr": "요르단", "nl": "Jordanië", "pt": "Jordânia", "tr": "Ürdün", "pt-BR": "Jordânia"}	31	36	🇯🇴	U+1F1EF U+1F1F4
112	Kazakhstan	KAZ	398	KZ	7	Astana	KZT	Kazakhstani tenge	лв	.kz	Қазақстан	Asia	Central Asia	{"{\\"tzName\\": \\"Alma-Ata Time[1\\", \\"zoneName\\": \\"Asia/Almaty\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"ALMT\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}","{\\"tzName\\": \\"Aqtobe Time\\", \\"zoneName\\": \\"Asia/Aqtau\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"AQTT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}","{\\"tzName\\": \\"Aqtobe Time\\", \\"zoneName\\": \\"Asia/Aqtobe\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"AQTT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}","{\\"tzName\\": \\"Moscow Daylight Time+1\\", \\"zoneName\\": \\"Asia/Atyrau\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"MSD+1\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}","{\\"tzName\\": \\"Oral Time\\", \\"zoneName\\": \\"Asia/Oral\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"ORAT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}","{\\"tzName\\": \\"Qyzylorda Summer Time\\", \\"zoneName\\": \\"Asia/Qostanay\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"QYZST\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}","{\\"tzName\\": \\"Qyzylorda Summer Time\\", \\"zoneName\\": \\"Asia/Qyzylorda\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"QYZT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "哈萨克斯坦", "de": "Kasachstan", "es": "Kazajistán", "fa": "قزاقستان", "fr": "Kazakhstan", "hr": "Kazahstan", "it": "Kazakistan", "ja": "カザフスタン", "kr": "카자흐스탄", "nl": "Kazachstan", "pt": "Cazaquistão", "tr": "Kazakistan", "pt-BR": "Cazaquistão"}	48	68	🇰🇿	U+1F1F0 U+1F1FF
113	Kenya	KEN	404	KE	254	Nairobi	KES	Kenyan shilling	KSh	.ke	Kenya	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Nairobi\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "肯尼亚", "de": "Kenia", "es": "Kenia", "fa": "کنیا", "fr": "Kenya", "hr": "Kenija", "it": "Kenya", "ja": "ケニア", "kr": "케냐", "nl": "Kenia", "pt": "Quénia", "tr": "Kenya", "pt-BR": "Quênia"}	1	38	🇰🇪	U+1F1F0 U+1F1EA
114	Kiribati	KIR	296	KI	686	Tarawa	AUD	Australian dollar	$	.ki	Kiribati	Oceania	Micronesia	{"{\\"tzName\\": \\"Phoenix Island Time\\", \\"zoneName\\": \\"Pacific/Enderbury\\", \\"gmtOffset\\": 46800, \\"abbreviation\\": \\"PHOT\\", \\"gmtOffsetName\\": \\"UTC+13:00\\"}","{\\"tzName\\": \\"Line Islands Time\\", \\"zoneName\\": \\"Pacific/Kiritimati\\", \\"gmtOffset\\": 50400, \\"abbreviation\\": \\"LINT\\", \\"gmtOffsetName\\": \\"UTC+14:00\\"}","{\\"tzName\\": \\"Gilbert Island Time\\", \\"zoneName\\": \\"Pacific/Tarawa\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"GILT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "基里巴斯", "de": "Kiribati", "es": "Kiribati", "fa": "کیریباتی", "fr": "Kiribati", "hr": "Kiribati", "it": "Kiribati", "ja": "キリバス", "kr": "키리바시", "nl": "Kiribati", "pt": "Quiribáti", "tr": "Kiribati", "pt-BR": "Kiribati"}	1.41666666	173	🇰🇮	U+1F1F0 U+1F1EE
248	Kosovo	XKX	926	XK	383	Pristina	EUR	Euro	€	.xk	Republika e Kosovës	Europe	Eastern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Belgrade\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "科索沃", "kr": "코소보", "tr": "Kosova"}	42.5612909	20.3403035	🇽🇰	U+1F1FD U+1F1F0
117	Kuwait	KWT	414	KW	965	Kuwait City	KWD	Kuwaiti dinar	ك.د	.kw	الكويت	Asia	Western Asia	{"{\\"tzName\\": \\"Arabia Standard Time\\", \\"zoneName\\": \\"Asia/Kuwait\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "科威特", "de": "Kuwait", "es": "Kuwait", "fa": "کویت", "fr": "Koweït", "hr": "Kuvajt", "it": "Kuwait", "ja": "クウェート", "kr": "쿠웨이트", "nl": "Koeweit", "pt": "Kuwait", "tr": "Kuveyt", "pt-BR": "Kuwait"}	29.5	45.75	🇰🇼	U+1F1F0 U+1F1FC
118	Kyrgyzstan	KGZ	417	KG	996	Bishkek	KGS	Kyrgyzstani som	лв	.kg	Кыргызстан	Asia	Central Asia	{"{\\"tzName\\": \\"Kyrgyzstan Time\\", \\"zoneName\\": \\"Asia/Bishkek\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"KGT\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}"}	{"cn": "吉尔吉斯斯坦", "de": "Kirgisistan", "es": "Kirguizistán", "fa": "قرقیزستان", "fr": "Kirghizistan", "hr": "Kirgistan", "it": "Kirghizistan", "ja": "キルギス", "kr": "키르기스스탄", "nl": "Kirgizië", "pt": "Quirguizistão", "tr": "Kirgizistan", "pt-BR": "Quirguistão"}	41	75	🇰🇬	U+1F1F0 U+1F1EC
119	Laos	LAO	418	LA	856	Vientiane	LAK	Lao kip	₭	.la	ສປປລາວ	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Indochina Time\\", \\"zoneName\\": \\"Asia/Vientiane\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"ICT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}"}	{"cn": "寮人民民主共和国", "de": "Laos", "es": "Laos", "fa": "لائوس", "fr": "Laos", "hr": "Laos", "it": "Laos", "ja": "ラオス人民民主共和国", "kr": "라오스", "nl": "Laos", "pt": "Laos", "tr": "Laos", "pt-BR": "Laos"}	18	105	🇱🇦	U+1F1F1 U+1F1E6
120	Latvia	LVA	428	LV	371	Riga	EUR	Euro	€	.lv	Latvija	Europe	Northern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Riga\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "拉脱维亚", "de": "Lettland", "es": "Letonia", "fa": "لتونی", "fr": "Lettonie", "hr": "Latvija", "it": "Lettonia", "ja": "ラトビア", "kr": "라트비아", "nl": "Letland", "pt": "Letónia", "tr": "Letonya", "pt-BR": "Letônia"}	57	25	🇱🇻	U+1F1F1 U+1F1FB
121	Lebanon	LBN	422	LB	961	Beirut	LBP	Lebanese pound	£	.lb	لبنان	Asia	Western Asia	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Beirut\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "黎巴嫩", "de": "Libanon", "es": "Líbano", "fa": "لبنان", "fr": "Liban", "hr": "Libanon", "it": "Libano", "ja": "レバノン", "kr": "레바논", "nl": "Libanon", "pt": "Líbano", "tr": "Lübnan", "pt-BR": "Líbano"}	33.83333333	35.83333333	🇱🇧	U+1F1F1 U+1F1E7
122	Lesotho	LSO	426	LS	266	Maseru	LSL	Lesotho loti	L	.ls	Lesotho	Africa	Southern Africa	{"{\\"tzName\\": \\"South African Standard Time\\", \\"zoneName\\": \\"Africa/Maseru\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"SAST\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "莱索托", "de": "Lesotho", "es": "Lesotho", "fa": "لسوتو", "fr": "Lesotho", "hr": "Lesoto", "it": "Lesotho", "ja": "レソト", "kr": "레소토", "nl": "Lesotho", "pt": "Lesoto", "tr": "Lesotho", "pt-BR": "Lesoto"}	-29.5	28.5	🇱🇸	U+1F1F1 U+1F1F8
123	Liberia	LBR	430	LR	231	Monrovia	LRD	Liberian dollar	$	.lr	Liberia	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Monrovia\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "利比里亚", "de": "Liberia", "es": "Liberia", "fa": "لیبریا", "fr": "Liberia", "hr": "Liberija", "it": "Liberia", "ja": "リベリア", "kr": "라이베리아", "nl": "Liberia", "pt": "Libéria", "tr": "Liberya", "pt-BR": "Libéria"}	6.5	-9.5	🇱🇷	U+1F1F1 U+1F1F7
124	Libya	LBY	434	LY	218	Tripolis	LYD	Libyan dinar	د.ل	.ly	‏ليبيا	Africa	Northern Africa	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Africa/Tripoli\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "利比亚", "de": "Libyen", "es": "Libia", "fa": "لیبی", "fr": "Libye", "hr": "Libija", "it": "Libia", "ja": "リビア", "kr": "리비아", "nl": "Libië", "pt": "Líbia", "tr": "Libya", "pt-BR": "Líbia"}	25	17	🇱🇾	U+1F1F1 U+1F1FE
125	Liechtenstein	LIE	438	LI	423	Vaduz	CHF	Swiss franc	CHf	.li	Liechtenstein	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Vaduz\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "列支敦士登", "de": "Liechtenstein", "es": "Liechtenstein", "fa": "لیختن‌اشتاین", "fr": "Liechtenstein", "hr": "Lihtenštajn", "it": "Liechtenstein", "ja": "リヒテンシュタイン", "kr": "리히텐슈타인", "nl": "Liechtenstein", "pt": "Listenstaine", "tr": "Lihtenştayn", "pt-BR": "Liechtenstein"}	47.26666666	9.53333333	🇱🇮	U+1F1F1 U+1F1EE
126	Lithuania	LTU	440	LT	370	Vilnius	EUR	Euro	€	.lt	Lietuva	Europe	Northern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Vilnius\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "立陶宛", "de": "Litauen", "es": "Lituania", "fa": "لیتوانی", "fr": "Lituanie", "hr": "Litva", "it": "Lituania", "ja": "リトアニア", "kr": "리투아니아", "nl": "Litouwen", "pt": "Lituânia", "tr": "Litvanya", "pt-BR": "Lituânia"}	56	24	🇱🇹	U+1F1F1 U+1F1F9
127	Luxembourg	LUX	442	LU	352	Luxembourg	EUR	Euro	€	.lu	Luxembourg	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Luxembourg\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "卢森堡", "de": "Luxemburg", "es": "Luxemburgo", "fa": "لوکزامبورگ", "fr": "Luxembourg", "hr": "Luksemburg", "it": "Lussemburgo", "ja": "ルクセンブルク", "kr": "룩셈부르크", "nl": "Luxemburg", "pt": "Luxemburgo", "tr": "Lüksemburg", "pt-BR": "Luxemburgo"}	49.75	6.16666666	🇱🇺	U+1F1F1 U+1F1FA
128	Macau S.A.R.	MAC	446	MO	853	Macao	MOP	Macanese pataca	$	.mo	澳門	Asia	Eastern Asia	{"{\\"tzName\\": \\"China Standard Time\\", \\"zoneName\\": \\"Asia/Macau\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "中国澳门", "de": "Macao", "es": "Macao", "fa": "مکائو", "fr": "Macao", "hr": "Makao", "it": "Macao", "ja": "マカオ", "kr": "마카오", "nl": "Macao", "pt": "Macau", "tr": "Makao", "pt-BR": "Macau"}	22.16666666	113.55	🇲🇴	U+1F1F2 U+1F1F4
129	Macedonia	MKD	807	MK	389	Skopje	MKD	Denar	ден	.mk	Северна Македонија	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Skopje\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "马其顿", "de": "Mazedonien", "es": "Macedonia", "fa": "", "fr": "Macédoine", "hr": "Makedonija", "it": "Macedonia", "ja": "マケドニア旧ユーゴスラビア共和国", "kr": "마케도니아", "nl": "Macedonië", "pt": "Macedónia", "tr": "Kuzey Makedonya", "pt-BR": "Macedônia"}	41.83333333	22	🇲🇰	U+1F1F2 U+1F1F0
130	Madagascar	MDG	450	MG	261	Antananarivo	MGA	Malagasy ariary	Ar	.mg	Madagasikara	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Indian/Antananarivo\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "马达加斯加", "de": "Madagaskar", "es": "Madagascar", "fa": "ماداگاسکار", "fr": "Madagascar", "hr": "Madagaskar", "it": "Madagascar", "ja": "マダガスカル", "kr": "마다가스카르", "nl": "Madagaskar", "pt": "Madagáscar", "tr": "Madagaskar", "pt-BR": "Madagascar"}	-20	47	🇲🇬	U+1F1F2 U+1F1EC
131	Malawi	MWI	454	MW	265	Lilongwe	MWK	Malawian kwacha	MK	.mw	Malawi	Africa	Eastern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Blantyre\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "马拉维", "de": "Malawi", "es": "Malawi", "fa": "مالاوی", "fr": "Malawi", "hr": "Malavi", "it": "Malawi", "ja": "マラウイ", "kr": "말라위", "nl": "Malawi", "pt": "Malávi", "tr": "Malavi", "pt-BR": "Malawi"}	-13.5	34	🇲🇼	U+1F1F2 U+1F1FC
132	Malaysia	MYS	458	MY	60	Kuala Lumpur	MYR	Malaysian ringgit	RM	.my	Malaysia	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Malaysia Time\\", \\"zoneName\\": \\"Asia/Kuala_Lumpur\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"MYT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}","{\\"tzName\\": \\"Malaysia Time\\", \\"zoneName\\": \\"Asia/Kuching\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"MYT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "马来西亚", "de": "Malaysia", "es": "Malasia", "fa": "مالزی", "fr": "Malaisie", "hr": "Malezija", "it": "Malesia", "ja": "マレーシア", "kr": "말레이시아", "nl": "Maleisië", "pt": "Malásia", "tr": "Malezya", "pt-BR": "Malásia"}	2.5	112.5	🇲🇾	U+1F1F2 U+1F1FE
133	Maldives	MDV	462	MV	960	Male	MVR	Maldivian rufiyaa	Rf	.mv	Maldives	Asia	Southern Asia	{"{\\"tzName\\": \\"Maldives Time\\", \\"zoneName\\": \\"Indian/Maldives\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"MVT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "马尔代夫", "de": "Malediven", "es": "Maldivas", "fa": "مالدیو", "fr": "Maldives", "hr": "Maldivi", "it": "Maldive", "ja": "モルディブ", "kr": "몰디브", "nl": "Maldiven", "pt": "Maldivas", "tr": "Maldivler", "pt-BR": "Maldivas"}	3.25	73	🇲🇻	U+1F1F2 U+1F1FB
134	Mali	MLI	466	ML	223	Bamako	XOF	West African CFA franc	CFA	.ml	Mali	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Bamako\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "马里", "de": "Mali", "es": "Mali", "fa": "مالی", "fr": "Mali", "hr": "Mali", "it": "Mali", "ja": "マリ", "kr": "말리", "nl": "Mali", "pt": "Mali", "tr": "Mali", "pt-BR": "Mali"}	17	-4	🇲🇱	U+1F1F2 U+1F1F1
135	Malta	MLT	470	MT	356	Valletta	EUR	Euro	€	.mt	Malta	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Malta\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "马耳他", "de": "Malta", "es": "Malta", "fa": "مالت", "fr": "Malte", "hr": "Malta", "it": "Malta", "ja": "マルタ", "kr": "몰타", "nl": "Malta", "pt": "Malta", "tr": "Malta", "pt-BR": "Malta"}	35.83333333	14.58333333	🇲🇹	U+1F1F2 U+1F1F9
136	Man (Isle of)	IMN	833	IM	+44-1624	Douglas, Isle of Man	GBP	British pound	£	.im	Isle of Man	Europe	Northern Europe	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Europe/Isle_of_Man\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "马恩岛", "de": "Insel Man", "es": "Isla de Man", "fa": "جزیره من", "fr": "Île de Man", "hr": "Otok Man", "it": "Isola di Man", "ja": "マン島", "kr": "맨 섬", "nl": "Isle of Man", "pt": "Ilha de Man", "tr": "Man Adasi", "pt-BR": "Ilha de Man"}	54.25	-4.5	🇮🇲	U+1F1EE U+1F1F2
137	Marshall Islands	MHL	584	MH	692	Majuro	USD	United States dollar	$	.mh	M̧ajeļ	Oceania	Micronesia	{"{\\"tzName\\": \\"Marshall Islands Time\\", \\"zoneName\\": \\"Pacific/Kwajalein\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"MHT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}","{\\"tzName\\": \\"Marshall Islands Time\\", \\"zoneName\\": \\"Pacific/Majuro\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"MHT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "马绍尔群岛", "de": "Marshallinseln", "es": "Islas Marshall", "fa": "جزایر مارشال", "fr": "Îles Marshall", "hr": "Maršalovi Otoci", "it": "Isole Marshall", "ja": "マーシャル諸島", "kr": "마셜 제도", "nl": "Marshalleilanden", "pt": "Ilhas Marshall", "tr": "Marşal Adalari", "pt-BR": "Ilhas Marshall"}	9	168	🇲🇭	U+1F1F2 U+1F1ED
138	Martinique	MTQ	474	MQ	596	Fort-de-France	EUR	Euro	€	.mq	Martinique	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Martinique\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "马提尼克岛", "de": "Martinique", "es": "Martinica", "fa": "مونتسرات", "fr": "Martinique", "hr": "Martinique", "it": "Martinica", "ja": "マルティニーク", "kr": "마르티니크", "nl": "Martinique", "pt": "Martinica", "tr": "Martinik", "pt-BR": "Martinica"}	14.666667	-61	🇲🇶	U+1F1F2 U+1F1F6
139	Mauritania	MRT	478	MR	222	Nouakchott	MRO	Mauritanian ouguiya	MRU	.mr	موريتانيا	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Nouakchott\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "毛里塔尼亚", "de": "Mauretanien", "es": "Mauritania", "fa": "موریتانی", "fr": "Mauritanie", "hr": "Mauritanija", "it": "Mauritania", "ja": "モーリタニア", "kr": "모리타니", "nl": "Mauritanië", "pt": "Mauritânia", "tr": "Moritanya", "pt-BR": "Mauritânia"}	20	-12	🇲🇷	U+1F1F2 U+1F1F7
140	Mauritius	MUS	480	MU	230	Port Louis	MUR	Mauritian rupee	₨	.mu	Maurice	Africa	Eastern Africa	{"{\\"tzName\\": \\"Mauritius Time\\", \\"zoneName\\": \\"Indian/Mauritius\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"MUT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "毛里求斯", "de": "Mauritius", "es": "Mauricio", "fa": "موریس", "fr": "Île Maurice", "hr": "Mauricijus", "it": "Mauritius", "ja": "モーリシャス", "kr": "모리셔스", "nl": "Mauritius", "pt": "Maurícia", "tr": "Morityus", "pt-BR": "Maurício"}	-20.28333333	57.55	🇲🇺	U+1F1F2 U+1F1FA
141	Mayotte	MYT	175	YT	262	Mamoudzou	EUR	Euro	€	.yt	Mayotte	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Indian/Mayotte\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "马约特", "de": "Mayotte", "es": "Mayotte", "fa": "مایوت", "fr": "Mayotte", "hr": "Mayotte", "it": "Mayotte", "ja": "マヨット", "kr": "마요트", "nl": "Mayotte", "pt": "Mayotte", "tr": "Mayotte", "pt-BR": "Mayotte"}	-12.83333333	45.16666666	🇾🇹	U+1F1FE U+1F1F9
142	Mexico	MEX	484	MX	52	Ciudad de México	MXN	Mexican peso	$	.mx	México	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Bahia_Banderas\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Cancun\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Chihuahua\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Hermosillo\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Matamoros\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Mazatlan\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Merida\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Mexico_City\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Monterrey\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Ojinaga\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Pacific Standard Time (North America\\", \\"zoneName\\": \\"America/Tijuana\\", \\"gmtOffset\\": -28800, \\"abbreviation\\": \\"PST\\", \\"gmtOffsetName\\": \\"UTC-08:00\\"}"}	{"cn": "墨西哥", "de": "Mexiko", "es": "México", "fa": "مکزیک", "fr": "Mexique", "hr": "Meksiko", "it": "Messico", "ja": "メキシコ", "kr": "멕시코", "nl": "Mexico", "pt": "México", "tr": "Meksika", "pt-BR": "México"}	23	-102	🇲🇽	U+1F1F2 U+1F1FD
143	Micronesia	FSM	583	FM	691	Palikir	USD	United States dollar	$	.fm	Micronesia	Oceania	Micronesia	{"{\\"tzName\\": \\"Chuuk Time\\", \\"zoneName\\": \\"Pacific/Chuuk\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"CHUT\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}","{\\"tzName\\": \\"Kosrae Time\\", \\"zoneName\\": \\"Pacific/Kosrae\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"KOST\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Pohnpei Standard Time\\", \\"zoneName\\": \\"Pacific/Pohnpei\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"PONT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}"}	{"cn": "密克罗尼西亚", "de": "Mikronesien", "es": "Micronesia", "fa": "ایالات فدرال میکرونزی", "fr": "Micronésie", "hr": "Mikronezija", "it": "Micronesia", "ja": "ミクロネシア連邦", "kr": "미크로네시아 연방", "nl": "Micronesië", "pt": "Micronésia", "tr": "Mikronezya", "pt-BR": "Micronésia"}	6.91666666	158.25	🇫🇲	U+1F1EB U+1F1F2
144	Moldova	MDA	498	MD	373	Chisinau	MDL	Moldovan leu	L	.md	Moldova	Europe	Eastern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Chisinau\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "摩尔多瓦", "de": "Moldawie", "es": "Moldavia", "fa": "مولداوی", "fr": "Moldavie", "hr": "Moldova", "it": "Moldavia", "ja": "モルドバ共和国", "kr": "몰도바", "nl": "Moldavië", "pt": "Moldávia", "tr": "Moldova", "pt-BR": "Moldávia"}	47	29	🇲🇩	U+1F1F2 U+1F1E9
145	Monaco	MCO	492	MC	377	Monaco	EUR	Euro	€	.mc	Monaco	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Monaco\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "摩纳哥", "de": "Monaco", "es": "Mónaco", "fa": "موناکو", "fr": "Monaco", "hr": "Monako", "it": "Principato di Monaco", "ja": "モナコ", "kr": "모나코", "nl": "Monaco", "pt": "Mónaco", "tr": "Monako", "pt-BR": "Mônaco"}	43.73333333	7.4	🇲🇨	U+1F1F2 U+1F1E8
146	Mongolia	MNG	496	MN	976	Ulan Bator	MNT	Mongolian tögrög	₮	.mn	Монгол улс	Asia	Eastern Asia	{"{\\"tzName\\": \\"Choibalsan Standard Time\\", \\"zoneName\\": \\"Asia/Choibalsan\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"CHOT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}","{\\"tzName\\": \\"Hovd Time\\", \\"zoneName\\": \\"Asia/Hovd\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"HOVT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Ulaanbaatar Standard Time\\", \\"zoneName\\": \\"Asia/Ulaanbaatar\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"ULAT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "蒙古", "de": "Mongolei", "es": "Mongolia", "fa": "مغولستان", "fr": "Mongolie", "hr": "Mongolija", "it": "Mongolia", "ja": "モンゴル", "kr": "몽골", "nl": "Mongolië", "pt": "Mongólia", "tr": "Moğolistan", "pt-BR": "Mongólia"}	46	105	🇲🇳	U+1F1F2 U+1F1F3
147	Montenegro	MNE	499	ME	382	Podgorica	EUR	Euro	€	.me	Црна Гора	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Podgorica\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "黑山", "de": "Montenegro", "es": "Montenegro", "fa": "مونته‌نگرو", "fr": "Monténégro", "hr": "Crna Gora", "it": "Montenegro", "ja": "モンテネグロ", "kr": "몬테네그로", "nl": "Montenegro", "pt": "Montenegro", "tr": "Karadağ", "pt-BR": "Montenegro"}	42.5	19.3	🇲🇪	U+1F1F2 U+1F1EA
148	Montserrat	MSR	500	MS	+1-664	Plymouth	XCD	Eastern Caribbean dollar	$	.ms	Montserrat	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Montserrat\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "蒙特塞拉特", "de": "Montserrat", "es": "Montserrat", "fa": "مایوت", "fr": "Montserrat", "hr": "Montserrat", "it": "Montserrat", "ja": "モントセラト", "kr": "몬트세랫", "nl": "Montserrat", "pt": "Monserrate", "tr": "Montserrat", "pt-BR": "Montserrat"}	16.75	-62.2	🇲🇸	U+1F1F2 U+1F1F8
149	Morocco	MAR	504	MA	212	Rabat	MAD	Moroccan dirham	DH	.ma	المغرب	Africa	Northern Africa	{"{\\"tzName\\": \\"Western European Summer Time\\", \\"zoneName\\": \\"Africa/Casablanca\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WEST\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "摩洛哥", "de": "Marokko", "es": "Marruecos", "fa": "مراکش", "fr": "Maroc", "hr": "Maroko", "it": "Marocco", "ja": "モロッコ", "kr": "모로코", "nl": "Marokko", "pt": "Marrocos", "tr": "Fas", "pt-BR": "Marrocos"}	32	-5	🇲🇦	U+1F1F2 U+1F1E6
150	Mozambique	MOZ	508	MZ	258	Maputo	MZN	Mozambican metical	MT	.mz	Moçambique	Africa	Eastern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Maputo\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "莫桑比克", "de": "Mosambik", "es": "Mozambique", "fa": "موزامبیک", "fr": "Mozambique", "hr": "Mozambik", "it": "Mozambico", "ja": "モザンビーク", "kr": "모잠비크", "nl": "Mozambique", "pt": "Moçambique", "tr": "Mozambik", "pt-BR": "Moçambique"}	-18.25	35	🇲🇿	U+1F1F2 U+1F1FF
151	Myanmar	MMR	104	MM	95	Nay Pyi Taw	MMK	Burmese kyat	K	.mm	မြန်မာ	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Myanmar Standard Time\\", \\"zoneName\\": \\"Asia/Yangon\\", \\"gmtOffset\\": 23400, \\"abbreviation\\": \\"MMT\\", \\"gmtOffsetName\\": \\"UTC+06:30\\"}"}	{"cn": "缅甸", "de": "Myanmar", "es": "Myanmar", "fa": "میانمار", "fr": "Myanmar", "hr": "Mijanmar", "it": "Birmania", "ja": "ミャンマー", "kr": "미얀마", "nl": "Myanmar", "pt": "Myanmar", "tr": "Myanmar", "pt-BR": "Myanmar"}	22	98	🇲🇲	U+1F1F2 U+1F1F2
152	Namibia	NAM	516	NA	264	Windhoek	NAD	Namibian dollar	$	.na	Namibia	Africa	Southern Africa	{"{\\"tzName\\": \\"West Africa Summer Time\\", \\"zoneName\\": \\"Africa/Windhoek\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"WAST\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "纳米比亚", "de": "Namibia", "es": "Namibia", "fa": "نامیبیا", "fr": "Namibie", "hr": "Namibija", "it": "Namibia", "ja": "ナミビア", "kr": "나미비아", "nl": "Namibië", "pt": "Namíbia", "tr": "Namibya", "pt-BR": "Namíbia"}	-22	17	🇳🇦	U+1F1F3 U+1F1E6
153	Nauru	NRU	520	NR	674	Yaren	AUD	Australian dollar	$	.nr	Nauru	Oceania	Micronesia	{"{\\"tzName\\": \\"Nauru Time\\", \\"zoneName\\": \\"Pacific/Nauru\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"NRT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "瑙鲁", "de": "Nauru", "es": "Nauru", "fa": "نائورو", "fr": "Nauru", "hr": "Nauru", "it": "Nauru", "ja": "ナウル", "kr": "나우루", "nl": "Nauru", "pt": "Nauru", "tr": "Nauru", "pt-BR": "Nauru"}	-0.53333333	166.91666666	🇳🇷	U+1F1F3 U+1F1F7
154	Nepal	NPL	524	NP	977	Kathmandu	NPR	Nepalese rupee	₨	.np	नपल	Asia	Southern Asia	{"{\\"tzName\\": \\"Nepal Time\\", \\"zoneName\\": \\"Asia/Kathmandu\\", \\"gmtOffset\\": 20700, \\"abbreviation\\": \\"NPT\\", \\"gmtOffsetName\\": \\"UTC+05:45\\"}"}	{"cn": "尼泊尔", "de": "Népal", "es": "Nepal", "fa": "نپال", "fr": "Népal", "hr": "Nepal", "it": "Nepal", "ja": "ネパール", "kr": "네팔", "nl": "Nepal", "pt": "Nepal", "tr": "Nepal", "pt-BR": "Nepal"}	28	84	🇳🇵	U+1F1F3 U+1F1F5
156	Netherlands	NLD	528	NL	31	Amsterdam	EUR	Euro	€	.nl	Nederland	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Amsterdam\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "荷兰", "de": "Niederlande", "es": "Países Bajos", "fa": "پادشاهی هلند", "fr": "Pays-Bas", "hr": "Nizozemska", "it": "Paesi Bassi", "ja": "オランダ", "kr": "네덜란드 ", "nl": "Nederland", "pt": "Países Baixos", "tr": "Hollanda", "pt-BR": "Holanda"}	52.5	5.75	🇳🇱	U+1F1F3 U+1F1F1
157	New Caledonia	NCL	540	NC	687	Noumea	XPF	CFP franc	₣	.nc	Nouvelle-Calédonie	Oceania	Melanesia	{"{\\"tzName\\": \\"New Caledonia Time\\", \\"zoneName\\": \\"Pacific/Noumea\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"NCT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}"}	{"cn": "新喀里多尼亚", "de": "Neukaledonien", "es": "Nueva Caledonia", "fa": "کالدونیای جدید", "fr": "Nouvelle-Calédonie", "hr": "Nova Kaledonija", "it": "Nuova Caledonia", "ja": "ニューカレドニア", "kr": "누벨칼레도니", "nl": "Nieuw-Caledonië", "pt": "Nova Caledónia", "tr": "Yeni Kaledonya", "pt-BR": "Nova Caledônia"}	-21.5	165.5	🇳🇨	U+1F1F3 U+1F1E8
158	New Zealand	NZL	554	NZ	64	Wellington	NZD	New Zealand dollar	$	.nz	New Zealand	Oceania	Australia and New Zealand	{"{\\"tzName\\": \\"New Zealand Daylight Time\\", \\"zoneName\\": \\"Pacific/Auckland\\", \\"gmtOffset\\": 46800, \\"abbreviation\\": \\"NZDT\\", \\"gmtOffsetName\\": \\"UTC+13:00\\"}","{\\"tzName\\": \\"Chatham Standard Time\\", \\"zoneName\\": \\"Pacific/Chatham\\", \\"gmtOffset\\": 49500, \\"abbreviation\\": \\"CHAST\\", \\"gmtOffsetName\\": \\"UTC+13:45\\"}"}	{"cn": "新西兰", "de": "Neuseeland", "es": "Nueva Zelanda", "fa": "نیوزیلند", "fr": "Nouvelle-Zélande", "hr": "Novi Zeland", "it": "Nuova Zelanda", "ja": "ニュージーランド", "kr": "뉴질랜드", "nl": "Nieuw-Zeeland", "pt": "Nova Zelândia", "tr": "Yeni Zelanda", "pt-BR": "Nova Zelândia"}	-41	174	🇳🇿	U+1F1F3 U+1F1FF
159	Nicaragua	NIC	558	NI	505	Managua	NIO	Nicaraguan córdoba	C$	.ni	Nicaragua	Americas	Central America	{"{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Managua\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}"}	{"cn": "尼加拉瓜", "de": "Nicaragua", "es": "Nicaragua", "fa": "نیکاراگوئه", "fr": "Nicaragua", "hr": "Nikaragva", "it": "Nicaragua", "ja": "ニカラグア", "kr": "니카라과", "nl": "Nicaragua", "pt": "Nicarágua", "tr": "Nikaragua", "pt-BR": "Nicarágua"}	13	-85	🇳🇮	U+1F1F3 U+1F1EE
160	Niger	NER	562	NE	227	Niamey	XOF	West African CFA franc	CFA	.ne	Niger	Africa	Western Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Niamey\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "尼日尔", "de": "Niger", "es": "Níger", "fa": "نیجر", "fr": "Niger", "hr": "Niger", "it": "Niger", "ja": "ニジェール", "kr": "니제르", "nl": "Niger", "pt": "Níger", "tr": "Nijer", "pt-BR": "Níger"}	16	8	🇳🇪	U+1F1F3 U+1F1EA
161	Nigeria	NGA	566	NG	234	Abuja	NGN	Nigerian naira	₦	.ng	Nigeria	Africa	Western Africa	{"{\\"tzName\\": \\"West Africa Time\\", \\"zoneName\\": \\"Africa/Lagos\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WAT\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "尼日利亚", "de": "Nigeria", "es": "Nigeria", "fa": "نیجریه", "fr": "Nigéria", "hr": "Nigerija", "it": "Nigeria", "ja": "ナイジェリア", "kr": "나이지리아", "nl": "Nigeria", "pt": "Nigéria", "tr": "Nijerya", "pt-BR": "Nigéria"}	10	8	🇳🇬	U+1F1F3 U+1F1EC
162	Niue	NIU	570	NU	683	Alofi	NZD	New Zealand dollar	$	.nu	Niuē	Oceania	Polynesia	{"{\\"tzName\\": \\"Niue Time\\", \\"zoneName\\": \\"Pacific/Niue\\", \\"gmtOffset\\": -39600, \\"abbreviation\\": \\"NUT\\", \\"gmtOffsetName\\": \\"UTC-11:00\\"}"}	{"cn": "纽埃", "de": "Niue", "es": "Niue", "fa": "نیووی", "fr": "Niue", "hr": "Niue", "it": "Niue", "ja": "ニウエ", "kr": "니우에", "nl": "Niue", "pt": "Niue", "tr": "Niue", "pt-BR": "Niue"}	-19.03333333	-169.86666666	🇳🇺	U+1F1F3 U+1F1FA
163	Norfolk Island	NFK	574	NF	672	Kingston	AUD	Australian dollar	$	.nf	Norfolk Island	Oceania	Australia and New Zealand	{"{\\"tzName\\": \\"Norfolk Time\\", \\"zoneName\\": \\"Pacific/Norfolk\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"NFT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "诺福克岛", "de": "Norfolkinsel", "es": "Isla de Norfolk", "fa": "جزیره نورفک", "fr": "Île de Norfolk", "hr": "Otok Norfolk", "it": "Isola Norfolk", "ja": "ノーフォーク島", "kr": "노퍽 섬", "nl": "Norfolkeiland", "pt": "Ilha Norfolk", "tr": "Norfolk Adasi", "pt-BR": "Ilha Norfolk"}	-29.03333333	167.95	🇳🇫	U+1F1F3 U+1F1EB
115	North Korea	PRK	408	KP	850	Pyongyang	KPW	North Korean Won	₩	.kp	북한	Asia	Eastern Asia	{"{\\"tzName\\": \\"Korea Standard Time\\", \\"zoneName\\": \\"Asia/Pyongyang\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"KST\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}"}	{"cn": "朝鲜", "de": "Nordkorea", "es": "Corea del Norte", "fa": "کره جنوبی", "fr": "Corée du Nord", "hr": "Sjeverna Koreja", "it": "Corea del Nord", "ja": "朝鮮民主主義人民共和国", "kr": "조선민주주의인민공화국", "nl": "Noord-Korea", "pt": "Coreia do Norte", "tr": "Kuzey Kore", "pt-BR": "Coreia do Norte"}	40	127	🇰🇵	U+1F1F0 U+1F1F5
164	Northern Mariana Islands	MNP	580	MP	+1-670	Saipan	USD	United States dollar	$	.mp	Northern Mariana Islands	Oceania	Micronesia	{"{\\"tzName\\": \\"Chamorro Standard Time\\", \\"zoneName\\": \\"Pacific/Saipan\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"ChST\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}"}	{"cn": "北马里亚纳群岛", "de": "Nördliche Marianen", "es": "Islas Marianas del Norte", "fa": "جزایر ماریانای شمالی", "fr": "Îles Mariannes du Nord", "hr": "Sjevernomarijanski otoci", "it": "Isole Marianne Settentrionali", "ja": "北マリアナ諸島", "kr": "북마리아나 제도", "nl": "Noordelijke Marianeneilanden", "pt": "Ilhas Marianas", "tr": "Kuzey Mariana Adalari", "pt-BR": "Ilhas Marianas"}	15.2	145.75	🇲🇵	U+1F1F2 U+1F1F5
165	Norway	NOR	578	NO	47	Oslo	NOK	Norwegian krone	kr	.no	Norge	Europe	Northern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Oslo\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "挪威", "de": "Norwegen", "es": "Noruega", "fa": "نروژ", "fr": "Norvège", "hr": "Norveška", "it": "Norvegia", "ja": "ノルウェー", "kr": "노르웨이", "nl": "Noorwegen", "pt": "Noruega", "tr": "Norveç", "pt-BR": "Noruega"}	62	10	🇳🇴	U+1F1F3 U+1F1F4
166	Oman	OMN	512	OM	968	Muscat	OMR	Omani rial	.ع.ر	.om	عمان	Asia	Western Asia	{"{\\"tzName\\": \\"Gulf Standard Time\\", \\"zoneName\\": \\"Asia/Muscat\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"GST\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "阿曼", "de": "Oman", "es": "Omán", "fa": "عمان", "fr": "Oman", "hr": "Oman", "it": "oman", "ja": "オマーン", "kr": "오만", "nl": "Oman", "pt": "Omã", "tr": "Umman", "pt-BR": "Omã"}	21	57	🇴🇲	U+1F1F4 U+1F1F2
167	Pakistan	PAK	586	PK	92	Islamabad	PKR	Pakistani rupee	₨	.pk	Pakistan	Asia	Southern Asia	{"{\\"tzName\\": \\"Pakistan Standard Time\\", \\"zoneName\\": \\"Asia/Karachi\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"PKT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "巴基斯坦", "de": "Pakistan", "es": "Pakistán", "fa": "پاکستان", "fr": "Pakistan", "hr": "Pakistan", "it": "Pakistan", "ja": "パキスタン", "kr": "파키스탄", "nl": "Pakistan", "pt": "Paquistão", "tr": "Pakistan", "pt-BR": "Paquistão"}	30	70	🇵🇰	U+1F1F5 U+1F1F0
168	Palau	PLW	585	PW	680	Melekeok	USD	United States dollar	$	.pw	Palau	Oceania	Micronesia	{"{\\"tzName\\": \\"Palau Time\\", \\"zoneName\\": \\"Pacific/Palau\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"PWT\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}"}	{"cn": "帕劳", "de": "Palau", "es": "Palau", "fa": "پالائو", "fr": "Palaos", "hr": "Palau", "it": "Palau", "ja": "パラオ", "kr": "팔라우", "nl": "Palau", "pt": "Palau", "tr": "Palau", "pt-BR": "Palau"}	7.5	134.5	🇵🇼	U+1F1F5 U+1F1FC
169	Palestinian Territory Occupied	PSE	275	PS	970	East Jerusalem	ILS	Israeli new shekel	₪	.ps	فلسطين	Asia	Western Asia	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Gaza\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}","{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Hebron\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "巴勒斯坦", "de": "Palästina", "es": "Palestina", "fa": "فلسطین", "fr": "Palestine", "hr": "Palestina", "it": "Palestina", "ja": "パレスチナ", "kr": "팔레스타인 영토", "nl": "Palestijnse gebieden", "pt": "Palestina", "tr": "Filistin", "pt-BR": "Palestina"}	31.9	35.2	🇵🇸	U+1F1F5 U+1F1F8
170	Panama	PAN	591	PA	507	Panama City	PAB	Panamanian balboa	B/.	.pa	Panamá	Americas	Central America	{"{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Panama\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "巴拿马", "de": "Panama", "es": "Panamá", "fa": "پاناما", "fr": "Panama", "hr": "Panama", "it": "Panama", "ja": "パナマ", "kr": "파나마", "nl": "Panama", "pt": "Panamá", "tr": "Panama", "pt-BR": "Panamá"}	9	-80	🇵🇦	U+1F1F5 U+1F1E6
171	Papua new Guinea	PNG	598	PG	675	Port Moresby	PGK	Papua New Guinean kina	K	.pg	Papua Niugini	Oceania	Melanesia	{"{\\"tzName\\": \\"Bougainville Standard Time[6\\", \\"zoneName\\": \\"Pacific/Bougainville\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"BST\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Papua New Guinea Time\\", \\"zoneName\\": \\"Pacific/Port_Moresby\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"PGT\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}"}	{"cn": "巴布亚新几内亚", "de": "Papua-Neuguinea", "es": "Papúa Nueva Guinea", "fa": "پاپوآ گینه نو", "fr": "Papouasie-Nouvelle-Guinée", "hr": "Papua Nova Gvineja", "it": "Papua Nuova Guinea", "ja": "パプアニューギニア", "kr": "파푸아뉴기니", "nl": "Papoea-Nieuw-Guinea", "pt": "Papua Nova Guiné", "tr": "Papua Yeni Gine", "pt-BR": "Papua Nova Guiné"}	-6	147	🇵🇬	U+1F1F5 U+1F1EC
172	Paraguay	PRY	600	PY	595	Asuncion	PYG	Paraguayan guarani	₲	.py	Paraguay	Americas	South America	{"{\\"tzName\\": \\"Paraguay Summer Time\\", \\"zoneName\\": \\"America/Asuncion\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"PYST\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "巴拉圭", "de": "Paraguay", "es": "Paraguay", "fa": "پاراگوئه", "fr": "Paraguay", "hr": "Paragvaj", "it": "Paraguay", "ja": "パラグアイ", "kr": "파라과이", "nl": "Paraguay", "pt": "Paraguai", "tr": "Paraguay", "pt-BR": "Paraguai"}	-23	-58	🇵🇾	U+1F1F5 U+1F1FE
173	Peru	PER	604	PE	51	Lima	PEN	Peruvian sol	S/.	.pe	Perú	Americas	South America	{"{\\"tzName\\": \\"Peru Time\\", \\"zoneName\\": \\"America/Lima\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"PET\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "秘鲁", "de": "Peru", "es": "Perú", "fa": "پرو", "fr": "Pérou", "hr": "Peru", "it": "Perù", "ja": "ペルー", "kr": "페루", "nl": "Peru", "pt": "Peru", "tr": "Peru", "pt-BR": "Peru"}	-10	-76	🇵🇪	U+1F1F5 U+1F1EA
174	Philippines	PHL	608	PH	63	Manila	PHP	Philippine peso	₱	.ph	Pilipinas	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Philippine Time\\", \\"zoneName\\": \\"Asia/Manila\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"PHT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "菲律宾", "de": "Philippinen", "es": "Filipinas", "fa": "جزایر الندفیلیپین", "fr": "Philippines", "hr": "Filipini", "it": "Filippine", "ja": "フィリピン", "kr": "필리핀", "nl": "Filipijnen", "pt": "Filipinas", "tr": "Filipinler", "pt-BR": "Filipinas"}	13	122	🇵🇭	U+1F1F5 U+1F1ED
175	Pitcairn Island	PCN	612	PN	870	Adamstown	NZD	New Zealand dollar	$	.pn	Pitcairn Islands	Oceania	Polynesia	{"{\\"tzName\\": \\"Pacific Standard Time (North America\\", \\"zoneName\\": \\"Pacific/Pitcairn\\", \\"gmtOffset\\": -28800, \\"abbreviation\\": \\"PST\\", \\"gmtOffsetName\\": \\"UTC-08:00\\"}"}	{"cn": "皮特凯恩群岛", "de": "Pitcairn", "es": "Islas Pitcairn", "fa": "پیتکرن", "fr": "Îles Pitcairn", "hr": "Pitcairnovo otočje", "it": "Isole Pitcairn", "ja": "ピトケアン", "kr": "핏케언 제도", "nl": "Pitcairneilanden", "pt": "Ilhas Picárnia", "tr": "Pitcairn Adalari", "pt-BR": "Ilhas Pitcairn"}	-25.06666666	-130.1	🇵🇳	U+1F1F5 U+1F1F3
176	Poland	POL	616	PL	48	Warsaw	PLN	Polish złoty	zł	.pl	Polska	Europe	Eastern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Warsaw\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "波兰", "de": "Polen", "es": "Polonia", "fa": "لهستان", "fr": "Pologne", "hr": "Poljska", "it": "Polonia", "ja": "ポーランド", "kr": "폴란드", "nl": "Polen", "pt": "Polónia", "tr": "Polonya", "pt-BR": "Polônia"}	52	20	🇵🇱	U+1F1F5 U+1F1F1
177	Portugal	PRT	620	PT	351	Lisbon	EUR	Euro	€	.pt	Portugal	Europe	Southern Europe	{"{\\"tzName\\": \\"Azores Standard Time\\", \\"zoneName\\": \\"Atlantic/Azores\\", \\"gmtOffset\\": -3600, \\"abbreviation\\": \\"AZOT\\", \\"gmtOffsetName\\": \\"UTC-01:00\\"}","{\\"tzName\\": \\"Western European Time\\", \\"zoneName\\": \\"Atlantic/Madeira\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"WET\\", \\"gmtOffsetName\\": \\"UTC±00\\"}","{\\"tzName\\": \\"Western European Time\\", \\"zoneName\\": \\"Europe/Lisbon\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"WET\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "葡萄牙", "de": "Portugal", "es": "Portugal", "fa": "پرتغال", "fr": "Portugal", "hr": "Portugal", "it": "Portogallo", "ja": "ポルトガル", "kr": "포르투갈", "nl": "Portugal", "pt": "Portugal", "tr": "Portekiz", "pt-BR": "Portugal"}	39.5	-8	🇵🇹	U+1F1F5 U+1F1F9
178	Puerto Rico	PRI	630	PR	+1-787 and 1-939	San Juan	USD	United States dollar	$	.pr	Puerto Rico	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Puerto_Rico\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "波多黎各", "de": "Puerto Rico", "es": "Puerto Rico", "fa": "پورتو ریکو", "fr": "Porto Rico", "hr": "Portoriko", "it": "Porto Rico", "ja": "プエルトリコ", "kr": "푸에르토리코", "nl": "Puerto Rico", "pt": "Porto Rico", "tr": "Porto Riko", "pt-BR": "Porto Rico"}	18.25	-66.5	🇵🇷	U+1F1F5 U+1F1F7
179	Qatar	QAT	634	QA	974	Doha	QAR	Qatari riyal	ق.ر	.qa	قطر	Asia	Western Asia	{"{\\"tzName\\": \\"Arabia Standard Time\\", \\"zoneName\\": \\"Asia/Qatar\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "卡塔尔", "de": "Katar", "es": "Catar", "fa": "قطر", "fr": "Qatar", "hr": "Katar", "it": "Qatar", "ja": "カタール", "kr": "카타르", "nl": "Qatar", "pt": "Catar", "tr": "Katar", "pt-BR": "Catar"}	25.5	51.25	🇶🇦	U+1F1F6 U+1F1E6
180	Reunion	REU	638	RE	262	Saint-Denis	EUR	Euro	€	.re	La Réunion	Africa	Eastern Africa	{"{\\"tzName\\": \\"Réunion Time\\", \\"zoneName\\": \\"Indian/Reunion\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"RET\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "留尼汪岛", "de": "Réunion", "es": "Reunión", "fa": "رئونیون", "fr": "Réunion", "hr": "Réunion", "it": "Riunione", "ja": "レユニオン", "kr": "레위니옹", "nl": "Réunion", "pt": "Reunião", "tr": "Réunion", "pt-BR": "Reunião"}	-21.15	55.5	🇷🇪	U+1F1F7 U+1F1EA
181	Romania	ROU	642	RO	40	Bucharest	RON	Romanian leu	lei	.ro	România	Europe	Eastern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Bucharest\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "罗马尼亚", "de": "Rumänien", "es": "Rumania", "fa": "رومانی", "fr": "Roumanie", "hr": "Rumunjska", "it": "Romania", "ja": "ルーマニア", "kr": "루마니아", "nl": "Roemenië", "pt": "Roménia", "tr": "Romanya", "pt-BR": "Romênia"}	46	25	🇷🇴	U+1F1F7 U+1F1F4
182	Russia	RUS	643	RU	7	Moscow	RUB	Russian ruble	₽	.ru	Россия	Europe	Eastern Europe	{"{\\"tzName\\": \\"Anadyr Time[4\\", \\"zoneName\\": \\"Asia/Anadyr\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"ANAT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}","{\\"tzName\\": \\"Krasnoyarsk Time\\", \\"zoneName\\": \\"Asia/Barnaul\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"KRAT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Yakutsk Time\\", \\"zoneName\\": \\"Asia/Chita\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"YAKT\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}","{\\"tzName\\": \\"Irkutsk Time\\", \\"zoneName\\": \\"Asia/Irkutsk\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"IRKT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}","{\\"tzName\\": \\"Kamchatka Time\\", \\"zoneName\\": \\"Asia/Kamchatka\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"PETT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}","{\\"tzName\\": \\"Yakutsk Time\\", \\"zoneName\\": \\"Asia/Khandyga\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"YAKT\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}","{\\"tzName\\": \\"Krasnoyarsk Time\\", \\"zoneName\\": \\"Asia/Krasnoyarsk\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"KRAT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Magadan Time\\", \\"zoneName\\": \\"Asia/Magadan\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"MAGT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Krasnoyarsk Time\\", \\"zoneName\\": \\"Asia/Novokuznetsk\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"KRAT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Novosibirsk Time\\", \\"zoneName\\": \\"Asia/Novosibirsk\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"NOVT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Omsk Time\\", \\"zoneName\\": \\"Asia/Omsk\\", \\"gmtOffset\\": 21600, \\"abbreviation\\": \\"OMST\\", \\"gmtOffsetName\\": \\"UTC+06:00\\"}","{\\"tzName\\": \\"Sakhalin Island Time\\", \\"zoneName\\": \\"Asia/Sakhalin\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"SAKT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Srednekolymsk Time\\", \\"zoneName\\": \\"Asia/Srednekolymsk\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"SRET\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}","{\\"tzName\\": \\"Moscow Daylight Time+3\\", \\"zoneName\\": \\"Asia/Tomsk\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"MSD+3\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}","{\\"tzName\\": \\"Vladivostok Time\\", \\"zoneName\\": \\"Asia/Ust-Nera\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"VLAT\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}","{\\"tzName\\": \\"Vladivostok Time\\", \\"zoneName\\": \\"Asia/Vladivostok\\", \\"gmtOffset\\": 36000, \\"abbreviation\\": \\"VLAT\\", \\"gmtOffsetName\\": \\"UTC+10:00\\"}","{\\"tzName\\": \\"Yakutsk Time\\", \\"zoneName\\": \\"Asia/Yakutsk\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"YAKT\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}","{\\"tzName\\": \\"Yekaterinburg Time\\", \\"zoneName\\": \\"Asia/Yekaterinburg\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"YEKT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}","{\\"tzName\\": \\"Samara Time\\", \\"zoneName\\": \\"Europe/Astrakhan\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"SAMT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}","{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Kaliningrad\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}","{\\"tzName\\": \\"Moscow Time\\", \\"zoneName\\": \\"Europe/Kirov\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"MSK\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}","{\\"tzName\\": \\"Moscow Time\\", \\"zoneName\\": \\"Europe/Moscow\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"MSK\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}","{\\"tzName\\": \\"Samara Time\\", \\"zoneName\\": \\"Europe/Samara\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"SAMT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}","{\\"tzName\\": \\"Moscow Daylight Time+4\\", \\"zoneName\\": \\"Europe/Saratov\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"MSD\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}","{\\"tzName\\": \\"Samara Time\\", \\"zoneName\\": \\"Europe/Ulyanovsk\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"SAMT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}","{\\"tzName\\": \\"Moscow Standard Time\\", \\"zoneName\\": \\"Europe/Volgograd\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"MSK\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "俄罗斯联邦", "de": "Russland", "es": "Rusia", "fa": "روسیه", "fr": "Russie", "hr": "Rusija", "it": "Russia", "ja": "ロシア連邦", "kr": "러시아", "nl": "Rusland", "pt": "Rússia", "tr": "Rusya", "pt-BR": "Rússia"}	60	100	🇷🇺	U+1F1F7 U+1F1FA
183	Rwanda	RWA	646	RW	250	Kigali	RWF	Rwandan franc	FRw	.rw	Rwanda	Africa	Eastern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Kigali\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "卢旺达", "de": "Ruanda", "es": "Ruanda", "fa": "رواندا", "fr": "Rwanda", "hr": "Ruanda", "it": "Ruanda", "ja": "ルワンダ", "kr": "르완다", "nl": "Rwanda", "pt": "Ruanda", "tr": "Ruanda", "pt-BR": "Ruanda"}	-2	30	🇷🇼	U+1F1F7 U+1F1FC
184	Saint Helena	SHN	654	SH	290	Jamestown	SHP	Saint Helena pound	£	.sh	Saint Helena	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Atlantic/St_Helena\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "圣赫勒拿", "de": "Sankt Helena", "es": "Santa Helena", "fa": "سنت هلنا، اسنشن و تریستان دا کونا", "fr": "Sainte-Hélène", "hr": "Sveta Helena", "it": "Sant'Elena", "ja": "セントヘレナ・アセンションおよびトリスタンダクーニャ", "kr": "세인트헬레나", "nl": "Sint-Helena", "pt": "Santa Helena", "tr": "Saint Helena", "pt-BR": "Santa Helena"}	-15.95	-5.7	🇸🇭	U+1F1F8 U+1F1ED
185	Saint Kitts And Nevis	KNA	659	KN	+1-869	Basseterre	XCD	Eastern Caribbean dollar	$	.kn	Saint Kitts and Nevis	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/St_Kitts\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圣基茨和尼维斯", "de": "St. Kitts und Nevis", "es": "San Cristóbal y Nieves", "fa": "سنت کیتس و نویس", "fr": "Saint-Christophe-et-Niévès", "hr": "Sveti Kristof i Nevis", "it": "Saint Kitts e Nevis", "ja": "セントクリストファー・ネイビス", "kr": "세인트키츠 네비스", "nl": "Saint Kitts en Nevis", "pt": "São Cristóvão e Neves", "tr": "Saint Kitts Ve Nevis", "pt-BR": "São Cristóvão e Neves"}	17.33333333	-62.75	🇰🇳	U+1F1F0 U+1F1F3
186	Saint Lucia	LCA	662	LC	+1-758	Castries	XCD	Eastern Caribbean dollar	$	.lc	Saint Lucia	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/St_Lucia\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圣卢西亚", "de": "Saint Lucia", "es": "Santa Lucía", "fa": "سنت لوسیا", "fr": "Saint-Lucie", "hr": "Sveta Lucija", "it": "Santa Lucia", "ja": "セントルシア", "kr": "세인트루시아", "nl": "Saint Lucia", "pt": "Santa Lúcia", "tr": "Saint Lucia", "pt-BR": "Santa Lúcia"}	13.88333333	-60.96666666	🇱🇨	U+1F1F1 U+1F1E8
187	Saint Pierre and Miquelon	SPM	666	PM	508	Saint-Pierre	EUR	Euro	€	.pm	Saint-Pierre-et-Miquelon	Americas	Northern America	{"{\\"tzName\\": \\"Pierre & Miquelon Daylight Time\\", \\"zoneName\\": \\"America/Miquelon\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"PMDT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "圣皮埃尔和密克隆", "de": "Saint-Pierre und Miquelon", "es": "San Pedro y Miquelón", "fa": "سن پیر و میکلن", "fr": "Saint-Pierre-et-Miquelon", "hr": "Sveti Petar i Mikelon", "it": "Saint-Pierre e Miquelon", "ja": "サンピエール島・ミクロン島", "kr": "생피에르 미클롱", "nl": "Saint Pierre en Miquelon", "pt": "São Pedro e Miquelon", "tr": "Saint Pierre Ve Miquelon", "pt-BR": "Saint-Pierre e Miquelon"}	46.83333333	-56.33333333	🇵🇲	U+1F1F5 U+1F1F2
188	Saint Vincent And The Grenadines	VCT	670	VC	+1-784	Kingstown	XCD	Eastern Caribbean dollar	$	.vc	Saint Vincent and the Grenadines	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/St_Vincent\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圣文森特和格林纳丁斯", "de": "Saint Vincent und die Grenadinen", "es": "San Vicente y Granadinas", "fa": "سنت وینسنت و گرنادین‌ها", "fr": "Saint-Vincent-et-les-Grenadines", "hr": "Sveti Vincent i Grenadini", "it": "Saint Vincent e Grenadine", "ja": "セントビンセントおよびグレナディーン諸島", "kr": "세인트빈센트 그레나딘", "nl": "Saint Vincent en de Grenadines", "pt": "São Vicente e Granadinas", "tr": "Saint Vincent Ve Grenadinler", "pt-BR": "São Vicente e Granadinas"}	13.25	-61.2	🇻🇨	U+1F1FB U+1F1E8
189	Saint-Barthelemy	BLM	652	BL	590	Gustavia	EUR	Euro	€	.bl	Saint-Barthélemy	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/St_Barthelemy\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圣巴泰勒米", "de": "Saint-Barthélemy", "es": "San Bartolomé", "fa": "سن-بارتلمی", "fr": "Saint-Barthélemy", "hr": "Saint Barthélemy", "it": "Antille Francesi", "ja": "サン・バルテルミー", "kr": "생바르텔레미", "nl": "Saint Barthélemy", "pt": "São Bartolomeu", "tr": "Saint Barthélemy", "pt-BR": "São Bartolomeu"}	18.5	-63.41666666	🇧🇱	U+1F1E7 U+1F1F1
190	Saint-Martin (French part)	MAF	663	MF	590	Marigot	EUR	Euro	€	.mf	Saint-Martin	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Marigot\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "密克罗尼西亚", "de": "Saint Martin", "es": "Saint Martin", "fa": "سینت مارتن", "fr": "Saint-Martin", "hr": "Sveti Martin", "it": "Saint Martin", "ja": "サン・マルタン（フランス領）", "kr": "세인트마틴 섬", "nl": "Saint-Martin", "pt": "Ilha São Martinho", "tr": "Saint Martin", "pt-BR": "Saint Martin"}	18.08333333	-63.95	🇲🇫	U+1F1F2 U+1F1EB
191	Samoa	WSM	882	WS	685	Apia	WST	Samoan tālā	SAT	.ws	Samoa	Oceania	Polynesia	{"{\\"tzName\\": \\"West Samoa Time\\", \\"zoneName\\": \\"Pacific/Apia\\", \\"gmtOffset\\": 50400, \\"abbreviation\\": \\"WST\\", \\"gmtOffsetName\\": \\"UTC+14:00\\"}"}	{"cn": "萨摩亚", "de": "Samoa", "es": "Samoa", "fa": "ساموآ", "fr": "Samoa", "hr": "Samoa", "it": "Samoa", "ja": "サモア", "kr": "사모아", "nl": "Samoa", "pt": "Samoa", "tr": "Samoa", "pt-BR": "Samoa"}	-13.58333333	-172.33333333	🇼🇸	U+1F1FC U+1F1F8
192	San Marino	SMR	674	SM	378	San Marino	EUR	Euro	€	.sm	San Marino	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/San_Marino\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "圣马力诺", "de": "San Marino", "es": "San Marino", "fa": "سان مارینو", "fr": "Saint-Marin", "hr": "San Marino", "it": "San Marino", "ja": "サンマリノ", "kr": "산마리노", "nl": "San Marino", "pt": "São Marinho", "tr": "San Marino", "pt-BR": "San Marino"}	43.76666666	12.41666666	🇸🇲	U+1F1F8 U+1F1F2
193	Sao Tome and Principe	STP	678	ST	239	Sao Tome	STD	Dobra	Db	.st	São Tomé e Príncipe	Africa	Middle Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Sao_Tome\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "圣多美和普林西比", "de": "São Tomé und Príncipe", "es": "Santo Tomé y Príncipe", "fa": "کواترو دو فرویرو", "fr": "Sao Tomé-et-Principe", "hr": "Sveti Toma i Princip", "it": "São Tomé e Príncipe", "ja": "サントメ・プリンシペ", "kr": "상투메 프린시페", "nl": "Sao Tomé en Principe", "pt": "São Tomé e Príncipe", "tr": "Sao Tome Ve Prinsipe", "pt-BR": "São Tomé e Príncipe"}	1	7	🇸🇹	U+1F1F8 U+1F1F9
194	Saudi Arabia	SAU	682	SA	966	Riyadh	SAR	Saudi riyal	﷼	.sa	المملكة العربية السعودية	Asia	Western Asia	{"{\\"tzName\\": \\"Arabia Standard Time\\", \\"zoneName\\": \\"Asia/Riyadh\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "沙特阿拉伯", "de": "Saudi-Arabien", "es": "Arabia Saudí", "fa": "عربستان سعودی", "fr": "Arabie Saoudite", "hr": "Saudijska Arabija", "it": "Arabia Saudita", "ja": "サウジアラビア", "kr": "사우디아라비아", "nl": "Saoedi-Arabië", "pt": "Arábia Saudita", "tr": "Suudi Arabistan", "pt-BR": "Arábia Saudita"}	25	45	🇸🇦	U+1F1F8 U+1F1E6
195	Senegal	SEN	686	SN	221	Dakar	XOF	West African CFA franc	CFA	.sn	Sénégal	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Dakar\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "塞内加尔", "de": "Senegal", "es": "Senegal", "fa": "سنگال", "fr": "Sénégal", "hr": "Senegal", "it": "Senegal", "ja": "セネガル", "kr": "세네갈", "nl": "Senegal", "pt": "Senegal", "tr": "Senegal", "pt-BR": "Senegal"}	14	-14	🇸🇳	U+1F1F8 U+1F1F3
196	Serbia	SRB	688	RS	381	Belgrade	RSD	Serbian dinar	din	.rs	Србија	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Belgrade\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "塞尔维亚", "de": "Serbien", "es": "Serbia", "fa": "صربستان", "fr": "Serbie", "hr": "Srbija", "it": "Serbia", "ja": "セルビア", "kr": "세르비아", "nl": "Servië", "pt": "Sérvia", "tr": "Sirbistan", "pt-BR": "Sérvia"}	44	21	🇷🇸	U+1F1F7 U+1F1F8
197	Seychelles	SYC	690	SC	248	Victoria	SCR	Seychellois rupee	SRe	.sc	Seychelles	Africa	Eastern Africa	{"{\\"tzName\\": \\"Seychelles Time\\", \\"zoneName\\": \\"Indian/Mahe\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"SCT\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "塞舌尔", "de": "Seychellen", "es": "Seychelles", "fa": "سیشل", "fr": "Seychelles", "hr": "Sejšeli", "it": "Seychelles", "ja": "セーシェル", "kr": "세이셸", "nl": "Seychellen", "pt": "Seicheles", "tr": "Seyşeller", "pt-BR": "Seicheles"}	-4.58333333	55.66666666	🇸🇨	U+1F1F8 U+1F1E8
198	Sierra Leone	SLE	694	SL	232	Freetown	SLL	Sierra Leonean leone	Le	.sl	Sierra Leone	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Freetown\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "塞拉利昂", "de": "Sierra Leone", "es": "Sierra Leone", "fa": "سیرالئون", "fr": "Sierra Leone", "hr": "Sijera Leone", "it": "Sierra Leone", "ja": "シエラレオネ", "kr": "시에라리온", "nl": "Sierra Leone", "pt": "Serra Leoa", "tr": "Sierra Leone", "pt-BR": "Serra Leoa"}	8.5	-11.5	🇸🇱	U+1F1F8 U+1F1F1
199	Singapore	SGP	702	SG	65	Singapur	SGD	Singapore dollar	$	.sg	Singapore	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Singapore Time\\", \\"zoneName\\": \\"Asia/Singapore\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"SGT\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "新加坡", "de": "Singapur", "es": "Singapur", "fa": "سنگاپور", "fr": "Singapour", "hr": "Singapur", "it": "Singapore", "ja": "シンガポール", "kr": "싱가포르", "nl": "Singapore", "pt": "Singapura", "tr": "Singapur", "pt-BR": "Singapura"}	1.36666666	103.8	🇸🇬	U+1F1F8 U+1F1EC
250	Sint Maarten (Dutch part)	SXM	534	SX	1721	Philipsburg	ANG	Netherlands Antillean guilder	ƒ	.sx	Sint Maarten	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Anguilla\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圣马丁岛（荷兰部分）", "de": "Sint Maarten (niederl. Teil)", "fa": "سینت مارتن", "fr": "Saint Martin (partie néerlandaise)", "it": "Saint Martin (parte olandese)", "kr": "신트마르턴", "nl": "Sint Maarten", "pt": "São Martinho", "tr": "Sint Maarten", "pt-BR": "Sint Maarten"}	18.033333	-63.05	🇸🇽	U+1F1F8 U+1F1FD
200	Slovakia	SVK	703	SK	421	Bratislava	EUR	Euro	€	.sk	Slovensko	Europe	Eastern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Bratislava\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "斯洛伐克", "de": "Slowakei", "es": "República Eslovaca", "fa": "اسلواکی", "fr": "Slovaquie", "hr": "Slovačka", "it": "Slovacchia", "ja": "スロバキア", "kr": "슬로바키아", "nl": "Slowakije", "pt": "Eslováquia", "tr": "Slovakya", "pt-BR": "Eslováquia"}	48.66666666	19.5	🇸🇰	U+1F1F8 U+1F1F0
201	Slovenia	SVN	705	SI	386	Ljubljana	EUR	Euro	€	.si	Slovenija	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Ljubljana\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "斯洛文尼亚", "de": "Slowenien", "es": "Eslovenia", "fa": "اسلوونی", "fr": "Slovénie", "hr": "Slovenija", "it": "Slovenia", "ja": "スロベニア", "kr": "슬로베니아", "nl": "Slovenië", "pt": "Eslovénia", "tr": "Slovenya", "pt-BR": "Eslovênia"}	46.11666666	14.81666666	🇸🇮	U+1F1F8 U+1F1EE
202	Solomon Islands	SLB	090	SB	677	Honiara	SBD	Solomon Islands dollar	Si$	.sb	Solomon Islands	Oceania	Melanesia	{"{\\"tzName\\": \\"Solomon Islands Time\\", \\"zoneName\\": \\"Pacific/Guadalcanal\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"SBT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}"}	{"cn": "所罗门群岛", "de": "Salomonen", "es": "Islas Salomón", "fa": "جزایر سلیمان", "fr": "Îles Salomon", "hr": "Solomonski Otoci", "it": "Isole Salomone", "ja": "ソロモン諸島", "kr": "솔로몬 제도", "nl": "Salomonseilanden", "pt": "Ilhas Salomão", "tr": "Solomon Adalari", "pt-BR": "Ilhas Salomão"}	-8	159	🇸🇧	U+1F1F8 U+1F1E7
203	Somalia	SOM	706	SO	252	Mogadishu	SOS	Somali shilling	Sh.so.	.so	Soomaaliya	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Mogadishu\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "索马里", "de": "Somalia", "es": "Somalia", "fa": "سومالی", "fr": "Somalie", "hr": "Somalija", "it": "Somalia", "ja": "ソマリア", "kr": "소말리아", "nl": "Somalië", "pt": "Somália", "tr": "Somali", "pt-BR": "Somália"}	10	49	🇸🇴	U+1F1F8 U+1F1F4
204	South Africa	ZAF	710	ZA	27	Pretoria	ZAR	South African rand	R	.za	South Africa	Africa	Southern Africa	{"{\\"tzName\\": \\"South African Standard Time\\", \\"zoneName\\": \\"Africa/Johannesburg\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"SAST\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "南非", "de": "Republik Südafrika", "es": "República de Sudáfrica", "fa": "آفریقای جنوبی", "fr": "Afrique du Sud", "hr": "Južnoafrička Republika", "it": "Sud Africa", "ja": "南アフリカ", "kr": "남아프리카 공화국", "nl": "Zuid-Afrika", "pt": "República Sul-Africana", "tr": "Güney Afrika Cumhuriyeti", "pt-BR": "República Sul-Africana"}	-29	24	🇿🇦	U+1F1FF U+1F1E6
205	South Georgia	SGS	239	GS	500	Grytviken	GBP	British pound	£	.gs	South Georgia	Americas	South America	{"{\\"tzName\\": \\"South Georgia and the South Sandwich Islands Time\\", \\"zoneName\\": \\"Atlantic/South_Georgia\\", \\"gmtOffset\\": -7200, \\"abbreviation\\": \\"GST\\", \\"gmtOffsetName\\": \\"UTC-02:00\\"}"}	{"cn": "南乔治亚", "de": "Südgeorgien und die Südlichen Sandwichinseln", "es": "Islas Georgias del Sur y Sandwich del Sur", "fa": "جزایر جورجیای جنوبی و ساندویچ جنوبی", "fr": "Géorgie du Sud-et-les Îles Sandwich du Sud", "hr": "Južna Georgija i otočje Južni Sandwich", "it": "Georgia del Sud e Isole Sandwich Meridionali", "ja": "サウスジョージア・サウスサンドウィッチ諸島", "kr": "사우스조지아", "nl": "Zuid-Georgia en Zuidelijke Sandwicheilanden", "pt": "Ilhas Geórgia do Sul e Sanduíche do Sul", "tr": "Güney Georgia", "pt-BR": "Ilhas Geórgias do Sul e Sandwich do Sul"}	-54.5	-37	🇬🇸	U+1F1EC U+1F1F8
116	South Korea	KOR	410	KR	82	Seoul	KRW	Won	₩	.kr	대한민국	Asia	Eastern Asia	{"{\\"tzName\\": \\"Korea Standard Time\\", \\"zoneName\\": \\"Asia/Seoul\\", \\"gmtOffset\\": 32400, \\"abbreviation\\": \\"KST\\", \\"gmtOffsetName\\": \\"UTC+09:00\\"}"}	{"cn": "韩国", "de": "Südkorea", "es": "Corea del Sur", "fa": "کره شمالی", "fr": "Corée du Sud", "hr": "Južna Koreja", "it": "Corea del Sud", "ja": "大韓民国", "kr": "대한민국", "nl": "Zuid-Korea", "pt": "Coreia do Sul", "tr": "Güney Kore", "pt-BR": "Coreia do Sul"}	37	127.5	🇰🇷	U+1F1F0 U+1F1F7
206	South Sudan	SSD	728	SS	211	Juba	SSP	South Sudanese pound	£	.ss	South Sudan	Africa	Middle Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Juba\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "南苏丹", "de": "Südsudan", "es": "Sudán del Sur", "fa": "سودان جنوبی", "fr": "Soudan du Sud", "hr": "Južni Sudan", "it": "Sudan del sud", "ja": "南スーダン", "kr": "남수단", "nl": "Zuid-Soedan", "pt": "Sudão do Sul", "tr": "Güney Sudan", "pt-BR": "Sudão do Sul"}	7	30	🇸🇸	U+1F1F8 U+1F1F8
207	Spain	ESP	724	ES	34	Madrid	EUR	Euro	€	.es	España	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Africa/Ceuta\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}","{\\"tzName\\": \\"Western European Time\\", \\"zoneName\\": \\"Atlantic/Canary\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"WET\\", \\"gmtOffsetName\\": \\"UTC±00\\"}","{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Madrid\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "西班牙", "de": "Spanien", "es": "España", "fa": "اسپانیا", "fr": "Espagne", "hr": "Španjolska", "it": "Spagna", "ja": "スペイン", "kr": "스페인", "nl": "Spanje", "pt": "Espanha", "tr": "İspanya", "pt-BR": "Espanha"}	40	-4	🇪🇸	U+1F1EA U+1F1F8
208	Sri Lanka	LKA	144	LK	94	Colombo	LKR	Sri Lankan rupee	Rs	.lk	śrī laṃkāva	Asia	Southern Asia	{"{\\"tzName\\": \\"Indian Standard Time\\", \\"zoneName\\": \\"Asia/Colombo\\", \\"gmtOffset\\": 19800, \\"abbreviation\\": \\"IST\\", \\"gmtOffsetName\\": \\"UTC+05:30\\"}"}	{"cn": "斯里兰卡", "de": "Sri Lanka", "es": "Sri Lanka", "fa": "سری‌لانکا", "fr": "Sri Lanka", "hr": "Šri Lanka", "it": "Sri Lanka", "ja": "スリランカ", "kr": "스리랑카", "nl": "Sri Lanka", "pt": "Sri Lanka", "tr": "Sri Lanka", "pt-BR": "Sri Lanka"}	7	81	🇱🇰	U+1F1F1 U+1F1F0
209	Sudan	SDN	729	SD	249	Khartoum	SDG	Sudanese pound	.س.ج	.sd	السودان	Africa	Northern Africa	{"{\\"tzName\\": \\"Eastern African Time\\", \\"zoneName\\": \\"Africa/Khartoum\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "苏丹", "de": "Sudan", "es": "Sudán", "fa": "سودان", "fr": "Soudan", "hr": "Sudan", "it": "Sudan", "ja": "スーダン", "kr": "수단", "nl": "Soedan", "pt": "Sudão", "tr": "Sudan", "pt-BR": "Sudão"}	15	30	🇸🇩	U+1F1F8 U+1F1E9
210	Suriname	SUR	740	SR	597	Paramaribo	SRD	Surinamese dollar	$	.sr	Suriname	Americas	South America	{"{\\"tzName\\": \\"Suriname Time\\", \\"zoneName\\": \\"America/Paramaribo\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"SRT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "苏里南", "de": "Suriname", "es": "Surinam", "fa": "سورینام", "fr": "Surinam", "hr": "Surinam", "it": "Suriname", "ja": "スリナム", "kr": "수리남", "nl": "Suriname", "pt": "Suriname", "tr": "Surinam", "pt-BR": "Suriname"}	4	-56	🇸🇷	U+1F1F8 U+1F1F7
211	Svalbard And Jan Mayen Islands	SJM	744	SJ	47	Longyearbyen	NOK	Norwegian Krone	kr	.sj	Svalbard og Jan Mayen	Europe	Northern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Arctic/Longyearbyen\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "斯瓦尔巴和扬马延群岛", "de": "Svalbard und Jan Mayen", "es": "Islas Svalbard y Jan Mayen", "fa": "سوالبارد و یان ماین", "fr": "Svalbard et Jan Mayen", "hr": "Svalbard i Jan Mayen", "it": "Svalbard e Jan Mayen", "ja": "スヴァールバル諸島およびヤンマイエン島", "kr": "스발바르 얀마옌 제도", "nl": "Svalbard en Jan Mayen", "pt": "Svalbard", "tr": "Svalbard Ve Jan Mayen", "pt-BR": "Svalbard"}	78	20	🇸🇯	U+1F1F8 U+1F1EF
212	Swaziland	SWZ	748	SZ	268	Mbabane	SZL	Lilangeni	E	.sz	Swaziland	Africa	Southern Africa	{"{\\"tzName\\": \\"South African Standard Time\\", \\"zoneName\\": \\"Africa/Mbabane\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"SAST\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "斯威士兰", "de": "Swasiland", "es": "Suazilandia", "fa": "سوازیلند", "fr": "Swaziland", "hr": "Svazi", "it": "Swaziland", "ja": "スワジランド", "kr": "에스와티니", "nl": "Swaziland", "pt": "Suazilândia", "tr": "Esvatini", "pt-BR": "Suazilândia"}	-26.5	31.5	🇸🇿	U+1F1F8 U+1F1FF
213	Sweden	SWE	752	SE	46	Stockholm	SEK	Swedish krona	kr	.se	Sverige	Europe	Northern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Stockholm\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "瑞典", "de": "Schweden", "es": "Suecia", "fa": "سوئد", "fr": "Suède", "hr": "Švedska", "it": "Svezia", "ja": "スウェーデン", "kr": "스웨덴", "nl": "Zweden", "pt": "Suécia", "tr": "İsveç", "pt-BR": "Suécia"}	62	15	🇸🇪	U+1F1F8 U+1F1EA
214	Switzerland	CHE	756	CH	41	Bern	CHF	Swiss franc	CHf	.ch	Schweiz	Europe	Western Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Zurich\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "瑞士", "de": "Schweiz", "es": "Suiza", "fa": "سوئیس", "fr": "Suisse", "hr": "Švicarska", "it": "Svizzera", "ja": "スイス", "kr": "스위스", "nl": "Zwitserland", "pt": "Suíça", "tr": "İsviçre", "pt-BR": "Suíça"}	47	8	🇨🇭	U+1F1E8 U+1F1ED
215	Syria	SYR	760	SY	963	Damascus	SYP	Syrian pound	LS	.sy	سوريا	Asia	Western Asia	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Asia/Damascus\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "叙利亚", "de": "Syrien", "es": "Siria", "fa": "سوریه", "fr": "Syrie", "hr": "Sirija", "it": "Siria", "ja": "シリア・アラブ共和国", "kr": "시리아", "nl": "Syrië", "pt": "Síria", "tr": "Suriye", "pt-BR": "Síria"}	35	38	🇸🇾	U+1F1F8 U+1F1FE
216	Taiwan	TWN	158	TW	886	Taipei	TWD	New Taiwan dollar	$	.tw	臺灣	Asia	Eastern Asia	{"{\\"tzName\\": \\"China Standard Time\\", \\"zoneName\\": \\"Asia/Taipei\\", \\"gmtOffset\\": 28800, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC+08:00\\"}"}	{"cn": "中国台湾", "de": "Taiwan", "es": "Taiwán", "fa": "تایوان", "fr": "Taïwan", "hr": "Tajvan", "it": "Taiwan", "ja": "台湾（中華民国）", "kr": "대만", "nl": "Taiwan", "pt": "Taiwan", "tr": "Tayvan", "pt-BR": "Taiwan"}	23.5	121	🇹🇼	U+1F1F9 U+1F1FC
217	Tajikistan	TJK	762	TJ	992	Dushanbe	TJS	Tajikistani somoni	SM	.tj	Тоҷикистон	Asia	Central Asia	{"{\\"tzName\\": \\"Tajikistan Time\\", \\"zoneName\\": \\"Asia/Dushanbe\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"TJT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "塔吉克斯坦", "de": "Tadschikistan", "es": "Tayikistán", "fa": "تاجیکستان", "fr": "Tadjikistan", "hr": "Tađikistan", "it": "Tagikistan", "ja": "タジキスタン", "kr": "타지키스탄", "nl": "Tadzjikistan", "pt": "Tajiquistão", "tr": "Tacikistan", "pt-BR": "Tajiquistão"}	39	71	🇹🇯	U+1F1F9 U+1F1EF
218	Tanzania	TZA	834	TZ	255	Dodoma	TZS	Tanzanian shilling	TSh	.tz	Tanzania	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Dar_es_Salaam\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "坦桑尼亚", "de": "Tansania", "es": "Tanzania", "fa": "تانزانیا", "fr": "Tanzanie", "hr": "Tanzanija", "it": "Tanzania", "ja": "タンザニア", "kr": "탄자니아", "nl": "Tanzania", "pt": "Tanzânia", "tr": "Tanzanya", "pt-BR": "Tanzânia"}	-6	35	🇹🇿	U+1F1F9 U+1F1FF
219	Thailand	THA	764	TH	66	Bangkok	THB	Thai baht	฿	.th	ประเทศไทย	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Indochina Time\\", \\"zoneName\\": \\"Asia/Bangkok\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"ICT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}"}	{"cn": "泰国", "de": "Thailand", "es": "Tailandia", "fa": "تایلند", "fr": "Thaïlande", "hr": "Tajland", "it": "Tailandia", "ja": "タイ", "kr": "태국", "nl": "Thailand", "pt": "Tailândia", "tr": "Tayland", "pt-BR": "Tailândia"}	15	100	🇹🇭	U+1F1F9 U+1F1ED
17	The Bahamas	BHS	044	BS	+1-242	Nassau	BSD	Bahamian dollar	B$	.bs	Bahamas	Americas	Caribbean	{"{\\"tzName\\": \\"Eastern Standard Time (North America)\\", \\"zoneName\\": \\"America/Nassau\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "巴哈马", "de": "Bahamas", "es": "Bahamas", "fa": "باهاما", "fr": "Bahamas", "hr": "Bahami", "it": "Bahamas", "ja": "バハマ", "kr": "바하마", "nl": "Bahama’s", "pt": "Baamas", "tr": "Bahamalar", "pt-BR": "Bahamas"}	24.25	-76	🇧🇸	U+1F1E7 U+1F1F8
220	Togo	TGO	768	TG	228	Lome	XOF	West African CFA franc	CFA	.tg	Togo	Africa	Western Africa	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Africa/Lome\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "多哥", "de": "Togo", "es": "Togo", "fa": "توگو", "fr": "Togo", "hr": "Togo", "it": "Togo", "ja": "トーゴ", "kr": "토고", "nl": "Togo", "pt": "Togo", "tr": "Togo", "pt-BR": "Togo"}	8	1.16666666	🇹🇬	U+1F1F9 U+1F1EC
221	Tokelau	TKL	772	TK	690		NZD	New Zealand dollar	$	.tk	Tokelau	Oceania	Polynesia	{"{\\"tzName\\": \\"Tokelau Time\\", \\"zoneName\\": \\"Pacific/Fakaofo\\", \\"gmtOffset\\": 46800, \\"abbreviation\\": \\"TKT\\", \\"gmtOffsetName\\": \\"UTC+13:00\\"}"}	{"cn": "托克劳", "de": "Tokelau", "es": "Islas Tokelau", "fa": "توکلائو", "fr": "Tokelau", "hr": "Tokelau", "it": "Isole Tokelau", "ja": "トケラウ", "kr": "토켈라우", "nl": "Tokelau", "pt": "Toquelau", "tr": "Tokelau", "pt-BR": "Tokelau"}	-9	-172	🇹🇰	U+1F1F9 U+1F1F0
222	Tonga	TON	776	TO	676	Nuku'alofa	TOP	Tongan paʻanga	$	.to	Tonga	Oceania	Polynesia	{"{\\"tzName\\": \\"Tonga Time\\", \\"zoneName\\": \\"Pacific/Tongatapu\\", \\"gmtOffset\\": 46800, \\"abbreviation\\": \\"TOT\\", \\"gmtOffsetName\\": \\"UTC+13:00\\"}"}	{"cn": "汤加", "de": "Tonga", "es": "Tonga", "fa": "تونگا", "fr": "Tonga", "hr": "Tonga", "it": "Tonga", "ja": "トンガ", "kr": "통가", "nl": "Tonga", "pt": "Tonga", "tr": "Tonga", "pt-BR": "Tonga"}	-20	-175	🇹🇴	U+1F1F9 U+1F1F4
223	Trinidad And Tobago	TTO	780	TT	+1-868	Port of Spain	TTD	Trinidad and Tobago dollar	$	.tt	Trinidad and Tobago	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Port_of_Spain\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "特立尼达和多巴哥", "de": "Trinidad und Tobago", "es": "Trinidad y Tobago", "fa": "ترینیداد و توباگو", "fr": "Trinité et Tobago", "hr": "Trinidad i Tobago", "it": "Trinidad e Tobago", "ja": "トリニダード・トバゴ", "kr": "트리니다드 토바고", "nl": "Trinidad en Tobago", "pt": "Trindade e Tobago", "tr": "Trinidad Ve Tobago", "pt-BR": "Trinidad e Tobago"}	11	-61	🇹🇹	U+1F1F9 U+1F1F9
224	Tunisia	TUN	788	TN	216	Tunis	TND	Tunisian dinar	ت.د	.tn	تونس	Africa	Northern Africa	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Africa/Tunis\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "突尼斯", "de": "Tunesien", "es": "Túnez", "fa": "تونس", "fr": "Tunisie", "hr": "Tunis", "it": "Tunisia", "ja": "チュニジア", "kr": "튀니지", "nl": "Tunesië", "pt": "Tunísia", "tr": "Tunus", "pt-BR": "Tunísia"}	34	9	🇹🇳	U+1F1F9 U+1F1F3
225	Turkey	TUR	792	TR	90	Ankara	TRY	Turkish lira	₺	.tr	Türkiye	Asia	Western Asia	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Istanbul\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "土耳其", "de": "Türkei", "es": "Turquía", "fa": "ترکیه", "fr": "Turquie", "hr": "Turska", "it": "Turchia", "ja": "トルコ", "kr": "터키", "nl": "Turkije", "pt": "Turquia", "tr": "Türkiye", "pt-BR": "Turquia"}	39	35	🇹🇷	U+1F1F9 U+1F1F7
226	Turkmenistan	TKM	795	TM	993	Ashgabat	TMT	Turkmenistan manat	T	.tm	Türkmenistan	Asia	Central Asia	{"{\\"tzName\\": \\"Turkmenistan Time\\", \\"zoneName\\": \\"Asia/Ashgabat\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"TMT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "土库曼斯坦", "de": "Turkmenistan", "es": "Turkmenistán", "fa": "ترکمنستان", "fr": "Turkménistan", "hr": "Turkmenistan", "it": "Turkmenistan", "ja": "トルクメニスタン", "kr": "투르크메니스탄", "nl": "Turkmenistan", "pt": "Turquemenistão", "tr": "Türkmenistan", "pt-BR": "Turcomenistão"}	40	60	🇹🇲	U+1F1F9 U+1F1F2
227	Turks And Caicos Islands	TCA	796	TC	+1-649	Cockburn Town	USD	United States dollar	$	.tc	Turks and Caicos Islands	Americas	Caribbean	{"{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Grand_Turk\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}"}	{"cn": "特克斯和凯科斯群岛", "de": "Turks- und Caicosinseln", "es": "Islas Turks y Caicos", "fa": "جزایر تورکس و کایکوس", "fr": "Îles Turques-et-Caïques", "hr": "Otoci Turks i Caicos", "it": "Isole Turks e Caicos", "ja": "タークス・カイコス諸島", "kr": "터크스 케이커스 제도", "nl": "Turks- en Caicoseilanden", "pt": "Ilhas Turcas e Caicos", "tr": "Turks Ve Caicos Adalari", "pt-BR": "Ilhas Turcas e Caicos"}	21.75	-71.58333333	🇹🇨	U+1F1F9 U+1F1E8
228	Tuvalu	TUV	798	TV	688	Funafuti	AUD	Australian dollar	$	.tv	Tuvalu	Oceania	Polynesia	{"{\\"tzName\\": \\"Tuvalu Time\\", \\"zoneName\\": \\"Pacific/Funafuti\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"TVT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "图瓦卢", "de": "Tuvalu", "es": "Tuvalu", "fa": "تووالو", "fr": "Tuvalu", "hr": "Tuvalu", "it": "Tuvalu", "ja": "ツバル", "kr": "투발루", "nl": "Tuvalu", "pt": "Tuvalu", "tr": "Tuvalu", "pt-BR": "Tuvalu"}	-8	178	🇹🇻	U+1F1F9 U+1F1FB
229	Uganda	UGA	800	UG	256	Kampala	UGX	Ugandan shilling	USh	.ug	Uganda	Africa	Eastern Africa	{"{\\"tzName\\": \\"East Africa Time\\", \\"zoneName\\": \\"Africa/Kampala\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"EAT\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "乌干达", "de": "Uganda", "es": "Uganda", "fa": "اوگاندا", "fr": "Uganda", "hr": "Uganda", "it": "Uganda", "ja": "ウガンダ", "kr": "우간다", "nl": "Oeganda", "pt": "Uganda", "tr": "Uganda", "pt-BR": "Uganda"}	1	32	🇺🇬	U+1F1FA U+1F1EC
230	Ukraine	UKR	804	UA	380	Kiev	UAH	Ukrainian hryvnia	₴	.ua	Україна	Europe	Eastern Europe	{"{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Kiev\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}","{\\"tzName\\": \\"Moscow Time\\", \\"zoneName\\": \\"Europe/Simferopol\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"MSK\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}","{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Uzhgorod\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}","{\\"tzName\\": \\"Eastern European Time\\", \\"zoneName\\": \\"Europe/Zaporozhye\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"EET\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "乌克兰", "de": "Ukraine", "es": "Ucrania", "fa": "وکراین", "fr": "Ukraine", "hr": "Ukrajina", "it": "Ucraina", "ja": "ウクライナ", "kr": "우크라이나", "nl": "Oekraïne", "pt": "Ucrânia", "tr": "Ukrayna", "pt-BR": "Ucrânia"}	49	32	🇺🇦	U+1F1FA U+1F1E6
231	United Arab Emirates	ARE	784	AE	971	Abu Dhabi	AED	United Arab Emirates dirham	إ.د	.ae	دولة الإمارات العربية المتحدة	Asia	Western Asia	{"{\\"tzName\\": \\"Gulf Standard Time\\", \\"zoneName\\": \\"Asia/Dubai\\", \\"gmtOffset\\": 14400, \\"abbreviation\\": \\"GST\\", \\"gmtOffsetName\\": \\"UTC+04:00\\"}"}	{"cn": "阿拉伯联合酋长国", "de": "Vereinigte Arabische Emirate", "es": "Emiratos Árabes Unidos", "fa": "امارات متحده عربی", "fr": "Émirats arabes unis", "hr": "Ujedinjeni Arapski Emirati", "it": "Emirati Arabi Uniti", "ja": "アラブ首長国連邦", "kr": "아랍에미리트", "nl": "Verenigde Arabische Emiraten", "pt": "Emirados árabes Unidos", "tr": "Birleşik Arap Emirlikleri", "pt-BR": "Emirados árabes Unidos"}	24	54	🇦🇪	U+1F1E6 U+1F1EA
232	United Kingdom	GBR	826	GB	44	London	GBP	British pound	£	.uk	United Kingdom	Europe	Northern Europe	{"{\\"tzName\\": \\"Greenwich Mean Time\\", \\"zoneName\\": \\"Europe/London\\", \\"gmtOffset\\": 0, \\"abbreviation\\": \\"GMT\\", \\"gmtOffsetName\\": \\"UTC±00\\"}"}	{"cn": "英国", "de": "Vereinigtes Königreich", "es": "Reino Unido", "fa": "بریتانیای کبیر و ایرلند شمالی", "fr": "Royaume-Uni", "hr": "Ujedinjeno Kraljevstvo", "it": "Regno Unito", "ja": "イギリス", "kr": "영국", "nl": "Verenigd Koninkrijk", "pt": "Reino Unido", "tr": "Birleşik Krallik", "pt-BR": "Reino Unido"}	54	-2	🇬🇧	U+1F1EC U+1F1E7
233	United States	USA	840	US	1	Washington	USD	United States dollar	$	.us	United States	Americas	Northern America	{"{\\"tzName\\": \\"Hawaii–Aleutian Standard Time\\", \\"zoneName\\": \\"America/Adak\\", \\"gmtOffset\\": -36000, \\"abbreviation\\": \\"HST\\", \\"gmtOffsetName\\": \\"UTC-10:00\\"}","{\\"tzName\\": \\"Alaska Standard Time\\", \\"zoneName\\": \\"America/Anchorage\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"AKST\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Boise\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Chicago\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Denver\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Detroit\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Indianapolis\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Knox\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Marengo\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Petersburg\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Tell_City\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Vevay\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Vincennes\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Indiana/Winamac\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Alaska Standard Time\\", \\"zoneName\\": \\"America/Juneau\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"AKST\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Kentucky/Louisville\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/Kentucky/Monticello\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Pacific Standard Time (North America\\", \\"zoneName\\": \\"America/Los_Angeles\\", \\"gmtOffset\\": -28800, \\"abbreviation\\": \\"PST\\", \\"gmtOffsetName\\": \\"UTC-08:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/Menominee\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Alaska Standard Time\\", \\"zoneName\\": \\"America/Metlakatla\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"AKST\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Eastern Standard Time (North America\\", \\"zoneName\\": \\"America/New_York\\", \\"gmtOffset\\": -18000, \\"abbreviation\\": \\"EST\\", \\"gmtOffsetName\\": \\"UTC-05:00\\"}","{\\"tzName\\": \\"Alaska Standard Time\\", \\"zoneName\\": \\"America/Nome\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"AKST\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/North_Dakota/Beulah\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/North_Dakota/Center\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Central Standard Time (North America\\", \\"zoneName\\": \\"America/North_Dakota/New_Salem\\", \\"gmtOffset\\": -21600, \\"abbreviation\\": \\"CST\\", \\"gmtOffsetName\\": \\"UTC-06:00\\"}","{\\"tzName\\": \\"Mountain Standard Time (North America\\", \\"zoneName\\": \\"America/Phoenix\\", \\"gmtOffset\\": -25200, \\"abbreviation\\": \\"MST\\", \\"gmtOffsetName\\": \\"UTC-07:00\\"}","{\\"tzName\\": \\"Alaska Standard Time\\", \\"zoneName\\": \\"America/Sitka\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"AKST\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Alaska Standard Time\\", \\"zoneName\\": \\"America/Yakutat\\", \\"gmtOffset\\": -32400, \\"abbreviation\\": \\"AKST\\", \\"gmtOffsetName\\": \\"UTC-09:00\\"}","{\\"tzName\\": \\"Hawaii–Aleutian Standard Time\\", \\"zoneName\\": \\"Pacific/Honolulu\\", \\"gmtOffset\\": -36000, \\"abbreviation\\": \\"HST\\", \\"gmtOffsetName\\": \\"UTC-10:00\\"}"}	{"cn": "美国", "de": "Vereinigte Staaten von Amerika", "es": "Estados Unidos", "fa": "ایالات متحده آمریکا", "fr": "États-Unis", "hr": "Sjedinjene Američke Države", "it": "Stati Uniti D'America", "ja": "アメリカ合衆国", "kr": "미국", "nl": "Verenigde Staten", "pt": "Estados Unidos", "tr": "Amerika", "pt-BR": "Estados Unidos"}	38	-97	🇺🇸	U+1F1FA U+1F1F8
234	United States Minor Outlying Islands	UMI	581	UM	1		USD	United States dollar	$	.us	United States Minor Outlying Islands	Americas	Northern America	{"{\\"tzName\\": \\"Samoa Standard Time\\", \\"zoneName\\": \\"Pacific/Midway\\", \\"gmtOffset\\": -39600, \\"abbreviation\\": \\"SST\\", \\"gmtOffsetName\\": \\"UTC-11:00\\"}","{\\"tzName\\": \\"Wake Island Time\\", \\"zoneName\\": \\"Pacific/Wake\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"WAKT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "美国本土外小岛屿", "de": "Kleinere Inselbesitzungen der Vereinigten Staaten", "es": "Islas Ultramarinas Menores de Estados Unidos", "fa": "جزایر کوچک حاشیه‌ای ایالات متحده آمریکا", "fr": "Îles mineures éloignées des États-Unis", "hr": "Mali udaljeni otoci SAD-a", "it": "Isole minori esterne degli Stati Uniti d'America", "ja": "合衆国領有小離島", "kr": "미국령 군소 제도", "nl": "Kleine afgelegen eilanden van de Verenigde Staten", "pt": "Ilhas Menores Distantes dos Estados Unidos", "tr": "Abd Küçük Harici Adalari", "pt-BR": "Ilhas Menores Distantes dos Estados Unidos"}	0	0	🇺🇲	U+1F1FA U+1F1F2
235	Uruguay	URY	858	UY	598	Montevideo	UYU	Uruguayan peso	$	.uy	Uruguay	Americas	South America	{"{\\"tzName\\": \\"Uruguay Standard Time\\", \\"zoneName\\": \\"America/Montevideo\\", \\"gmtOffset\\": -10800, \\"abbreviation\\": \\"UYT\\", \\"gmtOffsetName\\": \\"UTC-03:00\\"}"}	{"cn": "乌拉圭", "de": "Uruguay", "es": "Uruguay", "fa": "اروگوئه", "fr": "Uruguay", "hr": "Urugvaj", "it": "Uruguay", "ja": "ウルグアイ", "kr": "우루과이", "nl": "Uruguay", "pt": "Uruguai", "tr": "Uruguay", "pt-BR": "Uruguai"}	-33	-56	🇺🇾	U+1F1FA U+1F1FE
236	Uzbekistan	UZB	860	UZ	998	Tashkent	UZS	Uzbekistani soʻm	лв	.uz	O‘zbekiston	Asia	Central Asia	{"{\\"tzName\\": \\"Uzbekistan Time\\", \\"zoneName\\": \\"Asia/Samarkand\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"UZT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}","{\\"tzName\\": \\"Uzbekistan Time\\", \\"zoneName\\": \\"Asia/Tashkent\\", \\"gmtOffset\\": 18000, \\"abbreviation\\": \\"UZT\\", \\"gmtOffsetName\\": \\"UTC+05:00\\"}"}	{"cn": "乌兹别克斯坦", "de": "Usbekistan", "es": "Uzbekistán", "fa": "ازبکستان", "fr": "Ouzbékistan", "hr": "Uzbekistan", "it": "Uzbekistan", "ja": "ウズベキスタン", "kr": "우즈베키스탄", "nl": "Oezbekistan", "pt": "Usbequistão", "tr": "Özbekistan", "pt-BR": "Uzbequistão"}	41	64	🇺🇿	U+1F1FA U+1F1FF
237	Vanuatu	VUT	548	VU	678	Port Vila	VUV	Vanuatu vatu	VT	.vu	Vanuatu	Oceania	Melanesia	{"{\\"tzName\\": \\"Vanuatu Time\\", \\"zoneName\\": \\"Pacific/Efate\\", \\"gmtOffset\\": 39600, \\"abbreviation\\": \\"VUT\\", \\"gmtOffsetName\\": \\"UTC+11:00\\"}"}	{"cn": "瓦努阿图", "de": "Vanuatu", "es": "Vanuatu", "fa": "وانواتو", "fr": "Vanuatu", "hr": "Vanuatu", "it": "Vanuatu", "ja": "バヌアツ", "kr": "바누아투", "nl": "Vanuatu", "pt": "Vanuatu", "tr": "Vanuatu", "pt-BR": "Vanuatu"}	-16	167	🇻🇺	U+1F1FB U+1F1FA
238	Vatican City State (Holy See)	VAT	336	VA	379	Vatican City	EUR	Euro	€	.va	Vaticano	Europe	Southern Europe	{"{\\"tzName\\": \\"Central European Time\\", \\"zoneName\\": \\"Europe/Vatican\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"CET\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "梵蒂冈", "de": "Heiliger Stuhl", "es": "Santa Sede", "fa": "سریر مقدس", "fr": "voir Saint", "hr": "Sveta Stolica", "it": "Santa Sede", "ja": "聖座", "kr": "바티칸 시국", "nl": "Heilige Stoel", "pt": "Vaticano", "tr": "Vatikan", "pt-BR": "Vaticano"}	41.9	12.45	🇻🇦	U+1F1FB U+1F1E6
239	Venezuela	VEN	862	VE	58	Caracas	VEF	Bolívar	Bs	.ve	Venezuela	Americas	South America	{"{\\"tzName\\": \\"Venezuelan Standard Time\\", \\"zoneName\\": \\"America/Caracas\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"VET\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "委内瑞拉", "de": "Venezuela", "es": "Venezuela", "fa": "ونزوئلا", "fr": "Venezuela", "hr": "Venezuela", "it": "Venezuela", "ja": "ベネズエラ・ボリバル共和国", "kr": "베네수엘라", "nl": "Venezuela", "pt": "Venezuela", "tr": "Venezuela", "pt-BR": "Venezuela"}	8	-66	🇻🇪	U+1F1FB U+1F1EA
240	Vietnam	VNM	704	VN	84	Hanoi	VND	Vietnamese đồng	₫	.vn	Việt Nam	Asia	South-Eastern Asia	{"{\\"tzName\\": \\"Indochina Time\\", \\"zoneName\\": \\"Asia/Ho_Chi_Minh\\", \\"gmtOffset\\": 25200, \\"abbreviation\\": \\"ICT\\", \\"gmtOffsetName\\": \\"UTC+07:00\\"}"}	{"cn": "越南", "de": "Vietnam", "es": "Vietnam", "fa": "ویتنام", "fr": "Viêt Nam", "hr": "Vijetnam", "it": "Vietnam", "ja": "ベトナム", "kr": "베트남", "nl": "Vietnam", "pt": "Vietname", "tr": "Vietnam", "pt-BR": "Vietnã"}	16.16666666	107.83333333	🇻🇳	U+1F1FB U+1F1F3
241	Virgin Islands (British)	VGB	092	VG	+1-284	Road Town	USD	United States dollar	$	.vg	British Virgin Islands	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/Tortola\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "圣文森特和格林纳丁斯", "de": "Britische Jungferninseln", "es": "Islas Vírgenes del Reino Unido", "fa": "جزایر ویرجین بریتانیا", "fr": "Îles Vierges britanniques", "hr": "Britanski Djevičanski Otoci", "it": "Isole Vergini Britanniche", "ja": "イギリス領ヴァージン諸島", "kr": "영국령 버진아일랜드", "nl": "Britse Maagdeneilanden", "pt": "Ilhas Virgens Britânicas", "tr": "Britanya Virjin Adalari", "pt-BR": "Ilhas Virgens Britânicas"}	18.431383	-64.62305	🇻🇬	U+1F1FB U+1F1EC
242	Virgin Islands (US)	VIR	850	VI	+1-340	Charlotte Amalie	USD	United States dollar	$	.vi	United States Virgin Islands	Americas	Caribbean	{"{\\"tzName\\": \\"Atlantic Standard Time\\", \\"zoneName\\": \\"America/St_Thomas\\", \\"gmtOffset\\": -14400, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC-04:00\\"}"}	{"cn": "维尔京群岛（美国）", "de": "Amerikanische Jungferninseln", "es": "Islas Vírgenes de los Estados Unidos", "fa": "جزایر ویرجین آمریکا", "fr": "Îles Vierges des États-Unis", "it": "Isole Vergini americane", "ja": "アメリカ領ヴァージン諸島", "kr": "미국령 버진아일랜드", "nl": "Verenigde Staten Maagdeneilanden", "pt": "Ilhas Virgens Americanas", "tr": "Abd Virjin Adalari", "pt-BR": "Ilhas Virgens Americanas"}	18.34	-64.93	🇻🇮	U+1F1FB U+1F1EE
243	Wallis And Futuna Islands	WLF	876	WF	681	Mata Utu	XPF	CFP franc	₣	.wf	Wallis et Futuna	Oceania	Polynesia	{"{\\"tzName\\": \\"Wallis & Futuna Time\\", \\"zoneName\\": \\"Pacific/Wallis\\", \\"gmtOffset\\": 43200, \\"abbreviation\\": \\"WFT\\", \\"gmtOffsetName\\": \\"UTC+12:00\\"}"}	{"cn": "瓦利斯群岛和富图纳群岛", "de": "Wallis und Futuna", "es": "Wallis y Futuna", "fa": "والیس و فوتونا", "fr": "Wallis-et-Futuna", "hr": "Wallis i Fortuna", "it": "Wallis e Futuna", "ja": "ウォリス・フツナ", "kr": "왈리스 푸투나", "nl": "Wallis en Futuna", "pt": "Wallis e Futuna", "tr": "Wallis Ve Futuna", "pt-BR": "Wallis e Futuna"}	-13.3	-176.2	🇼🇫	U+1F1FC U+1F1EB
244	Western Sahara	ESH	732	EH	212	El-Aaiun	MAD	Moroccan Dirham	MAD	.eh	الصحراء الغربية	Africa	Northern Africa	{"{\\"tzName\\": \\"Western European Summer Time\\", \\"zoneName\\": \\"Africa/El_Aaiun\\", \\"gmtOffset\\": 3600, \\"abbreviation\\": \\"WEST\\", \\"gmtOffsetName\\": \\"UTC+01:00\\"}"}	{"cn": "西撒哈拉", "de": "Westsahara", "es": "Sahara Occidental", "fa": "جمهوری دموکراتیک عربی صحرا", "fr": "Sahara Occidental", "hr": "Zapadna Sahara", "it": "Sahara Occidentale", "ja": "西サハラ", "kr": "서사하라", "nl": "Westelijke Sahara", "pt": "Saara Ocidental", "tr": "Bati Sahra", "pt-BR": "Saara Ocidental"}	24.5	-13	🇪🇭	U+1F1EA U+1F1ED
245	Yemen	YEM	887	YE	967	Sanaa	YER	Yemeni rial	﷼	.ye	اليَمَن	Asia	Western Asia	{"{\\"tzName\\": \\"Arabia Standard Time\\", \\"zoneName\\": \\"Asia/Aden\\", \\"gmtOffset\\": 10800, \\"abbreviation\\": \\"AST\\", \\"gmtOffsetName\\": \\"UTC+03:00\\"}"}	{"cn": "也门", "de": "Jemen", "es": "Yemen", "fa": "یمن", "fr": "Yémen", "hr": "Jemen", "it": "Yemen", "ja": "イエメン", "kr": "예멘", "nl": "Jemen", "pt": "Iémen", "tr": "Yemen", "pt-BR": "Iêmen"}	15	48	🇾🇪	U+1F1FE U+1F1EA
246	Zambia	ZMB	894	ZM	260	Lusaka	ZMW	Zambian kwacha	ZK	.zm	Zambia	Africa	Eastern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Lusaka\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "赞比亚", "de": "Sambia", "es": "Zambia", "fa": "زامبیا", "fr": "Zambie", "hr": "Zambija", "it": "Zambia", "ja": "ザンビア", "kr": "잠비아", "nl": "Zambia", "pt": "Zâmbia", "tr": "Zambiya", "pt-BR": "Zâmbia"}	-15	30	🇿🇲	U+1F1FF U+1F1F2
247	Zimbabwe	ZWE	716	ZW	263	Harare	ZWL	Zimbabwe Dollar	$	.zw	Zimbabwe	Africa	Eastern Africa	{"{\\"tzName\\": \\"Central Africa Time\\", \\"zoneName\\": \\"Africa/Harare\\", \\"gmtOffset\\": 7200, \\"abbreviation\\": \\"CAT\\", \\"gmtOffsetName\\": \\"UTC+02:00\\"}"}	{"cn": "津巴布韦", "de": "Simbabwe", "es": "Zimbabue", "fa": "زیمباوه", "fr": "Zimbabwe", "hr": "Zimbabve", "it": "Zimbabwe", "ja": "ジンバブエ", "kr": "짐바브웨", "nl": "Zimbabwe", "pt": "Zimbabué", "tr": "Zimbabve", "pt-BR": "Zimbabwe"}	-20	30	🇿🇼	U+1F1FF U+1F1FC
\.


--
-- Data for Name: DeliveryZone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DeliveryZone" (id, "storeId", name, zipcodes, states, "minOrderPrice", "deliveryPrice", "conditionalPricing", "deliveryInformation", price, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Follows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Follows" ("followerId", "followingId") FROM stdin;
\.


--
-- Data for Name: FulfillmentService; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FulfillmentService" (id, name, email, "storeId") FROM stdin;
\.


--
-- Data for Name: GiftWrapOption; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."GiftWrapOption" (id, "productId", name, message, price, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Image" (id, "userId", "productId", url, description, "sortOrder", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: LineItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LineItem" (id, "orderId", "quantityOrdered", "quantityShipped", "quantityPending", "quantityCancelled", "quantityReturned", "quantityDelivered", "shippingMethod", "shippingCarrier", "minDaysInTransit", "maxDaysInTransit", "isReturnable", "daysToReturn", "policyUrl", "targetCountry", price, currency, "imageLink", title, gtin, brand, mpn, condition, attributes, "additionalFees", returns, cancellations, annotations, adjustments) FROM stdin;
\.


--
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Location" (id, "countryId", "createdAt", "updatedAt", "shippingZoneId") FROM stdin;
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, "storeId", "customerId", "billingAddressId", "shippingAddressId", "ipAddress", "cancelledAt", note, annotations, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: PricingRule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PricingRule" (id, "storeId", title, code, shipping, "order", "quantityMin", "adjusmentType", "adjustmentValue", "allocationLimit", "usageLimit", "usageCount", "startsAt", "endsAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" (id, "storeId", type, title, description, tags, weight, "weightUnit", width, height, depth, "dimensionUnit", price, "compareAtPrice", "costPrice", taxable, "taxId", "brandId", "inventoryTracking", "allowBackOrder", "inventoryLevel", "inventoryWarningLevel", sku, gtin, "isFreeShipping", "fixedShippingRate", public, featured, warranty, layout, availability, "availabilityLabel", "preOrderMessage", "preOrderOnly", "redirectUrl", condition, "showCondition", "searchKeywords", "pageTitle", "metaDescription", "metaKeywords", "viewCount", "customUrl", "openGraphTitle", "openGraphDescription", "openGraphType", "totalSold", "reviewCount", "reviewAverage", "customFields", subscription, "subscriptionInterval", "subscriptionLength", "subscriptionPrice", "createdAt", "updatedAt", "preOrderReleaseDate", currency, slug, "openGraphImageUrl", "shortUrl", currency_symbol) FROM stdin;
\.


--
-- Data for Name: ProductOption; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProductOption" (id, "productId", name, "values") FROM stdin;
\.


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProductVariant" (id, "productId", price, "compareAtPrice", "costPrice", "inventoryTracking", "allowBackOrder", "inventoryLevel", "inventoryWarningLevel", sku, gtin, "isFreeShipping", "fixedShippingRate", "imageId", "videoId", enabled, "pricingRuleId", "createdAt", "updatedAt", title) FROM stdin;
\.


--
-- Data for Name: ShippingRate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ShippingRate" (id, "shippingZoneId", type, "transitTime", "customRateName", price, "rateCondition", "rateConditionMin", "rateConditionMax", carrier, services, "handlingFeePercent", "handlingFeeFlat", currency, currency_symbol) FROM stdin;
\.


--
-- Data for Name: ShippingZone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ShippingZone" (id, "storeId", name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: State; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."State" (id, name, country_id, country_code, country_name, state_code, type, latitude, longitude, "locationId") FROM stdin;
3901	Badakhshan	1	AF	Afghanistan	BDS	\N	36.7347725	70.8119953	\N
3871	Badghis	1	AF	Afghanistan	BDG	\N	35.1671339	63.7695384	\N
3875	Baghlan	1	AF	Afghanistan	BGL	\N	36.1789026	68.7453064	\N
3884	Balkh	1	AF	Afghanistan	BAL	\N	36.7550603	66.8975372	\N
3872	Bamyan	1	AF	Afghanistan	BAM	\N	34.8100067	67.8212104	\N
3892	Daykundi	1	AF	Afghanistan	DAY	\N	33.669495	66.0463534	\N
3899	Farah	1	AF	Afghanistan	FRA	\N	32.495328	62.2626627	\N
3889	Faryab	1	AF	Afghanistan	FYB	\N	36.0795613	64.905955	\N
3870	Ghazni	1	AF	Afghanistan	GHA	\N	33.5450587	68.4173972	\N
3888	Ghōr	1	AF	Afghanistan	GHO	\N	34.0995776	64.905955	\N
3873	Helmand	1	AF	Afghanistan	HEL	\N	39.2989361	-76.6160472	\N
3887	Herat	1	AF	Afghanistan	HER	\N	34.352865	62.2040287	\N
3886	Jowzjan	1	AF	Afghanistan	JOW	\N	36.8969692	65.6658568	\N
3902	Kabul	1	AF	Afghanistan	KAB	\N	34.5553494	69.207486	\N
3890	Kandahar	1	AF	Afghanistan	KAN	\N	31.628871	65.7371749	\N
3879	Kapisa	1	AF	Afghanistan	KAP	\N	34.9810572	69.6214562	\N
3878	Khost	1	AF	Afghanistan	KHO	\N	33.3338472	69.9371673	\N
3876	Kunar	1	AF	Afghanistan	KNR	\N	34.8465893	71.097317	\N
3900	Kunduz Province	1	AF	Afghanistan	KDZ	\N	36.7285511	68.8678982	\N
3891	Laghman	1	AF	Afghanistan	LAG	\N	34.6897687	70.1455805	\N
3897	Logar	1	AF	Afghanistan	LOG	\N	34.0145518	69.1923916	\N
3882	Nangarhar	1	AF	Afghanistan	NAN	\N	34.1718313	70.6216794	\N
3896	Nimruz	1	AF	Afghanistan	NIM	\N	31.0261488	62.4504154	\N
3880	Nuristan	1	AF	Afghanistan	NUR	\N	35.3250223	70.9071236	\N
3894	Paktia	1	AF	Afghanistan	PIA	\N	33.706199	69.3831079	\N
3877	Paktika	1	AF	Afghanistan	PKA	\N	32.2645386	68.5247149	\N
3881	Panjshir	1	AF	Afghanistan	PAN	\N	38.8802391	-77.1717238	\N
3895	Parwan	1	AF	Afghanistan	PAR	\N	34.9630977	68.8108849	\N
3883	Samangan	1	AF	Afghanistan	SAM	\N	36.3155506	67.9642863	\N
3885	Sar-e Pol	1	AF	Afghanistan	SAR	\N	36.216628	65.93336	\N
3893	Takhar	1	AF	Afghanistan	TAK	\N	36.6698013	69.4784541	\N
3898	Urozgan	1	AF	Afghanistan	URU	\N	32.9271287	66.1415263	\N
3874	Zabul	1	AF	Afghanistan	ZAB	\N	32.1918782	67.1894488	\N
603	Berat County	3	AL	Albania	01	\N	40.6953012	20.0449662	\N
629	Berat District	3	AL	Albania	BR	\N	40.7086377	19.9437314	\N
607	Bulqizë District	3	AL	Albania	BU	\N	41.4942587	20.2147157	\N
618	Delvinë District	3	AL	Albania	DL	\N	39.9481364	20.0955891	\N
608	Devoll District	3	AL	Albania	DV	\N	40.6447347	20.9506636	\N
610	Dibër County	3	AL	Albania	09	\N	41.5888163	20.2355647	\N
605	Dibër District	3	AL	Albania	DI	\N	41.5888163	20.2355647	\N
632	Durrës County	3	AL	Albania	02	\N	41.5080972	19.6163185	\N
639	Durrës District	3	AL	Albania	DR	\N	41.3706517	19.5211063	\N
598	Elbasan County	3	AL	Albania	03	\N	41.1266672	20.2355647	\N
631	Fier County	3	AL	Albania	04	\N	40.9191392	19.6639309	\N
627	Fier District	3	AL	Albania	FR	\N	40.727504	19.5627596	\N
604	Gjirokastër County	3	AL	Albania	05	\N	40.0672874	20.1045229	\N
621	Gjirokastër District	3	AL	Albania	GJ	\N	40.0672874	20.1045229	\N
617	Gramsh District	3	AL	Albania	GR	\N	40.8669873	20.1849323	\N
600	Has District	3	AL	Albania	HA	\N	42.7901336	-83.6122012	\N
594	Kavajë District	3	AL	Albania	KA	\N	41.1844529	19.5627596	\N
628	Kolonjë District	3	AL	Albania	ER	\N	40.3373262	20.6794676	\N
630	Korçë County	3	AL	Albania	06	\N	40.590567	20.6168921	\N
597	Korçë District	3	AL	Albania	KO	\N	40.590567	20.6168921	\N
614	Krujë District	3	AL	Albania	KR	\N	41.5094765	19.7710732	\N
612	Kuçovë District	3	AL	Albania	KC	\N	40.7837063	19.8782348	\N
601	Kukës County	3	AL	Albania	07	\N	42.0807464	20.4142923	\N
623	Kukës District	3	AL	Albania	KU	\N	42.0807464	20.4142923	\N
622	Kurbin District	3	AL	Albania	KB	\N	41.6412644	19.705595	\N
609	Lezhë County	3	AL	Albania	08	\N	41.7813759	19.8067916	\N
595	Lezhë District	3	AL	Albania	LE	\N	41.786073	19.6460758	\N
596	Librazhd District	3	AL	Albania	LB	\N	41.1829232	20.3174769	\N
599	Lushnjë District	3	AL	Albania	LU	\N	40.941983	19.6996428	\N
602	Malësi e Madhe District	3	AL	Albania	MM	\N	42.4245173	19.6163185	\N
637	Mallakastër District	3	AL	Albania	MK	\N	40.5273376	19.7829791	\N
635	Mat District	3	AL	Albania	MT	\N	41.5937675	19.9973244	\N
638	Mirditë District	3	AL	Albania	MR	\N	41.764286	19.9020509	\N
619	Peqin District	3	AL	Albania	PQ	\N	41.0470902	19.7502384	\N
625	Përmet District	3	AL	Albania	PR	\N	40.2361837	20.3517334	\N
606	Pogradec District	3	AL	Albania	PG	\N	40.9015314	20.6556289	\N
620	Pukë District	3	AL	Albania	PU	\N	42.0469772	19.8960968	\N
624	Sarandë District	3	AL	Albania	SR	\N	39.8592119	20.0271001	\N
611	Shkodër County	3	AL	Albania	10	\N	42.150371	19.6639309	\N
626	Shkodër District	3	AL	Albania	SH	\N	42.0692985	19.5032559	\N
593	Skrapar District	3	AL	Albania	SK	\N	40.5349946	20.2832217	\N
616	Tepelenë District	3	AL	Albania	TE	\N	40.2966632	20.0181673	\N
615	Tirana County	3	AL	Albania	11	\N	41.2427598	19.8067916	\N
633	Tirana District	3	AL	Albania	TR	\N	41.3275459	19.8186982	\N
636	Tropojë District	3	AL	Albania	TP	\N	42.3982151	20.1625955	\N
634	Vlorë County	3	AL	Albania	12	\N	40.150096	19.8067916	\N
613	Vlorë District	3	AL	Albania	VL	\N	40.4660668	19.491356	\N
1118	Adrar	4	DZ	Algeria	01	\N	26.418131	-0.6014717	\N
1119	Aïn Defla	4	DZ	Algeria	44	\N	36.2509429	1.9393815	\N
1122	Aïn Témouchent	4	DZ	Algeria	46	\N	35.2992698	-1.1392792	\N
1144	Algiers	4	DZ	Algeria	16	\N	36.6997294	3.0576199	\N
1103	Annaba	4	DZ	Algeria	23	\N	36.8020508	7.5247243	\N
1142	Batna	4	DZ	Algeria	05	\N	35.5965954	5.8987139	\N
1108	Béchar	4	DZ	Algeria	08	\N	31.6238098	-2.2162443	\N
1128	Béjaïa	4	DZ	Algeria	06	\N	36.7515258	5.0556837	\N
4909	Béni Abbès	4	DZ	Algeria	53	\N	30.0831042	-2.8345052	\N
1114	Biskra	4	DZ	Algeria	07	\N	34.8449437	5.7248567	\N
1111	Blida	4	DZ	Algeria	09	\N	36.531123	2.8976254	\N
4908	Bordj Baji Mokhtar	4	DZ	Algeria	52	\N	22.966335	-3.9472732	\N
1116	Bordj Bou Arréridj	4	DZ	Algeria	34	\N	36.0739925	4.7630271	\N
1104	Bouïra	4	DZ	Algeria	10	\N	36.3691846	3.9006194	\N
1125	Boumerdès	4	DZ	Algeria	35	\N	36.6839559	3.6217802	\N
1105	Chlef	4	DZ	Algeria	02	\N	36.1693515	1.2891036	\N
1121	Constantine	4	DZ	Algeria	25	\N	36.3373911	6.663812	\N
4912	Djanet	4	DZ	Algeria	56	\N	23.8310872	8.7004672	\N
1098	Djelfa	4	DZ	Algeria	17	\N	34.6703956	3.2503761	\N
1129	El Bayadh	4	DZ	Algeria	32	\N	32.7148824	0.9056623	\N
4905	El M'ghair	4	DZ	Algeria	49	\N	33.9540561	5.1346418	\N
4906	El Menia	4	DZ	Algeria	50	\N	31.364225	2.5784495	\N
1099	El Oued	4	DZ	Algeria	39	\N	33.367811	6.8516511	\N
1100	El Tarf	4	DZ	Algeria	36	\N	36.7576678	8.3076343	\N
1127	Ghardaïa	4	DZ	Algeria	47	\N	32.4943741	3.64446	\N
1137	Guelma	4	DZ	Algeria	24	\N	36.4627444	7.4330833	\N
1112	Illizi	4	DZ	Algeria	33	\N	26.1690005	8.4842465	\N
4914	In Guezzam	4	DZ	Algeria	58	\N	20.3864323	4.7789394	\N
4913	In Salah	4	DZ	Algeria	57	\N	27.2149229	1.8484396	\N
1113	Jijel	4	DZ	Algeria	18	\N	36.7179681	5.9832577	\N
1126	Khenchela	4	DZ	Algeria	40	\N	35.4269404	7.1460155	\N
1138	Laghouat	4	DZ	Algeria	03	\N	33.8078341	2.8628294	\N
1134	M'Sila	4	DZ	Algeria	28	\N	35.7186646	4.5233423	\N
1124	Mascara	4	DZ	Algeria	29	\N	35.3904125	0.1494988	\N
1109	Médéa	4	DZ	Algeria	26	\N	36.2637078	2.7587857	\N
1132	Mila	4	DZ	Algeria	43	\N	36.3647957	6.1526985	\N
1140	Mostaganem	4	DZ	Algeria	27	\N	35.9583054	0.3371889	\N
1102	Naama	4	DZ	Algeria	45	\N	33.2667317	-0.3128659	\N
1101	Oran	4	DZ	Algeria	31	\N	35.6082351	-0.563609	\N
1139	Ouargla	4	DZ	Algeria	30	\N	32.2264863	5.7299821	\N
4907	Ouled Djellal	4	DZ	Algeria	51	\N	34.4178221	4.9685843	\N
1136	Oum El Bouaghi	4	DZ	Algeria	04	\N	35.8688789	7.1108266	\N
1130	Relizane	4	DZ	Algeria	48	\N	35.7383405	0.7532809	\N
1123	Saïda	4	DZ	Algeria	20	\N	34.8415207	0.1456055	\N
1141	Sétif	4	DZ	Algeria	19	\N	36.3073389	5.5617279	\N
4902	Sidi Bel Abbès	4	DZ	Algeria	22	\N	34.6806024	-1.0999495	\N
1110	Skikda	4	DZ	Algeria	21	\N	36.6721198	6.8350999	\N
1143	Souk Ahras	4	DZ	Algeria	41	\N	36.2801062	7.9384033	\N
1135	Tamanghasset	4	DZ	Algeria	11	\N	22.7902972	5.5193268	\N
1117	Tébessa	4	DZ	Algeria	12	\N	35.1290691	7.9592863	\N
1106	Tiaret	4	DZ	Algeria	14	\N	35.3708689	1.3217852	\N
4910	Timimoun	4	DZ	Algeria	54	\N	29.678906	0.5004608	\N
1120	Tindouf	4	DZ	Algeria	37	\N	27.8063119	-5.7299821	\N
1115	Tipasa	4	DZ	Algeria	42	\N	36.546265	2.1843285	\N
1133	Tissemsilt	4	DZ	Algeria	38	\N	35.6053781	1.813098	\N
1131	Tizi Ouzou	4	DZ	Algeria	15	\N	36.706911	4.2333355	\N
1107	Tlemcen	4	DZ	Algeria	13	\N	34.6780284	-1.366216	\N
4911	Touggourt	4	DZ	Algeria	55	\N	33.1248476	5.7832715	\N
488	Andorra la Vella	6	AD	Andorra	07	\N	42.5063174	1.5218355	\N
489	Canillo	6	AD	Andorra	02	\N	42.5978249	1.6566377	\N
487	Encamp	6	AD	Andorra	03	\N	42.5359764	1.5836773	\N
492	Escaldes-Engordany	6	AD	Andorra	08	\N	42.4909379	1.5886966	\N
493	La Massana	6	AD	Andorra	04	\N	42.545625	1.5147392	\N
491	Ordino	6	AD	Andorra	05	\N	42.5994433	1.5402327	\N
490	Sant Julià de Lòria	6	AD	Andorra	06	\N	42.4529631	1.4918235	\N
221	Bengo Province	7	AO	Angola	BGO	\N	-9.1042257	13.7289167	\N
218	Benguela Province	7	AO	Angola	BGU	\N	-12.8003744	13.914399	\N
212	Bié Province	7	AO	Angola	BIE	\N	-12.5727907	17.668887	\N
228	Cabinda Province	7	AO	Angola	CAB	\N	-5.0248749	12.3463875	\N
226	Cuando Cubango Province	7	AO	Angola	CCU	\N	-16.4180824	18.8076195	\N
217	Cuanza Norte Province	7	AO	Angola	CNO	\N	-9.2398513	14.6587821	\N
216	Cuanza Sul	7	AO	Angola	CUS	\N	-10.595191	15.4068079	\N
215	Cunene Province	7	AO	Angola	CNN	\N	-16.2802221	16.1580937	\N
213	Huambo Province	7	AO	Angola	HUA	\N	-12.5268221	15.5943388	\N
225	Huíla Province	7	AO	Angola	HUI	\N	-14.9280553	14.6587821	\N
222	Luanda Province	7	AO	Angola	LUA	\N	-9.035088	13.2663479	\N
223	Lunda Norte Province	7	AO	Angola	LNO	\N	-8.3525022	19.1880047	\N
220	Lunda Sul Province	7	AO	Angola	LSU	\N	-10.2866578	20.7122465	\N
227	Malanje Province	7	AO	Angola	MAL	\N	-9.8251183	16.912251	\N
219	Moxico Province	7	AO	Angola	MOX	\N	-13.4293579	20.3308814	\N
224	Uíge Province	7	AO	Angola	UIG	\N	-7.1736732	15.4068079	\N
214	Zaire Province	7	AO	Angola	ZAI	\N	-6.5733458	13.1740348	\N
3708	Barbuda	10	AG	Antigua And Barbuda	10	\N	17.6266242	-61.7713028	\N
3703	Redonda	10	AG	Antigua And Barbuda	11	\N	16.938416	-62.3455148	\N
3709	Saint George Parish	10	AG	Antigua And Barbuda	03	\N	\N	\N	\N
3706	Saint John Parish	10	AG	Antigua And Barbuda	04	\N	\N	\N	\N
3707	Saint Mary Parish	10	AG	Antigua And Barbuda	05	\N	\N	\N	\N
3705	Saint Paul Parish	10	AG	Antigua And Barbuda	06	\N	\N	\N	\N
3704	Saint Peter Parish	10	AG	Antigua And Barbuda	07	\N	\N	\N	\N
3710	Saint Philip Parish	10	AG	Antigua And Barbuda	08	\N	40.4368258	-80.0685532	\N
3656	Buenos Aires	11	AR	Argentina	B	province	-37.2017285	-59.8410697	\N
3647	Catamarca	11	AR	Argentina	K	province	-28.4715877	-65.7877209	\N
3640	Chaco	11	AR	Argentina	H	province	-27.4257175	-59.0243784	\N
3651	Chubut	11	AR	Argentina	U	province	-43.2934246	-65.1114818	\N
4880	Ciudad Autónoma de Buenos Aires	11	AR	Argentina	C	city	-34.6036844	-58.3815591	\N
3642	Córdoba	11	AR	Argentina	X	province	-31.3992876	-64.2643842	\N
3638	Corrientes	11	AR	Argentina	W	province	-27.4692131	-58.8306349	\N
3654	Entre Ríos	11	AR	Argentina	E	province	-31.7746654	-60.4956461	\N
3652	Formosa	11	AR	Argentina	P	province	-26.1894804	-58.2242806	\N
3645	Jujuy	11	AR	Argentina	Y	province	-24.1843397	-65.302177	\N
3655	La Pampa	11	AR	Argentina	L	province	-36.6147573	-64.2839209	\N
3653	La Rioja	11	AR	Argentina	F	province	-29.4193793	-66.8559932	\N
3646	Mendoza	11	AR	Argentina	M	province	-32.8894587	-68.8458386	\N
3644	Misiones	11	AR	Argentina	N	province	-27.4269255	-55.9467076	\N
3648	Neuquén	11	AR	Argentina	Q	province	-38.94587	-68.0730925	\N
3639	Río Negro	11	AR	Argentina	R	province	-40.8261434	-63.0266339	\N
3643	Salta	11	AR	Argentina	A	province	-24.7997688	-65.4150367	\N
3634	San Juan	11	AR	Argentina	J	province	-31.5316976	-68.5676962	\N
3636	San Luis	11	AR	Argentina	D	province	-33.2962042	-66.3294948	\N
3649	Santa Cruz	11	AR	Argentina	Z	province	-51.6352821	-69.2474353	\N
3641	Santa Fe	11	AR	Argentina	S	province	-31.5855109	-60.7238016	\N
3635	Santiago del Estero	11	AR	Argentina	G	province	-27.7833574	-64.264167	\N
3650	Tierra del Fuego	11	AR	Argentina	V	province	-54.8053998	-68.3242061	\N
3637	Tucumán	11	AR	Argentina	T	province	-26.8221127	-65.2192903	\N
2023	Aragatsotn Region	12	AM	Armenia	AG	\N	40.3347301	44.3748296	\N
2024	Ararat Province	12	AM	Armenia	AR	\N	39.9139415	44.7200004	\N
2026	Armavir Region	12	AM	Armenia	AV	\N	40.1554631	44.0372446	\N
2028	Gegharkunik Province	12	AM	Armenia	GR	\N	40.3526426	45.1260414	\N
2033	Kotayk Region	12	AM	Armenia	KT	\N	40.5410214	44.7690148	\N
2029	Lori Region	12	AM	Armenia	LO	\N	40.9698452	44.4900138	\N
2031	Shirak Region	12	AM	Armenia	SH	\N	40.9630814	43.8102461	\N
2027	Syunik Province	12	AM	Armenia	SU	\N	39.5133112	46.3393234	\N
2032	Tavush Region	12	AM	Armenia	TV	\N	40.8866296	45.339349	\N
2025	Vayots Dzor Region	12	AM	Armenia	VD	\N	39.7641996	45.3337528	\N
2030	Yerevan	12	AM	Armenia	ER	\N	40.1872023	44.515209	\N
3907	Australian Capital Territory	14	AU	Australia	ACT	territory	-35.4734679	149.0123679	\N
3909	New South Wales	14	AU	Australia	NSW	state	-31.2532183	146.921099	\N
3910	Northern Territory	14	AU	Australia	NT	territory	-19.4914108	132.5509603	\N
3905	Queensland	14	AU	Australia	QLD	state	-20.9175738	142.7027956	\N
3904	South Australia	14	AU	Australia	SA	state	-30.0002315	136.2091547	\N
3908	Tasmania	14	AU	Australia	TAS	state	-41.4545196	145.9706647	\N
3903	Victoria	14	AU	Australia	VIC	state	-36.4856423	140.9779425	\N
3906	Western Australia	14	AU	Australia	WA	state	-27.6728168	121.6283098	\N
2062	Burgenland	15	AT	Austria	1	\N	47.1537165	16.2688797	\N
2057	Carinthia	15	AT	Austria	2	\N	46.722203	14.1805882	\N
2065	Lower Austria	15	AT	Austria	3	\N	48.108077	15.8049558	\N
2061	Salzburg	15	AT	Austria	5	\N	47.80949	13.05501	\N
2059	Styria	15	AT	Austria	6	\N	47.3593442	14.4699827	\N
2064	Tyrol	15	AT	Austria	7	\N	47.2537414	11.601487	\N
2058	Upper Austria	15	AT	Austria	4	\N	48.025854	13.9723665	\N
2060	Vienna	15	AT	Austria	9	\N	48.2081743	16.3738189	\N
2063	Vorarlberg	15	AT	Austria	8	\N	47.2497427	9.9797373	\N
540	Absheron District	16	AZ	Azerbaijan	ABS	\N	40.3629693	49.2736815	\N
559	Agdam District	16	AZ	Azerbaijan	AGM	\N	39.9931853	46.9949562	\N
553	Agdash District	16	AZ	Azerbaijan	AGS	\N	40.6335427	47.467431	\N
577	Aghjabadi District	16	AZ	Azerbaijan	AGC	\N	28.7891841	77.5160788	\N
543	Agstafa District	16	AZ	Azerbaijan	AGA	\N	41.2655933	45.5134291	\N
547	Agsu District	16	AZ	Azerbaijan	AGU	\N	40.5283339	48.3650835	\N
528	Astara District	16	AZ	Azerbaijan	AST	\N	38.4937845	48.6944365	\N
575	Babek District	16	AZ	Azerbaijan	BAB	\N	39.1507613	45.4485368	\N
552	Baku	16	AZ	Azerbaijan	BA	\N	40.4092617	49.8670924	\N
560	Balakan District	16	AZ	Azerbaijan	BAL	\N	41.7037509	46.4044213	\N
569	Barda District	16	AZ	Azerbaijan	BAR	\N	40.3706555	47.1378909	\N
554	Beylagan District	16	AZ	Azerbaijan	BEY	\N	39.7723073	47.6154166	\N
532	Bilasuvar District	16	AZ	Azerbaijan	BIL	\N	39.4598833	48.5509813	\N
561	Dashkasan District	16	AZ	Azerbaijan	DAS	\N	40.5202257	46.0779304	\N
527	Fizuli District	16	AZ	Azerbaijan	FUZ	\N	39.5378605	47.3033877	\N
585	Ganja	16	AZ	Azerbaijan	GA	\N	36.3687338	-95.9985767	\N
589	Gədəbəy	16	AZ	Azerbaijan	GAD	\N	40.5699639	45.8106883	\N
573	Gobustan District	16	AZ	Azerbaijan	QOB	\N	40.5326104	48.927375	\N
551	Goranboy District	16	AZ	Azerbaijan	GOR	\N	40.5380506	46.5990891	\N
531	Goychay	16	AZ	Azerbaijan	GOY	\N	40.6236168	47.7403034	\N
574	Goygol District	16	AZ	Azerbaijan	GYG	\N	40.5595378	46.3314953	\N
571	Hajigabul District	16	AZ	Azerbaijan	HAC	\N	40.039377	48.9202533	\N
544	Imishli District	16	AZ	Azerbaijan	IMI	\N	39.8694686	48.0665218	\N
564	Ismailli District	16	AZ	Azerbaijan	ISM	\N	40.7429936	48.2125556	\N
570	Jabrayil District	16	AZ	Azerbaijan	CAB	\N	39.2645544	46.9621562	\N
578	Jalilabad District	16	AZ	Azerbaijan	CAL	\N	39.2051632	48.5100604	\N
572	Julfa District	16	AZ	Azerbaijan	CUL	\N	38.9604983	45.6292939	\N
525	Kalbajar District	16	AZ	Azerbaijan	KAL	\N	40.1024329	46.0364872	\N
567	Kangarli District	16	AZ	Azerbaijan	KAN	\N	39.387194	45.1639852	\N
590	Khachmaz District	16	AZ	Azerbaijan	XAC	\N	41.4591168	48.8020626	\N
537	Khizi District	16	AZ	Azerbaijan	XIZ	\N	40.9109489	49.0729264	\N
524	Khojali District	16	AZ	Azerbaijan	XCI	\N	39.9132553	46.794305	\N
549	Kurdamir District	16	AZ	Azerbaijan	KUR	\N	40.3698651	48.1644626	\N
541	Lachin District	16	AZ	Azerbaijan	LAC	\N	39.6383414	46.5460853	\N
587	Lankaran	16	AZ	Azerbaijan	LAN	\N	38.7528669	48.8475015	\N
558	Lankaran District	16	AZ	Azerbaijan	LA	\N	38.7528669	48.8475015	\N
546	Lerik District	16	AZ	Azerbaijan	LER	\N	38.7736192	48.4151483	\N
568	Martuni	16	AZ	Azerbaijan	XVD	\N	39.7914693	47.1100814	\N
555	Masally District	16	AZ	Azerbaijan	MAS	\N	39.0340722	48.6589354	\N
580	Mingachevir	16	AZ	Azerbaijan	MI	\N	40.7702563	47.0496015	\N
562	Nakhchivan Autonomous Republic	16	AZ	Azerbaijan	NX	\N	39.3256814	45.4912648	\N
530	Neftchala District	16	AZ	Azerbaijan	NEF	\N	39.3881052	49.2413743	\N
556	Oghuz District	16	AZ	Azerbaijan	OGU	\N	41.0727924	47.4650672	\N
534	Ordubad District	16	AZ	Azerbaijan	ORD	\N	38.9021622	46.0237625	\N
542	Qabala District	16	AZ	Azerbaijan	QAB	\N	40.9253925	47.8016106	\N
526	Qakh District	16	AZ	Azerbaijan	QAX	\N	41.4206827	46.9320184	\N
521	Qazakh District	16	AZ	Azerbaijan	QAZ	\N	41.0971074	45.3516331	\N
563	Quba District	16	AZ	Azerbaijan	QBA	\N	41.1564242	48.4135021	\N
548	Qubadli District	16	AZ	Azerbaijan	QBI	\N	39.2713996	46.6354312	\N
588	Qusar District	16	AZ	Azerbaijan	QUS	\N	41.4266886	48.4345577	\N
557	Saatly District	16	AZ	Azerbaijan	SAT	\N	39.9095503	48.3595122	\N
565	Sabirabad District	16	AZ	Azerbaijan	SAB	\N	39.9870663	48.4692545	\N
522	Sadarak District	16	AZ	Azerbaijan	SAD	\N	39.7105114	44.8864277	\N
545	Salyan District	16	AZ	Azerbaijan	SAL	\N	28.3524811	82.12784	\N
536	Samukh District	16	AZ	Azerbaijan	SMX	\N	40.7604631	46.4063181	\N
591	Shabran District	16	AZ	Azerbaijan	SBN	\N	41.2228376	48.8457304	\N
579	Shahbuz District	16	AZ	Azerbaijan	SAH	\N	39.4452103	45.6568009	\N
518	Shaki	16	AZ	Azerbaijan	SA	\N	41.1974753	47.1571241	\N
586	Shaki District	16	AZ	Azerbaijan	SAK	\N	41.1134662	47.1316927	\N
529	Shamakhi District	16	AZ	Azerbaijan	SMI	\N	40.6318731	48.6363801	\N
583	Shamkir District	16	AZ	Azerbaijan	SKR	\N	40.8288144	46.0166879	\N
535	Sharur District	16	AZ	Azerbaijan	SAR	\N	39.5536332	44.984568	\N
520	Shirvan	16	AZ	Azerbaijan	SR	\N	39.9469707	48.9223919	\N
592	Shusha District	16	AZ	Azerbaijan	SUS	\N	39.7537438	46.7464755	\N
584	Siazan District	16	AZ	Azerbaijan	SIY	\N	41.0783833	49.1118477	\N
582	Sumqayit	16	AZ	Azerbaijan	SM	\N	40.5854765	49.6317411	\N
519	Tartar District	16	AZ	Azerbaijan	TAR	\N	40.3443875	46.9376519	\N
533	Tovuz District	16	AZ	Azerbaijan	TOV	\N	40.9954523	45.6165907	\N
539	Ujar District	16	AZ	Azerbaijan	UCA	\N	40.5067525	47.6489641	\N
550	Yardymli District	16	AZ	Azerbaijan	YAR	\N	38.9058917	48.2496127	\N
538	Yevlakh	16	AZ	Azerbaijan	YE	\N	40.6196638	47.1500324	\N
523	Yevlakh District	16	AZ	Azerbaijan	YEV	\N	40.6196638	47.1500324	\N
581	Zangilan District	16	AZ	Azerbaijan	ZAN	\N	39.0856899	46.6524728	\N
566	Zaqatala District	16	AZ	Azerbaijan	ZAQ	\N	41.5906889	46.7240373	\N
576	Zardab District	16	AZ	Azerbaijan	ZAR	\N	40.2148114	47.714944	\N
1992	Capital	18	BH	Bahrain	13	\N	\N	\N	\N
1996	Central	18	BH	Bahrain	16	\N	26.1426093	50.5653294	\N
1995	Muharraq	18	BH	Bahrain	15	\N	26.2685653	50.6482517	\N
1994	Northern	18	BH	Bahrain	17	\N	26.1551914	50.4825173	\N
1993	Southern	18	BH	Bahrain	14	\N	25.9381018	50.5756887	\N
796	Bagerhat District	19	BD	Bangladesh	05	\N	22.6602436	89.7895478	\N
802	Bahadia	19	BD	Bangladesh	33	\N	23.7898712	90.1671483	\N
752	Bandarban District	19	BD	Bangladesh	01	\N	21.8311002	92.3686321	\N
784	Barguna District	19	BD	Bangladesh	02	\N	22.0952915	90.1120696	\N
818	Barisal District	19	BD	Bangladesh	06	\N	22.7022098	90.3696316	\N
807	Barisal Division	19	BD	Bangladesh	A	\N	22.3811131	90.3371889	\N
756	Bhola District	19	BD	Bangladesh	07	\N	22.1785315	90.7101023	\N
797	Bogra District	19	BD	Bangladesh	03	\N	24.8510402	89.3697225	\N
810	Brahmanbaria District	19	BD	Bangladesh	04	\N	23.9608181	91.1115014	\N
768	Chandpur District	19	BD	Bangladesh	09	\N	23.2513148	90.8517846	\N
761	Chapai Nawabganj District	19	BD	Bangladesh	45	\N	24.7413111	88.2912069	\N
785	Chittagong District	19	BD	Bangladesh	10	\N	22.5150105	91.7538817	\N
803	Chittagong Division	19	BD	Bangladesh	B	\N	23.1793157	91.9881527	\N
788	Chuadanga District	19	BD	Bangladesh	12	\N	23.6160512	88.8263006	\N
763	Comilla District	19	BD	Bangladesh	08	\N	23.4575667	91.1808996	\N
751	Cox's Bazar District	19	BD	Bangladesh	11	\N	21.5640626	92.0282129	\N
771	Dhaka District	19	BD	Bangladesh	13	\N	23.810514	90.3371889	\N
760	Dhaka Division	19	BD	Bangladesh	C	\N	23.9535742	90.1494988	\N
783	Dinajpur District	19	BD	Bangladesh	14	\N	25.6279123	88.6331758	\N
762	Faridpur District	19	BD	Bangladesh	15	\N	23.5423919	89.6308921	\N
816	Feni District	19	BD	Bangladesh	16	\N	22.9408784	91.4066646	\N
795	Gaibandha District	19	BD	Bangladesh	19	\N	25.3296928	89.5429652	\N
798	Gazipur District	19	BD	Bangladesh	18	\N	24.0958171	90.4125181	\N
792	Gopalganj District	19	BD	Bangladesh	17	\N	26.4831584	84.43655	\N
805	Habiganj District	19	BD	Bangladesh	20	\N	24.4771236	91.4506565	\N
808	Jamalpur District	19	BD	Bangladesh	21	\N	25.0830926	89.7853218	\N
757	Jessore District	19	BD	Bangladesh	22	\N	23.1634014	89.2181664	\N
778	Jhalokati District	19	BD	Bangladesh	25	\N	22.57208	90.1869644	\N
789	Jhenaidah District	19	BD	Bangladesh	23	\N	23.5449873	89.1726031	\N
806	Joypurhat District	19	BD	Bangladesh	24	\N	25.0947349	89.0944937	\N
786	Khagrachari District	19	BD	Bangladesh	29	\N	23.1321751	91.949021	\N
811	Khulna District	19	BD	Bangladesh	27	\N	22.6737735	89.3966581	\N
775	Khulna Division	19	BD	Bangladesh	D	\N	22.8087816	89.2467191	\N
779	Kishoreganj District	19	BD	Bangladesh	26	\N	24.4260457	90.9820668	\N
793	Kurigram District	19	BD	Bangladesh	28	\N	25.8072414	89.6294746	\N
774	Kushtia District	19	BD	Bangladesh	30	\N	23.8906995	89.1099368	\N
819	Lakshmipur District	19	BD	Bangladesh	31	\N	22.9446744	90.8281907	\N
780	Lalmonirhat District	19	BD	Bangladesh	32	\N	25.9923398	89.2847251	\N
817	Madaripur District	19	BD	Bangladesh	36	\N	23.2393346	90.1869644	\N
776	Meherpur District	19	BD	Bangladesh	39	\N	23.8051991	88.6723578	\N
794	Moulvibazar District	19	BD	Bangladesh	38	\N	24.3095344	91.7314903	\N
790	Munshiganj District	19	BD	Bangladesh	35	\N	23.4980931	90.4126621	\N
766	Mymensingh District	19	BD	Bangladesh	34	\N	24.7538575	90.4072919	\N
758	Mymensingh Division	19	BD	Bangladesh	H	\N	24.71362	90.4502368	\N
814	Naogaon District	19	BD	Bangladesh	48	\N	24.9131597	88.7530952	\N
769	Narail District	19	BD	Bangladesh	43	\N	23.1162929	89.5840404	\N
770	Narayanganj District	19	BD	Bangladesh	40	\N	23.7146601	90.563609	\N
787	Natore District	19	BD	Bangladesh	44	\N	24.410243	89.0076177	\N
764	Netrokona District	19	BD	Bangladesh	41	\N	24.8103284	90.8656415	\N
772	Nilphamari District	19	BD	Bangladesh	46	\N	25.8482798	88.9414134	\N
815	Noakhali District	19	BD	Bangladesh	47	\N	22.8723789	91.0973184	\N
754	Pabna District	19	BD	Bangladesh	49	\N	24.158505	89.4480718	\N
800	Panchagarh District	19	BD	Bangladesh	52	\N	26.2708705	88.5951751	\N
777	Patuakhali District	19	BD	Bangladesh	51	\N	22.2248632	90.4547503	\N
791	Pirojpur District	19	BD	Bangladesh	50	\N	22.5790744	89.9759264	\N
773	Rajbari District	19	BD	Bangladesh	53	\N	23.715134	89.5874819	\N
813	Rajshahi District	19	BD	Bangladesh	54	\N	24.3733087	88.6048716	\N
753	Rajshahi Division	19	BD	Bangladesh	E	\N	24.7105776	88.9413865	\N
809	Rangamati Hill District	19	BD	Bangladesh	56	\N	22.7324173	92.2985134	\N
759	Rangpur District	19	BD	Bangladesh	55	\N	25.7467925	89.2508335	\N
750	Rangpur Division	19	BD	Bangladesh	F	\N	25.8483388	88.9413865	\N
799	Satkhira District	19	BD	Bangladesh	58	\N	22.3154812	89.1114525	\N
801	Shariatpur District	19	BD	Bangladesh	62	\N	23.2423214	90.4347711	\N
755	Sherpur District	19	BD	Bangladesh	57	\N	25.0746235	90.1494904	\N
781	Sirajganj District	19	BD	Bangladesh	59	\N	24.3141115	89.5699615	\N
812	Sunamganj District	19	BD	Bangladesh	61	\N	25.0714535	91.3991627	\N
767	Sylhet District	19	BD	Bangladesh	60	\N	24.8993357	91.8700473	\N
765	Sylhet Division	19	BD	Bangladesh	G	\N	24.7049811	91.6760691	\N
782	Tangail District	19	BD	Bangladesh	63	\N	24.3917427	89.9948257	\N
804	Thakurgaon District	19	BD	Bangladesh	64	\N	26.0418392	88.4282616	\N
1228	Christ Church	20	BB	Barbados	01	\N	36.0060407	-95.921121	\N
1229	Saint Andrew	20	BB	Barbados	02	\N	\N	\N	\N
1226	Saint George	20	BB	Barbados	03	\N	37.0965278	-113.5684164	\N
1224	Saint James	20	BB	Barbados	04	\N	48.523566	-1.3237885	\N
1227	Saint John	20	BB	Barbados	05	\N	45.2733153	-66.063308	\N
1223	Saint Joseph	20	BB	Barbados	06	\N	39.7674578	-94.846681	\N
1221	Saint Lucy	20	BB	Barbados	07	\N	38.7614625	-77.4491439	\N
1230	Saint Michael	20	BB	Barbados	08	\N	36.035977	-95.849052	\N
1222	Saint Peter	20	BB	Barbados	09	\N	37.0827119	-94.517125	\N
1220	Saint Philip	20	BB	Barbados	10	\N	35.233114	-89.4364042	\N
1225	Saint Thomas	20	BB	Barbados	11	\N	18.3380965	-64.8940946	\N
2959	Brest Region	21	BY	Belarus	BR	\N	52.5296641	25.460648	\N
2955	Gomel Region	21	BY	Belarus	HO	\N	52.1648754	29.1333251	\N
2956	Grodno Region	21	BY	Belarus	HR	\N	53.6599945	25.3448571	\N
2958	Minsk	21	BY	Belarus	HM	\N	53.9006011	27.558972	\N
2957	Minsk Region	21	BY	Belarus	MI	\N	54.1067889	27.4129245	\N
2954	Mogilev Region	21	BY	Belarus	MA	\N	53.5101791	30.4006444	\N
2960	Vitebsk Region	21	BY	Belarus	VI	\N	55.2959833	28.7583627	\N
1381	Antwerp	22	BE	Belgium	VAN	\N	51.2194475	4.4024643	\N
1376	Brussels-Capital Region	22	BE	Belgium	BRU	\N	50.8503463	4.3517211	\N
1377	East Flanders	22	BE	Belgium	VOV	\N	51.0362101	3.7373124	\N
1373	Flanders	22	BE	Belgium	VLG	\N	51.0108706	3.7264613	\N
1374	Flemish Brabant	22	BE	Belgium	VBR	\N	50.8815434	4.564597	\N
1375	Hainaut	22	BE	Belgium	WHT	\N	50.5257076	4.0621017	\N
1384	Liège	22	BE	Belgium	WLG	\N	50.6325574	5.5796662	\N
1372	Limburg	22	BE	Belgium	VLI	\N	\N	\N	\N
1379	Luxembourg	22	BE	Belgium	WLX	\N	49.815273	6.129583	\N
1378	Namur	22	BE	Belgium	WNA	\N	50.4673883	4.8719854	\N
1380	Wallonia	22	BE	Belgium	WAL	\N	50.4175637	4.4510066	\N
1382	Walloon Brabant	22	BE	Belgium	WBR	\N	50.633241	4.524315	\N
1383	West Flanders	22	BE	Belgium	VWV	\N	40.0179334	-105.2806733	\N
264	Belize District	23	BZ	Belize	BZ	\N	17.5677679	-88.4016041	\N
269	Cayo District	23	BZ	Belize	CY	\N	17.0984445	-88.9413865	\N
266	Corozal District	23	BZ	Belize	CZL	\N	18.1349238	-88.2461183	\N
268	Orange Walk District	23	BZ	Belize	OW	\N	17.760353	-88.864698	\N
265	Stann Creek District	23	BZ	Belize	SC	\N	16.8116631	-88.4016041	\N
267	Toledo District	23	BZ	Belize	TOL	\N	16.2491923	-88.864698	\N
3077	Alibori Department	24	BJ	Benin	AL	\N	10.9681093	2.7779813	\N
3076	Atakora Department	24	BJ	Benin	AK	\N	10.7954931	1.6760691	\N
3079	Atlantique Department	24	BJ	Benin	AQ	\N	6.6588391	2.2236667	\N
3078	Borgou Department	24	BJ	Benin	BO	\N	9.5340864	2.7779813	\N
3070	Collines Department	24	BJ	Benin	CO	\N	8.3022297	2.302446	\N
3072	Donga Department	24	BJ	Benin	DO	\N	9.7191867	1.6760691	\N
3071	Kouffo Department	24	BJ	Benin	KO	\N	7.0035894	1.7538817	\N
3081	Littoral Department	24	BJ	Benin	LI	\N	6.3806973	2.4406387	\N
3075	Mono Department	24	BJ	Benin	MO	\N	37.9218608	-118.9528645	\N
3080	Ouémé Department	24	BJ	Benin	OU	\N	6.6148152	2.4999918	\N
3074	Plateau Department	24	BJ	Benin	PL	\N	7.3445141	2.539603	\N
3073	Zou Department	24	BJ	Benin	ZO	\N	7.3469268	2.0665197	\N
4860	Devonshire Parish	25	BM	Bermuda	DEV	\N	32.3038062	-64.7606954	\N
4861	Hamilton Parish	25	BM	Bermuda	HA	\N	32.3449432	-64.72365	\N
4863	Paget Parish	25	BM	Bermuda	PAG	\N	32.281074	-64.7784787	\N
4864	Pembroke Parish	25	BM	Bermuda	PEM	\N	32.3007672	-64.796263	\N
4866	Saint George's Parish	25	BM	Bermuda	SGE	\N	17.1257759	-62.5619811	\N
4867	Sandys Parish	25	BM	Bermuda	SAN	\N	32.2999528	-64.8674103	\N
4868	Smith's Parish,	25	BM	Bermuda	SMI	\N	32.3133966	-64.7310588	\N
4869	Southampton Parish	25	BM	Bermuda	SOU	\N	32.2540095	-64.8259058	\N
4870	Warwick Parish	25	BM	Bermuda	WAR	\N	32.2661534	-64.8081198	\N
240	Bumthang District	26	BT	Bhutan	33	\N	27.641839	90.6773046	\N
239	Chukha District	26	BT	Bhutan	12	\N	27.0784304	89.4742177	\N
238	Dagana District	26	BT	Bhutan	22	\N	27.0322861	89.8879304	\N
229	Gasa District	26	BT	Bhutan	GA	\N	28.0185886	89.9253233	\N
232	Haa District	26	BT	Bhutan	13	\N	27.2651669	89.1705998	\N
234	Lhuntse District	26	BT	Bhutan	44	\N	27.8264989	91.135302	\N
242	Mongar District	26	BT	Bhutan	42	\N	27.2617059	91.2891036	\N
237	Paro District	26	BT	Bhutan	11	\N	27.4285949	89.4166516	\N
244	Pemagatshel District	26	BT	Bhutan	43	\N	27.002382	91.3469247	\N
235	Punakha District	26	BT	Bhutan	23	\N	27.6903716	89.8879304	\N
243	Samdrup Jongkhar District	26	BT	Bhutan	45	\N	26.8035682	91.5039207	\N
246	Samtse District	26	BT	Bhutan	14	\N	27.0291832	89.0561532	\N
247	Sarpang District	26	BT	Bhutan	31	\N	26.9373041	90.4879916	\N
241	Thimphu District	26	BT	Bhutan	15	\N	27.4712216	89.6339041	\N
236	Trashigang District	26	BT	Bhutan	41	\N	27.2566795	91.7538817	\N
245	Trongsa District	26	BT	Bhutan	32	\N	27.5002269	90.5080634	\N
230	Tsirang District	26	BT	Bhutan	21	\N	27.032207	90.1869644	\N
231	Wangdue Phodrang District	26	BT	Bhutan	24	\N	27.4526046	90.0674928	\N
233	Zhemgang District	26	BT	Bhutan	34	\N	27.076975	90.8294002	\N
3375	Beni Department	27	BO	Bolivia	B	\N	-14.3782747	-65.0957792	\N
3382	Chuquisaca Department	27	BO	Bolivia	H	\N	-20.0249144	-64.1478236	\N
3381	Cochabamba Department	27	BO	Bolivia	C	\N	-17.5681675	-65.475736	\N
3380	La Paz Department	27	BO	Bolivia	L	\N	\N	\N	\N
3376	Oruro Department	27	BO	Bolivia	O	\N	-18.5711579	-67.7615983	\N
3379	Pando Department	27	BO	Bolivia	N	\N	-10.7988901	-66.9988011	\N
3383	Potosí Department	27	BO	Bolivia	P	\N	-20.624713	-66.9988011	\N
3377	Santa Cruz Department	27	BO	Bolivia	S	\N	-16.7476037	-62.0750998	\N
3378	Tarija Department	27	BO	Bolivia	T	\N	-21.5831595	-63.9586111	\N
5086	Bonaire	155	BQ	Bonaire, Sint Eustatius and Saba	BQ1	special municipality	12.2018902	-68.2623822	\N
5087	Saba	155	BQ	Bonaire, Sint Eustatius and Saba	BQ2	special municipality	17.6354642	-63.2326763	\N
5088	Sint Eustatius	155	BQ	Bonaire, Sint Eustatius and Saba	BQ3	special municipality	17.4890306	-62.973555	\N
472	Bosnian Podrinje Canton	28	BA	Bosnia and Herzegovina	05	\N	43.68749	18.8244394	\N
460	Brčko District	28	BA	Bosnia and Herzegovina	BRC	\N	44.8405944	18.742153	\N
471	Canton 10	28	BA	Bosnia and Herzegovina	10	\N	43.9534155	16.9425187	\N
462	Central Bosnia Canton	28	BA	Bosnia and Herzegovina	06	\N	44.1381856	17.6866714	\N
467	Federation of Bosnia and Herzegovina	28	BA	Bosnia and Herzegovina	BIH	\N	43.8874897	17.842793	\N
463	Herzegovina-Neretva Canton	28	BA	Bosnia and Herzegovina	07	\N	43.5265159	17.763621	\N
464	Posavina Canton	28	BA	Bosnia and Herzegovina	02	\N	45.0752094	18.3776304	\N
470	Republika Srpska	28	BA	Bosnia and Herzegovina	SRP	\N	44.7280186	17.3148136	\N
466	Sarajevo Canton	28	BA	Bosnia and Herzegovina	09	\N	43.8512564	18.2953442	\N
461	Tuzla Canton	28	BA	Bosnia and Herzegovina	03	\N	44.5343463	18.6972797	\N
465	Una-Sana Canton	28	BA	Bosnia and Herzegovina	01	\N	44.6503116	16.3171629	\N
469	West Herzegovina Canton	28	BA	Bosnia and Herzegovina	08	\N	43.4369244	17.3848831	\N
468	Zenica-Doboj Canton	28	BA	Bosnia and Herzegovina	04	\N	44.2127109	18.1604625	\N
3067	Central District	29	BW	Botswana	CE	\N	\N	\N	\N
3061	Ghanzi District	29	BW	Botswana	GH	\N	-21.8652314	21.8568586	\N
3066	Kgalagadi District	29	BW	Botswana	KG	\N	-24.7550285	21.8568586	\N
3062	Kgatleng District	29	BW	Botswana	KL	\N	-24.1970445	26.2304616	\N
3069	Kweneng District	29	BW	Botswana	KW	\N	-23.8367249	25.2837585	\N
3060	Ngamiland	29	BW	Botswana	NG	\N	-19.1905321	23.0011989	\N
3068	North-East District	29	BW	Botswana	NE	\N	37.5884461	-94.6863782	\N
3065	North-West District	29	BW	Botswana	NW	\N	39.3446307	-76.6854283	\N
3064	South-East District	29	BW	Botswana	SE	\N	31.2163798	-82.3527044	\N
3063	Southern District	29	BW	Botswana	SO	\N	\N	\N	\N
2012	Acre	31	BR	Brazil	AC	\N	-9.023796	-70.811995	\N
2007	Alagoas	31	BR	Brazil	AL	\N	-9.5713058	-36.7819505	\N
1999	Amapá	31	BR	Brazil	AP	\N	0.9019925	-52.0029565	\N
2004	Amazonas	31	BR	Brazil	AM	\N	-3.07	-61.66	\N
2002	Bahia	31	BR	Brazil	BA	\N	-11.409874	-41.280857	\N
2016	Ceará	31	BR	Brazil	CE	\N	-5.4983977	-39.3206241	\N
2017	Distrito Federal	31	BR	Brazil	DF	\N	-15.7997654	-47.8644715	\N
2018	Espírito Santo	31	BR	Brazil	ES	\N	-19.1834229	-40.3088626	\N
2000	Goiás	31	BR	Brazil	GO	\N	-15.8270369	-49.8362237	\N
2015	Maranhão	31	BR	Brazil	MA	\N	-4.9609498	-45.2744159	\N
2011	Mato Grosso	31	BR	Brazil	MT	\N	-12.6818712	-56.921099	\N
2010	Mato Grosso do Sul	31	BR	Brazil	MS	\N	-20.7722295	-54.7851531	\N
1998	Minas Gerais	31	BR	Brazil	MG	\N	-18.512178	-44.5550308	\N
2009	Pará	31	BR	Brazil	PA	\N	-1.9981271	-54.9306152	\N
2005	Paraíba	31	BR	Brazil	PB	\N	-7.2399609	-36.7819505	\N
2022	Paraná	31	BR	Brazil	PR	\N	-25.2520888	-52.0215415	\N
2006	Pernambuco	31	BR	Brazil	PE	\N	-8.8137173	-36.954107	\N
2008	Piauí	31	BR	Brazil	PI	\N	-7.7183401	-42.7289236	\N
1997	Rio de Janeiro	31	BR	Brazil	RJ	\N	-22.9068467	-43.1728965	\N
2019	Rio Grande do Norte	31	BR	Brazil	RN	\N	-5.4025803	-36.954107	\N
2001	Rio Grande do Sul	31	BR	Brazil	RS	\N	-30.0346316	-51.2176986	\N
2013	Rondônia	31	BR	Brazil	RO	\N	-11.5057341	-63.580611	\N
4858	Roraima	31	BR	Brazil	RR	\N	2.7375971	-62.0750998	\N
2014	Santa Catarina	31	BR	Brazil	SC	\N	-27.33	-49.44	\N
2021	São Paulo	31	BR	Brazil	SP	\N	-23.5505199	-46.6333094	\N
2003	Sergipe	31	BR	Brazil	SE	\N	-10.5740934	-37.3856581	\N
2020	Tocantins	31	BR	Brazil	TO	\N	-10.17528	-48.2982474	\N
1217	Belait District	33	BN	Brunei	BE	\N	4.3750749	114.6192899	\N
1216	Brunei-Muara District	33	BN	Brunei	BM	\N	4.9311206	114.9516869	\N
1218	Temburong District	33	BN	Brunei	TE	\N	4.6204128	115.141484	\N
1219	Tutong District	33	BN	Brunei	TU	\N	4.7140373	114.6667939	\N
4699	Blagoevgrad Province	34	BG	Bulgaria	01	\N	42.0208614	23.0943356	\N
4715	Burgas Province	34	BG	Bulgaria	02	\N	42.5048	27.4626079	\N
4718	Dobrich Province	34	BG	Bulgaria	08	\N	43.572786	27.8272802	\N
4693	Gabrovo Province	34	BG	Bulgaria	07	\N	42.86847	25.316889	\N
4704	Haskovo Province	34	BG	Bulgaria	26	\N	41.9344178	25.5554672	\N
4702	Kardzhali Province	34	BG	Bulgaria	09	\N	41.6338416	25.3776687	\N
4703	Kyustendil Province	34	BG	Bulgaria	10	\N	42.2868799	22.6939635	\N
4710	Lovech Province	34	BG	Bulgaria	11	\N	43.1367798	24.7139335	\N
4696	Montana Province	34	BG	Bulgaria	12	\N	43.4085148	23.2257589	\N
4712	Pazardzhik Province	34	BG	Bulgaria	13	\N	42.1927567	24.3336226	\N
4695	Pernik Province	34	BG	Bulgaria	14	\N	42.605199	23.0377916	\N
4706	Pleven Province	34	BG	Bulgaria	15	\N	43.4170169	24.6066708	\N
4701	Plovdiv Province	34	BG	Bulgaria	16	\N	42.1354079	24.7452904	\N
4698	Razgrad Province	34	BG	Bulgaria	17	\N	43.5271705	26.5241228	\N
4713	Ruse Province	34	BG	Bulgaria	18	\N	43.8355964	25.9656144	\N
4882	Shumen	34	BG	Bulgaria	27	\N	43.2712398	26.9361286	\N
4708	Silistra Province	34	BG	Bulgaria	19	\N	44.1147101	27.2671454	\N
4700	Sliven Province	34	BG	Bulgaria	20	\N	42.6816702	26.3228569	\N
4694	Smolyan Province	34	BG	Bulgaria	21	\N	41.5774148	24.7010871	\N
4705	Sofia City Province	34	BG	Bulgaria	22	\N	42.7570109	23.4504683	\N
4719	Sofia Province	34	BG	Bulgaria	23	\N	42.67344	23.8334937	\N
4707	Stara Zagora Province	34	BG	Bulgaria	24	\N	42.4257709	25.6344855	\N
4714	Targovishte Province	34	BG	Bulgaria	25	\N	43.2462349	26.5691251	\N
4717	Varna Province	34	BG	Bulgaria	03	\N	43.2046477	27.9105488	\N
4709	Veliko Tarnovo Province	34	BG	Bulgaria	04	\N	43.0756539	25.61715	\N
4697	Vidin Province	34	BG	Bulgaria	05	\N	43.9961739	22.8679515	\N
4711	Vratsa Province	34	BG	Bulgaria	06	\N	43.2101806	23.552921	\N
4716	Yambol Province	34	BG	Bulgaria	28	\N	42.4841494	26.5035296	\N
3160	Balé Province	35	BF	Burkina Faso	BAL	\N	11.7820602	-3.0175712	\N
3155	Bam Province	35	BF	Burkina Faso	BAM	\N	13.446133	-1.5983959	\N
3120	Banwa Province	35	BF	Burkina Faso	BAN	\N	12.1323053	-4.1513764	\N
3152	Bazèga Province	35	BF	Burkina Faso	BAZ	\N	11.9767692	-1.443469	\N
3138	Boucle du Mouhoun Region	35	BF	Burkina Faso	01	\N	12.4166	-3.4195527	\N
3121	Bougouriba Province	35	BF	Burkina Faso	BGR	\N	10.8722646	-3.3388917	\N
3131	Boulgou	35	BF	Burkina Faso	BLG	\N	11.4336766	-0.3748354	\N
3153	Cascades Region	35	BF	Burkina Faso	02	\N	10.4072992	-4.5624426	\N
3136	Centre	35	BF	Burkina Faso	03	\N	\N	\N	\N
3162	Centre-Est Region	35	BF	Burkina Faso	04	\N	11.5247674	-0.1494988	\N
3127	Centre-Nord Region	35	BF	Burkina Faso	05	\N	13.1724464	-0.9056623	\N
3115	Centre-Ouest Region	35	BF	Burkina Faso	06	\N	11.8798466	-2.302446	\N
3149	Centre-Sud Region	35	BF	Burkina Faso	07	\N	11.5228911	-1.0586135	\N
3167	Comoé Province	35	BF	Burkina Faso	COM	\N	10.4072992	-4.5624426	\N
3158	Est Region	35	BF	Burkina Faso	08	\N	12.4365526	0.9056623	\N
3148	Ganzourgou Province	35	BF	Burkina Faso	GAN	\N	12.2537648	-0.7532809	\N
3122	Gnagna Province	35	BF	Burkina Faso	GNA	\N	12.8974992	0.0746767	\N
3143	Gourma Province	35	BF	Burkina Faso	GOU	\N	12.1624473	0.6773046	\N
3165	Hauts-Bassins Region	35	BF	Burkina Faso	09	\N	11.4942003	-4.2333355	\N
3129	Houet Province	35	BF	Burkina Faso	HOU	\N	11.1320447	-4.2333355	\N
3135	Ioba Province	35	BF	Burkina Faso	IOB	\N	11.0562034	-3.0175712	\N
3168	Kadiogo Province	35	BF	Burkina Faso	KAD	\N	12.3425897	-1.443469	\N
3112	Kénédougou Province	35	BF	Burkina Faso	KEN	\N	11.3919395	-4.976654	\N
3132	Komondjari Province	35	BF	Burkina Faso	KMD	\N	12.7126527	0.6773046	\N
3157	Kompienga Province	35	BF	Burkina Faso	KMP	\N	11.5238362	0.7532809	\N
3146	Kossi Province	35	BF	Burkina Faso	KOS	\N	12.960458	-3.9062688	\N
3133	Koulpélogo Province	35	BF	Burkina Faso	KOP	\N	11.5247674	0.1494988	\N
3161	Kouritenga Province	35	BF	Burkina Faso	KOT	\N	12.1631813	-0.2244662	\N
3147	Kourwéogo Province	35	BF	Burkina Faso	KOW	\N	12.7077495	-1.7538817	\N
3159	Léraba Province	35	BF	Burkina Faso	LER	\N	10.6648785	-5.3102505	\N
3151	Loroum Province	35	BF	Burkina Faso	LOR	\N	13.8129814	-2.0665197	\N
3123	Mouhoun	35	BF	Burkina Faso	MOU	\N	12.1432381	-3.3388917	\N
3116	Nahouri Province	35	BF	Burkina Faso	NAO	\N	11.2502267	-1.135302	\N
3113	Namentenga Province	35	BF	Burkina Faso	NAM	\N	13.0812584	-0.5257823	\N
3142	Nayala Province	35	BF	Burkina Faso	NAY	\N	12.6964558	-3.0175712	\N
3164	Nord Region, Burkina Faso	35	BF	Burkina Faso	10	\N	13.718252	-2.302446	\N
3156	Noumbiel Province	35	BF	Burkina Faso	NOU	\N	9.8440946	-2.9775558	\N
3141	Oubritenga Province	35	BF	Burkina Faso	OUB	\N	12.7096087	-1.443469	\N
3144	Oudalan Province	35	BF	Burkina Faso	OUD	\N	14.471902	-0.4502368	\N
3117	Passoré Province	35	BF	Burkina Faso	PAS	\N	12.8881221	-2.2236667	\N
3125	Plateau-Central Region	35	BF	Burkina Faso	11	\N	12.2537648	-0.7532809	\N
3163	Poni Province	35	BF	Burkina Faso	PON	\N	10.3325996	-3.3388917	\N
3114	Sahel Region	35	BF	Burkina Faso	12	\N	14.1000865	-0.1494988	\N
3154	Sanguié Province	35	BF	Burkina Faso	SNG	\N	12.1501861	-2.6983868	\N
3126	Sanmatenga Province	35	BF	Burkina Faso	SMT	\N	13.3565304	-1.0586135	\N
3139	Séno Province	35	BF	Burkina Faso	SEN	\N	14.0072234	-0.0746767	\N
3119	Sissili Province	35	BF	Burkina Faso	SIS	\N	11.2441219	-2.2236667	\N
3166	Soum Province	35	BF	Burkina Faso	SOM	\N	14.0962841	-1.366216	\N
3137	Sourou Province	35	BF	Burkina Faso	SOR	\N	13.341803	-2.9375739	\N
3140	Sud-Ouest Region	35	BF	Burkina Faso	13	\N	10.4231493	-3.2583626	\N
3128	Tapoa Province	35	BF	Burkina Faso	TAP	\N	12.2497072	1.6760691	\N
3134	Tuy Province	35	BF	Burkina Faso	TUI	\N	38.888684	-77.004719	\N
3124	Yagha Province	35	BF	Burkina Faso	YAG	\N	13.3576157	0.7532809	\N
3150	Yatenga Province	35	BF	Burkina Faso	YAT	\N	13.6249344	-2.3813621	\N
3145	Ziro Province	35	BF	Burkina Faso	ZIR	\N	11.6094995	-1.9099238	\N
3130	Zondoma Province	35	BF	Burkina Faso	ZON	\N	13.1165926	-2.4208713	\N
3118	Zoundwéogo Province	35	BF	Burkina Faso	ZOU	\N	11.6141174	-0.9820668	\N
3196	Bubanza Province	36	BI	Burundi	BB	\N	-3.1572403	29.3714909	\N
3198	Bujumbura Mairie Province	36	BI	Burundi	BM	\N	-3.3884141	29.3482646	\N
3200	Bujumbura Rural Province	36	BI	Burundi	BL	\N	-3.5090144	29.464359	\N
3202	Bururi Province	36	BI	Burundi	BR	\N	-3.9006851	29.5107708	\N
3201	Cankuzo Province	36	BI	Burundi	CA	\N	-3.1527788	30.6199895	\N
3190	Cibitoke Province	36	BI	Burundi	CI	\N	-2.8102897	29.1855785	\N
3197	Gitega Province	36	BI	Burundi	GI	\N	-3.4929051	29.9277947	\N
3194	Karuzi Province	36	BI	Burundi	KR	\N	-3.1340347	30.112735	\N
3192	Kayanza Province	36	BI	Burundi	KY	\N	-3.0077981	29.6499162	\N
3195	Kirundo Province	36	BI	Burundi	KI	\N	-2.5762882	30.112735	\N
3188	Makamba Province	36	BI	Burundi	MA	\N	-4.3257062	29.6962677	\N
3193	Muramvya Province	36	BI	Burundi	MU	\N	-3.2898398	29.6499162	\N
3186	Muyinga Province	36	BI	Burundi	MY	\N	-2.7793511	30.2974199	\N
3187	Mwaro Province	36	BI	Burundi	MW	\N	-3.5025918	29.6499162	\N
3199	Ngozi Province	36	BI	Burundi	NG	\N	-2.8958243	29.8815203	\N
3185	Rumonge Province	36	BI	Burundi	RM	\N	-3.9754049	29.4388014	\N
3189	Rutana Province	36	BI	Burundi	RT	\N	-3.8791523	30.0665236	\N
3191	Ruyigi Province	36	BI	Burundi	RY	\N	-3.446207	30.2512728	\N
3984	Banteay Meanchey	37	KH	Cambodia	1	province	13.7531914	102.989615	\N
3976	Battambang	37	KH	Cambodia	2	province	13.0286971	102.989615	\N
3991	Kampong Cham	37	KH	Cambodia	3	province	12.0982918	105.3131185	\N
3979	Kampong Chhnang	37	KH	Cambodia	4	province	12.1392352	104.5655273	\N
3988	Kampong Speu	37	KH	Cambodia	5	province	11.6155109	104.3791912	\N
5070	Kampong Thom	37	KH	Cambodia	6	province	12.8167485	103.8413104	\N
3981	Kampot	37	KH	Cambodia	7	province	10.7325351	104.3791912	\N
3983	Kandal	37	KH	Cambodia	8	province	11.2237383	105.1258955	\N
3978	Kep	37	KH	Cambodia	23	province	10.536089	104.3559158	\N
3982	Koh Kong	37	KH	Cambodia	9	province	11.5762804	103.3587288	\N
3986	Kratie	37	KH	Cambodia	10	province	12.5043608	105.9699878	\N
3985	Mondulkiri	37	KH	Cambodia	11	province	12.7879427	107.1011931	\N
3987	Oddar Meanchey	37	KH	Cambodia	22	province	14.1609738	103.8216261	\N
3980	Pailin	37	KH	Cambodia	24	province	12.9092962	102.6675575	\N
3994	Phnom Penh	37	KH	Cambodia	12	autonomous municipality	11.5563738	104.9282099	\N
3973	Preah Vihear	37	KH	Cambodia	13	province	14.0085797	104.8454619	\N
3974	Prey Veng	37	KH	Cambodia	14	province	11.3802442	105.5005483	\N
3977	Pursat	37	KH	Cambodia	15	province	12.2720956	103.7289167	\N
3990	Ratanakiri	37	KH	Cambodia	16	province	13.8576607	107.1011931	\N
3992	Siem Reap	37	KH	Cambodia	17	province	13.330266	104.1001326	\N
3989	Sihanoukville	37	KH	Cambodia	18	province	10.7581899	103.8216261	\N
3993	Stung Treng	37	KH	Cambodia	19	province	13.576473	105.9699878	\N
3972	Svay Rieng	37	KH	Cambodia	20	province	11.142722	105.8290298	\N
3975	Takeo	37	KH	Cambodia	21	province	10.9321519	104.798771	\N
2663	Adamawa	38	CM	Cameroon	AD	\N	9.3264751	12.3983853	\N
2660	Centre	38	CM	Cameroon	CE	\N	\N	\N	\N
2661	East	38	CM	Cameroon	ES	\N	39.0185336	-94.2792411	\N
2656	Far North	38	CM	Cameroon	EN	\N	66.7613451	124.123753	\N
2662	Littoral	38	CM	Cameroon	LT	\N	48.4622757	-68.5178071	\N
2665	North	38	CM	Cameroon	NO	\N	37.09024	-95.712891	\N
2657	Northwest	38	CM	Cameroon	NW	\N	36.3711857	-94.1934606	\N
2659	South	38	CM	Cameroon	SU	\N	37.631595	-97.3458409	\N
2658	Southwest	38	CM	Cameroon	SW	\N	36.1908813	-95.8897448	\N
2664	West	38	CM	Cameroon	OU	\N	37.0364989	-95.6705987	\N
872	Alberta	39	CA	Canada	AB	province	53.9332706	-116.5765035	\N
875	British Columbia	39	CA	Canada	BC	province	53.7266683	-127.6476205	\N
867	Manitoba	39	CA	Canada	MB	province	53.7608608	-98.8138762	\N
868	New Brunswick	39	CA	Canada	NB	province	46.5653163	-66.4619164	\N
877	Newfoundland and Labrador	39	CA	Canada	NL	province	53.1355091	-57.6604364	\N
878	Northwest Territories	39	CA	Canada	NT	territory	64.8255441	-124.8457334	\N
874	Nova Scotia	39	CA	Canada	NS	province	44.6819866	-63.744311	\N
876	Nunavut	39	CA	Canada	NU	territory	70.2997711	-83.107577	\N
866	Ontario	39	CA	Canada	ON	province	51.253775	-85.323214	\N
871	Prince Edward Island	39	CA	Canada	PE	province	46.510712	-63.4168136	\N
873	Quebec	39	CA	Canada	QC	province	52.9399159	-73.5491361	\N
870	Saskatchewan	39	CA	Canada	SK	province	52.9399159	-106.4508639	\N
869	Yukon	39	CA	Canada	YT	territory	35.5067215	-97.7625441	\N
2994	Barlavento Islands	40	CV	Cape Verde	B	\N	16.8236845	-23.9934881	\N
2999	Boa Vista	40	CV	Cape Verde	BV	\N	38.743466	-120.7304297	\N
2996	Brava	40	CV	Cape Verde	BR	\N	40.9897778	-73.6835715	\N
2991	Maio Municipality	40	CV	Cape Verde	MA	\N	15.2003098	-23.1679793	\N
2987	Mosteiros	40	CV	Cape Verde	MO	\N	37.8904348	-25.8207556	\N
2997	Paul	40	CV	Cape Verde	PA	\N	37.0625	-95.677068	\N
2989	Porto Novo	40	CV	Cape Verde	PN	\N	6.4968574	2.6288523	\N
2988	Praia	40	CV	Cape Verde	PR	\N	14.93305	-23.5133267	\N
2982	Ribeira Brava Municipality	40	CV	Cape Verde	RB	\N	16.6070739	-24.2033843	\N
3002	Ribeira Grande	40	CV	Cape Verde	RG	\N	37.8210369	-25.5148137	\N
2984	Ribeira Grande de Santiago	40	CV	Cape Verde	RS	\N	14.9830298	-23.6561725	\N
2998	Sal	40	CV	Cape Verde	SL	\N	26.5958122	-80.2045083	\N
2985	Santa Catarina	40	CV	Cape Verde	CA	\N	-27.2423392	-50.2188556	\N
2995	Santa Catarina do Fogo	40	CV	Cape Verde	CF	\N	14.9309104	-24.3222577	\N
3004	Santa Cruz	40	CV	Cape Verde	CR	\N	36.9741171	-122.0307963	\N
2986	São Domingos	40	CV	Cape Verde	SD	\N	15.0286165	-23.563922	\N
3000	São Filipe	40	CV	Cape Verde	SF	\N	14.8951679	-24.4945636	\N
2993	São Lourenço dos Órgãos	40	CV	Cape Verde	SO	\N	15.0537841	-23.6085612	\N
2990	São Miguel	40	CV	Cape Verde	SM	\N	37.780411	-25.4970466	\N
3001	São Vicente	40	CV	Cape Verde	SV	\N	-23.9607157	-46.3962022	\N
2992	Sotavento Islands	40	CV	Cape Verde	S	\N	15	-24	\N
2983	Tarrafal	40	CV	Cape Verde	TA	\N	15.2760578	-23.7484077	\N
3003	Tarrafal de São Nicolau	40	CV	Cape Verde	TS	\N	16.5636498	-24.354942	\N
1259	Bamingui-Bangoran Prefecture	42	CF	Central African Republic	BB	\N	8.2733455	20.7122465	\N
1262	Bangui	42	CF	Central African Republic	BGF	\N	4.3946735	18.5581899	\N
1264	Basse-Kotto Prefecture	42	CF	Central African Republic	BK	\N	4.8719319	21.2845025	\N
1258	Haut-Mbomou Prefecture	42	CF	Central African Republic	HM	\N	6.2537134	25.4733554	\N
1268	Haute-Kotto Prefecture	42	CF	Central African Republic	HK	\N	7.7964379	23.3823545	\N
1263	Kémo Prefecture	42	CF	Central African Republic	KG	\N	5.8867794	19.3783206	\N
1256	Lobaye Prefecture	42	CF	Central African Republic	LB	\N	4.3525981	17.4795173	\N
1257	Mambéré-Kadéï	42	CF	Central African Republic	HS	\N	4.7055653	15.9699878	\N
1266	Mbomou Prefecture	42	CF	Central African Republic	MB	\N	5.556837	23.7632828	\N
1253	Nana-Grébizi Economic Prefecture	42	CF	Central African Republic	KB	\N	7.1848607	19.3783206	\N
1260	Nana-Mambéré Prefecture	42	CF	Central African Republic	NM	\N	5.6932135	15.2194808	\N
1255	Ombella-M'Poko Prefecture	42	CF	Central African Republic	MP	\N	5.1188825	18.4276047	\N
1265	Ouaka Prefecture	42	CF	Central African Republic	UK	\N	6.3168216	20.7122465	\N
1254	Ouham Prefecture	42	CF	Central African Republic	AC	\N	7.090911	17.668887	\N
1267	Ouham-Pendé Prefecture	42	CF	Central African Republic	OP	\N	6.4850984	16.1580937	\N
1252	Sangha-Mbaéré	42	CF	Central African Republic	SE	\N	3.4368607	16.3463791	\N
1261	Vakaga Prefecture	42	CF	Central African Republic	VK	\N	9.5113296	22.2384017	\N
3583	Bahr el Gazel	43	TD	Chad	BG	province	14.7702266	16.912251	\N
3590	Batha	43	TD	Chad	BA	province	13.9371775	18.4276047	\N
3574	Borkou	43	TD	Chad	BO	province	17.8688845	18.8076195	\N
5114	Chari-Baguirmi	43	TD	Chad	CB	province	11.4618626	15.2446394	\N
3575	Ennedi-Est	43	TD	Chad	EE	province	16.3420496	23.0011989	\N
3584	Ennedi-Ouest	43	TD	Chad	EO	province	18.977563	21.8568586	\N
3576	Guéra	43	TD	Chad	GR	province	11.1219015	18.4276047	\N
3573	Hadjer-Lamis	43	TD	Chad	HL	province	12.4577273	16.7234639	\N
3588	Kanem	43	TD	Chad	KA	province	14.8781262	15.4068079	\N
3577	Lac	43	TD	Chad	LC	province	13.6915377	14.1001326	\N
3585	Logone Occidental	43	TD	Chad	LO	province	8.759676	15.876004	\N
3591	Logone Oriental	43	TD	Chad	LR	province	8.3149949	16.3463791	\N
3589	Mandoul	43	TD	Chad	MA	province	8.603091	17.4795173	\N
3580	Mayo-Kebbi Est	43	TD	Chad	ME	province	9.4046039	14.8454619	\N
3571	Mayo-Kebbi Ouest	43	TD	Chad	MO	province	10.4113014	15.5943388	\N
3570	Moyen-Chari	43	TD	Chad	MC	province	9.0639998	18.4276047	\N
3586	N'Djamena	43	TD	Chad	ND	province	12.1348457	15.0557415	\N
3582	Ouaddaï	43	TD	Chad	OD	province	13.748476	20.7122465	\N
3592	Salamat	43	TD	Chad	SA	province	10.9691601	20.7122465	\N
3572	Sila	43	TD	Chad	SI	province	12.13074	21.2845025	\N
3579	Tandjilé	43	TD	Chad	TA	province	9.6625729	16.7234639	\N
3587	Tibesti	43	TD	Chad	TI	province	21.3650031	16.912251	\N
3581	Wadi Fira	43	TD	Chad	WF	province	15.0892416	21.4752851	\N
2828	Aisén del General Carlos Ibañez del Campo	44	CL	Chile	AI	\N	-46.378345	-72.3007623	\N
2832	Antofagasta	44	CL	Chile	AN	\N	-23.8369104	-69.2877535	\N
2829	Arica y Parinacota	44	CL	Chile	AP	\N	-18.5940485	-69.4784541	\N
2823	Atacama	44	CL	Chile	AT	\N	-27.5660558	-70.050314	\N
2827	Biobío	44	CL	Chile	BI	\N	-37.4464428	-72.1416132	\N
2825	Coquimbo	44	CL	Chile	CO	\N	-30.540181	-70.8119953	\N
2826	La Araucanía	44	CL	Chile	AR	\N	-38.948921	-72.331113	\N
2838	Libertador General Bernardo O'Higgins	44	CL	Chile	LI	\N	-34.5755374	-71.0022311	\N
2835	Los Lagos	44	CL	Chile	LL	\N	-41.9197779	-72.1416132	\N
2834	Los Ríos	44	CL	Chile	LR	\N	-40.2310217	-72.331113	\N
2836	Magallanes y de la Antártica Chilena	44	CL	Chile	MA	\N	-52.2064316	-72.1685001	\N
2833	Maule	44	CL	Chile	ML	\N	-35.5163603	-71.5723953	\N
2831	Ñuble	44	CL	Chile	NB	\N	-36.7225743	-71.7622481	\N
2824	Región Metropolitana de Santiago	44	CL	Chile	RM	\N	-33.4375545	-70.6504896	\N
2837	Tarapacá	44	CL	Chile	TA	\N	-20.2028799	-69.2877535	\N
2830	Valparaíso	44	CL	Chile	VS	\N	-33.047238	-71.6126885	\N
2251	Anhui	45	CN	China	AH	province	30.6006773	117.9249002	\N
2257	Beijing	45	CN	China	BJ	municipality	39.9041999	116.4073963	\N
2271	Chongqing	45	CN	China	CQ	municipality	29.4315861	106.912251	\N
2248	Fujian	45	CN	China	FJ	province	26.4836842	117.9249002	\N
2275	Gansu	45	CN	China	GS	province	35.7518326	104.2861116	\N
2279	Guangdong	45	CN	China	GD	province	23.3790333	113.7632828	\N
2278	Guangxi Zhuang	45	CN	China	GX	autonomous region	23.7247599	108.8076195	\N
2261	Guizhou	45	CN	China	GZ	province	26.8429645	107.2902839	\N
2273	Hainan	45	CN	China	HI	province	19.5663947	109.949686	\N
2280	Hebei	45	CN	China	HE	province	37.8956594	114.9042208	\N
2265	Heilongjiang	45	CN	China	HL	province	47.1216472	128.738231	\N
2259	Henan	45	CN	China	HA	province	34.2904302	113.3823545	\N
2267	Hong Kong SAR	45	CN	China	HK	special administrative region	22.3193039	114.1693611	\N
2274	Hubei	45	CN	China	HB	province	30.7378118	112.2384017	\N
2258	Hunan	45	CN	China	HN	province	27.3683009	109.2819347	\N
2269	Inner Mongolia	45	CN	China	NM	autonomous region	43.37822	115.0594815	\N
2250	Jiangsu	45	CN	China	JS	province	33.1401715	119.7889248	\N
2256	Jiangxi	45	CN	China	JX	province	27.0874564	114.9042208	\N
2253	Jilin	45	CN	China	JL	province	43.837883	126.549572	\N
2268	Liaoning	45	CN	China	LN	province	41.9436543	122.5290376	\N
2266	Macau SAR	45	CN	China	MO	special administrative region	22.198745	113.543873	\N
2262	Ningxia Huizu	45	CN	China	NX	autonomous region	37.198731	106.1580937	\N
2270	Qinghai	45	CN	China	QH	province	35.744798	96.4077358	\N
2272	Shaanxi	45	CN	China	SN	province	35.3939908	109.1880047	\N
2252	Shandong	45	CN	China	SD	province	37.8006064	-122.2699918	\N
2249	Shanghai	45	CN	China	SH	municipality	31.230416	121.473701	\N
2254	Shanxi	45	CN	China	SX	province	37.2425649	111.8568586	\N
2277	Sichuan	45	CN	China	SC	province	30.2638032	102.8054753	\N
2255	Taiwan	45	CN	China	TW	province	23.69781	120.960515	\N
2276	Tianjin	45	CN	China	TJ	municipality	39.1252291	117.0153435	\N
2263	Xinjiang	45	CN	China	XJ	autonomous region	42.5246357	87.5395855	\N
2264	Xizang	45	CN	China	XZ	autonomous region	30.1533605	88.7878678	\N
2260	Yunnan	45	CN	China	YN	province	24.4752847	101.3431058	\N
2247	Zhejiang	45	CN	China	ZJ	province	29.1416432	119.7889248	\N
2895	Amazonas	48	CO	Colombia	AMA	\N	-1.4429123	-71.5723953	\N
2890	Antioquia	48	CO	Colombia	ANT	\N	7.1986064	-75.3412179	\N
2881	Arauca	48	CO	Colombia	ARA	\N	6.547306	-71.0022311	\N
2900	Archipiélago de San Andrés, Providencia y Santa Catalina	48	CO	Colombia	SAP	\N	12.5567324	-81.7185253	\N
2880	Atlántico	48	CO	Colombia	ATL	\N	10.6966159	-74.8741045	\N
4921	Bogotá D.C.	48	CO	Colombia	DC	capital district	4.2820415	-74.5027042	\N
2893	Bolívar	48	CO	Colombia	BOL	\N	8.6704382	-74.0300122	\N
2903	Boyacá	48	CO	Colombia	BOY	\N	5.454511	-73.362003	\N
2887	Caldas	48	CO	Colombia	CAL	\N	5.29826	-75.2479061	\N
2891	Caquetá	48	CO	Colombia	CAQ	\N	0.869892	-73.8419063	\N
2892	Casanare	48	CO	Colombia	CAS	\N	5.7589269	-71.5723953	\N
2884	Cauca	48	CO	Colombia	CAU	\N	2.7049813	-76.8259652	\N
2899	Cesar	48	CO	Colombia	CES	\N	9.3372948	-73.6536209	\N
2876	Chocó	48	CO	Colombia	CHO	\N	5.2528033	-76.8259652	\N
2898	Córdoba	48	CO	Colombia	COR	\N	8.049293	-75.57405	\N
2875	Cundinamarca	48	CO	Colombia	CUN	\N	5.026003	-74.0300122	\N
2882	Guainía	48	CO	Colombia	GUA	\N	2.585393	-68.5247149	\N
2888	Guaviare	48	CO	Colombia	GUV	\N	2.043924	-72.331113	\N
4871	Huila	48	CO	Colombia	HUI	department	2.5359349	-75.5276699	\N
2889	La Guajira	48	CO	Colombia	LAG	\N	11.3547743	-72.5204827	\N
2886	Magdalena	48	CO	Colombia	MAG	\N	10.4113014	-74.4056612	\N
2878	Meta	48	CO	Colombia	MET	\N	39.7673258	-104.9753595	\N
2897	Nariño	48	CO	Colombia	NAR	\N	1.289151	-77.35794	\N
2877	Norte de Santander	48	CO	Colombia	NSA	\N	7.9462831	-72.8988069	\N
2896	Putumayo	48	CO	Colombia	PUT	\N	0.4359506	-75.5276699	\N
2874	Quindío	48	CO	Colombia	QUI	\N	4.4610191	-75.667356	\N
2879	Risaralda	48	CO	Colombia	RIS	\N	5.3158475	-75.9927652	\N
2901	Santander	48	CO	Colombia	SAN	\N	6.6437076	-73.6536209	\N
2902	Sucre	48	CO	Colombia	SUC	\N	8.813977	-74.723283	\N
2883	Tolima	48	CO	Colombia	TOL	\N	4.0925168	-75.1545381	\N
2904	Valle del Cauca	48	CO	Colombia	VAC	\N	3.8008893	-76.6412712	\N
2885	Vaupés	48	CO	Colombia	VAU	\N	0.8553561	-70.8119953	\N
2894	Vichada	48	CO	Colombia	VID	\N	4.4234452	-69.2877535	\N
2821	Anjouan	49	KM	Comoros	A	\N	-12.2138145	44.4370606	\N
2822	Grande Comore	49	KM	Comoros	G	\N	-11.7167338	43.3680788	\N
2820	Mohéli	49	KM	Comoros	M	\N	-12.3377376	43.7334089	\N
2866	Bouenza Department	50	CG	Congo	11	\N	-4.1128079	13.7289167	\N
2870	Brazzaville	50	CG	Congo	BZV	\N	-4.2633597	15.2428853	\N
2864	Cuvette Department	50	CG	Congo	8	\N	-0.2877446	16.1580937	\N
2869	Cuvette-Ouest Department	50	CG	Congo	15	\N	0.144755	14.4723301	\N
2867	Kouilou Department	50	CG	Congo	5	\N	-4.1428413	11.8891721	\N
2868	Lékoumou Department	50	CG	Congo	2	\N	-3.170382	13.3587288	\N
2865	Likouala Department	50	CG	Congo	7	\N	2.043924	17.668887	\N
2872	Niari Department	50	CG	Congo	9	\N	-3.18427	12.2547919	\N
2862	Plateaux Department	50	CG	Congo	14	\N	-2.0680088	15.4068079	\N
2863	Pointe-Noire	50	CG	Congo	16	\N	-4.7691623	11.866362	\N
2873	Pool Department	50	CG	Congo	12	\N	-3.7762628	14.8454619	\N
2871	Sangha Department	50	CG	Congo	13	\N	1.4662328	15.4068079	\N
1215	Alajuela Province	53	CR	Costa Rica	A	\N	10.391583	-84.4382721	\N
1209	Guanacaste Province	53	CR	Costa Rica	G	\N	10.6267399	-85.4436706	\N
1212	Heredia Province	53	CR	Costa Rica	H	\N	10.473523	-84.0167423	\N
1213	Limón Province	53	CR	Costa Rica	L	\N	9.9896398	-83.0332417	\N
1211	Provincia de Cartago	53	CR	Costa Rica	C	\N	9.8622311	-83.9214187	\N
1210	Puntarenas Province	53	CR	Costa Rica	P	\N	9.2169531	-83.336188	\N
1214	San José Province	53	CR	Costa Rica	SJ	\N	9.9129727	-84.0768294	\N
2634	Abidjan	54	CI	Cote D'Ivoire (Ivory Coast)	AB	\N	5.3599517	-4.0082563	\N
2626	Agnéby	54	CI	Cote D'Ivoire (Ivory Coast)	16	\N	5.3224503	-4.3449529	\N
2636	Bafing Region	54	CI	Cote D'Ivoire (Ivory Coast)	17	\N	8.3252047	-7.5247243	\N
2643	Bas-Sassandra District	54	CI	Cote D'Ivoire (Ivory Coast)	BS	\N	5.2798356	-6.1526985	\N
2635	Bas-Sassandra Region	54	CI	Cote D'Ivoire (Ivory Coast)	09	\N	5.3567916	-6.7493993	\N
2654	Comoé District	54	CI	Cote D'Ivoire (Ivory Coast)	CM	\N	5.552793	-3.2583626	\N
2644	Denguélé District	54	CI	Cote D'Ivoire (Ivory Coast)	DN	\N	48.0707763	-68.5609341	\N
2642	Denguélé Region	54	CI	Cote D'Ivoire (Ivory Coast)	10	\N	9.4662372	-7.4381355	\N
2645	Dix-Huit Montagnes	54	CI	Cote D'Ivoire (Ivory Coast)	06	\N	7.3762373	-7.4381355	\N
2633	Fromager	54	CI	Cote D'Ivoire (Ivory Coast)	18	\N	45.5450213	-73.6046223	\N
2651	Gôh-Djiboua District	54	CI	Cote D'Ivoire (Ivory Coast)	GD	\N	5.8711393	-5.5617279	\N
2638	Haut-Sassandra	54	CI	Cote D'Ivoire (Ivory Coast)	02	\N	6.8757848	-6.5783387	\N
2632	Lacs District	54	CI	Cote D'Ivoire (Ivory Coast)	LC	\N	48.1980169	-80.4564412	\N
2640	Lacs Region	54	CI	Cote D'Ivoire (Ivory Coast)	07	\N	47.7395866	-70.4186652	\N
2627	Lagunes District	54	CI	Cote D'Ivoire (Ivory Coast)	LG	\N	5.8827334	-4.2333355	\N
2639	Lagunes region	54	CI	Cote D'Ivoire (Ivory Coast)	01	\N	5.8827334	-4.2333355	\N
2631	Marahoué Region	54	CI	Cote D'Ivoire (Ivory Coast)	12	\N	6.8846207	-5.8987139	\N
2629	Montagnes District	54	CI	Cote D'Ivoire (Ivory Coast)	MG	\N	7.3762373	-7.4381355	\N
2646	Moyen-Cavally	54	CI	Cote D'Ivoire (Ivory Coast)	19	\N	6.5208793	-7.6114217	\N
2630	Moyen-Comoé	54	CI	Cote D'Ivoire (Ivory Coast)	05	\N	6.6514917	-3.5003454	\N
2655	N'zi-Comoé	54	CI	Cote D'Ivoire (Ivory Coast)	11	\N	7.2456749	-4.2333355	\N
2648	Sassandra-Marahoué District	54	CI	Cote D'Ivoire (Ivory Coast)	SM	\N	6.8803348	-6.2375947	\N
2625	Savanes Region	54	CI	Cote D'Ivoire (Ivory Coast)	03	\N	\N	\N	\N
2628	Sud-Bandama	54	CI	Cote D'Ivoire (Ivory Coast)	15	\N	5.5357083	-5.5617279	\N
2652	Sud-Comoé	54	CI	Cote D'Ivoire (Ivory Coast)	13	\N	5.552793	-3.2583626	\N
2637	Vallée du Bandama District	54	CI	Cote D'Ivoire (Ivory Coast)	VB	\N	8.278978	-4.8935627	\N
2647	Vallée du Bandama Region	54	CI	Cote D'Ivoire (Ivory Coast)	04	\N	8.278978	-4.8935627	\N
2650	Woroba District	54	CI	Cote D'Ivoire (Ivory Coast)	WR	\N	8.2491372	-6.9209135	\N
2649	Worodougou	54	CI	Cote D'Ivoire (Ivory Coast)	14	\N	8.2548962	-6.5783387	\N
2653	Yamoussoukro	54	CI	Cote D'Ivoire (Ivory Coast)	YM	\N	6.8276228	-5.2893433	\N
2641	Zanzan Region	54	CI	Cote D'Ivoire (Ivory Coast)	ZZ	\N	8.8207904	-3.4195527	\N
734	Bjelovar-Bilogora	55	HR	Croatia	07	county	45.8987972	16.8423093	\N
737	Brod-Posavina	55	HR	Croatia	12	county	45.2637951	17.3264562	\N
728	Dubrovnik-Neretva	55	HR	Croatia	19	county	43.0766588	17.5268471	\N
743	Istria	55	HR	Croatia	18	county	45.1286455	13.901542	\N
5069	Karlovac	55	HR	Croatia	04	county	45.2613352	15.52542016	\N
742	Koprivnica-Križevci	55	HR	Croatia	06	county	46.1568919	16.8390826	\N
729	Krapina-Zagorje	55	HR	Croatia	02	county	46.1013393	15.8809693	\N
731	Lika-Senj	55	HR	Croatia	09	county	44.6192218	15.4701608	\N
726	Međimurje	55	HR	Croatia	20	county	46.3766644	16.4213298	\N
740	Osijek-Baranja	55	HR	Croatia	14	county	45.5576428	18.3942141	\N
724	Požega-Slavonia	55	HR	Croatia	11	county	45.3417868	17.8114359	\N
735	Primorje-Gorski Kotar	55	HR	Croatia	08	county	45.3173996	14.8167466	\N
730	Šibenik-Knin	55	HR	Croatia	15	county	43.9281485	16.1037694	\N
733	Sisak-Moslavina	55	HR	Croatia	03	county	45.3837926	16.5380994	\N
725	Split-Dalmatia	55	HR	Croatia	17	county	43.5240328	16.8178377	\N
739	Varaždin	55	HR	Croatia	05	county	46.2317473	16.3360559	\N
732	Virovitica-Podravina	55	HR	Croatia	10	county	45.6557985	17.7932472	\N
741	Vukovar-Syrmia	55	HR	Croatia	16	county	45.1773552	18.8053527	\N
727	Zadar	55	HR	Croatia	13	county	44.146939	15.6164943	\N
736	Zagreb	55	HR	Croatia	01	county	45.8706612	16.395491	\N
738	Zagreb	55	HR	Croatia	21	city	45.8150108	15.9819189	\N
283	Artemisa Province	56	CU	Cuba	15	\N	22.7522903	-82.9931607	\N
286	Camagüey Province	56	CU	Cuba	09	\N	21.2167247	-77.7452081	\N
282	Ciego de Ávila Province	56	CU	Cuba	08	\N	21.9329515	-78.5660852	\N
287	Cienfuegos Province	56	CU	Cuba	06	\N	22.2379783	-80.365865	\N
275	Granma Province	56	CU	Cuba	12	\N	20.3844902	-76.6412712	\N
285	Guantánamo Province	56	CU	Cuba	14	\N	20.1455917	-74.8741045	\N
272	Havana Province	56	CU	Cuba	03	\N	23.0540698	-82.345189	\N
279	Holguín Province	56	CU	Cuba	11	\N	20.7837893	-75.8069082	\N
278	Isla de la Juventud	56	CU	Cuba	99	\N	21.7084737	-82.8220232	\N
281	Las Tunas Province	56	CU	Cuba	10	\N	21.0605162	-76.9182097	\N
284	Matanzas Province	56	CU	Cuba	04	\N	22.5767123	-81.3399414	\N
276	Mayabeque Province	56	CU	Cuba	16	\N	22.8926529	-81.9534815	\N
277	Pinar del Río Province	56	CU	Cuba	01	\N	22.4076256	-83.8473015	\N
274	Sancti Spíritus Province	56	CU	Cuba	07	\N	21.9938214	-79.4703885	\N
273	Santiago de Cuba Province	56	CU	Cuba	13	\N	20.2397682	-75.9927652	\N
280	Villa Clara Province	56	CU	Cuba	05	\N	22.4937204	-79.9192702	\N
749	Famagusta District (Mağusa)	57	CY	Cyprus	04	district	35.2857023	33.8411288	\N
744	Kyrenia District (Keryneia)	57	CY	Cyprus	06	district	35.299194	33.2363246	\N
747	Larnaca District (Larnaka)	57	CY	Cyprus	03	district	34.8507206	33.4831906	\N
748	Limassol District (Leymasun)	57	CY	Cyprus	02	district	34.7071301	33.0226174	\N
745	Nicosia District (Lefkoşa)	57	CY	Cyprus	01	district	35.1855659	33.3822764	\N
746	Paphos District (Pafos)	57	CY	Cyprus	05	district	34.9164594	32.4920088	\N
4627	Benešov	58	CZ	Czech Republic	201	\N	49.6900828	14.7764399	\N
4620	Beroun	58	CZ	Czech Republic	202	\N	49.9573428	13.9840715	\N
4615	Blansko	58	CZ	Czech Republic	641	\N	49.3648502	16.6477552	\N
4542	Břeclav	58	CZ	Czech Republic	644	\N	48.75314	16.8825169	\N
4568	Brno-město	58	CZ	Czech Republic	642	\N	49.1950602	16.6068371	\N
4545	Brno-venkov	58	CZ	Czech Republic	643	\N	49.1250138	16.4558824	\N
4644	Bruntál	58	CZ	Czech Republic	801	\N	49.9881767	17.4636941	\N
4633	Česká Lípa	58	CZ	Czech Republic	511	\N	50.6785201	14.5396991	\N
4556	České Budějovice	58	CZ	Czech Republic	311	\N	48.9775553	14.5150747	\N
4543	Český Krumlov	58	CZ	Czech Republic	312	\N	48.8127354	14.3174657	\N
4573	Cheb	58	CZ	Czech Republic	411	\N	50.0795334	12.3698636	\N
4553	Chomutov	58	CZ	Czech Republic	422	\N	50.4583872	13.301791	\N
4634	Chrudim	58	CZ	Czech Republic	531	\N	49.8830216	15.8290866	\N
4609	Děčín	58	CZ	Czech Republic	421	\N	50.7725563	14.2127612	\N
4641	Domažlice	58	CZ	Czech Republic	321	\N	49.4397027	12.9311435	\N
4559	Frýdek-Místek	58	CZ	Czech Republic	802	\N	49.6819305	18.3673216	\N
4611	Havlíčkův Brod	58	CZ	Czech Republic	631	\N	49.6043364	15.5796552	\N
4561	Hodonín	58	CZ	Czech Republic	645	\N	48.8529391	17.1260025	\N
4580	Hradec Králové	58	CZ	Czech Republic	521	\N	50.2414805	15.6743	\N
4612	Jablonec nad Nisou	58	CZ	Czech Republic	512	\N	50.7220528	15.1703135	\N
4625	Jeseník	58	CZ	Czech Republic	711	\N	50.2246249	17.1980471	\N
4640	Jičín	58	CZ	Czech Republic	522	\N	50.4353325	15.361044	\N
4613	Jihlava	58	CZ	Czech Republic	632	\N	49.3983782	15.5870415	\N
4639	Jihočeský kraj	58	CZ	Czech Republic	31	\N	48.9457789	14.4416055	\N
4602	Jihomoravský kraj	58	CZ	Czech Republic	64	\N	48.9544528	16.7676899	\N
4624	Jindřichův Hradec	58	CZ	Czech Republic	313	\N	49.1444823	15.0061389	\N
4581	Karlovarský kraj	58	CZ	Czech Republic	41	\N	50.1435	12.7501899	\N
4604	Karlovy Vary	58	CZ	Czech Republic	412	\N	50.1435	12.7501899	\N
4586	Karviná	58	CZ	Czech Republic	803	\N	49.8566524	18.5432186	\N
4631	Kladno	58	CZ	Czech Republic	203	\N	50.1940258	14.1043657	\N
4591	Klatovy	58	CZ	Czech Republic	322	\N	49.3955549	13.2950937	\N
4618	Kolín	58	CZ	Czech Republic	204	\N	49.9883293	15.0551977	\N
4575	Kraj Vysočina	58	CZ	Czech Republic	63	\N	49.4490052	15.6405934	\N
4614	Královéhradecký kraj	58	CZ	Czech Republic	52	\N	50.3512484	15.7976459	\N
4593	Kroměříž	58	CZ	Czech Republic	721	\N	49.2916582	17.39938	\N
4923	Kutná Hora	58	CZ	Czech Republic	205	\N	49.9492089	15.247044	\N
4590	Liberec	58	CZ	Czech Republic	513	\N	50.7564101	14.9965041	\N
4601	Liberecký kraj	58	CZ	Czech Republic	51	\N	50.659424	14.7632424	\N
4605	Litoměřice	58	CZ	Czech Republic	423	\N	50.5384197	14.1305458	\N
4617	Louny	58	CZ	Czech Republic	424	\N	50.3539812	13.8033551	\N
4638	Mělník	58	CZ	Czech Republic	206	\N	50.3104415	14.5179223	\N
4643	Mladá Boleslav	58	CZ	Czech Republic	207	\N	50.4252317	14.9362477	\N
4600	Moravskoslezský kraj	58	CZ	Czech Republic	80	\N	49.7305327	18.2332637	\N
4629	Most	58	CZ	Czech Republic	425	\N	37.1554083	-94.2948884	\N
4550	Náchod	58	CZ	Czech Republic	523	\N	50.4145722	16.1656347	\N
4548	Nový Jičín	58	CZ	Czech Republic	804	\N	49.5943251	18.0135356	\N
4582	Nymburk	58	CZ	Czech Republic	208	\N	50.1855816	15.0436604	\N
4574	Olomouc	58	CZ	Czech Republic	712	\N	49.593778	17.2508787	\N
4589	Olomoucký kraj	58	CZ	Czech Republic	71	\N	49.6586549	17.0811406	\N
4623	Opava	58	CZ	Czech Republic	805	\N	49.9083757	17.916338	\N
4584	Ostrava-město	58	CZ	Czech Republic	806	\N	49.8209226	18.2625243	\N
4547	Pardubice	58	CZ	Czech Republic	532	\N	49.9444479	16.2856916	\N
4588	Pardubický kraj	58	CZ	Czech Republic	53	\N	49.9444479	16.2856916	\N
4645	Pelhřimov	58	CZ	Czech Republic	633	\N	49.4306207	15.222983	\N
4560	Písek	58	CZ	Czech Republic	314	\N	49.3419938	14.246976	\N
4608	Plzeň-jih	58	CZ	Czech Republic	324	\N	49.5904885	13.5715861	\N
4544	Plzeň-město	58	CZ	Czech Republic	323	\N	49.7384314	13.3736371	\N
4564	Plzeň-sever	58	CZ	Czech Republic	325	\N	49.8774893	13.2537428	\N
4607	Plzeňský kraj	58	CZ	Czech Republic	32	\N	49.4134812	13.3157246	\N
4578	Prachatice	58	CZ	Czech Republic	315	\N	49.01091	14.0000005	\N
4606	Praha-východ	58	CZ	Czech Republic	209	\N	49.9389307	14.7924472	\N
4619	Praha-západ	58	CZ	Czech Republic	20A	\N	49.8935235	14.3293779	\N
4598	Praha, Hlavní město	58	CZ	Czech Republic	10	\N	50.0755381	14.4378005	\N
4626	Přerov	58	CZ	Czech Republic	714	\N	49.4671356	17.5077332	\N
4546	Příbram	58	CZ	Czech Republic	20B	\N	49.6947959	14.082381	\N
4551	Prostějov	58	CZ	Czech Republic	713	\N	49.4418401	17.1277904	\N
4558	Rakovník	58	CZ	Czech Republic	20C	\N	50.106123	13.7396623	\N
4583	Rokycany	58	CZ	Czech Republic	326	\N	49.8262827	13.6874943	\N
4636	Rychnov nad Kněžnou	58	CZ	Czech Republic	524	\N	50.1659651	16.2776842	\N
4596	Semily	58	CZ	Czech Republic	514	\N	50.6051576	15.3281409	\N
4595	Sokolov	58	CZ	Czech Republic	413	\N	50.2013434	12.6054636	\N
4628	Strakonice	58	CZ	Czech Republic	316	\N	49.2604043	13.9103085	\N
4554	Středočeský kraj	58	CZ	Czech Republic	20	\N	49.8782223	14.9362955	\N
4642	Šumperk	58	CZ	Czech Republic	715	\N	49.9778407	16.9717754	\N
4571	Svitavy	58	CZ	Czech Republic	533	\N	49.7551629	16.4691861	\N
4565	Tábor	58	CZ	Czech Republic	317	\N	49.3646293	14.7191293	\N
4646	Tachov	58	CZ	Czech Republic	327	\N	49.7987803	12.6361921	\N
4621	Teplice	58	CZ	Czech Republic	426	\N	50.6584605	13.7513227	\N
4597	Třebíč	58	CZ	Czech Republic	634	\N	49.2147869	15.8795516	\N
4579	Trutnov	58	CZ	Czech Republic	525	\N	50.5653838	15.9090923	\N
4592	Uherské Hradiště	58	CZ	Czech Republic	722	\N	49.0597969	17.4958501	\N
4576	Ústecký kraj	58	CZ	Czech Republic	42	\N	50.6119037	13.7870086	\N
4599	Ústí nad Labem	58	CZ	Czech Republic	427	\N	50.6119037	13.7870086	\N
4647	Ústí nad Orlicí	58	CZ	Czech Republic	534	\N	49.9721801	16.3996617	\N
4572	Vsetín	58	CZ	Czech Republic	723	\N	49.379325	18.0618162	\N
4622	Vyškov	58	CZ	Czech Republic	646	\N	49.2127445	16.9855927	\N
4648	Žďár nad Sázavou	58	CZ	Czech Republic	635	\N	49.5643012	15.939103	\N
4563	Zlín	58	CZ	Czech Republic	724	\N	49.1696052	17.802522	\N
4552	Zlínský kraj	58	CZ	Czech Republic	72	\N	49.2162296	17.7720353	\N
4630	Znojmo	58	CZ	Czech Republic	647	\N	48.9272327	16.1037808	\N
2753	Bas-Uélé	51	CD	Democratic Republic of the Congo	BU	\N	3.9901009	24.9042208	\N
2744	Équateur	51	CD	Democratic Republic of the Congo	EQ	\N	-1.831239	-78.183406	\N
2750	Haut-Katanga	51	CD	Democratic Republic of the Congo	HK	\N	-10.4102075	27.5495846	\N
2758	Haut-Lomami	51	CD	Democratic Republic of the Congo	HL	\N	-7.7052752	24.9042208	\N
2734	Haut-Uélé	51	CD	Democratic Republic of the Congo	HU	\N	3.5845154	28.299435	\N
2751	Ituri	51	CD	Democratic Republic of the Congo	IT	\N	1.5957682	29.4179324	\N
2757	Kasaï	51	CD	Democratic Republic of the Congo	KS	\N	-5.0471979	20.7122465	\N
2742	Kasaï Central	51	CD	Democratic Republic of the Congo	KC	\N	-8.4404591	20.4165934	\N
2735	Kasaï Oriental	51	CD	Democratic Republic of the Congo	KE	\N	-6.033623	23.5728501	\N
2741	Kinshasa	51	CD	Democratic Republic of the Congo	KN	\N	-4.4419311	15.2662931	\N
2746	Kongo Central	51	CD	Democratic Republic of the Congo	BC	\N	-5.2365685	13.914399	\N
2740	Kwango	51	CD	Democratic Republic of the Congo	KG	\N	-6.4337409	17.668887	\N
2759	Kwilu	51	CD	Democratic Republic of the Congo	KL	\N	-5.1188825	18.4276047	\N
2747	Lomami	51	CD	Democratic Republic of the Congo	LO	\N	-6.1453931	24.524264	\N
4953	Lualaba	51	CD	Democratic Republic of the Congo	LU	\N	-10.4808698	25.6297816	\N
2755	Mai-Ndombe	51	CD	Democratic Republic of the Congo	MN	\N	-2.6357434	18.4276047	\N
2745	Maniema	51	CD	Democratic Republic of the Congo	MA	\N	-3.0730929	26.0413889	\N
2752	Mongala	51	CD	Democratic Republic of the Congo	MO	\N	1.9962324	21.4752851	\N
2749	Nord-Kivu	51	CD	Democratic Republic of the Congo	NK	\N	-0.7917729	29.0459927	\N
2739	Nord-Ubangi	51	CD	Democratic Republic of the Congo	NU	\N	3.7878726	21.4752851	\N
2743	Sankuru	51	CD	Democratic Republic of the Congo	SA	\N	-2.8437453	23.3823545	\N
2738	Sud-Kivu	51	CD	Democratic Republic of the Congo	SK	\N	-3.011658	28.299435	\N
2748	Sud-Ubangi	51	CD	Democratic Republic of the Congo	SU	\N	3.2299942	19.1880047	\N
2733	Tanganyika	51	CD	Democratic Republic of the Congo	TA	\N	-6.2740118	27.9249002	\N
2756	Tshopo	51	CD	Democratic Republic of the Congo	TO	\N	0.5455462	24.9042208	\N
2732	Tshuapa	51	CD	Democratic Republic of the Congo	TU	\N	-0.9903023	23.0288844	\N
1530	Capital Region of Denmark	59	DK	Denmark	84	\N	55.6751812	12.5493261	\N
1531	Central Denmark Region	59	DK	Denmark	82	\N	56.302139	9.302777	\N
1532	North Denmark Region	59	DK	Denmark	81	\N	56.8307416	9.4930527	\N
1529	Region of Southern Denmark	59	DK	Denmark	83	\N	55.3307714	9.0924903	\N
1528	Region Zealand	59	DK	Denmark	85	\N	55.4632518	11.7214979	\N
2933	Ali Sabieh Region	60	DJ	Djibouti	AS	\N	11.1928973	42.941698	\N
2932	Arta Region	60	DJ	Djibouti	AR	\N	11.5255528	42.8479474	\N
2930	Dikhil Region	60	DJ	Djibouti	DI	\N	11.1054336	42.3704744	\N
2929	Djibouti	60	DJ	Djibouti	DJ	\N	11.825138	42.590275	\N
2928	Obock Region	60	DJ	Djibouti	OB	\N	12.3895691	43.0194897	\N
2931	Tadjourah Region	60	DJ	Djibouti	TA	\N	11.9338885	42.3938375	\N
4082	Saint Andrew Parish	61	DM	Dominica	02	\N	\N	\N	\N
4078	Saint David Parish	61	DM	Dominica	03	\N	\N	\N	\N
4079	Saint George Parish	61	DM	Dominica	04	\N	\N	\N	\N
4076	Saint John Parish	61	DM	Dominica	05	\N	\N	\N	\N
4085	Saint Joseph Parish	61	DM	Dominica	06	\N	39.0222712	-94.7176504	\N
4083	Saint Luke Parish	61	DM	Dominica	07	\N	42.1051363	-80.0570722	\N
4077	Saint Mark Parish	61	DM	Dominica	08	\N	\N	\N	\N
4080	Saint Patrick Parish	61	DM	Dominica	09	\N	\N	\N	\N
4084	Saint Paul Parish	61	DM	Dominica	10	\N	38.86146	-90.7435619	\N
4081	Saint Peter Parish	61	DM	Dominica	11	\N	40.4524194	-80.0085056	\N
4114	Azua Province	62	DO	Dominican Republic	02	\N	18.4552709	-70.7380928	\N
4105	Baoruco Province	62	DO	Dominican Republic	03	\N	18.4879898	-71.4182249	\N
4090	Barahona Province	62	DO	Dominican Republic	04	\N	18.2139066	-71.1043759	\N
4107	Dajabón Province	62	DO	Dominican Republic	05	\N	19.5499241	-71.7086514	\N
4095	Distrito Nacional	62	DO	Dominican Republic	01	\N	18.4860575	-69.9312117	\N
4113	Duarte Province	62	DO	Dominican Republic	06	\N	19.2090823	-70.0270004	\N
4086	El Seibo Province	62	DO	Dominican Republic	08	\N	18.7658496	-69.040668	\N
4102	Espaillat Province	62	DO	Dominican Republic	09	\N	19.6277658	-70.2786775	\N
4106	Hato Mayor Province	62	DO	Dominican Republic	30	\N	18.7635799	-69.2557637	\N
4089	Hermanas Mirabal Province	62	DO	Dominican Republic	19	\N	19.3747559	-70.3513235	\N
4097	Independencia	62	DO	Dominican Republic	10	\N	32.6335748	-115.4289294	\N
4109	La Altagracia Province	62	DO	Dominican Republic	11	\N	18.5850236	-68.6201072	\N
4087	La Romana Province	62	DO	Dominican Republic	12	\N	18.4310271	-68.9837373	\N
4116	La Vega Province	62	DO	Dominican Republic	13	\N	19.2211554	-70.5288753	\N
4094	María Trinidad Sánchez Province	62	DO	Dominican Republic	14	\N	19.3734597	-69.8514439	\N
4099	Monseñor Nouel Province	62	DO	Dominican Republic	28	\N	18.9215234	-70.3836815	\N
4115	Monte Cristi Province	62	DO	Dominican Republic	15	\N	19.7396899	-71.4433984	\N
4111	Monte Plata Province	62	DO	Dominican Republic	29	\N	18.8080878	-69.7869146	\N
4101	Pedernales Province	62	DO	Dominican Republic	16	\N	17.8537626	-71.3303209	\N
4096	Peravia Province	62	DO	Dominican Republic	17	\N	18.2786594	-70.3335887	\N
4092	Puerto Plata Province	62	DO	Dominican Republic	18	\N	19.7543225	-70.8332847	\N
4103	Samaná Province	62	DO	Dominican Republic	20	\N	19.2058371	-69.3362949	\N
4091	San Cristóbal Province	62	DO	Dominican Republic	21	\N	18.4180414	-70.1065849	\N
4112	San José de Ocoa Province	62	DO	Dominican Republic	31	\N	18.543858	-70.5041816	\N
4098	San Juan Province	62	DO	Dominican Republic	22	\N	-31.5287127	-68.5360403	\N
4110	San Pedro de Macorís	62	DO	Dominican Republic	23	\N	18.46266	-69.3051234	\N
4088	Sánchez Ramírez Province	62	DO	Dominican Republic	24	\N	19.052706	-70.1492264	\N
4108	Santiago Province	62	DO	Dominican Republic	25	\N	-33.45	-70.6667	\N
4100	Santiago Rodríguez Province	62	DO	Dominican Republic	26	\N	19.4713181	-71.3395801	\N
4093	Santo Domingo Province	62	DO	Dominican Republic	32	\N	18.5104253	-69.8404054	\N
4104	Valverde Province	62	DO	Dominican Republic	27	\N	19.5881221	-70.980331	\N
4520	Aileu municipality	63	TL	East Timor	AL	\N	-8.7043994	125.6095474	\N
4518	Ainaro Municipality	63	TL	East Timor	AN	\N	-9.0113171	125.5220012	\N
4521	Baucau Municipality	63	TL	East Timor	BA	\N	-8.4714308	126.4575991	\N
4525	Bobonaro Municipality	63	TL	East Timor	BO	\N	-8.9655406	125.2587964	\N
4522	Cova Lima Municipality	63	TL	East Timor	CO	\N	-9.2650375	125.2587964	\N
4524	Dili municipality	63	TL	East Timor	DI	\N	-8.2449613	125.5876697	\N
4516	Ermera District	63	TL	East Timor	ER	\N	-8.7524802	125.3987294	\N
4523	Lautém Municipality	63	TL	East Timor	LA	\N	-8.3642307	126.9043845	\N
4515	Liquiçá Municipality	63	TL	East Timor	LI	\N	-8.6674095	125.2587964	\N
4517	Manatuto District	63	TL	East Timor	MT	\N	-8.5155608	126.0159255	\N
4519	Manufahi Municipality	63	TL	East Timor	MF	\N	-9.0145495	125.8279959	\N
4514	Viqueque Municipality	63	TL	East Timor	VI	\N	-8.8597918	126.3633516	\N
2923	Azuay	64	EC	Ecuador	A	province	-2.8943068	-78.9968344	\N
2920	Bolívar	64	EC	Ecuador	B	province	-1.7095828	-79.0450429	\N
2917	Cañar	64	EC	Ecuador	F	province	-2.5589315	-78.9388191	\N
2915	Carchi	64	EC	Ecuador	C	province	0.5026912	-77.9042521	\N
2925	Chimborazo	64	EC	Ecuador	H	province	-1.6647995	-78.6543255	\N
2921	Cotopaxi	64	EC	Ecuador	X	province	-0.8384206	-78.6662678	\N
2924	El Oro	64	EC	Ecuador	O	province	-3.2592413	-79.9583541	\N
2922	Esmeraldas	64	EC	Ecuador	E	province	0.9681789	-79.6517202	\N
2905	Galápagos	64	EC	Ecuador	W	province	-0.9537691	-90.9656019	\N
2914	Guayas	64	EC	Ecuador	G	province	-1.9574839	-79.9192702	\N
2911	Imbabura	64	EC	Ecuador	I	province	0.3499768	-78.1260129	\N
5068	Loja	64	EC	Ecuador	L	province	-3.99313	-79.20422	\N
2910	Los Ríos	64	EC	Ecuador	R	province	-1.0230607	-79.4608897	\N
2913	Manabí	64	EC	Ecuador	M	province	-1.0543434	-80.452644	\N
2918	Morona-Santiago	64	EC	Ecuador	S	province	-2.3051062	-78.1146866	\N
2916	Napo	64	EC	Ecuador	N	province	-0.9955964	-77.8129684	\N
2926	Orellana	64	EC	Ecuador	D	province	-0.4545163	-76.9950286	\N
2907	Pastaza	64	EC	Ecuador	Y	province	-1.4882265	-78.0031057	\N
2927	Pichincha	64	EC	Ecuador	P	province	-0.1464847	-78.4751945	\N
2912	Santa Elena	64	EC	Ecuador	SE	province	-2.2267105	-80.859499	\N
2919	Santo Domingo de los Tsáchilas	64	EC	Ecuador	SD	province	-0.2521882	-79.1879383	\N
2906	Sucumbíos	64	EC	Ecuador	U	province	0.0889231	-76.8897557	\N
2908	Tungurahua	64	EC	Ecuador	T	province	-1.2635284	-78.5660852	\N
2909	Zamora Chinchipe	64	EC	Ecuador	Z	province	-4.0655892	-78.9503525	\N
3235	Alexandria	65	EG	Egypt	ALX	\N	30.8760568	29.742604	\N
3225	Aswan	65	EG	Egypt	ASN	\N	23.6966498	32.7181375	\N
3236	Asyut	65	EG	Egypt	AST	\N	27.2133831	31.4456179	\N
3241	Beheira	65	EG	Egypt	BH	\N	30.8480986	30.3435506	\N
3230	Beni Suef	65	EG	Egypt	BNS	\N	28.8938837	31.4456179	\N
3223	Cairo	65	EG	Egypt	C	\N	29.9537564	31.5370003	\N
3245	Dakahlia	65	EG	Egypt	DK	\N	31.1656044	31.4913182	\N
3224	Damietta	65	EG	Egypt	DT	\N	31.3625799	31.6739371	\N
3238	Faiyum	65	EG	Egypt	FYM	\N	29.3084021	30.8428497	\N
3234	Gharbia	65	EG	Egypt	GH	\N	30.8753556	31.03351	\N
3239	Giza	65	EG	Egypt	GZ	\N	28.7666216	29.2320784	\N
3244	Ismailia	65	EG	Egypt	IS	\N	30.5830934	32.2653887	\N
3222	Kafr el-Sheikh	65	EG	Egypt	KFS	\N	31.3085444	30.8039474	\N
3242	Luxor	65	EG	Egypt	LX	\N	25.3944444	32.4920088	\N
3231	Matrouh	65	EG	Egypt	MT	\N	29.569635	26.419389	\N
3243	Minya	65	EG	Egypt	MN	\N	28.284729	30.5279096	\N
3228	Monufia	65	EG	Egypt	MNF	\N	30.5972455	30.9876321	\N
3246	New Valley	65	EG	Egypt	WAD	\N	24.5455638	27.1735316	\N
3227	North Sinai	65	EG	Egypt	SIN	\N	30.282365	33.617577	\N
3229	Port Said	65	EG	Egypt	PTS	\N	31.0758606	32.2653887	\N
3232	Qalyubia	65	EG	Egypt	KB	\N	30.3292368	31.2168466	\N
3247	Qena	65	EG	Egypt	KN	\N	26.2346033	32.9888319	\N
3240	Red Sea	65	EG	Egypt	BA	\N	24.6826316	34.1531947	\N
5067	Sharqia	65	EG	Egypt	SHR	\N	30.6730545	31.1593247	\N
3226	Sohag	65	EG	Egypt	SHG	\N	26.693834	32.174605	\N
3237	South Sinai	65	EG	Egypt	JS	\N	29.3101828	34.1531947	\N
3233	Suez	65	EG	Egypt	SUZ	\N	29.3682255	32.174605	\N
4139	Ahuachapán Department	66	SV	El Salvador	AH	\N	13.8216148	-89.9253233	\N
4132	Cabañas Department	66	SV	El Salvador	CA	\N	13.8648288	-88.7493998	\N
4131	Chalatenango Department	66	SV	El Salvador	CH	\N	14.1916648	-89.1705998	\N
4137	Cuscatlán Department	66	SV	El Salvador	CU	\N	13.8661957	-89.0561532	\N
4134	La Libertad Department	66	SV	El Salvador	LI	\N	13.6817661	-89.3606298	\N
4136	La Paz Department	66	SV	El Salvador	PA	\N	\N	\N	\N
4138	La Unión Department	66	SV	El Salvador	UN	\N	13.4886443	-87.8942451	\N
4130	Morazán Department	66	SV	El Salvador	MO	\N	13.7682	-88.1291387	\N
4135	San Miguel Department	66	SV	El Salvador	SM	\N	13.4451041	-88.2461183	\N
4133	San Salvador Department	66	SV	El Salvador	SS	\N	13.7739997	-89.2086773	\N
4127	San Vicente Department	66	SV	El Salvador	SV	\N	13.5868561	-88.7493998	\N
4128	Santa Ana Department	66	SV	El Salvador	SA	\N	14.1461121	-89.5120084	\N
4140	Sonsonate Department	66	SV	El Salvador	SO	\N	13.682358	-89.6628111	\N
4129	Usulután Department	66	SV	El Salvador	US	\N	13.4470634	-88.556531	\N
3444	Annobón Province	67	GQ	Equatorial Guinea	AN	\N	-1.4268782	5.6352801	\N
3446	Bioko Norte Province	67	GQ	Equatorial Guinea	BN	\N	3.6595072	8.7921836	\N
3443	Bioko Sur Province	67	GQ	Equatorial Guinea	BS	\N	3.4209785	8.6160674	\N
3445	Centro Sur Province	67	GQ	Equatorial Guinea	CS	\N	1.3436084	10.439656	\N
3442	Insular Region	67	GQ	Equatorial Guinea	I	\N	37.09024	-95.712891	\N
3439	Kié-Ntem Province	67	GQ	Equatorial Guinea	KN	\N	2.028093	11.0711758	\N
3441	Litoral Province	67	GQ	Equatorial Guinea	LI	\N	1.5750244	9.8124935	\N
3438	Río Muni	67	GQ	Equatorial Guinea	C	\N	1.4610606	9.6786894	\N
3440	Wele-Nzas Province	67	GQ	Equatorial Guinea	WN	\N	1.4166162	11.0711758	\N
3425	Anseba Region	68	ER	Eritrea	AN	\N	16.4745531	37.8087693	\N
3427	Debub Region	68	ER	Eritrea	DU	\N	14.9478692	39.1543677	\N
3428	Gash-Barka Region	68	ER	Eritrea	GB	\N	15.4068825	37.6386622	\N
3426	Maekel Region	68	ER	Eritrea	MA	\N	15.3551409	38.8623683	\N
3424	Northern Red Sea Region	68	ER	Eritrea	SK	\N	16.2583997	38.8205454	\N
3429	Southern Red Sea Region	68	ER	Eritrea	DK	\N	13.5137103	41.7606472	\N
3567	Harju County	69	EE	Estonia	37	\N	59.3334239	25.2466974	\N
3555	Hiiu County	69	EE	Estonia	39	\N	58.9239553	22.5919468	\N
3569	Ida-Viru County	69	EE	Estonia	44	\N	59.2592663	27.4136535	\N
3566	Järva County	69	EE	Estonia	51	\N	58.8866713	25.5000624	\N
3565	Jõgeva County	69	EE	Estonia	49	\N	58.7506143	26.3604878	\N
3568	Lääne County	69	EE	Estonia	57	\N	58.9722742	23.8740834	\N
3564	Lääne-Viru County	69	EE	Estonia	59	\N	59.3018816	26.3280312	\N
3562	Pärnu County	69	EE	Estonia	67	\N	58.5261952	24.4020159	\N
3563	Põlva County	69	EE	Estonia	65	\N	58.1160622	27.2066394	\N
3559	Rapla County	69	EE	Estonia	70	\N	58.8492625	24.7346569	\N
3561	Saare County	69	EE	Estonia	74	\N	58.4849721	22.6136408	\N
3557	Tartu County	69	EE	Estonia	78	\N	58.4057128	26.801576	\N
3558	Valga County	69	EE	Estonia	82	\N	57.9103441	26.1601819	\N
3556	Viljandi County	69	EE	Estonia	84	\N	58.2821746	25.5752233	\N
3560	Võru County	69	EE	Estonia	86	\N	57.7377372	27.1398938	\N
11	Addis Ababa	70	ET	Ethiopia	AA	\N	8.9806034	38.7577605	\N
6	Afar Region	70	ET	Ethiopia	AF	\N	11.7559388	40.958688	\N
3	Amhara Region	70	ET	Ethiopia	AM	\N	11.3494247	37.9784585	\N
9	Benishangul-Gumuz Region	70	ET	Ethiopia	BE	\N	10.7802889	35.5657862	\N
8	Dire Dawa	70	ET	Ethiopia	DD	\N	9.6008747	41.850142	\N
10	Gambela Region	70	ET	Ethiopia	GA	\N	7.9219687	34.1531947	\N
7	Harari Region	70	ET	Ethiopia	HA	\N	9.314866	42.1967716	\N
5	Oromia Region	70	ET	Ethiopia	OR	\N	7.5460377	40.6346851	\N
2	Somali Region	70	ET	Ethiopia	SO	\N	6.6612293	43.7908453	\N
1	Southern Nations, Nationalities, and Peoples' Region	70	ET	Ethiopia	SN	\N	6.5156911	36.954107	\N
4	Tigray Region	70	ET	Ethiopia	TI	\N	14.0323336	38.3165725	\N
1917	Ba	73	FJ	Fiji Islands	01	\N	36.0613893	-95.8005872	\N
1930	Bua	73	FJ	Fiji Islands	02	\N	43.0964584	-89.50088	\N
1924	Cakaudrove	73	FJ	Fiji Islands	03	\N	-16.5814105	179.5120084	\N
1929	Central Division	73	FJ	Fiji Islands	C	\N	34.0440066	-118.2472738	\N
1932	Eastern Division	73	FJ	Fiji Islands	E	\N	32.8094305	-117.1289937	\N
1934	Kadavu	73	FJ	Fiji Islands	04	\N	-19.0127122	178.1876676	\N
1933	Lau	73	FJ	Fiji Islands	05	\N	31.6687015	-106.3955763	\N
1916	Lomaiviti	73	FJ	Fiji Islands	06	\N	-17.709	179.091	\N
1922	Macuata	73	FJ	Fiji Islands	07	\N	-16.4864922	179.2847251	\N
1919	Nadroga-Navosa	73	FJ	Fiji Islands	08	\N	-17.9865278	177.658113	\N
1927	Naitasiri	73	FJ	Fiji Islands	09	\N	-17.8975754	178.2071598	\N
1928	Namosi	73	FJ	Fiji Islands	10	\N	-18.0864176	178.1291387	\N
1921	Northern Division	73	FJ	Fiji Islands	N	\N	32.8768766	-117.2156345	\N
1926	Ra	73	FJ	Fiji Islands	11	\N	37.1003153	-95.6744246	\N
1920	Rewa	73	FJ	Fiji Islands	12	\N	34.7923517	-82.3609264	\N
1931	Rotuma	73	FJ	Fiji Islands	R	\N	-12.5025069	177.0724164	\N
1925	Serua	73	FJ	Fiji Islands	13	\N	-18.1804749	178.050979	\N
1918	Tailevu	73	FJ	Fiji Islands	14	\N	-17.8269111	178.293248	\N
1923	Western Division	73	FJ	Fiji Islands	W	\N	42.9662198	-78.7021134	\N
1509	Åland Islands	74	FI	Finland	01	region	60.1785247	19.9156105	\N
1511	Central Finland	74	FI	Finland	08	region	62.5666743	25.5549445	\N
1494	Central Ostrobothnia	74	FI	Finland	07	region	63.5621735	24.0013631	\N
1507	Finland Proper	74	FI	Finland	19	region	60.3627914	22.4439369	\N
1496	Kainuu	74	FI	Finland	05	region	64.3736564	28.7437475	\N
1512	Kymenlaakso	74	FI	Finland	09	region	60.780512	26.8829336	\N
1500	Lapland	74	FI	Finland	10	region	67.9222304	26.5046438	\N
1504	North Karelia	74	FI	Finland	13	region	62.8062078	30.1553887	\N
1505	Northern Ostrobothnia	74	FI	Finland	14	region	65.279493	26.2890417	\N
1503	Northern Savonia	74	FI	Finland	15	region	63.08448	27.0253504	\N
1508	Ostrobothnia	74	FI	Finland	12	region	63.1181757	21.9061062	\N
1502	Päijänne Tavastia	74	FI	Finland	16	region	61.3230041	25.7322496	\N
1506	Pirkanmaa	74	FI	Finland	11	region	61.6986918	23.7895598	\N
1501	Satakunta	74	FI	Finland	17	region	61.5932758	22.1483081	\N
1497	South Karelia	74	FI	Finland	02	region	61.1181949	28.1024372	\N
1498	Southern Ostrobothnia	74	FI	Finland	03	region	62.9433099	23.5285267	\N
1495	Southern Savonia	74	FI	Finland	04	region	61.6945148	27.8005015	\N
1493	Tavastia Proper	74	FI	Finland	06	region	60.907015	24.3005498	\N
1510	Uusimaa	74	FI	Finland	18	region	60.21872	25.271621	\N
4967	Ain	75	FR	France	01	metropolitan department	46.065086	4.888615	\N
4968	Aisne	75	FR	France	02	metropolitan department	49.4528921	3.0465111	\N
4969	Allier	75	FR	France	03	metropolitan department	46.3670863	2.5808277	\N
4970	Alpes-de-Haute-Provence	75	FR	France	04	metropolitan department	44.1637752	5.672478	\N
4972	Alpes-Maritimes	75	FR	France	06	metropolitan department	43.920417	6.6167822	\N
4811	Alsace	75	FR	France	6AE	European collectivity	48.3181795	7.4416241	\N
4973	Ardèche	75	FR	France	07	metropolitan department	44.8148695	3.8133483	\N
4974	Ardennes	75	FR	France	08	metropolitan department	49.6975951	4.1489576	\N
4975	Ariège	75	FR	France	09	metropolitan department	42.9434783	0.9404864	\N
4976	Aube	75	FR	France	10	metropolitan department	48.3197547	3.5637104	\N
4977	Aude	75	FR	France	11	metropolitan department	43.054114	1.9038476	\N
3008	Lower Saxony	82	DE	Germany	NI	\N	52.6367036	9.8450766	\N
4798	Auvergne-Rhône-Alpes	75	FR	France	ARA	metropolitan region	45.4471431	4.3852507	\N
4978	Aveyron	75	FR	France	12	metropolitan department	44.3156362	2.0852379	\N
5035	Bas-Rhin	75	FR	France	67	metropolitan department	48.5986444	7.0266676	\N
4979	Bouches-du-Rhône	75	FR	France	13	metropolitan department	43.5403865	4.4613829	\N
4825	Bourgogne-Franche-Comté	75	FR	France	BFC	metropolitan region	47.2805127	4.9994372	\N
4807	Bretagne	75	FR	France	BRE	metropolitan region	48.2020471	-2.9326435	\N
4981	Calvados	75	FR	France	14	metropolitan department	49.0903514	-0.9170648	\N
4982	Cantal	75	FR	France	15	metropolitan department	45.0492177	2.1567272	\N
4818	Centre-Val de Loire	75	FR	France	CVL	metropolitan region	47.7515686	1.6750631	\N
4983	Charente	75	FR	France	16	metropolitan department	45.6658479	-0.3184577	\N
4984	Charente-Maritime	75	FR	France	17	metropolitan department	45.7296828	-1.3388116	\N
4985	Cher	75	FR	France	18	metropolitan department	47.0243628	1.8662732	\N
5064	Clipperton	75	FR	France	CP	dependency	10.2833541	-109.2254215	\N
4986	Corrèze	75	FR	France	19	metropolitan department	45.3423707	1.3171733	\N
4806	Corse	75	FR	France	20R	metropolitan collectivity with special status	42.0396042	9.0128926	\N
4996	Corse-du-Sud	75	FR	France	2A	metropolitan department	41.8572055	8.4109183	\N
4987	Côte-d'Or	75	FR	France	21	metropolitan department	47.4651302	4.2315495	\N
4988	Côtes-d'Armor	75	FR	France	22	metropolitan department	48.4663336	-3.3478961	\N
4989	Creuse	75	FR	France	23	metropolitan department	46.0590394	1.431505	\N
5047	Deux-Sèvres	75	FR	France	79	metropolitan department	46.5386817	-0.9019948	\N
4990	Dordogne	75	FR	France	24	metropolitan department	45.1423416	0.1427408	\N
4991	Doubs	75	FR	France	25	metropolitan department	46.9321774	6.3476214	\N
4992	Drôme	75	FR	France	26	metropolitan department	44.7293357	4.6782158	\N
5059	Essonne	75	FR	France	91	metropolitan department	48.5304615	1.9699056	\N
4993	Eure	75	FR	France	27	metropolitan department	49.0754035	0.4893732	\N
4994	Eure-et-Loir	75	FR	France	28	metropolitan department	48.4469784	0.8147025	\N
4995	Finistère	75	FR	France	29	metropolitan department	48.226961	-4.8243733	\N
4822	French Guiana	75	FR	France	973	overseas region	3.933889	-53.125782	\N
4824	French Polynesia	75	FR	France	PF	overseas collectivity	-17.679742	-149.406843	\N
5065	French Southern and Antarctic Lands	75	FR	France	TF	overseas territory	-47.5446604	51.2837542	\N
4998	Gard	75	FR	France	30	metropolitan department	43.9595276	3.4935681	\N
5000	Gers	75	FR	France	32	metropolitan department	43.6950534	-0.0999728	\N
5001	Gironde	75	FR	France	33	metropolitan department	44.8958469	-1.5940532	\N
4820	Grand-Est	75	FR	France	GES	metropolitan region	48.699803	6.1878074	\N
4829	Guadeloupe	75	FR	France	971	overseas region	16.265	-61.551	\N
5036	Haut-Rhin	75	FR	France	68	metropolitan department	47.8653774	6.6711381	\N
4997	Haute-Corse	75	FR	France	2B	metropolitan department	42.4295866	8.5062561	\N
4999	Haute-Garonne	75	FR	France	31	metropolitan department	43.3050555	0.6845515	\N
5011	Haute-Loire	75	FR	France	43	metropolitan department	45.0853806	3.2260707	\N
5020	Haute-Marne	75	FR	France	52	metropolitan department	48.1324821	4.6983499	\N
5039	Haute-Saône	75	FR	France	70	metropolitan department	47.6378996	5.5355055	\N
5043	Haute-Savoie	75	FR	France	74	metropolitan department	46.0445277	5.864138	\N
5055	Haute-Vienne	75	FR	France	87	metropolitan department	45.9186878	0.7097206	\N
4971	Hautes-Alpes	75	FR	France	05	metropolitan department	44.6562682	5.6873211	\N
5033	Hautes-Pyrénées	75	FR	France	65	metropolitan department	43.1429462	-0.4009736	\N
4828	Hauts-de-France	75	FR	France	HDF	metropolitan region	50.4801153	2.7937265	\N
5060	Hauts-de-Seine	75	FR	France	92	metropolitan department	48.8403008	2.1012559	\N
5002	Hérault	75	FR	France	34	metropolitan department	43.591112	2.8066108	\N
4796	Île-de-France	75	FR	France	IDF	metropolitan region	48.8499198	2.6370411	\N
5003	Ille-et-Vilaine	75	FR	France	35	metropolitan department	48.1762484	-2.2130401	\N
5004	Indre	75	FR	France	36	metropolitan department	46.811755	0.9755523	\N
5005	Indre-et-Loire	75	FR	France	37	metropolitan department	47.2228582	0.1489619	\N
5006	Isère	75	FR	France	38	metropolitan department	45.2892271	4.9902355	\N
5007	Jura	75	FR	France	39	metropolitan department	46.7828741	5.1691844	\N
4823	La Réunion	75	FR	France	974	overseas region	-21.115141	55.536384	\N
5008	Landes	75	FR	France	40	metropolitan department	44.009508	-1.2538579	\N
5009	Loir-et-Cher	75	FR	France	41	metropolitan department	47.659376	0.8537631	\N
5010	Loire	75	FR	France	42	metropolitan department	46.3522812	-1.1756339	\N
5012	Loire-Atlantique	75	FR	France	44	metropolitan department	47.3475721	-2.3466312	\N
5013	Loiret	75	FR	France	45	metropolitan department	47.9135431	1.760099	\N
5014	Lot	75	FR	France	46	metropolitan department	44.624607	1.0357631	\N
5015	Lot-et-Garonne	75	FR	France	47	metropolitan department	44.3687314	-0.0916169	\N
5016	Lozère	75	FR	France	48	metropolitan department	44.5422779	2.9293459	\N
5017	Maine-et-Loire	75	FR	France	49	metropolitan department	47.3890034	-1.1202527	\N
5018	Manche	75	FR	France	50	metropolitan department	49.0881734	-2.4627209	\N
5019	Marne	75	FR	France	51	metropolitan department	48.9610745	3.6573767	\N
4827	Martinique	75	FR	France	972	overseas region	14.641528	-61.024174	\N
5021	Mayenne	75	FR	France	53	metropolitan department	48.3066842	-0.6490182	\N
4797	Mayotte	75	FR	France	976	overseas region	-12.8275	45.166244	\N
5038	Métropole de Lyon	75	FR	France	69M	metropolitan department	45.7482629	4.5958404	\N
5022	Meurthe-et-Moselle	75	FR	France	54	metropolitan department	48.9556615	5.714235	\N
5023	Meuse	75	FR	France	55	metropolitan department	49.012462	4.8108734	\N
5024	Morbihan	75	FR	France	56	metropolitan department	47.7439518	-3.4455524	\N
5025	Moselle	75	FR	France	57	metropolitan department	49.0204566	6.2055322	\N
5026	Nièvre	75	FR	France	58	metropolitan department	47.1192164	2.9779713	\N
5027	Nord	75	FR	France	59	metropolitan department	50.5285477	2.6000776	\N
4804	Normandie	75	FR	France	NOR	metropolitan region	48.8798704	0.1712529	\N
4795	Nouvelle-Aquitaine	75	FR	France	NAQ	metropolitan region	45.7087182	0.626891	\N
4799	Occitanie	75	FR	France	OCC	metropolitan region	43.8927232	3.2827625	\N
5028	Oise	75	FR	France	60	metropolitan department	49.4117335	1.8668825	\N
5029	Orne	75	FR	France	61	metropolitan department	48.5757644	-0.5024295	\N
4816	Paris	75	FR	France	75C	metropolitan collectivity with special status	48.856614	2.3522219	\N
5030	Pas-de-Calais	75	FR	France	62	metropolitan department	50.5144699	1.811498	\N
4802	Pays-de-la-Loire	75	FR	France	PDL	metropolitan region	47.7632836	-0.3299687	\N
4812	Provence-Alpes-Côte-d’Azur	75	FR	France	PAC	metropolitan region	43.9351691	6.0679194	\N
5031	Puy-de-Dôme	75	FR	France	63	metropolitan department	45.7714185	2.6262676	\N
5032	Pyrénées-Atlantiques	75	FR	France	64	metropolitan department	43.186817	-1.4417071	\N
5034	Pyrénées-Orientales	75	FR	France	66	metropolitan department	42.6254179	1.8892958	\N
5037	Rhône	75	FR	France	69	metropolitan department	44.93433	4.2409329	\N
4821	Saint Pierre and Miquelon	75	FR	France	PM	overseas collectivity	46.8852	-56.3159	\N
4794	Saint-Barthélemy	75	FR	France	BL	overseas collectivity	17.9005134	-62.8205871	\N
4809	Saint-Martin	75	FR	France	MF	overseas collectivity	18.0708298	-63.0500809	\N
5040	Saône-et-Loire	75	FR	France	71	metropolitan department	46.6554883	3.983505	\N
5041	Sarthe	75	FR	France	72	metropolitan department	48.0262733	-0.3261317	\N
5042	Savoie	75	FR	France	73	metropolitan department	45.494699	5.8432984	\N
5045	Seine-et-Marne	75	FR	France	77	metropolitan department	48.6185394	2.4152561	\N
5044	Seine-Maritime	75	FR	France	76	metropolitan department	49.6609681	0.3677561	\N
5061	Seine-Saint-Denis	75	FR	France	93	metropolitan department	48.9099318	2.3057379	\N
5048	Somme	75	FR	France	80	metropolitan department	49.9685922	1.7310696	\N
5049	Tarn	75	FR	France	81	metropolitan department	43.7914977	1.6758893	\N
5050	Tarn-et-Garonne	75	FR	France	82	metropolitan department	44.080895	1.0891657	\N
5058	Territoire de Belfort	75	FR	France	90	metropolitan department	47.6293072	6.66962	\N
5063	Val-d'Oise	75	FR	France	95	metropolitan department	49.0751818	1.8216914	\N
5062	Val-de-Marne	75	FR	France	94	metropolitan department	48.7747004	2.3221039	\N
5051	Var	75	FR	France	83	metropolitan department	43.395073	5.7342417	\N
5052	Vaucluse	75	FR	France	84	metropolitan department	44.04475	4.6427718	\N
5053	Vendée	75	FR	France	85	metropolitan department	46.6754103	-2.0298392	\N
5054	Vienne	75	FR	France	86	metropolitan department	45.5221314	4.8453136	\N
5056	Vosges	75	FR	France	88	metropolitan department	48.1630173	5.73556	\N
4810	Wallis and Futuna	75	FR	France	WF	overseas collectivity	-14.2938	-178.1165	\N
5057	Yonne	75	FR	France	89	metropolitan department	47.8547614	3.0339404	\N
5046	Yvelines	75	FR	France	78	metropolitan department	48.7615301	1.2772949	\N
2727	Estuaire Province	79	GA	Gabon	1	\N	0.4432864	10.0807298	\N
2726	Haut-Ogooué Province	79	GA	Gabon	2	\N	-1.4762544	13.914399	\N
2730	Moyen-Ogooué Province	79	GA	Gabon	3	\N	-0.442784	10.439656	\N
2731	Ngounié Province	79	GA	Gabon	4	\N	-1.4930303	10.9807003	\N
2725	Nyanga Province	79	GA	Gabon	5	\N	-2.8821033	11.1617356	\N
2724	Ogooué-Ivindo Province	79	GA	Gabon	6	\N	0.8818311	13.1740348	\N
2729	Ogooué-Lolo Province	79	GA	Gabon	7	\N	-0.8844093	12.4380581	\N
2728	Ogooué-Maritime Province	79	GA	Gabon	8	\N	-1.3465975	9.7232673	\N
2723	Woleu-Ntem Province	79	GA	Gabon	9	\N	2.2989827	11.4466914	\N
2666	Banjul	80	GM	Gambia The	B	\N	13.4548761	-16.5790323	\N
2669	Central River Division	80	GM	Gambia The	M	\N	13.5994469	-14.8921668	\N
2670	Lower River Division	80	GM	Gambia The	L	\N	13.3553306	-15.92299	\N
2671	North Bank Division	80	GM	Gambia The	N	\N	13.5285436	-16.0169971	\N
2668	Upper River Division	80	GM	Gambia The	U	\N	13.4257366	-14.0072348	\N
2667	West Coast Division	80	GM	Gambia The	W	\N	5.9772798	116.0754288	\N
900	Adjara	81	GE	Georgia	AJ	\N	41.6005626	42.0688383	\N
901	Autonomous Republic of Abkhazia	81	GE	Georgia	AB	\N	43.0015544	41.023407	\N
907	Guria	81	GE	Georgia	GU	\N	41.9442736	42.0458091	\N
905	Imereti	81	GE	Georgia	IM	\N	42.230108	42.9008664	\N
910	Kakheti	81	GE	Georgia	KA	\N	41.6481602	45.6905554	\N
897	Khelvachauri Municipality	81	GE	Georgia	29	\N	41.5801926	41.6610742	\N
904	Kvemo Kartli	81	GE	Georgia	KK	\N	41.4791833	44.6560451	\N
902	Mtskheta-Mtianeti	81	GE	Georgia	MM	\N	42.1682185	44.6506058	\N
909	Racha-Lechkhumi and Kvemo Svaneti	81	GE	Georgia	RL	\N	42.6718873	43.0562836	\N
908	Samegrelo-Zemo Svaneti	81	GE	Georgia	SZ	\N	42.7352247	42.1689362	\N
906	Samtskhe-Javakheti	81	GE	Georgia	SJ	\N	41.5479296	43.27764	\N
898	Senaki Municipality	81	GE	Georgia	50	\N	42.269636	42.0656896	\N
903	Shida Kartli	81	GE	Georgia	SK	\N	42.0756944	43.9540462	\N
899	Tbilisi	81	GE	Georgia	TB	\N	41.7151377	44.827096	\N
3006	Baden-Württemberg	82	DE	Germany	BW	\N	48.6616037	9.3501336	\N
3009	Bavaria	82	DE	Germany	BY	\N	48.7904472	11.4978895	\N
3010	Berlin	82	DE	Germany	BE	\N	52.5200066	13.404954	\N
3013	Brandenburg	82	DE	Germany	BB	\N	52.4125287	12.5316444	\N
3014	Bremen	82	DE	Germany	HB	\N	53.0792962	8.8016936	\N
3016	Hamburg	82	DE	Germany	HH	\N	53.5510846	9.9936819	\N
3018	Hesse	82	DE	Germany	HE	\N	50.6520515	9.1624376	\N
3007	Mecklenburg-Vorpommern	82	DE	Germany	MV	\N	53.6126505	12.4295953	\N
3017	North Rhine-Westphalia	82	DE	Germany	NW	\N	51.4332367	7.6615938	\N
3019	Rhineland-Palatinate	82	DE	Germany	RP	\N	50.118346	7.3089527	\N
3020	Saarland	82	DE	Germany	SL	\N	49.3964234	7.0229607	\N
3021	Saxony	82	DE	Germany	SN	\N	51.1045407	13.2017384	\N
3011	Saxony-Anhalt	82	DE	Germany	ST	\N	51.9502649	11.6922734	\N
3005	Schleswig-Holstein	82	DE	Germany	SH	\N	54.2193672	9.6961167	\N
3015	Thuringia	82	DE	Germany	TH	\N	51.0109892	10.845346	\N
53	Ahafo	83	GH	Ghana	AF	region	7.5821372	-2.5497463	\N
48	Ashanti	83	GH	Ghana	AH	region	6.7470436	-1.5208624	\N
4959	Bono	83	GH	Ghana	BO	region	7.65	-2.5	\N
4958	Bono East	83	GH	Ghana	BE	region	7.75	-1.05	\N
52	Central	83	GH	Ghana	CP	region	5.5	-1	\N
50	Eastern	83	GH	Ghana	EP	region	6.5	-0.5	\N
54	Greater Accra	83	GH	Ghana	AA	region	5.8142836	0.0746767	\N
4960	North East	83	GH	Ghana	NE	region	10.516667	-0.366667	\N
51	Northern	83	GH	Ghana	NP	region	9.5	-1	\N
4961	Oti	83	GH	Ghana	OT	region	7.9	0.3	\N
4962	Savannah	83	GH	Ghana	SV	region	9.083333	-1.816667	\N
55	Upper East	83	GH	Ghana	UE	region	10.7082499	-0.9820668	\N
57	Upper West	83	GH	Ghana	UW	region	10.2529757	-2.1450245	\N
56	Volta	83	GH	Ghana	TV	region	6.5781373	0.4502368	\N
49	Western	83	GH	Ghana	WP	region	5.5	-2.5	\N
4963	Western North	83	GH	Ghana	WN	region	6.3	-2.8	\N
2116	Achaea Regional Unit	85	GR	Greece	13	\N	38.1158729	21.9522491	\N
2123	Aetolia-Acarnania Regional Unit	85	GR	Greece	01	\N	38.7084386	21.3798928	\N
2098	Arcadia Prefecture	85	GR	Greece	12	\N	37.5557825	22.3337769	\N
2105	Argolis Regional Unit	85	GR	Greece	11	\N	\N	\N	\N
2122	Attica Region	85	GR	Greece	I	\N	38.0457568	23.8584737	\N
2126	Boeotia Regional Unit	85	GR	Greece	03	\N	38.3663664	23.0965064	\N
2128	Central Greece Region	85	GR	Greece	H	\N	38.6043984	22.7152131	\N
2125	Central Macedonia	85	GR	Greece	B	\N	40.621173	23.1918021	\N
2115	Chania Regional Unit	85	GR	Greece	94	\N	35.5138298	24.0180367	\N
2124	Corfu Prefecture	85	GR	Greece	22	\N	39.6249838	19.9223461	\N
2129	Corinthia Regional Unit	85	GR	Greece	15	\N	\N	\N	\N
2109	Crete Region	85	GR	Greece	M	\N	35.240117	24.8092691	\N
2130	Drama Regional Unit	85	GR	Greece	52	\N	41.2340023	24.2390498	\N
2120	East Attica Regional Unit	85	GR	Greece	A2	\N	38.2054093	23.8584737	\N
2117	East Macedonia and Thrace	85	GR	Greece	A	\N	41.1295126	24.8877191	\N
2110	Epirus Region	85	GR	Greece	D	\N	39.5706413	20.7642843	\N
2101	Euboea	85	GR	Greece	04	\N	38.5236036	23.8584737	\N
2102	Grevena Prefecture	85	GR	Greece	51	\N	40.0837626	21.4273299	\N
2099	Imathia Regional Unit	85	GR	Greece	53	\N	40.6060067	22.1430215	\N
2113	Ioannina Regional Unit	85	GR	Greece	33	\N	39.6650288	20.8537466	\N
2131	Ionian Islands Region	85	GR	Greece	F	\N	37.9694898	21.3802372	\N
2095	Karditsa Regional Unit	85	GR	Greece	41	\N	39.3640258	21.9214049	\N
2100	Kastoria Regional Unit	85	GR	Greece	56	\N	40.5192691	21.2687171	\N
2127	Kefalonia Prefecture	85	GR	Greece	23	\N	38.1753675	20.5692179	\N
2111	Kilkis Regional Unit	85	GR	Greece	57	\N	40.9937071	22.8753674	\N
2112	Kozani Prefecture	85	GR	Greece	58	\N	40.3005586	21.7887737	\N
2106	Laconia	85	GR	Greece	16	\N	43.5278546	-71.4703509	\N
2132	Larissa Prefecture	85	GR	Greece	42	\N	39.6390224	22.4191254	\N
2104	Lefkada Regional Unit	85	GR	Greece	24	\N	38.8333663	20.7069108	\N
2107	Pella Regional Unit	85	GR	Greece	59	\N	40.9148039	22.1430215	\N
2119	Peloponnese Region	85	GR	Greece	J	\N	37.5079472	22.37349	\N
2114	Phthiotis Prefecture	85	GR	Greece	06	\N	38.999785	22.3337769	\N
2103	Preveza Prefecture	85	GR	Greece	34	\N	38.9592649	20.7517155	\N
2121	Serres Prefecture	85	GR	Greece	62	\N	41.0863854	23.5483819	\N
2118	South Aegean	85	GR	Greece	L	\N	37.0855302	25.1489215	\N
2097	Thessaloniki Regional Unit	85	GR	Greece	54	\N	40.6400629	22.9444191	\N
2096	West Greece Region	85	GR	Greece	G	\N	38.5115496	21.5706786	\N
2108	West Macedonia Region	85	GR	Greece	C	\N	40.3004058	21.7903559	\N
3867	Carriacou and Petite Martinique	87	GD	Grenada	10	\N	12.4785888	-61.4493842	\N
3865	Saint Andrew Parish	87	GD	Grenada	01	\N	\N	\N	\N
3869	Saint David Parish	87	GD	Grenada	02	\N	\N	\N	\N
3864	Saint George Parish	87	GD	Grenada	03	\N	\N	\N	\N
3868	Saint John Parish	87	GD	Grenada	04	\N	30.1118331	-90.4879916	\N
3866	Saint Mark Parish	87	GD	Grenada	05	\N	40.5881863	-73.9495701	\N
3863	Saint Patrick Parish	87	GD	Grenada	06	\N	\N	\N	\N
3671	Alta Verapaz Department	90	GT	Guatemala	AV	\N	15.5942883	-90.1494988	\N
3674	Baja Verapaz Department	90	GT	Guatemala	BV	\N	15.1255867	-90.3748354	\N
3675	Chimaltenango Department	90	GT	Guatemala	CM	\N	14.5634787	-90.9820668	\N
3666	Chiquimula Department	90	GT	Guatemala	CQ	\N	14.7514999	-89.4742177	\N
3662	El Progreso Department	90	GT	Guatemala	PR	\N	14.9388732	-90.0746767	\N
3677	Escuintla Department	90	GT	Guatemala	ES	\N	14.1910912	-90.9820668	\N
3672	Guatemala Department	90	GT	Guatemala	GU	\N	14.5649401	-90.5257823	\N
3670	Huehuetenango Department	90	GT	Guatemala	HU	\N	15.5879914	-91.6760691	\N
3659	Izabal Department	90	GT	Guatemala	IZ	\N	15.4976517	-88.864698	\N
3658	Jalapa Department	90	GT	Guatemala	JA	\N	14.6121446	-89.9626799	\N
3673	Jutiapa Department	90	GT	Guatemala	JU	\N	14.1930802	-89.9253233	\N
3669	Petén Department	90	GT	Guatemala	PE	\N	16.912033	-90.2995785	\N
3668	Quetzaltenango Department	90	GT	Guatemala	QZ	\N	14.792433	-91.714958	\N
3657	Quiché Department	90	GT	Guatemala	QC	\N	15.4983808	-90.9820668	\N
3664	Retalhuleu Department	90	GT	Guatemala	RE	\N	14.5245485	-91.685788	\N
3676	Sacatepéquez Department	90	GT	Guatemala	SA	\N	14.5178379	-90.7152749	\N
3667	San Marcos Department	90	GT	Guatemala	SM	\N	14.9309569	-91.9099238	\N
3665	Santa Rosa Department	90	GT	Guatemala	SR	\N	38.4405759	-122.7037543	\N
3661	Sololá Department	90	GT	Guatemala	SO	\N	14.748523	-91.2891036	\N
3660	Suchitepéquez Department	90	GT	Guatemala	SU	\N	14.4215982	-91.4048249	\N
3663	Totonicapán Department	90	GT	Guatemala	TO	\N	14.9173402	-91.3613923	\N
2672	Beyla Prefecture	92	GN	Guinea	BE	\N	8.9198178	-8.3088441	\N
2699	Boffa Prefecture	92	GN	Guinea	BF	\N	10.1808254	-14.0391615	\N
2709	Boké Prefecture	92	GN	Guinea	BK	\N	11.0847379	-14.3791912	\N
2676	Boké Region	92	GN	Guinea	B	\N	11.1864672	-14.1001326	\N
2686	Conakry	92	GN	Guinea	C	\N	9.6411855	-13.5784012	\N
2705	Coyah Prefecture	92	GN	Guinea	CO	\N	9.7715535	-13.3125299	\N
2679	Dabola Prefecture	92	GN	Guinea	DB	\N	10.7297806	-11.1107854	\N
2706	Dalaba Prefecture	92	GN	Guinea	DL	\N	10.6868176	-12.2490697	\N
2688	Dinguiraye Prefecture	92	GN	Guinea	DI	\N	11.6844222	-10.8000051	\N
2681	Dubréka Prefecture	92	GN	Guinea	DU	\N	9.7907348	-13.5147735	\N
2682	Faranah Prefecture	92	GN	Guinea	FA	\N	9.9057399	-10.8000051	\N
2683	Forécariah Prefecture	92	GN	Guinea	FO	\N	9.3886187	-13.0817903	\N
2675	Fria Prefecture	92	GN	Guinea	FR	\N	10.3674543	-13.5841871	\N
2685	Gaoual Prefecture	92	GN	Guinea	GA	\N	11.5762804	-13.3587288	\N
2711	Guéckédou Prefecture	92	GN	Guinea	GU	\N	8.5649688	-10.1311163	\N
2704	Kankan Prefecture	92	GN	Guinea	KA	\N	10.3034465	-9.3673084	\N
2697	Kankan Region	92	GN	Guinea	K	\N	10.120923	-9.5450974	\N
2710	Kérouané Prefecture	92	GN	Guinea	KE	\N	9.2536643	-9.0128926	\N
2693	Kindia Prefecture	92	GN	Guinea	KD	\N	10.1013292	-12.7135121	\N
2701	Kindia Region	92	GN	Guinea	D	\N	10.1781694	-12.989615	\N
2691	Kissidougou Prefecture	92	GN	Guinea	KS	\N	9.2252022	-10.0807298	\N
2692	Koubia Prefecture	92	GN	Guinea	KB	\N	11.582354	-11.8920237	\N
2703	Koundara Prefecture	92	GN	Guinea	KN	\N	12.4894021	-13.3067562	\N
2695	Kouroussa Prefecture	92	GN	Guinea	KO	\N	10.6489229	-9.8850586	\N
2680	Labé Prefecture	92	GN	Guinea	LA	\N	11.3541939	-12.3463875	\N
2677	Labé Region	92	GN	Guinea	L	\N	11.3232042	-12.2891314	\N
2690	Lélouma Prefecture	92	GN	Guinea	LE	\N	11.183333	-12.933333	\N
2708	Lola Prefecture	92	GN	Guinea	LO	\N	7.9613818	-8.3964938	\N
2702	Macenta Prefecture	92	GN	Guinea	MC	\N	8.4615795	-9.2785583	\N
2700	Mali Prefecture	92	GN	Guinea	ML	\N	11.983709	-12.2547919	\N
2689	Mamou Prefecture	92	GN	Guinea	MM	\N	10.5736024	-11.8891721	\N
2698	Mamou Region	92	GN	Guinea	M	\N	10.5736024	-11.8891721	\N
2673	Mandiana Prefecture	92	GN	Guinea	MD	\N	10.6172827	-8.6985716	\N
2678	Nzérékoré Prefecture	92	GN	Guinea	NZ	\N	7.7478359	-8.8252502	\N
2684	Nzérékoré Region	92	GN	Guinea	N	\N	8.038587	-8.8362755	\N
2694	Pita Prefecture	92	GN	Guinea	PI	\N	10.8062086	-12.7135121	\N
2707	Siguiri Prefecture	92	GN	Guinea	SI	\N	11.4148113	-9.1788304	\N
2687	Télimélé Prefecture	92	GN	Guinea	TE	\N	10.9089364	-13.0299331	\N
2696	Tougué Prefecture	92	GN	Guinea	TO	\N	11.3841583	-11.6157773	\N
2674	Yomou Prefecture	92	GN	Guinea	YO	\N	7.5696279	-9.2591571	\N
2720	Bafatá	93	GW	Guinea-Bissau	BA	\N	12.1735243	-14.652952	\N
2714	Biombo Region	93	GW	Guinea-Bissau	BM	\N	11.8529061	-15.7351171	\N
2722	Bolama Region	93	GW	Guinea-Bissau	BL	\N	11.1480591	-16.1345705	\N
2713	Cacheu Region	93	GW	Guinea-Bissau	CA	\N	12.0551416	-16.0640179	\N
2719	Gabú Region	93	GW	Guinea-Bissau	GA	\N	11.8962488	-14.1001326	\N
2721	Leste Province	93	GW	Guinea-Bissau	L	\N	\N	\N	\N
2717	Norte Province	93	GW	Guinea-Bissau	N	\N	7.8721811	123.8857747	\N
2718	Oio Region	93	GW	Guinea-Bissau	OI	\N	12.2760709	-15.3131185	\N
2715	Quinara Region	93	GW	Guinea-Bissau	QU	\N	11.795562	-15.1726816	\N
2716	Sul Province	93	GW	Guinea-Bissau	S	\N	-10.2866578	20.7122465	\N
2712	Tombali Region	93	GW	Guinea-Bissau	TO	\N	11.3632696	-14.9856176	\N
2764	Barima-Waini	94	GY	Guyana	BA	\N	7.4882419	-59.6564494	\N
2760	Cuyuni-Mazaruni	94	GY	Guyana	CU	\N	6.4642141	-60.2110752	\N
2767	Demerara-Mahaica	94	GY	Guyana	DE	\N	6.546426	-58.0982046	\N
2766	East Berbice-Corentyne	94	GY	Guyana	EB	\N	2.7477922	-57.4627259	\N
2768	Essequibo Islands-West Demerara	94	GY	Guyana	ES	\N	6.5720132	-58.4629997	\N
2762	Mahaica-Berbice	94	GY	Guyana	MA	\N	6.238496	-57.9162555	\N
2765	Pomeroon-Supenaam	94	GY	Guyana	PM	\N	7.1294166	-58.9206295	\N
2761	Potaro-Siparuni	94	GY	Guyana	PT	\N	4.7855853	-59.2879977	\N
2763	Upper Demerara-Berbice	94	GY	Guyana	UD	\N	5.3064879	-58.1892921	\N
2769	Upper Takutu-Upper Essequibo	94	GY	Guyana	UT	\N	2.9239595	-58.7373634	\N
4123	Artibonite	95	HT	Haiti	AR	\N	19.362902	-72.4258145	\N
4125	Centre	95	HT	Haiti	CE	\N	32.8370251	-96.7773882	\N
4119	Grand'Anse	95	HT	Haiti	GA	\N	12.0166667	-61.7666667	\N
4118	Nippes	95	HT	Haiti	NI	\N	18.3990735	-73.4180211	\N
4117	Nord	95	HT	Haiti	ND	\N	43.190526	-89.437921	\N
4121	Nord-Est	95	HT	Haiti	NE	\N	19.4889723	-71.8571331	\N
4126	Nord-Ouest	95	HT	Haiti	NO	\N	19.8374009	-73.0405277	\N
4120	Ouest	95	HT	Haiti	OU	\N	45.4547249	-73.6502365	\N
4122	Sud	95	HT	Haiti	SD	\N	29.9213248	-90.0973772	\N
4124	Sud-Est	95	HT	Haiti	SE	\N	18.2783598	-72.3547915	\N
4047	Atlántida Department	97	HN	Honduras	AT	\N	15.6696283	-87.1422895	\N
4045	Bay Islands Department	97	HN	Honduras	IB	\N	16.4826614	-85.8793252	\N
4041	Choluteca Department	97	HN	Honduras	CH	\N	13.2504325	-87.1422895	\N
4051	Colón Department	97	HN	Honduras	CL	\N	15.6425965	-85.520024	\N
4042	Comayagua Department	97	HN	Honduras	CM	\N	14.5534828	-87.6186379	\N
4049	Copán Department	97	HN	Honduras	CP	\N	14.9360838	-88.864698	\N
4046	Cortés Department	97	HN	Honduras	CR	\N	15.4923508	-88.0900762	\N
4043	El Paraíso Department	97	HN	Honduras	EP	\N	13.9821294	-86.4996546	\N
4052	Francisco Morazán Department	97	HN	Honduras	FM	\N	14.45411	-87.0624261	\N
4048	Gracias a Dios Department	97	HN	Honduras	GD	\N	15.341806	-84.6060449	\N
4044	Intibucá Department	97	HN	Honduras	IN	\N	14.372734	-88.2461183	\N
4058	La Paz Department	97	HN	Honduras	LP	\N	-15.0892416	-68.5247149	\N
4054	Lempira Department	97	HN	Honduras	LE	\N	14.1887698	-88.556531	\N
4056	Ocotepeque Department	97	HN	Honduras	OC	\N	14.5170347	-89.0561532	\N
4050	Olancho Department	97	HN	Honduras	OL	\N	14.8067406	-85.7666645	\N
4053	Santa Bárbara Department	97	HN	Honduras	SB	\N	15.1202795	-88.4016041	\N
4055	Valle Department	97	HN	Honduras	VA	\N	13.5782936	-87.5791287	\N
4057	Yoro Department	97	HN	Honduras	YO	\N	15.2949679	-87.1422895	\N
4889	Central and Western District	98	HK	Hong Kong S.A.R.	HCW	\N	22.28666	114.15497	\N
4891	Eastern	98	HK	Hong Kong S.A.R.	HEA	\N	22.28411	114.22414	\N
4888	Islands District	98	HK	Hong Kong S.A.R.	NIS	\N	22.26114	113.94608	\N
4895	Kowloon City	98	HK	Hong Kong S.A.R.	KKC	\N	22.3282	114.19155	\N
4898	Kwai Tsing	98	HK	Hong Kong S.A.R.	NKT	\N	22.35488	114.08401	\N
4897	Kwun Tong	98	HK	Hong Kong S.A.R.	KKT	\N	22.31326	114.22581	\N
4900	North	98	HK	Hong Kong S.A.R.	NNO	\N	22.49471	114.13812	\N
4887	Sai Kung District	98	HK	Hong Kong S.A.R.	NSK	\N	22.38143	114.27052	\N
4901	Sha Tin	98	HK	Hong Kong S.A.R.	NST	\N	22.38715	114.19534	\N
4894	Sham Shui Po	98	HK	Hong Kong S.A.R.	KSS	\N	22.33074	114.1622	\N
4892	Southern	98	HK	Hong Kong S.A.R.	HSO	\N	22.24725	114.15884	\N
4885	Tai Po District	98	KH	Hong Kong S.A.R.	NTP	\N	22.45085	114.16422	\N
4884	Tsuen Wan District	98	HK	Hong Kong S.A.R.	NTW	\N	22.36281	114.12907	\N
4899	Tuen Mun	98	HK	Hong Kong S.A.R.	NTM	\N	22.39163	113.9770885	\N
4890	Wan Chai	98	HK	Hong Kong S.A.R.	HWC	\N	22.27968	114.17168	\N
4896	Wong Tai Sin	98	HK	Hong Kong S.A.R.	KWT	\N	22.33353	114.19686	\N
4893	Yau Tsim Mong	98	HK	Hong Kong S.A.R.	KYT	\N	22.32138	114.1726	\N
4883	Yuen Long District	98	HK	Hong Kong S.A.R.	NYL	\N	22.44559	114.02218	\N
1048	Bács-Kiskun	99	HU	Hungary	BK	county	46.5661437	19.4272464	\N
1055	Baranya	99	HU	Hungary	BA	county	46.0484585	18.2719173	\N
1060	Békés	99	HU	Hungary	BE	county	46.6704899	21.0434996	\N
1036	Békéscsaba	99	HU	Hungary	BC	city with county rights	46.6735939	21.0877309	\N
1058	Borsod-Abaúj-Zemplén	99	HU	Hungary	BZ	county	48.2939401	20.6934112	\N
1064	Budapest	99	HU	Hungary	BU	capital city	47.497912	19.040235	\N
1031	Csongrád County	99	HU	Hungary	CS	county	46.416705	20.2566161	\N
1032	Debrecen	99	HU	Hungary	DE	city with county rights	47.5316049	21.6273124	\N
1049	Dunaújváros	99	HU	Hungary	DU	city with county rights	46.9619059	18.9355227	\N
1037	Eger	99	HU	Hungary	EG	city with county rights	47.9025348	20.3772284	\N
1028	Érd	99	HU	Hungary	ER	city with county rights	47.3919718	18.904544	\N
1044	Fejér County	99	HU	Hungary	FE	county	47.1217932	18.5294815	\N
1041	Győr	99	HU	Hungary	GY	city with county rights	47.6874569	17.6503974	\N
1042	Győr-Moson-Sopron County	99	HU	Hungary	GS	county	47.6509285	17.2505883	\N
1063	Hajdú-Bihar County	99	HU	Hungary	HB	county	47.4688355	21.5453227	\N
1040	Heves County	99	HU	Hungary	HE	county	47.8057617	20.2038559	\N
1027	Hódmezővásárhely	99	HU	Hungary	HV	city with county rights	46.4181262	20.3300315	\N
1043	Jász-Nagykun-Szolnok County	99	HU	Hungary	JN	county	47.2555579	20.5232456	\N
1067	Kaposvár	99	HU	Hungary	KV	city with county rights	46.3593606	17.7967639	\N
1056	Kecskemét	99	HU	Hungary	KM	city with county rights	46.8963711	19.6896861	\N
5085	Komárom-Esztergom	99	HU	Hungary	KE	county	47.5779786	18.1256855	\N
1065	Miskolc	99	HU	Hungary	MI	city with county rights	48.1034775	20.7784384	\N
1030	Nagykanizsa	99	HU	Hungary	NK	city with county rights	46.4590218	16.9896796	\N
1051	Nógrád County	99	HU	Hungary	NO	county	47.9041031	19.0498504	\N
1034	Nyíregyháza	99	HU	Hungary	NY	city with county rights	47.9495324	21.7244053	\N
1053	Pécs	99	HU	Hungary	PS	city with county rights	46.0727345	18.232266	\N
1059	Pest County	99	HU	Hungary	PE	county	47.4480001	19.4618128	\N
1068	Salgótarján	99	HU	Hungary	ST	city with county rights	48.0935237	19.7999813	\N
1035	Somogy County	99	HU	Hungary	SO	county	46.554859	17.5866732	\N
1057	Sopron	99	HU	Hungary	SN	city with county rights	47.6816619	16.5844795	\N
1045	Szabolcs-Szatmár-Bereg County	99	HU	Hungary	SZ	county	48.0394954	22.00333	\N
1029	Szeged	99	HU	Hungary	SD	city with county rights	46.2530102	20.1414253	\N
1033	Székesfehérvár	99	HU	Hungary	SF	city with county rights	47.1860262	18.4221358	\N
1061	Szekszárd	99	HU	Hungary	SS	city with county rights	46.3474326	18.7062293	\N
1047	Szolnok	99	HU	Hungary	SK	city with county rights	47.1621355	20.1824712	\N
1052	Szombathely	99	HU	Hungary	SH	city with county rights	47.2306851	16.6218441	\N
1066	Tatabánya	99	HU	Hungary	TB	city with county rights	47.569246	18.404818	\N
1038	Tolna County	99	HU	Hungary	TO	county	46.4762754	18.5570627	\N
1039	Vas County	99	HU	Hungary	VA	county	47.0929111	16.6812183	\N
1062	Veszprém	99	HU	Hungary	VM	city with county rights	47.1028087	17.9093019	\N
1054	Veszprém County	99	HU	Hungary	VE	county	47.0930974	17.9100763	\N
1046	Zala County	99	HU	Hungary	ZA	county	46.7384404	16.9152252	\N
1050	Zalaegerszeg	99	HU	Hungary	ZE	county	46.8416936	16.8416322	\N
3431	Capital Region	100	IS	Iceland	1	\N	38.5656957	-92.1816949	\N
3433	Eastern Region	100	IS	Iceland	7	\N	\N	\N	\N
3437	Northeastern Region	100	IS	Iceland	6	\N	43.2994285	-74.2179326	\N
3435	Northwestern Region	100	IS	Iceland	5	\N	41.9133932	-73.0471688	\N
3430	Southern Peninsula Region	100	IS	Iceland	2	\N	63.9154803	-22.3649667	\N
3434	Southern Region	100	IS	Iceland	8	\N	\N	\N	\N
3436	Western Region	100	IS	Iceland	3	\N	\N	\N	\N
3432	Westfjords	100	IS	Iceland	4	\N	65.919615	-21.8811764	\N
4023	Andaman and Nicobar Islands	101	IN	India	AN	Union territory	11.7400867	92.6586401	\N
4017	Andhra Pradesh	101	IN	India	AP	state	15.9128998	79.7399875	\N
4024	Arunachal Pradesh	101	IN	India	AR	state	28.2179994	94.7277528	\N
4027	Assam	101	IN	India	AS	state	26.2006043	92.9375739	\N
4037	Bihar	101	IN	India	BR	state	25.0960742	85.3131194	\N
4031	Chandigarh	101	IN	India	CH	Union territory	30.7333148	76.7794179	\N
4040	Chhattisgarh	101	IN	India	CT	state	21.2786567	81.8661442	\N
4033	Dadra and Nagar Haveli and Daman and Diu	101	IN	India	DH	Union territory	20.3973736	72.8327991	\N
4021	Delhi	101	IN	India	DL	Union territory	28.7040592	77.1024902	\N
4009	Goa	101	IN	India	GA	state	15.2993265	74.123996	\N
4030	Gujarat	101	IN	India	GJ	state	22.258652	71.1923805	\N
4007	Haryana	101	IN	India	HR	state	29.0587757	76.085601	\N
4020	Himachal Pradesh	101	IN	India	HP	state	31.1048294	77.1733901	\N
4029	Jammu and Kashmir	101	IN	India	JK	Union territory	33.277839	75.3412179	\N
4025	Jharkhand	101	IN	India	JH	state	23.6101808	85.2799354	\N
4026	Karnataka	101	IN	India	KA	state	15.3172775	75.7138884	\N
4028	Kerala	101	IN	India	KL	state	10.8505159	76.2710833	\N
4852	Ladakh	101	IN	India	LA	Union territory	34.2268475	77.5619419	\N
4019	Lakshadweep	101	IN	India	LD	Union territory	10.3280265	72.7846336	\N
4039	Madhya Pradesh	101	IN	India	MP	state	22.9734229	78.6568942	\N
4008	Maharashtra	101	IN	India	MH	state	19.7514798	75.7138884	\N
4010	Manipur	101	IN	India	MN	state	24.6637173	93.9062688	\N
4006	Meghalaya	101	IN	India	ML	state	25.4670308	91.366216	\N
4036	Mizoram	101	IN	India	MZ	state	23.164543	92.9375739	\N
4018	Nagaland	101	IN	India	NL	state	26.1584354	94.5624426	\N
4013	Odisha	101	IN	India	OR	state	20.9516658	85.0985236	\N
4011	Puducherry	101	IN	India	PY	Union territory	11.9415915	79.8083133	\N
4015	Punjab	101	IN	India	PB	state	31.1471305	75.3412179	\N
4014	Rajasthan	101	IN	India	RJ	state	27.0238036	74.2179326	\N
4034	Sikkim	101	IN	India	SK	state	27.5329718	88.5122178	\N
4035	Tamil Nadu	101	IN	India	TN	state	11.1271225	78.6568942	\N
4012	Telangana	101	IN	India	TG	state	18.1124372	79.0192997	\N
4038	Tripura	101	IN	India	TR	state	23.9408482	91.9881527	\N
4022	Uttar Pradesh	101	IN	India	UP	state	26.8467088	80.9461592	\N
4016	Uttarakhand	101	IN	India	UT	state	30.066753	79.0192997	\N
4853	West Bengal	101	IN	India	WB	state	22.9867569	87.8549755	\N
1822	Aceh	102	ID	Indonesia	AC	province	4.695135	96.7493993	\N
1826	Bali	102	ID	Indonesia	BA	province	-8.3405389	115.0919509	\N
1810	Banten	102	ID	Indonesia	BT	province	-6.4058172	106.0640179	\N
1793	Bengkulu	102	ID	Indonesia	BE	province	-3.7928451	102.2607641	\N
1829	DI Yogyakarta	102	ID	Indonesia	YO	province	-7.8753849	110.4262088	\N
1805	DKI Jakarta	102	ID	Indonesia	JK	capital district	-6.2087634	106.845599	\N
1812	Gorontalo	102	ID	Indonesia	GO	province	0.5435442	123.0567693	\N
1815	Jambi	102	ID	Indonesia	JA	province	-1.6101229	103.6131203	\N
1825	Jawa Barat	102	ID	Indonesia	JB	province	-7.090911	107.668887	\N
1802	Jawa Tengah	102	ID	Indonesia	JT	province	-7.150975	110.1402594	\N
1827	Jawa Timur	102	ID	Indonesia	JI	province	-7.5360639	112.2384017	\N
1806	Kalimantan Barat	102	ID	Indonesia	KB	province	0.4773475	106.6131405	\N
1819	Kalimantan Selatan	102	ID	Indonesia	KS	province	-3.0926415	115.2837585	\N
1794	Kalimantan Tengah	102	ID	Indonesia	KT	province	-1.6814878	113.3823545	\N
1804	Kalimantan Timur	102	ID	Indonesia	KI	province	0.5386586	116.419389	\N
1824	Kalimantan Utara	102	ID	Indonesia	KU	province	3.0730929	116.0413889	\N
1820	Kepulauan Bangka Belitung	102	ID	Indonesia	BB	province	-2.7410513	106.4405872	\N
1807	Kepulauan Riau	102	ID	Indonesia	KR	province	3.9456514	108.1428669	\N
1811	Lampung	102	ID	Indonesia	LA	province	-4.5585849	105.4068079	\N
1800	Maluku	102	ID	Indonesia	MA	province	-3.2384616	130.1452734	\N
1801	Maluku Utara	102	ID	Indonesia	MU	province	1.5709993	127.8087693	\N
1814	Nusa Tenggara Barat	102	ID	Indonesia	NB	province	-8.6529334	117.3616476	\N
1818	Nusa Tenggara Timur	102	ID	Indonesia	NT	province	-8.6573819	121.0793705	\N
1798	Papua	102	ID	Indonesia	PA	province	-5.0122202	141.3470159	\N
1799	Papua Barat	102	ID	Indonesia	PB	province	-1.3361154	133.1747162	\N
1809	Riau	102	ID	Indonesia	RI	province	0.2933469	101.7068294	\N
1817	Sulawesi Barat	102	ID	Indonesia	SR	province	-2.8441371	119.2320784	\N
1795	Sulawesi Selatan	102	ID	Indonesia	SN	province	-3.6687994	119.9740534	\N
1813	Sulawesi Tengah	102	ID	Indonesia	ST	province	-1.4300254	121.4456179	\N
1796	Sulawesi Tenggara	102	ID	Indonesia	SG	province	-4.14491	122.174605	\N
1808	Sulawesi Utara	102	ID	Indonesia	SA	province	0.6246932	123.9750018	\N
1828	Sumatera Barat	102	ID	Indonesia	SB	province	-0.7399397	100.8000051	\N
1816	Sumatera Selatan	102	ID	Indonesia	SS	province	-3.3194374	103.914399	\N
1792	Sumatera Utara	102	ID	Indonesia	SU	province	2.1153547	99.5450974	\N
3929	Alborz	103	IR	Iran	30	province	35.9960467	50.9289246	\N
3934	Ardabil	103	IR	Iran	24	province	38.4853276	47.8911209	\N
3932	Bushehr	103	IR	Iran	18	province	28.7620739	51.5150077	\N
3921	Chaharmahal and Bakhtiari	103	IR	Iran	14	province	31.9970419	50.6613849	\N
3944	East Azerbaijan	103	IR	Iran	03	province	37.9035733	46.2682109	\N
3939	Fars	103	IR	Iran	07	province	29.1043813	53.045893	\N
3920	Gilan	103	IR	Iran	01	province	37.2809455	49.5924134	\N
3933	Golestan	103	IR	Iran	27	province	37.2898123	55.1375834	\N
4920	Hamadan	103	IR	Iran	13	province	34.9193607	47.4832925	\N
3937	Hormozgan	103	IR	Iran	22	province	27.138723	55.1375834	\N
3918	Ilam	103	IR	Iran	16	province	33.2957618	46.670534	\N
3923	Isfahan	103	IR	Iran	10	province	33.2771073	52.3613378	\N
3943	Kerman	103	IR	Iran	08	province	29.4850089	57.6439048	\N
3919	Kermanshah	103	IR	Iran	05	province	34.4576233	46.670534	\N
3917	Khuzestan	103	IR	Iran	06	province	31.4360149	49.041312	\N
3926	Kohgiluyeh and Boyer-Ahmad	103	IR	Iran	17	province	30.724586	50.8456323	\N
3935	Kurdistan	103	IR	Iran	12	province	35.9553579	47.1362125	\N
3928	Lorestan	103	IR	Iran	15	province	33.5818394	48.3988186	\N
3916	Markazi	103	IR	Iran	00	province	34.612305	49.8547266	\N
3938	Mazandaran	103	IR	Iran	02	province	36.2262393	52.5318604	\N
3942	North Khorasan	103	IR	Iran	28	province	37.4710353	57.1013188	\N
3941	Qazvin	103	IR	Iran	26	province	36.0881317	49.8547266	\N
3922	Qom	103	IR	Iran	25	province	34.6415764	50.8746035	\N
3927	Razavi Khorasan	103	IR	Iran	09	province	35.1020253	59.1041758	\N
3940	Semnan	103	IR	Iran	20	province	35.2255585	54.4342138	\N
3931	Sistan and Baluchestan	103	IR	Iran	11	province	27.5299906	60.5820676	\N
3930	South Khorasan	103	IR	Iran	29	province	32.5175643	59.1041758	\N
3945	Tehran	103	IR	Iran	23	province	35.7248416	51.381653	\N
3924	West Azarbaijan	103	IR	Iran	04	province	37.4550062	45	\N
3936	Yazd	103	IR	Iran	21	province	32.1006387	54.4342138	\N
3925	Zanjan	103	IR	Iran	19	province	36.5018185	48.3988186	\N
3964	Al Anbar	104	IQ	Iraq	AN	governorate	32.5597614	41.9196471	\N
3958	Al Muthanna	104	IQ	Iraq	MU	governorate	29.9133171	45.2993862	\N
3956	Al-Qādisiyyah	104	IQ	Iraq	QA	governorate	32.043691	45.1494505	\N
3955	Babylon	104	IQ	Iraq	BB	governorate	32.468191	44.5501935	\N
3959	Baghdad	104	IQ	Iraq	BG	governorate	33.3152618	44.3660653	\N
3960	Basra	104	IQ	Iraq	BA	governorate	30.5114252	47.8296253	\N
3954	Dhi Qar	104	IQ	Iraq	DQ	governorate	31.1042292	46.3624686	\N
3965	Diyala	104	IQ	Iraq	DI	governorate	33.7733487	45.1494505	\N
3967	Dohuk	104	IQ	Iraq	DA	governorate	36.9077252	43.0631689	\N
3968	Erbil	104	IQ	Iraq	AR	governorate	36.5570628	44.3851263	\N
3957	Karbala	104	IQ	Iraq	KA	governorate	32.4045493	43.8673222	\N
3971	Kirkuk	104	IQ	Iraq	KI	governorate	35.3292014	43.9436788	\N
3966	Maysan	104	IQ	Iraq	MA	governorate	31.8734002	47.1362125	\N
3962	Najaf	104	IQ	Iraq	NA	governorate	31.3517486	44.0960311	\N
3963	Nineveh	104	IQ	Iraq	NI	governorate	36.229574	42.2362435	\N
3961	Saladin	104	IQ	Iraq	SD	governorate	34.5337527	43.483738	\N
3969	Sulaymaniyah	104	IQ	Iraq	SU	governorate	35.5466348	45.3003683	\N
3970	Wasit	104	IQ	Iraq	WA	governorate	32.6024094	45.7520985	\N
1095	Carlow	105	IE	Ireland	CW	county	52.7232217	-6.8108295	\N
1088	Cavan	105	IE	Ireland	CN	county	53.9765424	-7.2996623	\N
1091	Clare	105	IE	Ireland	CE	county	43.04664	-87.899581	\N
1087	Connacht	105	IE	Ireland	C	province	53.8376243	-8.9584481	\N
1074	Cork	105	IE	Ireland	CO	county	51.8985143	-8.4756035	\N
1071	Donegal	105	IE	Ireland	DL	county	54.6548993	-8.1040967	\N
1072	Dublin	105	IE	Ireland	D	county	53.3498053	-6.2603097	\N
1079	Galway	105	IE	Ireland	G	county	53.3564509	-8.8534113	\N
1077	Kerry	105	IE	Ireland	KY	county	52.1544607	-9.5668633	\N
1082	Kildare	105	IE	Ireland	KE	county	53.2120434	-6.8194708	\N
1090	Kilkenny	105	IE	Ireland	KK	county	52.5776957	-7.218002	\N
1096	Laois	105	IE	Ireland	LS	county	52.994295	-7.3323007	\N
1073	Leinster	105	IE	Ireland	L	province	53.3271538	-7.5140841	\N
1094	Limerick	105	IE	Ireland	LK	county	52.5090517	-8.7474955	\N
1076	Longford	105	IE	Ireland	LD	county	53.7274982	-7.7931527	\N
1083	Louth	105	IE	Ireland	LH	county	53.9252324	-6.4889423	\N
1084	Mayo	105	IE	Ireland	MO	county	54.0152604	-9.4289369	\N
1092	Meath	105	IE	Ireland	MH	county	53.605548	-6.6564169	\N
1075	Monaghan	105	IE	Ireland	MN	county	54.2492046	-6.9683132	\N
1080	Munster	105	IE	Ireland	M	province	51.9471197	7.584532	\N
1078	Offaly	105	IE	Ireland	OY	county	53.2356871	-7.7122229	\N
1081	Roscommon	105	IE	Ireland	RN	county	53.7592604	-8.2681621	\N
1070	Sligo	105	IE	Ireland	SO	county	54.1553277	-8.6064532	\N
1069	Tipperary	105	IE	Ireland	TA	county	52.4737894	-8.1618514	\N
1086	Ulster	105	IE	Ireland	U	province	54.7616555	-6.9612273	\N
1089	Waterford	105	IE	Ireland	WD	county	52.1943549	-7.6227512	\N
1097	Westmeath	105	IE	Ireland	WH	county	53.5345308	-7.4653217	\N
1093	Wexford	105	IE	Ireland	WX	county	52.4793603	-6.5839913	\N
1085	Wicklow	105	IE	Ireland	WW	county	52.9862313	-6.3672543	\N
1367	Central District	106	IL	Israel	M	\N	47.6087583	-122.2964235	\N
1369	Haifa District	106	IL	Israel	HA	\N	32.4814111	34.994751	\N
1370	Jerusalem District	106	IL	Israel	JM	\N	31.7648243	34.994751	\N
1366	Northern District	106	IL	Israel	Z	\N	36.1511864	-95.9951763	\N
1368	Southern District	106	IL	Israel	D	\N	40.7137586	-74.0009059	\N
1371	Tel Aviv District	106	IL	Israel	TA	\N	32.0929075	34.8072165	\N
1679	Abruzzo	107	IT	Italy	65	region	42.1920119	13.7289167	\N
1727	Agrigento	107	IT	Italy	AG	free municipal consortium	37.3105202	13.5857978	\N
1783	Alessandria	107	IT	Italy	AL	province	44.8175587	8.7046627	\N
1672	Ancona	107	IT	Italy	AN	province	43.5493245	13.2663479	\N
1716	Aosta Valley	107	IT	Italy	23	autonomous region	45.7388878	7.4261866	\N
1688	Apulia	107	IT	Italy	75	region	40.7928393	17.1011931	\N
1681	Ascoli Piceno	107	IT	Italy	AP	province	42.8638933	13.5899733	\N
1780	Asti	107	IT	Italy	AT	province	44.9007652	8.2064315	\N
1692	Avellino	107	IT	Italy	AV	province	40.996451	15.1258955	\N
1772	Bari	107	IT	Italy	BA	metropolitan city	41.1171432	16.8718715	\N
1686	Barletta-Andria-Trani	107	IT	Italy	BT	province	41.2004543	16.2051484	\N
1706	Basilicata	107	IT	Italy	77	region	40.6430766	15.9699878	\N
1689	Belluno	107	IT	Italy	BL	province	46.2497659	12.1969565	\N
1701	Benevento	107	IT	Italy	BN	province	41.2035093	14.7520939	\N
1704	Bergamo	107	IT	Italy	BG	province	45.6982642	9.6772698	\N
1778	Biella	107	IT	Italy	BI	province	45.5628176	8.0582717	\N
1684	Bologna	107	IT	Italy	BO	metropolitan city	44.494887	11.3426162	\N
1717	Brescia	107	IT	Italy	BS	province	45.5415526	10.2118019	\N
1714	Brindisi	107	IT	Italy	BR	province	40.6112663	17.763621	\N
1682	Cagliari	107	IT	Italy	CA	metropolitan city	39.2238411	9.1216613	\N
1703	Calabria	107	IT	Italy	78	region	39.3087714	16.3463791	\N
1718	Caltanissetta	107	IT	Italy	CL	free municipal consortium	37.486013	14.0614982	\N
1669	Campania	107	IT	Italy	72	region	40.6670887	15.1068113	\N
1721	Campobasso	107	IT	Italy	CB	province	41.6738865	14.7520939	\N
1731	Caserta	107	IT	Italy	CE	province	41.2078354	14.1001326	\N
1766	Catania	107	IT	Italy	CT	metropolitan city	37.4515438	15.0557415	\N
1728	Catanzaro	107	IT	Italy	CZ	province	38.8896348	16.4405872	\N
1739	Chieti	107	IT	Italy	CH	province	42.0334428	14.3791912	\N
1740	Como	107	IT	Italy	CO	province	45.8080416	9.0851793	\N
1742	Cosenza	107	IT	Italy	CS	province	39.5644105	16.2522143	\N
1751	Cremona	107	IT	Italy	CR	province	45.2014375	9.9836582	\N
1754	Crotone	107	IT	Italy	KR	province	39.1309856	17.0067031	\N
1775	Cuneo	107	IT	Italy	CN	province	44.5970314	7.6114217	\N
1773	Emilia-Romagna	107	IT	Italy	45	region	44.5967607	11.2186396	\N
1723	Enna	107	IT	Italy	EN	free municipal consortium	37.5676216	14.2795349	\N
1744	Fermo	107	IT	Italy	FM	province	43.0931367	13.5899733	\N
1746	Ferrara	107	IT	Italy	FE	province	44.766368	11.7644068	\N
1680	Florence	107	IT	Italy	FI	metropolitan city	43.7679178	11.2523792	\N
1771	Foggia	107	IT	Italy	FG	province	41.638448	15.5943388	\N
1779	Forlì-Cesena	107	IT	Italy	FC	province	43.9947681	11.9804613	\N
1756	Friuli–Venezia Giulia	107	IT	Italy	36	autonomous region	46.2259177	13.1033646	\N
1776	Frosinone	107	IT	Italy	FR	province	41.6576528	13.6362715	\N
1699	Genoa	107	IT	Italy	GE	metropolitan city	44.4056493	8.9462564	\N
1777	Gorizia	107	IT	Italy	GO	decentralized regional entity	45.9053899	13.5163725	\N
1787	Grosseto	107	IT	Italy	GR	province	42.8518007	11.2523792	\N
1788	Imperia	107	IT	Italy	IM	province	43.941866	7.8286368	\N
1789	Isernia	107	IT	Italy	IS	province	41.5891555	14.1930918	\N
1781	L'Aquila	107	IT	Italy	AQ	province	42.1256317	13.6362715	\N
1791	La Spezia	107	IT	Italy	SP	province	44.2447913	9.7678687	\N
1674	Latina	107	IT	Italy	LT	province	41.4087476	13.0817903	\N
1678	Lazio	107	IT	Italy	62	region	45.6991667	-73.6558333	\N
1675	Lecce	107	IT	Italy	LE	province	40.2347393	18.1428669	\N
1677	Lecco	107	IT	Italy	LC	province	45.9382941	9.385729	\N
1768	Liguria	107	IT	Italy	42	region	44.3167917	8.3964938	\N
1745	Livorno	107	IT	Italy	LI	province	43.0239848	10.6647101	\N
1747	Lodi	107	IT	Italy	LO	province	45.2405036	9.5292512	\N
1705	Lombardy	107	IT	Italy	25	region	45.4790671	9.8452433	\N
1749	Lucca	107	IT	Italy	LU	province	43.8376736	10.495053	\N
1750	Macerata	107	IT	Italy	MC	province	43.2459322	13.2663479	\N
1758	Mantua	107	IT	Italy	MN	province	45.1667728	10.7753613	\N
1670	Marche	107	IT	Italy	57	region	30.556707	-81.449303	\N
1759	Massa and Carrara	107	IT	Italy	MS	province	44.2213998	10.0359661	\N
1760	Matera	107	IT	Italy	MT	province	40.6663496	16.6043636	\N
1761	Medio Campidano	107	IT	Italy	VS	province	39.5317389	8.704075	\N
1770	Messina	107	IT	Italy	ME	metropolitan city	38.1937335	15.5542057	\N
1698	Milan	107	IT	Italy	MI	metropolitan city	45.458626	9.181873	\N
1757	Modena	107	IT	Italy	MO	province	44.5513799	10.918048	\N
1695	Molise	107	IT	Italy	67	region	41.6738865	14.7520939	\N
1769	Monza and Brianza	107	IT	Italy	MB	province	45.623599	9.2588015	\N
1724	Naples	107	IT	Italy	NA	metropolitan city	40.901975	14.332644	\N
1774	Novara	107	IT	Italy	NO	province	45.5485133	8.5150793	\N
1790	Nuoro	107	IT	Italy	NU	province	40.3286904	9.456155	\N
1786	Oristano	107	IT	Italy	OR	province	40.0599068	8.7481167	\N
1665	Padua	107	IT	Italy	PD	province	45.3661864	11.8209139	\N
1668	Palermo	107	IT	Italy	PA	province	38.11569	13.3614868	\N
1666	Parma	107	IT	Italy	PR	province	44.8015322	10.3279354	\N
1676	Pavia	107	IT	Italy	PV	province	45.3218166	8.8466236	\N
1691	Perugia	107	IT	Italy	PG	province	42.938004	12.6216211	\N
1693	Pesaro and Urbino	107	IT	Italy	PU	province	43.6130118	12.7135121	\N
1694	Pescara	107	IT	Italy	PE	province	42.3570655	13.9608091	\N
1696	Piacenza	107	IT	Italy	PC	province	44.8263112	9.5291447	\N
1702	Piedmont	107	IT	Italy	21	region	45.0522366	7.5153885	\N
1685	Pisa	107	IT	Italy	PI	province	43.7228315	10.4017194	\N
1687	Pistoia	107	IT	Italy	PT	province	43.9543733	10.8903099	\N
1690	Pordenone	107	IT	Italy	PN	decentralized regional entity	46.0378862	12.710835	\N
1697	Potenza	107	IT	Italy	PZ	province	40.4182194	15.876004	\N
1700	Prato	107	IT	Italy	PO	province	44.04539	11.1164452	\N
1729	Ragusa	107	IT	Italy	RG	free municipal consortium	36.9269273	14.7255129	\N
1707	Ravenna	107	IT	Italy	RA	province	44.4184443	12.2035998	\N
1671	Reggio Calabria	107	IT	Italy	RC	metropolitan city	38.1084396	15.6437048	\N
1708	Reggio Emilia	107	IT	Italy	RE	province	44.585658	10.5564736	\N
1712	Rieti	107	IT	Italy	RI	province	42.3674405	12.8975098	\N
1713	Rimini	107	IT	Italy	RN	province	44.0678288	12.5695158	\N
1711	Rome	107	IT	Italy	RM	metropolitan city	41.9027008	12.4962352	\N
1719	Rovigo	107	IT	Italy	RO	province	45.0241818	11.8238162	\N
1720	Salerno	107	IT	Italy	SA	province	40.4287832	15.2194808	\N
1715	Sardinia	107	IT	Italy	88	autonomous region	40.1208752	9.0128926	\N
1722	Sassari	107	IT	Italy	SS	province	40.7967907	8.5750407	\N
1732	Savona	107	IT	Italy	SV	province	44.2887995	8.265058	\N
1709	Sicily	107	IT	Italy	82	autonomous region	37.5999938	14.0153557	\N
1734	Siena	107	IT	Italy	SI	province	43.2937732	11.4339148	\N
1667	Siracusa	107	IT	Italy	SR	free municipal consortium	37.0656924	15.2857109	\N
1741	Sondrio	107	IT	Italy	SO	province	46.1727636	9.7994917	\N
1730	South Sardinia	107	IT	Italy	SU	province	39.3893535	8.9397	\N
1767	South Tyrol	107	IT	Italy	BZ	autonomous province	46.494945	11.3402657	\N
1743	Taranto	107	IT	Italy	TA	province	40.5740901	17.2429976	\N
1752	Teramo	107	IT	Italy	TE	province	42.5895608	13.6362715	\N
1755	Terni	107	IT	Italy	TR	province	42.5634534	12.5298028	\N
1733	Trapani	107	IT	Italy	TP	free municipal consortium	38.0183116	12.5148265	\N
1748	Trentino	107	IT	Italy	TN	autonomous province	46.0512004	11.1175392	\N
1725	Trentino-South Tyrol	107	IT	Italy	32	autonomous region	46.4336662	11.1693296	\N
1762	Treviso	107	IT	Italy	TV	province	45.6668517	12.2430617	\N
1763	Trieste	107	IT	Italy	TS	decentralized regional entity	45.6894823	13.7833072	\N
1710	Turin	107	IT	Italy	TO	metropolitan city	45.063299	7.669289	\N
1664	Tuscany	107	IT	Italy	52	region	43.7710513	11.2486208	\N
1764	Udine	107	IT	Italy	UD	decentralized regional entity	46.1407972	13.1662896	\N
1683	Umbria	107	IT	Italy	55	region	42.938004	12.6216211	\N
1765	Varese	107	IT	Italy	VA	province	45.799026	8.7300945	\N
1753	Veneto	107	IT	Italy	34	region	45.4414662	12.3152595	\N
1673	Venice	107	IT	Italy	VE	metropolitan city	45.4414685	12.3152672	\N
1726	Verbano-Cusio-Ossola	107	IT	Italy	VB	province	46.1399688	8.2724649	\N
1785	Vercelli	107	IT	Italy	VC	province	45.3202204	8.418508	\N
1736	Verona	107	IT	Italy	VR	province	45.4418498	11.0735316	\N
1737	Vibo Valentia	107	IT	Italy	VV	province	38.6378565	16.2051484	\N
1738	Vicenza	107	IT	Italy	VI	province	45.6983995	11.5661465	\N
1735	Viterbo	107	IT	Italy	VT	province	42.400242	11.8891721	\N
3753	Clarendon Parish	108	JM	Jamaica	13	\N	17.9557183	-77.2405153	\N
3749	Hanover Parish	108	JM	Jamaica	09	\N	18.4097707	-78.133638	\N
3748	Kingston Parish	108	JM	Jamaica	01	\N	17.9683271	-76.782702	\N
3754	Manchester Parish	108	JM	Jamaica	12	\N	18.0669654	-77.5160788	\N
3752	Portland Parish	108	JM	Jamaica	04	\N	18.0844274	-76.4100267	\N
3751	Saint Andrew	108	JM	Jamaica	02	\N	37.2245103	-95.7021189	\N
3744	Saint Ann Parish	108	JM	Jamaica	06	\N	37.2871452	-77.4103533	\N
3746	Saint Catherine Parish	108	JM	Jamaica	14	\N	18.0364134	-77.0564464	\N
3743	Saint Elizabeth Parish	108	JM	Jamaica	11	\N	38.9925308	-94.58992	\N
3745	Saint James Parish	108	JM	Jamaica	08	\N	30.0179292	-90.7913227	\N
3747	Saint Mary Parish	108	JM	Jamaica	05	\N	36.092522	-95.973844	\N
3750	Saint Thomas Parish	108	JM	Jamaica	03	\N	41.4425389	-81.7402218	\N
3755	Trelawny Parish	108	JM	Jamaica	07	\N	18.3526143	-77.6077865	\N
3742	Westmoreland Parish	108	JM	Jamaica	10	\N	18.2944378	-78.1564432	\N
827	Aichi Prefecture	109	JP	Japan	23	\N	35.0182505	137.2923893	\N
829	Akita Prefecture	109	JP	Japan	05	\N	40.1376293	140.334341	\N
839	Aomori Prefecture	109	JP	Japan	02	\N	40.7657077	140.9175879	\N
821	Chiba Prefecture	109	JP	Japan	12	\N	35.3354155	140.1832516	\N
865	Ehime Prefecture	109	JP	Japan	38	\N	33.6025306	132.7857583	\N
848	Fukui Prefecture	109	JP	Japan	18	\N	35.896227	136.2111579	\N
861	Fukuoka Prefecture	109	JP	Japan	40	\N	33.5662559	130.715857	\N
847	Fukushima Prefecture	109	JP	Japan	07	\N	37.3834373	140.1832516	\N
858	Gifu Prefecture	109	JP	Japan	21	\N	35.7437491	136.9805103	\N
862	Gunma Prefecture	109	JP	Japan	10	\N	36.5605388	138.8799972	\N
828	Hiroshima Prefecture	109	JP	Japan	34	\N	34.8823408	133.0194897	\N
832	Hokkaidō Prefecture	109	JP	Japan	01	\N	43.2203266	142.8634737	\N
831	Hyōgo Prefecture	109	JP	Japan	28	\N	34.8579518	134.5453787	\N
851	Ibaraki Prefecture	109	JP	Japan	08	\N	36.2193571	140.1832516	\N
830	Ishikawa Prefecture	109	JP	Japan	17	\N	36.3260317	136.5289653	\N
856	Iwate Prefecture	109	JP	Japan	03	\N	39.5832989	141.2534574	\N
864	Kagawa Prefecture	109	JP	Japan	37	\N	34.2225915	134.0199152	\N
840	Kagoshima Prefecture	109	JP	Japan	46	\N	31.3911958	130.8778586	\N
842	Kanagawa Prefecture	109	JP	Japan	14	\N	35.4913535	139.284143	\N
4924	Kōchi Prefecture	109	JP	Japan	39	\N	33.2879161	132.2759262	\N
846	Kumamoto Prefecture	109	JP	Japan	43	\N	32.8594427	130.7969149	\N
834	Kyōto Prefecture	109	JP	Japan	26	\N	35.1566609	135.5251982	\N
833	Mie Prefecture	109	JP	Japan	24	\N	33.8143901	136.0487047	\N
857	Miyagi Prefecture	109	JP	Japan	04	\N	38.630612	141.1193048	\N
855	Miyazaki Prefecture	109	JP	Japan	45	\N	32.6036022	131.441251	\N
843	Nagano Prefecture	109	JP	Japan	20	\N	36.1543941	137.9218204	\N
849	Nagasaki Prefecture	109	JP	Japan	42	\N	33.2488525	129.6930912	\N
824	Nara Prefecture	109	JP	Japan	29	\N	34.2975528	135.8279734	\N
841	Niigata Prefecture	109	JP	Japan	15	\N	37.5178386	138.9269794	\N
822	Ōita Prefecture	109	JP	Japan	44	\N	33.1589299	131.3611121	\N
820	Okayama Prefecture	109	JP	Japan	33	\N	34.8963407	133.6375314	\N
853	Okinawa Prefecture	109	JP	Japan	47	\N	26.1201911	127.7025012	\N
859	Ōsaka Prefecture	109	JP	Japan	27	\N	34.6413315	135.5629394	\N
863	Saga Prefecture	109	JP	Japan	41	\N	33.3078371	130.2271243	\N
860	Saitama Prefecture	109	JP	Japan	11	\N	35.9962513	139.4466005	\N
845	Shiga Prefecture	109	JP	Japan	25	\N	35.3292014	136.0563212	\N
826	Shimane Prefecture	109	JP	Japan	32	\N	35.1244094	132.6293446	\N
825	Shizuoka Prefecture	109	JP	Japan	22	\N	35.0929397	138.3190276	\N
854	Tochigi Prefecture	109	JP	Japan	09	\N	36.6714739	139.8547266	\N
836	Tokushima Prefecture	109	JP	Japan	36	\N	33.9419655	134.3236557	\N
823	Tokyo	109	JP	Japan	13	\N	35.6761919	139.6503106	\N
850	Tottori Prefecture	109	JP	Japan	31	\N	35.3573161	133.4066618	\N
838	Toyama Prefecture	109	JP	Japan	16	\N	36.6958266	137.2137071	\N
844	Wakayama Prefecture	109	JP	Japan	30	\N	33.9480914	135.3745358	\N
837	Yamagata Prefecture	109	JP	Japan	06	\N	38.5370564	140.1435198	\N
835	Yamaguchi Prefecture	109	JP	Japan	35	\N	34.2796769	131.5212742	\N
852	Yamanashi Prefecture	109	JP	Japan	19	\N	35.6635113	138.6388879	\N
963	Ajloun	111	JO	Jordan	AJ	\N	32.3325584	35.7516844	\N
965	Amman	111	JO	Jordan	AM	\N	31.9453633	35.9283895	\N
959	Aqaba	111	JO	Jordan	AQ	\N	29.532086	35.0062821	\N
961	Balqa	111	JO	Jordan	BA	\N	32.0366806	35.728848	\N
960	Irbid	111	JO	Jordan	IR	\N	32.5569636	35.8478965	\N
966	Jerash	111	JO	Jordan	JA	\N	32.2747237	35.8960954	\N
956	Karak	111	JO	Jordan	KA	\N	31.1853527	35.7047682	\N
964	Ma'an	111	JO	Jordan	MN	\N	30.1926789	35.7249319	\N
958	Madaba	111	JO	Jordan	MD	\N	31.7196097	35.7932754	\N
962	Mafraq	111	JO	Jordan	MA	\N	32.3416923	36.2020175	\N
957	Tafilah	111	JO	Jordan	AT	\N	30.8338063	35.6160513	\N
967	Zarqa	111	JO	Jordan	AZ	\N	32.0608505	36.0942121	\N
145	Akmola Region	112	KZ	Kazakhstan	AKM	\N	51.916532	69.4110494	\N
151	Aktobe Region	112	KZ	Kazakhstan	AKT	\N	48.7797078	57.9974378	\N
152	Almaty	112	KZ	Kazakhstan	ALA	\N	43.2220146	76.8512485	\N
143	Almaty Region	112	KZ	Kazakhstan	ALM	\N	45.0119227	78.4229392	\N
153	Atyrau Region	112	KZ	Kazakhstan	ATY	\N	47.1076188	51.914133	\N
155	Baikonur	112	KZ	Kazakhstan	BAY	\N	45.9645851	63.3052428	\N
154	East Kazakhstan Region	112	KZ	Kazakhstan	VOS	\N	48.7062687	80.7922534	\N
147	Jambyl Region	112	KZ	Kazakhstan	ZHA	\N	44.2220308	72.3657967	\N
150	Karaganda Region	112	KZ	Kazakhstan	KAR	\N	47.9022182	71.7706807	\N
157	Kostanay Region	112	KZ	Kazakhstan	KUS	\N	51.5077096	64.0479073	\N
142	Kyzylorda Region	112	KZ	Kazakhstan	KZY	\N	44.6922613	62.6571885	\N
141	Mangystau Region	112	KZ	Kazakhstan	MAN	\N	44.590802	53.8499508	\N
144	North Kazakhstan Region	112	KZ	Kazakhstan	SEV	\N	54.1622066	69.9387071	\N
156	Nur-Sultan	112	KZ	Kazakhstan	AST	\N	51.1605227	71.4703558	\N
146	Pavlodar Region	112	KZ	Kazakhstan	PAV	\N	52.2878444	76.9733453	\N
149	Turkestan Region	112	KZ	Kazakhstan	YUZ	\N	43.3666958	68.4094405	\N
148	West Kazakhstan Province	112	KZ	Kazakhstan	ZAP	\N	49.5679727	50.8066616	\N
181	Baringo	113	KE	Kenya	01	county	0.8554988	36.0893406	\N
210	Bomet	113	KE	Kenya	02	county	-0.8015009	35.3027226	\N
168	Bungoma	113	KE	Kenya	03	county	0.5695252	34.5583766	\N
161	Busia	113	KE	Kenya	04	county	0.4346506	34.2421597	\N
201	Elgeyo-Marakwet	113	KE	Kenya	05	county	1.0498237	35.4781926	\N
163	Embu	113	KE	Kenya	06	county	-0.6560477	37.7237678	\N
196	Garissa	113	KE	Kenya	07	county	-0.4532293	39.6460988	\N
195	Homa Bay	113	KE	Kenya	08	county	-0.6220655	34.3310364	\N
170	Isiolo	113	KE	Kenya	09	county	0.3524352	38.4849923	\N
197	Kajiado	113	KE	Kenya	10	county	-2.0980751	36.7819505	\N
158	Kakamega	113	KE	Kenya	11	county	0.307894	34.7740793	\N
193	Kericho	113	KE	Kenya	12	county	-0.1827913	35.4781926	\N
199	Kiambu	113	KE	Kenya	13	county	-1.0313701	36.8680791	\N
174	Kilifi	113	KE	Kenya	14	county	-3.5106508	39.9093269	\N
167	Kirinyaga	113	KE	Kenya	15	county	-0.6590565	37.3827234	\N
159	Kisii	113	KE	Kenya	16	county	-0.677334	34.779603	\N
171	Kisumu	113	KE	Kenya	17	county	-0.0917016	34.7679568	\N
211	Kitui	113	KE	Kenya	18	county	-1.6832822	38.3165725	\N
173	Kwale	113	KE	Kenya	19	county	-4.1816115	39.4605612	\N
164	Laikipia	113	KE	Kenya	20	county	0.3606063	36.7819505	\N
166	Lamu	113	KE	Kenya	21	county	-2.2355058	40.4720004	\N
184	Machakos	113	KE	Kenya	22	county	-1.5176837	37.2634146	\N
188	Makueni	113	KE	Kenya	23	county	-2.2558734	37.8936663	\N
187	Mandera	113	KE	Kenya	24	county	3.5737991	40.958688	\N
194	Marsabit	113	KE	Kenya	25	county	2.4426403	37.9784585	\N
198	Meru	113	KE	Kenya	26	county	0.3557174	37.8087693	\N
190	Migori	113	KE	Kenya	27	county	-0.9365702	34.4198243	\N
200	Mombasa	113	KE	Kenya	28	county	-3.9768291	39.7137181	\N
178	Murang'a	113	KE	Kenya	29	county	-0.7839281	37.0400339	\N
191	Nairobi City	113	KE	Kenya	30	county	-1.2920659	36.8219462	\N
203	Nakuru	113	KE	Kenya	31	county	-0.3030988	36.080026	\N
165	Nandi	113	KE	Kenya	32	county	0.1835867	35.1268781	\N
175	Narok	113	KE	Kenya	33	county	-1.104111	36.0893406	\N
209	Nyamira	113	KE	Kenya	34	county	-0.5669405	34.9341234	\N
192	Nyandarua	113	KE	Kenya	35	county	-0.1803855	36.5229641	\N
180	Nyeri	113	KE	Kenya	36	county	-0.4196915	37.0400339	\N
207	Samburu	113	KE	Kenya	37	county	1.2154506	36.954107	\N
186	Siaya	113	KE	Kenya	38	county	-0.0617328	34.2421597	\N
176	Taita–Taveta	113	KE	Kenya	39	county	-3.3160687	38.4849923	\N
205	Tana River	113	KE	Kenya	40	county	-1.6518468	39.6518165	\N
185	Tharaka-Nithi	113	KE	Kenya	41	county	-0.2964851	37.7237678	\N
183	Trans Nzoia	113	KE	Kenya	42	county	1.0566667	34.9506625	\N
206	Turkana	113	KE	Kenya	43	county	3.3122477	35.5657862	\N
169	Uasin Gishu	113	KE	Kenya	44	county	0.5527638	35.3027226	\N
202	Vihiga	113	KE	Kenya	45	county	0.0767553	34.7077665	\N
182	Wajir	113	KE	Kenya	46	county	1.6360475	40.3088626	\N
208	West Pokot	113	KE	Kenya	47	county	1.6210076	35.3905046	\N
1831	Gilbert Islands	114	KI	Kiribati	G	\N	0.3524262	174.7552634	\N
1832	Line Islands	114	KI	Kiribati	L	\N	1.7429439	-157.2132826	\N
1830	Phoenix Islands	114	KI	Kiribati	P	\N	33.3284369	-111.9824774	\N
4876	Đakovica District (Gjakove)	248	XK	Kosovo	XDG	\N	42.4375756	20.3785438	\N
4877	Gjilan District	248	XK	Kosovo	XGJ	\N	42.4635206	21.4694011	\N
4878	Kosovska Mitrovica District	248	XK	Kosovo	XKM	\N	42.8913909	20.8659995	\N
3738	Peć District	248	XK	Kosovo	XPE	\N	42.6592155	20.2887624	\N
4879	Pristina (Priştine)	248	XK	Kosovo	XPI	\N	42.6629138	21.1655028	\N
3723	Prizren District	248	XK	Kosovo	XPR	\N	42.2152522	20.7414772	\N
4874	Uroševac District (Ferizaj)	248	XK	Kosovo	XUF	\N	42.3701844	21.1483281	\N
977	Al Ahmadi	117	KW	Kuwait	AH	\N	28.5745125	48.1024743	\N
975	Al Farwaniyah	117	KW	Kuwait	FA	\N	29.273357	47.9400154	\N
972	Al Jahra	117	KW	Kuwait	JA	\N	29.9931831	47.7634731	\N
976	Capital	117	KW	Kuwait	KU	\N	26.2285161	50.5860497	\N
973	Hawalli	117	KW	Kuwait	HA	\N	29.3056716	48.0307613	\N
974	Mubarak Al-Kabeer	117	KW	Kuwait	MU	\N	29.21224	48.0605108	\N
998	Batken Region	118	KG	Kyrgyzstan	B	\N	39.9721425	69.8597406	\N
1001	Bishkek	118	KG	Kyrgyzstan	GB	\N	42.8746212	74.5697617	\N
1004	Chuy Region	118	KG	Kyrgyzstan	C	\N	42.5655	74.4056612	\N
1002	Issyk-Kul Region	118	KG	Kyrgyzstan	Y	\N	42.1859428	77.5619419	\N
1000	Jalal-Abad Region	118	KG	Kyrgyzstan	J	\N	41.106808	72.8988069	\N
999	Naryn Region	118	KG	Kyrgyzstan	N	\N	41.2943227	75.3412179	\N
1003	Osh	118	KG	Kyrgyzstan	GO	\N	36.0631399	-95.9182895	\N
1005	Osh Region	118	KG	Kyrgyzstan	O	\N	39.8407366	72.8988069	\N
997	Talas Region	118	KG	Kyrgyzstan	T	\N	42.2867339	72.5204827	\N
982	Attapeu Province	119	LA	Laos	AT	\N	14.93634	107.1011931	\N
991	Bokeo Province	119	LA	Laos	BK	\N	20.2872662	100.7097867	\N
985	Bolikhamsai Province	119	LA	Laos	BL	\N	18.4362924	104.4723301	\N
996	Champasak Province	119	LA	Laos	CH	\N	14.6578664	105.9699878	\N
989	Houaphanh Province	119	LA	Laos	HO	\N	20.3254175	104.1001326	\N
986	Khammouane Province	119	LA	Laos	KH	\N	17.6384066	105.2194808	\N
992	Luang Namtha Province	119	LA	Laos	LM	\N	20.9170187	101.1617356	\N
978	Luang Prabang Province	119	LA	Laos	LP	\N	20.0656229	102.6216211	\N
988	Oudomxay Province	119	LA	Laos	OU	\N	20.4921929	101.8891721	\N
987	Phongsaly Province	119	LA	Laos	PH	\N	21.5919377	102.2547919	\N
993	Sainyabuli Province	119	LA	Laos	XA	\N	19.3907886	101.5248055	\N
981	Salavan Province	119	LA	Laos	SL	\N	15.8171073	106.2522143	\N
990	Savannakhet Province	119	LA	Laos	SV	\N	16.5065381	105.5943388	\N
984	Sekong Province	119	LA	Laos	XE	\N	15.5767446	107.0067031	\N
979	Vientiane Prefecture	119	LA	Laos	VT	\N	18.110541	102.5298028	\N
980	Vientiane Province	119	LA	Laos	VI	\N	18.5705063	102.6216211	\N
994	Xaisomboun	119	LA	Laos	XN	\N	\N	\N	\N
983	Xaisomboun Province	119	LA	Laos	XS	\N	18.4362924	104.4723301	\N
995	Xiangkhouang Province	119	LA	Laos	XI	\N	19.6093003	103.7289167	\N
4445	Aglona Municipality	120	LV	Latvia	001	\N	56.1089006	27.1286227	\N
4472	Aizkraukle Municipality	120	LV	Latvia	002	\N	56.646108	25.2370854	\N
4496	Aizpute Municipality	120	LV	Latvia	003	\N	56.7182596	21.6072759	\N
4499	Aknīste Municipality	120	LV	Latvia	004	\N	56.1613037	25.7484827	\N
4484	Aloja Municipality	120	LV	Latvia	005	\N	57.767136	24.8770839	\N
4485	Alsunga Municipality	120	LV	Latvia	006	\N	56.9828531	21.5555919	\N
4487	Alūksne Municipality	120	LV	Latvia	007	\N	57.4254485	27.0424968	\N
4497	Amata Municipality	120	LV	Latvia	008	\N	56.9938726	25.2627675	\N
4457	Ape Municipality	120	LV	Latvia	009	\N	57.5392697	26.6941649	\N
4481	Auce Municipality	120	LV	Latvia	010	\N	56.460168	22.9054781	\N
4427	Babīte Municipality	120	LV	Latvia	012	\N	56.954155	23.945399	\N
4482	Baldone Municipality	120	LV	Latvia	013	\N	56.74246	24.3911544	\N
4498	Baltinava Municipality	120	LV	Latvia	014	\N	56.9458468	27.6441066	\N
4505	Balvi Municipality	120	LV	Latvia	015	\N	57.132624	27.2646685	\N
4465	Bauska Municipality	120	LV	Latvia	016	\N	56.4101868	24.2000689	\N
4471	Beverīna Municipality	120	LV	Latvia	017	\N	57.5197109	25.6073654	\N
4468	Brocēni Municipality	120	LV	Latvia	018	\N	56.7347541	22.6357371	\N
4411	Burtnieki Municipality	120	LV	Latvia	019	\N	57.6949004	25.2764777	\N
4454	Carnikava Municipality	120	LV	Latvia	020	\N	57.1024121	24.2108662	\N
4469	Cēsis Municipality	120	LV	Latvia	022	\N	57.3102897	25.2676125	\N
4414	Cesvaine Municipality	120	LV	Latvia	021	\N	56.9679264	26.3083172	\N
4410	Cibla Municipality	120	LV	Latvia	023	\N	56.6102344	27.8696598	\N
4504	Dagda Municipality	120	LV	Latvia	024	\N	56.0956089	27.532459	\N
4463	Daugavpils	120	LV	Latvia	DGV	\N	55.874736	26.536179	\N
4492	Daugavpils Municipality	120	LV	Latvia	025	\N	55.8991783	26.6102012	\N
4437	Dobele Municipality	120	LV	Latvia	026	\N	56.626305	23.2809066	\N
4428	Dundaga Municipality	120	LV	Latvia	027	\N	57.5049167	22.3505114	\N
4458	Durbe Municipality	120	LV	Latvia	028	\N	56.6279857	21.4916245	\N
4448	Engure Municipality	120	LV	Latvia	029	\N	57.16235	23.2196634	\N
4444	Ērgļi Municipality	120	LV	Latvia	030	\N	56.9237065	25.6753852	\N
4510	Garkalne Municipality	120	LV	Latvia	031	\N	57.0190387	24.3826181	\N
4470	Grobiņa Municipality	120	LV	Latvia	032	\N	56.539632	21.166892	\N
4400	Gulbene Municipality	120	LV	Latvia	033	\N	57.2155645	26.6452955	\N
4441	Iecava Municipality	120	LV	Latvia	034	\N	56.5986793	24.1996272	\N
4511	Ikšķile Municipality	120	LV	Latvia	035	\N	56.8373667	24.4974745	\N
4399	Ilūkste Municipality	120	LV	Latvia	036	\N	55.9782547	26.2965088	\N
4449	Inčukalns Municipality	120	LV	Latvia	037	\N	57.0994342	24.685557	\N
4475	Jaunjelgava Municipality	120	LV	Latvia	038	\N	56.5283659	25.3921443	\N
4407	Jaunpiebalga Municipality	120	LV	Latvia	039	\N	57.1433471	25.9951888	\N
4489	Jaunpils Municipality	120	LV	Latvia	040	\N	56.7314194	23.0125616	\N
4464	Jēkabpils	120	LV	Latvia	JKB	\N	56.501455	25.878299	\N
4438	Jēkabpils Municipality	120	LV	Latvia	042	\N	56.291932	25.9812017	\N
4500	Jelgava	120	LV	Latvia	JEL	\N	56.6511091	23.7213541	\N
4424	Jelgava Municipality	120	LV	Latvia	041	\N	56.5895689	23.6610481	\N
4446	Jūrmala	120	LV	Latvia	JUR	\N	56.947079	23.6168485	\N
4420	Kandava Municipality	120	LV	Latvia	043	\N	57.0340673	22.7801813	\N
4453	Kārsava Municipality	120	LV	Latvia	044	\N	56.7645842	27.7358295	\N
4412	Ķegums Municipality	120	LV	Latvia	051	\N	56.7475357	24.7173645	\N
4435	Ķekava Municipality	120	LV	Latvia	052	\N	56.8064351	24.1939493	\N
4495	Kocēni Municipality	120	LV	Latvia	045	\N	57.5226292	25.3349507	\N
4452	Koknese Municipality	120	LV	Latvia	046	\N	56.720556	25.4893909	\N
4474	Krāslava Municipality	120	LV	Latvia	047	\N	55.8951464	27.1814577	\N
4422	Krimulda Municipality	120	LV	Latvia	048	\N	57.1791273	24.7140127	\N
4413	Krustpils Municipality	120	LV	Latvia	049	\N	56.5415578	26.2446397	\N
4490	Kuldīga Municipality	120	LV	Latvia	050	\N	56.9687257	21.9613739	\N
4512	Lielvārde Municipality	120	LV	Latvia	053	\N	56.7392976	24.9711618	\N
4460	Liepāja	120	LV	Latvia	LPX	\N	56.5046678	21.010806	\N
4488	Līgatne Municipality	120	LV	Latvia	055	\N	57.1944204	25.0940681	\N
4418	Limbaži Municipality	120	LV	Latvia	054	\N	57.5403227	24.7134451	\N
4401	Līvāni Municipality	120	LV	Latvia	056	\N	56.3550942	26.172519	\N
4419	Lubāna Municipality	120	LV	Latvia	057	\N	56.8999269	26.7198789	\N
4501	Ludza Municipality	120	LV	Latvia	058	\N	56.545959	27.7143199	\N
4433	Madona Municipality	120	LV	Latvia	059	\N	56.8598923	26.2276201	\N
4461	Mālpils Municipality	120	LV	Latvia	061	\N	57.0084119	24.9574278	\N
4450	Mārupe Municipality	120	LV	Latvia	062	\N	56.8965717	24.0460049	\N
4513	Mazsalaca Municipality	120	LV	Latvia	060	\N	57.9267749	25.0669895	\N
4451	Mērsrags Municipality	120	LV	Latvia	063	\N	57.3306881	23.1023707	\N
4398	Naukšēni Municipality	120	LV	Latvia	064	\N	57.9295361	25.5119266	\N
4432	Nereta Municipality	120	LV	Latvia	065	\N	56.1986655	25.3252969	\N
4436	Nīca Municipality	120	LV	Latvia	066	\N	56.3464983	21.065493	\N
4416	Ogre Municipality	120	LV	Latvia	067	\N	56.8147355	24.6044555	\N
4417	Olaine Municipality	120	LV	Latvia	068	\N	56.7952353	24.0153589	\N
4442	Ozolnieki Municipality	120	LV	Latvia	069	\N	56.6756305	23.8994816	\N
4507	Pārgauja Municipality	120	LV	Latvia	070	\N	57.3648122	24.9822045	\N
4467	Pāvilosta Municipality	120	LV	Latvia	071	\N	56.8865424	21.1946849	\N
4405	Pļaviņas Municipality	120	LV	Latvia	072	\N	56.6177313	25.7194043	\N
4483	Preiļi Municipality	120	LV	Latvia	073	\N	56.1511157	26.7439767	\N
4429	Priekule Municipality	120	LV	Latvia	074	\N	56.4179413	21.5503336	\N
4506	Priekuļi Municipality	120	LV	Latvia	075	\N	57.3617138	25.4410423	\N
4479	Rauna Municipality	120	LV	Latvia	076	\N	57.331693	25.6100339	\N
4509	Rēzekne	120	LV	Latvia	REZ	\N	56.5099223	27.3331357	\N
4455	Rēzekne Municipality	120	LV	Latvia	077	\N	56.3273638	27.3284331	\N
4502	Riebiņi Municipality	120	LV	Latvia	078	\N	56.343619	26.8018138	\N
4491	Riga	120	LV	Latvia	RIX	\N	56.9496487	24.1051865	\N
4440	Roja Municipality	120	LV	Latvia	079	\N	57.5046713	22.8012164	\N
4493	Ropaži Municipality	120	LV	Latvia	080	\N	56.9615786	24.6010476	\N
4503	Rucava Municipality	120	LV	Latvia	081	\N	56.1593124	21.1618121	\N
4423	Rugāji Municipality	120	LV	Latvia	082	\N	57.0056023	27.1317203	\N
4426	Rūjiena Municipality	120	LV	Latvia	084	\N	57.8937291	25.3391008	\N
4404	Rundāle Municipality	120	LV	Latvia	083	\N	56.409721	24.0124139	\N
4434	Sala Municipality	120	LV	Latvia	085	\N	59.9679613	16.4978217	\N
4396	Salacgrīva Municipality	120	LV	Latvia	086	\N	57.7580883	24.3543181	\N
4402	Salaspils Municipality	120	LV	Latvia	087	\N	56.8608152	24.3497881	\N
4439	Saldus Municipality	120	LV	Latvia	088	\N	56.6665088	22.4935493	\N
4443	Saulkrasti Municipality	120	LV	Latvia	089	\N	57.2579418	24.4183146	\N
4408	Sēja Municipality	120	LV	Latvia	090	\N	57.2006995	24.5922821	\N
4476	Sigulda Municipality	120	LV	Latvia	091	\N	57.1055092	24.8314259	\N
4415	Skrīveri Municipality	120	LV	Latvia	092	\N	56.6761391	25.0978849	\N
4447	Skrunda Municipality	120	LV	Latvia	093	\N	56.6643458	22.0045729	\N
4462	Smiltene Municipality	120	LV	Latvia	094	\N	57.4230332	25.900278	\N
4478	Stopiņi Municipality	120	LV	Latvia	095	\N	56.936449	24.2872949	\N
4494	Strenči Municipality	120	LV	Latvia	096	\N	57.6225471	25.8048086	\N
4459	Talsi Municipality	120	LV	Latvia	097	\N	57.3415208	22.5713125	\N
4480	Tērvete Municipality	120	LV	Latvia	098	\N	56.4119201	23.3188332	\N
4409	Tukums Municipality	120	LV	Latvia	099	\N	56.9672868	23.1524379	\N
4508	Vaiņode Municipality	120	LV	Latvia	100	\N	56.4154271	21.8513984	\N
4425	Valka Municipality	120	LV	Latvia	101	\N	57.77439	26.017005	\N
4473	Valmiera	120	LV	Latvia	VMR	\N	57.5384659	25.4263618	\N
4431	Varakļāni Municipality	120	LV	Latvia	102	\N	56.6688006	26.5636414	\N
4406	Vārkava Municipality	120	LV	Latvia	103	\N	56.2465744	26.5664371	\N
4466	Vecpiebalga Municipality	120	LV	Latvia	104	\N	57.0603356	25.8161592	\N
4397	Vecumnieki Municipality	120	LV	Latvia	105	\N	56.6062337	24.5221891	\N
4421	Ventspils	120	LV	Latvia	VEN	\N	57.3937216	21.5647066	\N
4403	Ventspils Municipality	120	LV	Latvia	106	\N	57.2833682	21.8587558	\N
4456	Viesīte Municipality	120	LV	Latvia	107	\N	56.3113085	25.5070464	\N
4477	Viļaka Municipality	120	LV	Latvia	108	\N	57.1722263	27.6673188	\N
4486	Viļāni Municipality	120	LV	Latvia	109	\N	56.5456171	26.9167927	\N
4430	Zilupe Municipality	120	LV	Latvia	110	\N	56.3018985	28.133959	\N
2285	Akkar	121	LB	Lebanon	AK	\N	34.5328763	36.1328132	\N
2283	Baalbek-Hermel	121	LB	Lebanon	BH	\N	34.2658556	36.3498097	\N
2286	Beirut	121	LB	Lebanon	BA	\N	33.8886106	35.4954772	\N
2287	Beqaa	121	LB	Lebanon	BI	\N	33.8462662	35.9019489	\N
2282	Mount Lebanon	121	LB	Lebanon	JL	\N	33.8100858	35.5973139	\N
2288	Nabatieh	121	LB	Lebanon	NA	\N	33.3771693	35.4838293	\N
2284	North	121	LB	Lebanon	AS	\N	34.4380625	35.8308233	\N
2281	South	121	LB	Lebanon	JA	\N	33.2721479	35.2032778	\N
3030	Berea District	122	LS	Lesotho	D	\N	41.3661614	-81.8543026	\N
3029	Butha-Buthe District	122	LS	Lesotho	B	\N	-28.7653754	28.2468148	\N
3026	Leribe District	122	LS	Lesotho	C	\N	-28.8638065	28.0478826	\N
3022	Mafeteng District	122	LS	Lesotho	E	\N	-29.8041008	27.5026174	\N
3028	Maseru District	122	LS	Lesotho	A	\N	-29.516565	27.8311428	\N
3023	Mohale's Hoek District	122	LS	Lesotho	F	\N	-30.1425917	27.4673845	\N
3024	Mokhotlong District	122	LS	Lesotho	J	\N	-29.2573193	28.9528645	\N
3025	Qacha's Nek District	122	LS	Lesotho	H	\N	-30.1114565	28.678979	\N
3027	Quthing District	122	LS	Lesotho	G	\N	-30.4015687	27.7080133	\N
3031	Thaba-Tseka District	122	LS	Lesotho	K	\N	-29.5238975	28.6089752	\N
3041	Bomi County	123	LR	Liberia	BM	\N	6.7562926	-10.8451467	\N
3034	Bong County	123	LR	Liberia	BG	\N	6.8295019	-9.3673084	\N
3044	Gbarpolu County	123	LR	Liberia	GP	\N	7.4952637	-10.0807298	\N
3040	Grand Bassa County	123	LR	Liberia	GB	\N	6.2308452	-9.8124935	\N
3036	Grand Cape Mount County	123	LR	Liberia	CM	\N	7.0467758	-11.0711758	\N
3039	Grand Gedeh County	123	LR	Liberia	GG	\N	5.9222078	-8.2212979	\N
3045	Grand Kru County	123	LR	Liberia	GK	\N	4.7613862	-8.2212979	\N
3037	Lofa County	123	LR	Liberia	LO	\N	8.1911184	-9.7232673	\N
3043	Margibi County	123	LR	Liberia	MG	\N	6.5151875	-10.3048897	\N
3042	Maryland County	123	LR	Liberia	MY	\N	39.0457549	-76.6412712	\N
3032	Montserrado County	123	LR	Liberia	MO	\N	6.5525815	-10.5296115	\N
3046	Nimba	123	LR	Liberia	NI	\N	7.6166667	-8.4166667	\N
3033	River Cess County	123	LR	Liberia	RI	\N	5.9025328	-9.456155	\N
3038	River Gee County	123	LR	Liberia	RG	\N	5.2604894	-7.87216	\N
3035	Sinoe County	123	LR	Liberia	SI	\N	5.49871	-8.6600586	\N
2964	Al Wahat District	124	LY	Libya	WA	\N	29.0466808	21.8568586	\N
2981	Benghazi	124	LY	Libya	BA	\N	32.1194242	20.0867909	\N
2966	Derna District	124	LY	Libya	DR	\N	32.755613	22.6377432	\N
2969	Ghat District	124	LY	Libya	GT	\N	24.9640371	10.1759285	\N
2980	Jabal al Akhdar	124	LY	Libya	JA	\N	23.1856081	57.3713879	\N
2974	Jabal al Gharbi District	124	LY	Libya	JG	\N	30.2638032	12.8054753	\N
2979	Jafara	124	LY	Libya	JI	\N	32.4525904	12.9435536	\N
2970	Jufra	124	LY	Libya	JU	\N	27.9835135	16.912251	\N
2972	Kufra District	124	LY	Libya	KF	\N	23.3112389	21.8568586	\N
2968	Marj District	124	LY	Libya	MJ	\N	32.0550363	21.1891151	\N
2978	Misrata District	124	LY	Libya	MI	\N	32.3255884	15.0992556	\N
2961	Murqub	124	LY	Libya	MB	\N	32.4599677	14.1001326	\N
2967	Murzuq District	124	LY	Libya	MQ	\N	25.9182262	13.9260001	\N
2976	Nalut District	124	LY	Libya	NL	\N	31.8742348	10.9750484	\N
2962	Nuqat al Khams	124	LY	Libya	NQ	\N	32.6914909	11.8891721	\N
2965	Sabha District	124	LY	Libya	SB	\N	27.0365406	14.4290236	\N
2977	Sirte District	124	LY	Libya	SR	\N	31.189689	16.5701927	\N
2971	Tripoli District	124	LY	Libya	TB	\N	32.6408021	13.2663479	\N
2973	Wadi al Hayaa District	124	LY	Libya	WD	\N	26.4225926	12.6216211	\N
2975	Wadi al Shatii District	124	LY	Libya	WS	\N	27.7351468	12.4380581	\N
2963	Zawiya District	124	LY	Libya	ZA	\N	32.7630282	12.7364962	\N
458	Balzers	125	LI	Liechtenstein	01	\N	42.0528357	-88.0366848	\N
451	Eschen	125	LI	Liechtenstein	02	\N	40.7669574	-73.9522821	\N
457	Gamprin	125	LI	Liechtenstein	03	\N	47.213249	9.5025195	\N
455	Mauren	125	LI	Liechtenstein	04	\N	47.2189285	9.541735	\N
454	Planken	125	LI	Liechtenstein	05	\N	40.6650576	-73.504798	\N
453	Ruggell	125	LI	Liechtenstein	06	\N	47.2529222	9.5402127	\N
450	Schaan	125	LI	Liechtenstein	07	\N	47.120434	9.5941602	\N
449	Schellenberg	125	LI	Liechtenstein	08	\N	47.230966	9.5467843	\N
459	Triesen	125	LI	Liechtenstein	09	\N	47.1097988	9.5248296	\N
456	Triesenberg	125	LI	Liechtenstein	10	\N	47.1224511	9.5701985	\N
452	Vaduz	125	LI	Liechtenstein	11	\N	47.1410303	9.5209277	\N
1561	Akmenė District Municipality	126	LT	Lithuania	01	\N	56.2455029	22.7471169	\N
1605	Alytus City Municipality	126	LT	Lithuania	02	\N	54.3962938	24.0458761	\N
1574	Alytus County	126	LT	Lithuania	AL	\N	54.2000214	24.1512634	\N
1599	Alytus District Municipality	126	LT	Lithuania	03	\N	54.3297496	24.1960931	\N
1603	Birštonas Municipality	126	LT	Lithuania	05	\N	54.5669664	24.0093098	\N
1566	Biržai District Municipality	126	LT	Lithuania	06	\N	56.2017719	24.7560118	\N
1579	Druskininkai municipality	126	LT	Lithuania	07	\N	53.9933685	24.0342438	\N
1559	Elektrėnai municipality	126	LT	Lithuania	08	\N	54.7653934	24.7740583	\N
1562	Ignalina District Municipality	126	LT	Lithuania	09	\N	55.4090342	26.3284893	\N
1567	Jonava District Municipality	126	LT	Lithuania	10	\N	55.0727242	24.2793337	\N
1581	Joniškis District Municipality	126	LT	Lithuania	11	\N	56.236073	23.6136579	\N
1555	Jurbarkas District Municipality	126	LT	Lithuania	12	\N	55.077407	22.7419569	\N
1583	Kaišiadorys District Municipality	126	LT	Lithuania	13	\N	54.8588669	24.4277929	\N
1591	Kalvarija municipality	126	LT	Lithuania	14	\N	54.3761674	23.1920321	\N
1580	Kaunas City Municipality	126	LT	Lithuania	15	\N	54.9145326	23.9053518	\N
1556	Kaunas County	126	LT	Lithuania	KU	\N	54.9872863	23.9525736	\N
1565	Kaunas District Municipality	126	LT	Lithuania	16	\N	54.9936236	23.6324941	\N
1575	Kazlų Rūda municipality	126	LT	Lithuania	17	\N	54.7807526	23.4840243	\N
1584	Kėdainiai District Municipality	126	LT	Lithuania	18	\N	55.3560947	23.9832683	\N
1618	Kelmė District Municipality	126	LT	Lithuania	19	\N	55.6266352	22.878172	\N
1597	Klaipeda City Municipality	126	LT	Lithuania	20	\N	55.7032948	21.1442795	\N
1600	Klaipėda County	126	LT	Lithuania	KL	\N	55.6519744	21.3743956	\N
1604	Klaipėda District Municipality	126	LT	Lithuania	21	\N	55.6841615	21.4416464	\N
1571	Kretinga District Municipality	126	LT	Lithuania	22	\N	55.883842	21.2350919	\N
1585	Kupiškis District Municipality	126	LT	Lithuania	23	\N	55.8428741	25.0295816	\N
1611	Lazdijai District Municipality	126	LT	Lithuania	24	\N	54.2343267	23.5156505	\N
1570	Marijampolė County	126	LT	Lithuania	MR	\N	54.7819971	23.1341365	\N
1610	Marijampolė Municipality	126	LT	Lithuania	25	\N	54.5711094	23.4859371	\N
1557	Mažeikiai District Municipality	126	LT	Lithuania	26	\N	56.3092439	22.341468	\N
1582	Molėtai District Municipality	126	LT	Lithuania	27	\N	55.2265309	25.4180011	\N
1563	Neringa Municipality	126	LT	Lithuania	28	\N	55.4572403	21.0839005	\N
1612	Pagėgiai municipality	126	LT	Lithuania	29	\N	55.172132	21.9683614	\N
1595	Pakruojis District Municipality	126	LT	Lithuania	30	\N	56.0732605	23.9389906	\N
1588	Palanga City Municipality	126	LT	Lithuania	31	\N	55.920198	21.0677614	\N
1589	Panevėžys City Municipality	126	LT	Lithuania	32	\N	55.7347915	24.3574774	\N
1558	Panevėžys County	126	LT	Lithuania	PN	\N	55.9748049	25.0794767	\N
1614	Panevėžys District Municipality	126	LT	Lithuania	33	\N	55.6166728	24.3142283	\N
1616	Pasvalys District Municipality	126	LT	Lithuania	34	\N	56.0604619	24.396291	\N
1553	Plungė District Municipality	126	LT	Lithuania	35	\N	55.910784	21.8454069	\N
1578	Prienai District Municipality	126	LT	Lithuania	36	\N	54.638358	23.9468009	\N
1568	Radviliškis District Municipality	126	LT	Lithuania	37	\N	55.8108399	23.546487	\N
1587	Raseiniai District Municipality	126	LT	Lithuania	38	\N	55.3819499	23.1156129	\N
1590	Rietavas municipality	126	LT	Lithuania	39	\N	55.7021719	21.9986564	\N
1615	Rokiškis District Municipality	126	LT	Lithuania	40	\N	55.9555039	25.5859249	\N
1576	Šakiai District Municipality	126	LT	Lithuania	41	\N	54.952671	23.0480199	\N
1577	Šalčininkai District Municipality	126	LT	Lithuania	42	\N	54.309767	25.387564	\N
1609	Šiauliai City Municipality	126	LT	Lithuania	43	\N	55.9349085	23.3136823	\N
1586	Šiauliai County	126	LT	Lithuania	SA	\N	55.9985751	23.1380051	\N
1554	Šiauliai District Municipality	126	LT	Lithuania	44	\N	55.9721456	23.0332371	\N
1613	Šilalė District Municipality	126	LT	Lithuania	45	\N	55.49268	22.1845559	\N
1607	Šilutė District Municipality	126	LT	Lithuania	46	\N	55.350414	21.4659859	\N
1594	Širvintos District Municipality	126	LT	Lithuania	47	\N	55.043102	24.956981	\N
1617	Skuodas District Municipality	126	LT	Lithuania	48	\N	56.2702169	21.5214331	\N
1560	Švenčionys District Municipality	126	LT	Lithuania	49	\N	55.1028098	26.0071855	\N
1573	Tauragė County	126	LT	Lithuania	TA	\N	55.3072586	22.3572939	\N
1572	Tauragė District Municipality	126	LT	Lithuania	50	\N	55.250366	22.29095	\N
1569	Telšiai County	126	LT	Lithuania	TE	\N	56.1026616	22.1113915	\N
1608	Telšiai District Municipality	126	LT	Lithuania	51	\N	55.9175215	22.345184	\N
1593	Trakai District Municipality	126	LT	Lithuania	52	\N	54.6379113	24.9346894	\N
1596	Ukmergė District Municipality	126	LT	Lithuania	53	\N	55.245265	24.7760749	\N
1621	Utena County	126	LT	Lithuania	UT	\N	55.5318969	25.7904699	\N
1598	Utena District Municipality	126	LT	Lithuania	54	\N	55.5084614	25.6832642	\N
1602	Varėna District Municipality	126	LT	Lithuania	55	\N	54.220333	24.578997	\N
1620	Vilkaviškis District Municipality	126	LT	Lithuania	56	\N	54.651945	23.035155	\N
1606	Vilnius City Municipality	126	LT	Lithuania	57	\N	54.6710761	25.2878721	\N
1601	Vilnius County	126	LT	Lithuania	VL	\N	54.8086502	25.2182139	\N
1592	Vilnius District Municipality	126	LT	Lithuania	58	\N	54.7732578	25.5867113	\N
1564	Visaginas Municipality	126	LT	Lithuania	59	\N	55.594118	26.4307954	\N
1619	Zarasai District Municipality	126	LT	Lithuania	60	\N	55.7309609	26.245295	\N
1518	Canton of Capellen	127	LU	Luxembourg	CA	\N	49.6403931	5.9553846	\N
1521	Canton of Clervaux	127	LU	Luxembourg	CL	\N	50.0546313	6.0285875	\N
1513	Canton of Diekirch	127	LU	Luxembourg	DI	\N	49.8671784	6.1595633	\N
1515	Canton of Echternach	127	LU	Luxembourg	EC	\N	49.8114133	6.4175635	\N
1517	Canton of Esch-sur-Alzette	127	LU	Luxembourg	ES	\N	49.5008805	5.9860925	\N
1525	Canton of Grevenmacher	127	LU	Luxembourg	GR	\N	49.680841	6.4407593	\N
1527	Canton of Luxembourg	127	LU	Luxembourg	LU	\N	49.6301025	6.1520185	\N
1522	Canton of Mersch	127	LU	Luxembourg	ME	\N	49.7542906	6.1292185	\N
1516	Canton of Redange	127	LU	Luxembourg	RD	\N	49.76455	5.88948	\N
1519	Canton of Remich	127	LU	Luxembourg	RM	\N	49.545017	6.3674222	\N
1523	Canton of Vianden	127	LU	Luxembourg	VD	\N	49.9341924	6.2019917	\N
1526	Canton of Wiltz	127	LU	Luxembourg	WI	\N	49.96622	5.9324306	\N
1524	Diekirch District	127	LU	Luxembourg	D	\N	49.867172	6.1596362	\N
1520	Grevenmacher District	127	LU	Luxembourg	G	\N	49.680851	6.4407524	\N
1514	Luxembourg District	127	LU	Luxembourg	L	\N	49.5953706	6.1333178	\N
703	Aerodrom Municipality	129	MK	Macedonia	01	\N	41.9464363	21.4931713	\N
656	Aračinovo Municipality	129	MK	Macedonia	02	\N	42.0247381	21.5766407	\N
716	Berovo Municipality	129	MK	Macedonia	03	\N	41.6661929	22.762883	\N
679	Bitola Municipality	129	MK	Macedonia	04	\N	41.0363302	21.3321974	\N
649	Bogdanci Municipality	129	MK	Macedonia	05	\N	41.1869616	22.5960268	\N
721	Bogovinje Municipality	129	MK	Macedonia	06	\N	41.9236371	20.9163887	\N
652	Bosilovo Municipality	129	MK	Macedonia	07	\N	41.4904864	22.7867174	\N
660	Brvenica Municipality	129	MK	Macedonia	08	\N	41.9681482	20.9819586	\N
694	Butel Municipality	129	MK	Macedonia	09	\N	42.0895068	21.463361	\N
704	Čair Municipality	129	MK	Macedonia	79	\N	41.9930355	21.4365318	\N
676	Čaška Municipality	129	MK	Macedonia	80	\N	41.647438	21.6914115	\N
702	Centar Municipality	129	MK	Macedonia	77	\N	41.9698934	21.4216267	\N
720	Centar Župa Municipality	129	MK	Macedonia	78	\N	41.4652259	20.5930548	\N
644	Češinovo-Obleševo Municipality	129	MK	Macedonia	81	\N	41.8639316	22.262246	\N
715	Čučer-Sandevo Municipality	129	MK	Macedonia	82	\N	42.1483946	21.4037407	\N
645	Debarca Municipality	129	MK	Macedonia	22	\N	41.3584077	20.8552919	\N
695	Delčevo Municipality	129	MK	Macedonia	23	\N	41.9684387	22.762883	\N
687	Demir Hisar Municipality	129	MK	Macedonia	25	\N	41.227083	21.1414226	\N
655	Demir Kapija Municipality	129	MK	Macedonia	24	\N	41.3795538	22.2145571	\N
697	Dojran Municipality	129	MK	Macedonia	26	\N	41.2436672	22.6913764	\N
675	Dolneni Municipality	129	MK	Macedonia	27	\N	41.4640935	21.4037407	\N
657	Drugovo Municipality	129	MK	Macedonia	28	\N	41.4408153	20.9268201	\N
707	Gazi Baba Municipality	129	MK	Macedonia	17	\N	42.0162961	21.4991334	\N
648	Gevgelija Municipality	129	MK	Macedonia	18	\N	41.2118606	22.3814624	\N
722	Gjorče Petrov Municipality	129	MK	Macedonia	29	\N	42.0606374	21.3202736	\N
693	Gostivar Municipality	129	MK	Macedonia	19	\N	41.8025541	20.9089378	\N
708	Gradsko Municipality	129	MK	Macedonia	20	\N	41.5991608	21.8807064	\N
684	Greater Skopje	129	MK	Macedonia	85	\N	41.9981294	21.4254355	\N
690	Ilinden Municipality	129	MK	Macedonia	34	\N	41.9957443	21.5676975	\N
678	Jegunovce Municipality	129	MK	Macedonia	35	\N	42.074072	21.1220478	\N
674	Karbinci	129	MK	Macedonia	37	\N	41.8180159	22.2324758	\N
681	Karpoš Municipality	129	MK	Macedonia	38	\N	41.9709661	21.3918168	\N
713	Kavadarci Municipality	129	MK	Macedonia	36	\N	41.2890068	21.9999435	\N
688	Kičevo Municipality	129	MK	Macedonia	40	\N	41.5129112	20.9525065	\N
686	Kisela Voda Municipality	129	MK	Macedonia	39	\N	41.92748	21.4931713	\N
723	Kočani Municipality	129	MK	Macedonia	42	\N	41.9858374	22.4053046	\N
665	Konče Municipality	129	MK	Macedonia	41	\N	41.5171011	22.3814624	\N
641	Kratovo Municipality	129	MK	Macedonia	43	\N	42.0537141	22.0714835	\N
677	Kriva Palanka Municipality	129	MK	Macedonia	44	\N	42.2058454	22.3307965	\N
647	Krivogaštani Municipality	129	MK	Macedonia	45	\N	41.3082306	21.3679689	\N
714	Kruševo Municipality	129	MK	Macedonia	46	\N	41.3769331	21.2606554	\N
683	Kumanovo Municipality	129	MK	Macedonia	47	\N	42.0732613	21.7853143	\N
659	Lipkovo Municipality	129	MK	Macedonia	48	\N	42.2006626	21.6183755	\N
705	Lozovo Municipality	129	MK	Macedonia	49	\N	41.7818139	21.9000827	\N
701	Makedonska Kamenica Municipality	129	MK	Macedonia	51	\N	42.0694604	22.548349	\N
692	Makedonski Brod Municipality	129	MK	Macedonia	52	\N	41.5133088	21.2174329	\N
669	Mavrovo and Rostuša Municipality	129	MK	Macedonia	50	\N	41.6092427	20.6012488	\N
653	Mogila Municipality	129	MK	Macedonia	53	\N	41.1479645	21.4514369	\N
664	Negotino Municipality	129	MK	Macedonia	54	\N	41.4989985	22.0953297	\N
696	Novaci Municipality	129	MK	Macedonia	55	\N	41.0442661	21.4588894	\N
718	Novo Selo Municipality	129	MK	Macedonia	56	\N	41.432558	22.8820489	\N
699	Ohrid Municipality	129	MK	Macedonia	58	\N	41.0682088	20.7599266	\N
682	Oslomej Municipality	129	MK	Macedonia	57	\N	41.5758391	21.022196	\N
685	Pehčevo Municipality	129	MK	Macedonia	60	\N	41.7737132	22.8820489	\N
698	Petrovec Municipality	129	MK	Macedonia	59	\N	41.9029897	21.689921	\N
670	Plasnica Municipality	129	MK	Macedonia	61	\N	41.4546349	21.1056539	\N
666	Prilep Municipality	129	MK	Macedonia	62	\N	41.2693142	21.7137694	\N
646	Probištip Municipality	129	MK	Macedonia	63	\N	41.9589146	22.166867	\N
709	Radoviš Municipality	129	MK	Macedonia	64	\N	41.6495531	22.4768287	\N
717	Rankovce Municipality	129	MK	Macedonia	65	\N	42.1808141	22.0953297	\N
712	Resen Municipality	129	MK	Macedonia	66	\N	40.9368093	21.0460407	\N
691	Rosoman Municipality	129	MK	Macedonia	67	\N	41.4848006	21.8807064	\N
667	Saraj Municipality	129	MK	Macedonia	68	\N	41.9869496	21.2606554	\N
719	Sopište Municipality	129	MK	Macedonia	70	\N	41.8638492	21.3083499	\N
643	Staro Nagoričane Municipality	129	MK	Macedonia	71	\N	42.2191692	21.9045541	\N
661	Štip Municipality	129	MK	Macedonia	83	\N	41.7079297	22.1907122	\N
700	Struga Municipality	129	MK	Macedonia	72	\N	41.3173744	20.6645683	\N
710	Strumica Municipality	129	MK	Macedonia	73	\N	41.4378004	22.6427428	\N
711	Studeničani Municipality	129	MK	Macedonia	74	\N	41.9225639	21.5363965	\N
680	Šuto Orizari Municipality	129	MK	Macedonia	84	\N	42.0290416	21.4097027	\N
640	Sveti Nikole Municipality	129	MK	Macedonia	69	\N	41.8980312	21.9999435	\N
654	Tearce Municipality	129	MK	Macedonia	75	\N	42.0777511	21.0534923	\N
663	Tetovo Municipality	129	MK	Macedonia	76	\N	42.027486	20.9506636	\N
671	Valandovo Municipality	129	MK	Macedonia	10	\N	41.3211909	22.5006693	\N
658	Vasilevo Municipality	129	MK	Macedonia	11	\N	41.4741699	22.6422128	\N
651	Veles Municipality	129	MK	Macedonia	13	\N	41.7274426	21.7137694	\N
662	Vevčani Municipality	129	MK	Macedonia	12	\N	41.2407543	20.5915649	\N
672	Vinica Municipality	129	MK	Macedonia	14	\N	41.857102	22.5721881	\N
650	Vraneštica Municipality	129	MK	Macedonia	15	\N	41.4829087	21.0579632	\N
689	Vrapčište Municipality	129	MK	Macedonia	16	\N	41.879116	20.83145	\N
642	Zajas Municipality	129	MK	Macedonia	31	\N	41.6030328	20.8791343	\N
706	Zelenikovo Municipality	129	MK	Macedonia	32	\N	41.8733812	21.602725	\N
668	Želino Municipality	129	MK	Macedonia	30	\N	41.9006531	21.1175767	\N
673	Zrnovci Municipality	129	MK	Macedonia	33	\N	41.8228221	22.4172256	\N
2951	Antananarivo Province	130	MG	Madagascar	T	\N	-18.7051474	46.8252838	\N
2950	Antsiranana Province	130	MG	Madagascar	D	\N	-13.771539	49.5279996	\N
2948	Fianarantsoa Province	130	MG	Madagascar	F	\N	-22.353624	46.8252838	\N
2953	Mahajanga Province	130	MG	Madagascar	M	\N	-16.523883	46.516262	\N
2952	Toamasina Province	130	MG	Madagascar	A	\N	-18.1442811	49.3957836	\N
2949	Toliara Province	130	MG	Madagascar	U	\N	-23.3516191	43.6854936	\N
3096	Balaka District	131	MW	Malawi	BA	\N	-15.0506595	35.0828588	\N
3102	Blantyre District	131	MW	Malawi	BL	\N	-15.6778541	34.9506625	\N
3092	Central Region	131	MW	Malawi	C	\N	\N	\N	\N
3107	Chikwawa District	131	MW	Malawi	CK	\N	-16.1958446	34.7740793	\N
3109	Chiradzulu District	131	MW	Malawi	CR	\N	-15.7423151	35.2587964	\N
3087	Chitipa district	131	MW	Malawi	CT	\N	-9.7037655	33.2700253	\N
3097	Dedza District	131	MW	Malawi	DE	\N	-14.1894585	34.2421597	\N
3090	Dowa District	131	MW	Malawi	DO	\N	-13.6041256	33.8857747	\N
3091	Karonga District	131	MW	Malawi	KR	\N	-9.9036365	33.9750018	\N
3094	Kasungu District	131	MW	Malawi	KS	\N	-13.1367065	33.258793	\N
3093	Likoma District	131	MW	Malawi	LK	\N	-12.0584005	34.7354031	\N
3101	Lilongwe District	131	MW	Malawi	LI	\N	-14.0475228	33.617577	\N
3082	Machinga District	131	MW	Malawi	MH	\N	-14.9407263	35.4781926	\N
3110	Mangochi District	131	MW	Malawi	MG	\N	-14.1388248	35.0388164	\N
3099	Mchinji District	131	MW	Malawi	MC	\N	-13.7401525	32.9888319	\N
3103	Mulanje District	131	MW	Malawi	MU	\N	-15.9346434	35.5220012	\N
3084	Mwanza District	131	MW	Malawi	MW	\N	-2.4671197	32.8986812	\N
3104	Mzimba District	131	MW	Malawi	MZ	\N	-11.7475452	33.5280072	\N
3095	Nkhata Bay District	131	MW	Malawi	NB	\N	-11.7185042	34.3310364	\N
3100	Nkhotakota District	131	MW	Malawi	NK	\N	-12.7541961	34.2421597	\N
3105	Northern Region	131	MW	Malawi	N	\N	\N	\N	\N
3085	Nsanje District	131	MW	Malawi	NS	\N	-16.7288202	35.1708741	\N
3088	Ntcheu District	131	MW	Malawi	NU	\N	-14.9037538	34.7740793	\N
3111	Ntchisi District	131	MW	Malawi	NI	\N	-13.2841992	33.8857747	\N
3108	Phalombe District	131	MW	Malawi	PH	\N	-15.7092038	35.6532848	\N
3089	Rumphi District	131	MW	Malawi	RU	\N	-10.7851537	34.3310364	\N
3086	Salima District	131	MW	Malawi	SA	\N	-13.6809586	34.4198243	\N
3106	Southern Region	131	MW	Malawi	S	\N	32.7504957	-97.3315476	\N
3098	Thyolo District	131	MW	Malawi	TH	\N	-16.1299177	35.1268781	\N
3083	Zomba District	131	MW	Malawi	ZO	\N	-15.3765857	35.3356518	\N
1950	Johor	132	MY	Malaysia	01	\N	1.4853682	103.7618154	\N
1947	Kedah	132	MY	Malaysia	02	\N	6.1183964	100.3684595	\N
1946	Kelantan	132	MY	Malaysia	03	\N	6.1253969	102.238071	\N
1949	Kuala Lumpur	132	MY	Malaysia	14	\N	3.139003	101.686855	\N
1935	Labuan	132	MY	Malaysia	15	\N	5.2831456	115.230825	\N
1941	Malacca	132	MY	Malaysia	04	\N	2.189594	102.2500868	\N
1948	Negeri Sembilan	132	MY	Malaysia	05	\N	2.7258058	101.9423782	\N
1940	Pahang	132	MY	Malaysia	06	\N	3.8126318	103.3256204	\N
1939	Penang	132	MY	Malaysia	07	\N	5.4163935	100.3326786	\N
1943	Perak	132	MY	Malaysia	08	\N	4.5921126	101.090109	\N
1938	Perlis	132	MY	Malaysia	09	\N	29.9227094	-90.1228559	\N
1945	Putrajaya	132	MY	Malaysia	16	\N	2.926361	101.696445	\N
1936	Sabah	132	MY	Malaysia	12	\N	5.9788398	116.0753199	\N
1937	Sarawak	132	MY	Malaysia	13	\N	1.5532783	110.3592127	\N
1944	Selangor	132	MY	Malaysia	10	\N	3.0738379	101.5183469	\N
1942	Terengganu	132	MY	Malaysia	11	\N	5.3116916	103.1324154	\N
2594	Addu Atoll	133	MV	Maldives	01	\N	-0.6300995	73.1585626	\N
2587	Alif Alif Atoll	133	MV	Maldives	02	\N	4.085	72.8515479	\N
2600	Alif Dhaal Atoll	133	MV	Maldives	00	\N	3.6543302	72.8042797	\N
2604	Central Province	133	MV	Maldives	CE	\N	\N	\N	\N
2590	Dhaalu Atoll	133	MV	Maldives	17	\N	2.8468502	72.9460566	\N
2599	Faafu Atoll	133	MV	Maldives	14	\N	3.2309409	72.9460566	\N
2598	Gaafu Alif Atoll	133	MV	Maldives	27	\N	0.6124813	73.323708	\N
2603	Gaafu Dhaalu Atoll	133	MV	Maldives	28	\N	0.358804	73.1821623	\N
2595	Gnaviyani Atoll	133	MV	Maldives	29	\N	-0.3006425	73.4239143	\N
2586	Haa Alif Atoll	133	MV	Maldives	07	\N	6.9903488	72.9460566	\N
2597	Haa Dhaalu Atoll	133	MV	Maldives	23	\N	6.5782717	72.9460566	\N
2596	Kaafu Atoll	133	MV	Maldives	26	\N	4.4558979	73.5594128	\N
2601	Laamu Atoll	133	MV	Maldives	05	\N	1.9430737	73.4180211	\N
2607	Lhaviyani Atoll	133	MV	Maldives	03	\N	5.3747021	73.5122928	\N
2609	Malé	133	MV	Maldives	MLE	\N	46.3488867	10.9072489	\N
2608	Meemu Atoll	133	MV	Maldives	12	\N	3.0090345	73.5122928	\N
2592	Noonu Atoll	133	MV	Maldives	25	\N	5.8551276	73.323708	\N
2589	North Central Province	133	MV	Maldives	NC	\N	\N	\N	\N
2588	North Province	133	MV	Maldives	NO	\N	8.8855027	80.2767327	\N
2602	Raa Atoll	133	MV	Maldives	13	\N	5.6006457	72.9460566	\N
2585	Shaviyani Atoll	133	MV	Maldives	24	\N	6.17511	73.1349605	\N
2606	South Central Province	133	MV	Maldives	SC	\N	7.2564996	80.7214417	\N
2605	South Province	133	MV	Maldives	SU	\N	-21.7482006	166.1783739	\N
2591	Thaa Atoll	133	MV	Maldives	08	\N	2.4311161	73.1821623	\N
2593	Upper South Province	133	MV	Maldives	US	\N	0.2307	73.2794846	\N
2584	Vaavu Atoll	133	MV	Maldives	04	\N	3.3955438	73.5122928	\N
253	Bamako	134	ML	Mali	BKO	\N	12.6392316	-8.0028892	\N
258	Gao Region	134	ML	Mali	7	\N	16.9066332	1.5208624	\N
252	Kayes Region	134	ML	Mali	1	\N	14.0818308	-9.9018131	\N
257	Kidal Region	134	ML	Mali	8	\N	18.7986832	1.8318334	\N
250	Koulikoro Region	134	ML	Mali	2	\N	13.8018074	-7.4381355	\N
251	Ménaka Region	134	ML	Mali	9	\N	15.9156421	2.396174	\N
255	Mopti Region	134	ML	Mali	5	\N	14.6338039	-3.4195527	\N
249	Ségou Region	134	ML	Mali	4	\N	13.8394456	-6.0679194	\N
254	Sikasso Region	134	ML	Mali	3	\N	10.8905186	-7.4381355	\N
256	Taoudénit Region	134	ML	Mali	10	\N	22.6764132	-3.9789143	\N
248	Tombouctou Region	134	ML	Mali	6	\N	21.0526706	-3.743509	\N
110	Attard	135	MT	Malta	01	\N	35.8904967	14.4199322	\N
108	Balzan	135	MT	Malta	02	\N	35.8957414	14.4534065	\N
107	Birgu	135	MT	Malta	03	\N	35.8879214	14.522562	\N
97	Birkirkara	135	MT	Malta	04	\N	35.8954706	14.4665072	\N
88	Birżebbuġa	135	MT	Malta	05	\N	35.8135989	14.5247463	\N
138	Cospicua	135	MT	Malta	06	\N	35.8806753	14.5218338	\N
117	Dingli	135	MT	Malta	07	\N	35.8627309	14.3850107	\N
129	Fgura	135	MT	Malta	08	\N	35.8738269	14.5232901	\N
84	Floriana	135	MT	Malta	09	\N	45.4952185	-73.7139576	\N
134	Fontana	135	MT	Malta	10	\N	34.0922335	-117.435048	\N
130	Għajnsielem	135	MT	Malta	13	\N	36.0247966	14.2802961	\N
92	Għarb	135	MT	Malta	14	\N	36.068909	14.2018098	\N
120	Għargħur	135	MT	Malta	15	\N	35.9220569	14.4563176	\N
106	Għasri	135	MT	Malta	16	\N	36.0668075	14.2192475	\N
124	Għaxaq	135	MT	Malta	17	\N	35.8440359	14.516009	\N
118	Gudja	135	MT	Malta	11	\N	35.8469803	14.502904	\N
113	Gżira	135	MT	Malta	12	\N	35.905897	14.4953338	\N
105	Ħamrun	135	MT	Malta	18	\N	35.8861237	14.4883442	\N
93	Iklin	135	MT	Malta	19	\N	35.9098774	14.4577732	\N
99	Kalkara	135	MT	Malta	21	\N	35.8914242	14.5320278	\N
91	Kerċem	135	MT	Malta	22	\N	36.0447939	14.2250605	\N
82	Kirkop	135	MT	Malta	23	\N	35.8437862	14.4854324	\N
126	Lija	135	MT	Malta	24	\N	49.180076	-123.103317	\N
77	Luqa	135	MT	Malta	25	\N	35.8582865	14.4868883	\N
128	Marsa	135	MT	Malta	26	\N	34.0319587	-118.4455535	\N
137	Marsaskala	135	MT	Malta	27	\N	35.860364	14.5567876	\N
78	Marsaxlokk	135	MT	Malta	28	\N	35.8411699	14.5393097	\N
89	Mdina	135	MT	Malta	29	\N	35.888093	14.4068357	\N
102	Mellieħa	135	MT	Malta	30	\N	35.9523529	14.3500975	\N
109	Mġarr	135	MT	Malta	31	\N	35.9189327	14.3617343	\N
140	Mosta	135	MT	Malta	32	\N	35.9141504	14.4228427	\N
74	Mqabba	135	MT	Malta	33	\N	35.8444143	14.4694186	\N
96	Msida	135	MT	Malta	34	\N	35.8956388	14.4868883	\N
131	Mtarfa	135	MT	Malta	35	\N	35.8895125	14.3951953	\N
132	Munxar	135	MT	Malta	36	\N	36.0288058	14.2250605	\N
133	Nadur	135	MT	Malta	37	\N	36.0447019	14.2919273	\N
112	Naxxar	135	MT	Malta	38	\N	35.9317518	14.4315746	\N
115	Paola	135	MT	Malta	39	\N	38.5722353	-94.8791294	\N
125	Pembroke	135	MT	Malta	40	\N	34.6801626	-79.1950373	\N
127	Pietà	135	MT	Malta	41	\N	42.21862	-83.734647	\N
79	Qala	135	MT	Malta	42	\N	36.0388628	14.318101	\N
119	Qormi	135	MT	Malta	43	\N	35.8764388	14.4694186	\N
111	Qrendi	135	MT	Malta	44	\N	35.8328488	14.4548621	\N
83	Rabat	135	MT	Malta	46	\N	33.9715904	-6.8498129	\N
87	Saint Lawrence	135	MT	Malta	50	\N	38.9578056	-95.2565689	\N
75	San Ġwann	135	MT	Malta	49	\N	35.9077365	14.4752416	\N
116	Sannat	135	MT	Malta	52	\N	36.0192643	14.2599437	\N
94	Santa Luċija	135	MT	Malta	53	\N	35.856142	14.50436	\N
90	Santa Venera	135	MT	Malta	54	\N	35.8902201	14.4766974	\N
136	Senglea	135	MT	Malta	20	\N	35.8873041	14.5167371	\N
98	Siġġiewi	135	MT	Malta	55	\N	35.8463742	14.4315746	\N
104	Sliema	135	MT	Malta	56	\N	35.9110081	14.502904	\N
100	St. Julian's	135	MT	Malta	48	\N	42.2122513	-85.8917127	\N
139	St. Paul's Bay	135	MT	Malta	51	\N	35.936017	14.3966503	\N
86	Swieqi	135	MT	Malta	57	\N	35.9191182	14.4694186	\N
122	Ta' Xbiex	135	MT	Malta	58	\N	35.8991448	14.4963519	\N
103	Tarxien	135	MT	Malta	59	\N	35.8672552	14.5116405	\N
95	Valletta	135	MT	Malta	60	\N	35.8989085	14.5145528	\N
101	Victoria	135	MT	Malta	45	\N	28.8052674	-97.0035982	\N
114	Xagħra	135	MT	Malta	61	\N	36.050845	14.267482	\N
121	Xewkija	135	MT	Malta	62	\N	36.0299236	14.2599437	\N
81	Xgħajra	135	MT	Malta	63	\N	35.8868282	14.5472391	\N
123	Żabbar	135	MT	Malta	64	\N	35.8724715	14.5451354	\N
85	Żebbuġ Gozo	135	MT	Malta	65	\N	36.0716403	14.245408	\N
80	Żebbuġ Malta	135	MT	Malta	66	\N	35.8764648	14.439084	\N
135	Żejtun	135	MT	Malta	67	\N	35.8548714	14.5363969	\N
76	Żurrieq	135	MT	Malta	68	\N	35.8216306	14.4810648	\N
2574	Ralik Chain	137	MH	Marshall Islands	L	\N	8.136146	164.8867956	\N
2573	Ratak Chain	137	MH	Marshall Islands	T	\N	10.2763276	170.5500937	\N
3344	Adrar	139	MR	Mauritania	07	region	19.8652176	-12.8054753	\N
3349	Assaba	139	MR	Mauritania	03	region	16.7759558	-11.5248055	\N
3339	Brakna	139	MR	Mauritania	05	region	17.2317561	-13.1740348	\N
3346	Dakhlet Nouadhibou	139	MR	Mauritania	08	region	20.5985588	-16.2522143	\N
3341	Gorgol	139	MR	Mauritania	04	region	15.9717357	-12.6216211	\N
3350	Guidimaka	139	MR	Mauritania	10	region	15.2557331	-12.2547919	\N
3338	Hodh Ech Chargui	139	MR	Mauritania	01	region	18.6737026	-7.092877	\N
3351	Hodh El Gharbi	139	MR	Mauritania	02	region	16.6912149	-9.5450974	\N
3342	Inchiri	139	MR	Mauritania	12	region	20.0280561	-15.4068079	\N
3343	Nouakchott-Nord	139	MR	Mauritania	14	region	18.1130205	-15.8994956	\N
3352	Nouakchott-Ouest	139	MR	Mauritania	13	region	18.1511357	-15.993491	\N
3347	Nouakchott-Sud	139	MR	Mauritania	15	region	17.9709288	-15.9464874	\N
3345	Tagant	139	MR	Mauritania	09	region	18.5467527	-9.9018131	\N
3340	Tiris Zemmour	139	MR	Mauritania	11	region	24.5773764	-9.9018131	\N
3348	Trarza	139	MR	Mauritania	06	region	17.8664964	-14.6587821	\N
3248	Agaléga	140	MU	Mauritius	AG	\N	-10.4	56.6166667	\N
3262	Beau Bassin-Rose Hill	140	MU	Mauritius	BR	\N	-20.2230305	57.468383	\N
3251	Cargados Carajos	140	MU	Mauritius	CC	\N	-16.583333	59.616667	\N
3255	Curepipe	140	MU	Mauritius	CU	\N	-20.3170872	57.5265289	\N
3254	Flacq District	140	MU	Mauritius	FL	\N	-20.2257836	57.7119274	\N
3264	Grand Port District	140	MU	Mauritius	GP	\N	-20.3851546	57.6665742	\N
3253	Moka District	140	MU	Mauritius	MO	\N	-20.2399782	57.575926	\N
3250	Pamplemousses District	140	MU	Mauritius	PA	\N	-20.1136008	57.575926	\N
3263	Plaines Wilhems District	140	MU	Mauritius	PW	\N	-20.3054872	57.4853561	\N
3256	Port Louis	140	MU	Mauritius	PU	\N	-20.1608912	57.5012222	\N
3260	Port Louis District	140	MU	Mauritius	PL	\N	-20.1608912	57.5012222	\N
3258	Quatre Bornes	140	MU	Mauritius	QB	\N	-20.2674718	57.4796981	\N
3261	Rivière du Rempart District	140	MU	Mauritius	RR	\N	-20.0560983	57.6552389	\N
3259	Rivière Noire District	140	MU	Mauritius	BL	\N	-20.3708492	57.3948649	\N
3249	Rodrigues	140	MU	Mauritius	RO	\N	-19.7245385	63.4272185	\N
3257	Savanne District	140	MU	Mauritius	SA	\N	-20.473953	57.4853561	\N
3252	Vacoas-Phoenix	140	MU	Mauritius	VP	\N	-20.2984026	57.4938355	\N
3456	Aguascalientes	142	MX	Mexico	AGU	state	21.8852562	-102.2915677	\N
3457	Baja California	142	MX	Mexico	BCN	state	30.8406338	-115.2837585	\N
3460	Baja California Sur	142	MX	Mexico	BCS	state	26.0444446	-111.6660725	\N
3475	Campeche	142	MX	Mexico	CAM	state	19.8301251	-90.5349087	\N
3451	Chiapas	142	MX	Mexico	CHP	state	16.7569318	-93.1292353	\N
3447	Chihuahua	142	MX	Mexico	CHH	state	28.6329957	-106.0691004	\N
3473	Ciudad de México	142	MX	Mexico	CDMX	federal district	19.4326077	-99.133208	\N
3471	Coahuila de Zaragoza	142	MX	Mexico	COA	state	27.058676	-101.7068294	\N
3472	Colima	142	MX	Mexico	COL	state	19.2452342	-103.7240868	\N
3453	Durango	142	MX	Mexico	DUR	state	37.27528	-107.8800667	\N
3450	Estado de México	142	MX	Mexico	MEX	state	23.634501	-102.552784	\N
3469	Guanajuato	142	MX	Mexico	GUA	state	21.0190145	-101.2573586	\N
3459	Guerrero	142	MX	Mexico	GRO	state	17.4391926	-99.5450974	\N
3470	Hidalgo	142	MX	Mexico	HID	state	26.1003547	-98.2630684	\N
4857	Jalisco	142	MX	Mexico	JAL	state	20.6595382	-103.3494376	\N
3474	Michoacán de Ocampo	142	MX	Mexico	MIC	state	19.5665192	-101.7068294	\N
3465	Morelos	142	MX	Mexico	MOR	state	18.6813049	-99.1013498	\N
3477	Nayarit	142	MX	Mexico	NAY	state	21.7513844	-104.8454619	\N
3452	Nuevo León	142	MX	Mexico	NLE	state	25.592172	-99.9961947	\N
3448	Oaxaca	142	MX	Mexico	OAX	state	17.0731842	-96.7265889	\N
3476	Puebla	142	MX	Mexico	PUE	state	19.0414398	-98.2062727	\N
3455	Querétaro	142	MX	Mexico	QUE	state	20.5887932	-100.3898881	\N
3467	Quintana Roo	142	MX	Mexico	ROO	state	19.1817393	-88.4791376	\N
3461	San Luis Potosí	142	MX	Mexico	SLP	state	22.1564699	-100.9855409	\N
3449	Sinaloa	142	MX	Mexico	SIN	state	25.1721091	-107.4795173	\N
3468	Sonora	142	MX	Mexico	SON	state	37.9829496	-120.3821724	\N
3454	Tabasco	142	MX	Mexico	TAB	state	17.8409173	-92.6189273	\N
3463	Tamaulipas	142	MX	Mexico	TAM	state	24.26694	-98.8362755	\N
3458	Tlaxcala	142	MX	Mexico	TLA	state	19.318154	-98.2374954	\N
3464	Veracruz de Ignacio de la Llave	142	MX	Mexico	VER	state	19.173773	-96.1342241	\N
3466	Yucatán	142	MX	Mexico	YUC	state	20.7098786	-89.0943377	\N
3462	Zacatecas	142	MX	Mexico	ZAC	state	22.7708555	-102.5832426	\N
2580	Chuuk State	143	FM	Micronesia	TRK	\N	7.1386759	151.5593065	\N
2583	Kosrae State	143	FM	Micronesia	KSA	\N	5.3095618	162.9814877	\N
2581	Pohnpei State	143	FM	Micronesia	PNI	\N	6.8541254	158.2623822	\N
2582	Yap State	143	FM	Micronesia	YAP	\N	8.671649	142.8439335	\N
4368	Anenii Noi District	144	MD	Moldova	AN	\N	46.8795663	29.2312175	\N
4393	Bălți Municipality	144	MD	Moldova	BA	\N	47.7539947	27.9184148	\N
4379	Basarabeasca District	144	MD	Moldova	BS	\N	46.423706	28.8935492	\N
4362	Bender Municipality	144	MD	Moldova	BD	\N	46.8227551	29.4620101	\N
4375	Briceni District	144	MD	Moldova	BR	\N	48.3632022	27.0750398	\N
4391	Cahul District	144	MD	Moldova	CA	\N	45.8939404	28.1890275	\N
4366	Călărași District	144	MD	Moldova	CL	\N	47.286946	28.274531	\N
4380	Cantemir District	144	MD	Moldova	CT	\N	46.2771742	28.2009653	\N
4365	Căușeni District	144	MD	Moldova	CS	\N	46.6554715	29.4091222	\N
4373	Chișinău Municipality	144	MD	Moldova	CU	\N	47.0104529	28.8638102	\N
4360	Cimișlia District	144	MD	Moldova	CM	\N	46.5250851	28.7721835	\N
4390	Criuleni District	144	MD	Moldova	CR	\N	47.2136114	29.1557519	\N
4384	Dondușeni District	144	MD	Moldova	DO	\N	48.2338305	27.5998087	\N
4392	Drochia District	144	MD	Moldova	DR	\N	48.0797788	27.8604114	\N
4383	Dubăsari District	144	MD	Moldova	DU	\N	47.2643942	29.1550348	\N
4387	Edineț District	144	MD	Moldova	ED	\N	48.1678991	27.2936143	\N
4381	Fălești District	144	MD	Moldova	FA	\N	47.5647725	27.7265593	\N
4370	Florești District	144	MD	Moldova	FL	\N	47.8667849	28.3391864	\N
4385	Gagauzia	144	MD	Moldova	GA	\N	46.0979435	28.6384645	\N
4367	Glodeni District	144	MD	Moldova	GL	\N	47.7790156	27.516801	\N
4382	Hîncești District	144	MD	Moldova	HI	\N	46.8281147	28.5850889	\N
4369	Ialoveni District	144	MD	Moldova	IA	\N	46.863086	28.8234218	\N
4363	Nisporeni District	144	MD	Moldova	NI	\N	47.0751349	28.1768155	\N
4389	Ocnița District	144	MD	Moldova	OC	\N	48.4110435	27.4768092	\N
4361	Orhei District	144	MD	Moldova	OR	\N	47.38604	28.8303082	\N
4394	Rezina District	144	MD	Moldova	RE	\N	47.7180447	28.8871024	\N
4376	Rîșcani District	144	MD	Moldova	RI	\N	47.9070153	27.5374996	\N
4364	Sîngerei District	144	MD	Moldova	SI	\N	47.6389134	28.1371816	\N
4388	Șoldănești District	144	MD	Moldova	SD	\N	47.8147389	28.7889586	\N
4374	Soroca District	144	MD	Moldova	SO	\N	48.1549743	28.2870783	\N
4378	Ștefan Vodă District	144	MD	Moldova	SV	\N	46.5540488	29.702242	\N
4377	Strășeni District	144	MD	Moldova	ST	\N	47.1450267	28.6136736	\N
4372	Taraclia District	144	MD	Moldova	TA	\N	45.898651	28.6671644	\N
4371	Telenești District	144	MD	Moldova	TE	\N	47.4983962	28.3676019	\N
4395	Transnistria autonomous territorial unit	144	MD	Moldova	SN	\N	47.2152972	29.4638054	\N
4386	Ungheni District	144	MD	Moldova	UN	\N	47.2305767	27.7892661	\N
4917	La Colle	145	MC	Monaco	CL	\N	43.7327465	7.4137276	\N
4918	La Condamine	145	MC	Monaco	CO	\N	43.7350665	7.419906	\N
4919	Moneghetti	145	MC	Monaco	MG	\N	43.7364927	7.4153383	\N
1973	Arkhangai Province	146	MN	Mongolia	073	\N	47.8971101	100.7240165	\N
1969	Bayan-Ölgii Province	146	MN	Mongolia	071	\N	48.3983254	89.6625915	\N
1976	Bayankhongor Province	146	MN	Mongolia	069	\N	45.1526707	100.1073667	\N
1961	Bulgan Province	146	MN	Mongolia	067	\N	48.9690913	102.8831723	\N
1962	Darkhan-Uul Province	146	MN	Mongolia	037	\N	49.4648434	105.9745919	\N
1963	Dornod Province	146	MN	Mongolia	061	\N	47.4658154	115.392712	\N
1981	Dornogovi Province	146	MN	Mongolia	063	\N	43.9653889	109.1773459	\N
1970	Dundgovi Province	146	MN	Mongolia	059	\N	45.5822786	106.7644209	\N
1972	Govi-Altai Province	146	MN	Mongolia	065	\N	45.4511227	95.8505766	\N
1978	Govisümber Province	146	MN	Mongolia	064	\N	46.4762754	108.5570627	\N
1974	Khentii Province	146	MN	Mongolia	039	\N	47.6081209	109.9372856	\N
1964	Khovd Province	146	MN	Mongolia	043	\N	47.1129654	92.3110752	\N
1975	Khövsgöl Province	146	MN	Mongolia	041	\N	50.2204484	100.3213768	\N
1967	Ömnögovi Province	146	MN	Mongolia	053	\N	43.500024	104.2861116	\N
1966	Orkhon Province	146	MN	Mongolia	035	\N	49.004705	104.3016527	\N
1965	Övörkhangai Province	146	MN	Mongolia	055	\N	45.7624392	103.0917032	\N
1980	Selenge Province	146	MN	Mongolia	049	\N	50.0059273	106.4434108	\N
1977	Sükhbaatar Province	146	MN	Mongolia	051	\N	46.5653163	113.5380836	\N
1968	Töv Province	146	MN	Mongolia	047	\N	47.2124056	106.41541	\N
1971	Uvs Province	146	MN	Mongolia	046	\N	49.6449707	93.2736576	\N
1979	Zavkhan Province	146	MN	Mongolia	057	\N	48.2388147	96.0703019	\N
23	Andrijevica Municipality	147	ME	Montenegro	01	\N	42.7362477	19.7859556	\N
13	Bar Municipality	147	ME	Montenegro	02	\N	42.1278119	19.140438	\N
21	Berane Municipality	147	ME	Montenegro	03	\N	42.8257289	19.9020509	\N
25	Bijelo Polje Municipality	147	ME	Montenegro	04	\N	43.0846526	19.7115472	\N
30	Budva Municipality	147	ME	Montenegro	05	\N	42.314072	18.8313832	\N
14	Danilovgrad Municipality	147	ME	Montenegro	07	\N	42.58357	19.140438	\N
24	Gusinje Municipality	147	ME	Montenegro	22	\N	42.5563455	19.8306051	\N
31	Kolašin Municipality	147	ME	Montenegro	09	\N	42.7601916	19.4259114	\N
26	Kotor Municipality	147	ME	Montenegro	10	\N	42.5740261	18.6413145	\N
22	Mojkovac Municipality	147	ME	Montenegro	11	\N	42.9688018	19.5211063	\N
17	Nikšić Municipality	147	ME	Montenegro	12	\N	42.7997184	18.7600963	\N
28	Old Royal Capital Cetinje	147	ME	Montenegro	06	\N	42.3930959	18.9115964	\N
12	Petnjica Municipality	147	ME	Montenegro	23	\N	42.935348	20.0211449	\N
19	Plav Municipality	147	ME	Montenegro	13	\N	42.6001337	19.9407541	\N
20	Pljevlja Municipality	147	ME	Montenegro	14	\N	43.2723383	19.2831531	\N
16	Plužine Municipality	147	ME	Montenegro	15	\N	43.1593384	18.8551484	\N
27	Podgorica Municipality	147	ME	Montenegro	16	\N	42.3693834	19.2831531	\N
15	Rožaje Municipality	147	ME	Montenegro	17	\N	42.8408389	20.1670628	\N
18	Šavnik Municipality	147	ME	Montenegro	18	\N	42.9603756	19.140438	\N
29	Tivat Municipality	147	ME	Montenegro	19	\N	42.42348	18.7185184	\N
33	Ulcinj Municipality	147	ME	Montenegro	20	\N	41.9652795	19.3069432	\N
32	Žabljak Municipality	147	ME	Montenegro	21	\N	43.1555152	19.1226018	\N
4928	Agadir-Ida-Ou-Tanane	149	MA	Morocco	AGD	prefecture	30.6462091	-9.8339061	\N
3320	Al Haouz	149	MA	Morocco	HAO	province	31.2956729	-7.87216	\N
3267	Al Hoceïma	149	MA	Morocco	HOC	province	35.2445589	-3.9317468	\N
3266	Aousserd (EH)	149	MA	Morocco	AOU	province	22.5521538	-14.3297353	\N
3297	Assa-Zag (EH-partial)	149	MA	Morocco	ASZ	province	28.1402395	-9.7232673	\N
3321	Azilal	149	MA	Morocco	AZI	province	32.004262	-6.5783387	\N
3272	Béni Mellal	149	MA	Morocco	BEM	province	32.342443	-6.375799	\N
3278	Béni Mellal-Khénifra	149	MA	Morocco	05	region	32.5719184	-6.0679194	\N
3304	Benslimane	149	MA	Morocco	BES	province	33.6189698	-7.1305536	\N
3285	Berkane	149	MA	Morocco	BER	province	34.8840876	-2.341887	\N
4929	Berrechid	149	MA	Morocco	BRR	province	33.2602523	-7.5984837	\N
3275	Boujdour (EH)	149	MA	Morocco	BOD	province	26.1252493	-14.4847347	\N
3270	Boulemane	149	MA	Morocco	BOM	province	33.3625159	-4.7303397	\N
4930	Casablanca	149	MA	Morocco	CAS	prefecture	33.5722678	-7.6570326	\N
3303	Casablanca-Settat	149	MA	Morocco	06	region	33.2160872	-7.4381355	\N
3310	Chefchaouen	149	MA	Morocco	CHE	province	35.018172	-5.1432068	\N
3274	Chichaoua	149	MA	Morocco	CHI	province	31.5383581	-8.7646388	\N
3302	Chtouka-Ait Baha	149	MA	Morocco	CHT	province	30.1072422	-9.2785583	\N
3306	Dakhla-Oued Ed-Dahab (EH)	149	MA	Morocco	12	region	22.7337892	-14.2861116	\N
3290	Drâa-Tafilalet	149	MA	Morocco	08	region	31.1499538	-5.3939551	\N
4931	Driouch	149	MA	Morocco	DRI	province	34.976032	-3.3964493	\N
3291	El Hajeb	149	MA	Morocco	HAJ	province	33.685735	-5.3677844	\N
3280	El Jadida	149	MA	Morocco	JDI	province	33.2316326	-8.5007116	\N
3309	El Kelâa des Sraghna	149	MA	Morocco	KES	province	32.0522767	-7.3516558	\N
3299	Errachidia	149	MA	Morocco	ERR	province	31.9051275	-4.7277528	\N
3292	Es-Semara (EH-partial)	149	MA	Morocco	ESM	province	26.741856	-11.6783671	\N
3316	Essaouira	149	MA	Morocco	ESI	province	31.5084926	-9.7595041	\N
3300	Fahs-Anjra	149	MA	Morocco	FAH	province	35.7601992	-5.6668306	\N
4932	Fès	149	MA	Morocco	FES	prefecture	34.0239579	-5.0367599	\N
3313	Fès-Meknès	149	MA	Morocco	03	region	34.062529	-4.7277528	\N
3301	Figuig	149	MA	Morocco	FIG	province	32.1092613	-1.229806	\N
4933	Fquih Ben Salah	149	MA	Morocco	FQH	province	32.500168	-6.7100717	\N
3265	Guelmim	149	MA	Morocco	GUE	province	28.9883659	-10.0527498	\N
3305	Guelmim-Oued Noun (EH-partial)	149	MA	Morocco	10	region	28.4844281	-10.0807298	\N
4934	Guercif	149	MA	Morocco	GUF	province	34.2345036	-3.3813005	\N
3325	Ifrane	149	MA	Morocco	IFR	province	33.5228062	-5.1109552	\N
3294	Inezgane-Ait Melloul	149	MA	Morocco	INE	prefecture	30.3509098	-9.389511	\N
3307	Jerada	149	MA	Morocco	JRA	province	34.3061791	-2.1794136	\N
3308	Kénitra	149	MA	Morocco	KEN	province	34.2540503	-6.5890166	\N
3276	Khémisset	149	MA	Morocco	KHE	province	33.8153704	-6.0573302	\N
3317	Khénifra	149	MA	Morocco	KHN	province	32.9340471	-5.661571	\N
3326	Khouribga	149	MA	Morocco	KHO	province	32.886023	-6.9208655	\N
3271	L'Oriental	149	MA	Morocco	02	region	37.069683	-94.512277	\N
3293	Laâyoune (EH)	149	MA	Morocco	LAA	province	27.1500384	-13.1990758	\N
3298	Laâyoune-Sakia El Hamra (EH-partial)	149	MA	Morocco	11	region	27.8683194	-11.9804613	\N
3268	Larache	149	MA	Morocco	LAR	province	35.1744271	-6.1473964	\N
4936	M’diq-Fnideq	149	MA	Morocco	MDF	prefecture	35.7733019	-5.51433	\N
4935	Marrakech	149	MA	Morocco	MAR	prefecture	31.6346023	-8.0778932	\N
3288	Marrakesh-Safi	149	MA	Morocco	07	region	31.7330833	-8.1338558	\N
3284	Médiouna	149	MA	Morocco	MED	province	33.4540939	-7.516602	\N
4937	Meknès	149	MA	Morocco	MEK	prefecture	33.881	-5.5730397	\N
4938	Midelt	149	MA	Morocco	MID	province	32.6855079	-4.7501709	\N
4939	Mohammadia	149	MA	Morocco	MOH	prefecture	33.6873749	-7.4239142	\N
3315	Moulay Yacoub	149	MA	Morocco	MOU	province	34.0874479	-5.1784019	\N
3281	Nador	149	MA	Morocco	NAD	province	34.9171926	-2.8577105	\N
3287	Nouaceur	149	MA	Morocco	NOU	province	33.3670393	-7.5732537	\N
3269	Ouarzazate	149	MA	Morocco	OUA	province	30.9335436	-6.937016	\N
3319	Oued Ed-Dahab (EH)	149	MA	Morocco	OUD	province	22.7337892	-14.2861116	\N
4941	Ouezzane	149	MA	Morocco	OUZ	province	34.806345	-5.5914505	\N
4940	Oujda-Angad	149	MA	Morocco	OUJ	prefecture	34.6837504	-2.2993239	\N
4942	Rabat	149	MA	Morocco	RAB	prefecture	33.969199	-6.9273029	\N
4927	Rabat-Salé-Kénitra	149	MA	Morocco	04	region	34.076864	-7.3454476	\N
4943	Rehamna	149	MA	Morocco	REH	province	32.2032905	-8.5689671	\N
3311	Safi	149	MA	Morocco	SAF	province	32.2989872	-9.1013498	\N
4944	Salé	149	MA	Morocco	SAL	prefecture	34.037757	-6.8427073	\N
3289	Sefrou	149	MA	Morocco	SEF	province	33.8305244	-4.8353154	\N
3282	Settat	149	MA	Morocco	SET	province	32.9924242	-7.6222665	\N
4945	Sidi Bennour	149	MA	Morocco	SIB	province	32.6492602	-8.4471453	\N
4946	Sidi Ifni	149	MA	Morocco	SIF	province	29.3665797	-10.2108485	\N
3279	Sidi Kacem	149	MA	Morocco	SIK	province	34.2260172	-5.7129164	\N
4952	Sidi Slimane	149	MA	Morocco	SIL	province	34.2737828	-5.9805972	\N
4947	Skhirate-Témara	149	MA	Morocco	SKH	prefecture	33.7622425	-7.0419052	\N
3295	Souss-Massa	149	MA	Morocco	09	region	30.2750611	-8.1338558	\N
3286	Tan-Tan (EH-partial)	149	MA	Morocco	TNT	province	28.03012	-11.1617356	\N
4950	Tanger-Assilah	149	MA	Morocco	TNG	prefecture	35.7632539	-5.9045098	\N
3324	Tanger-Tétouan-Al Hoceïma	149	MA	Morocco	01	region	35.2629558	-5.5617279	\N
3323	Taounate	149	MA	Morocco	TAO	province	34.536917	-4.6398693	\N
3322	Taourirt	149	MA	Morocco	TAI	province	34.212598	-2.6983868	\N
4948	Tarfaya (EH-partial)	149	MA	Morocco	TAF	province	27.9377701	-12.9294063	\N
3314	Taroudannt	149	MA	Morocco	TAR	province	30.4727126	-8.8748765	\N
3312	Tata	149	MA	Morocco	TAT	province	29.750877	-7.9756343	\N
3296	Taza	149	MA	Morocco	TAZ	province	34.2788953	-3.5812692	\N
3318	Tétouan	149	MA	Morocco	TET	province	35.5888995	-5.3625516	\N
4949	Tinghir	149	MA	Morocco	TIN	province	31.4850794	-6.2019298	\N
3277	Tiznit	149	MA	Morocco	TIZ	province	29.693392	-9.732157	\N
4951	Youssoufia	149	MA	Morocco	YUS	province	32.0200679	-8.8692648	\N
3283	Zagora	149	MA	Morocco	ZAG	province	30.5786093	-5.8987139	\N
3327	Cabo Delgado Province	150	MZ	Mozambique	P	\N	-12.3335474	39.3206241	\N
3329	Gaza Province	150	MZ	Mozambique	G	\N	-23.0221928	32.7181375	\N
3330	Inhambane Province	150	MZ	Mozambique	I	\N	-22.8527997	34.5508758	\N
3337	Manica Province	150	MZ	Mozambique	B	\N	-19.5059787	33.438353	\N
3335	Maputo	150	MZ	Mozambique	MPM	\N	-25.969248	32.5731746	\N
3332	Maputo Province	150	MZ	Mozambique	L	\N	-25.2569876	32.5372741	\N
3336	Nampula Province	150	MZ	Mozambique	N	\N	-14.7604931	39.3206241	\N
3333	Niassa Province	150	MZ	Mozambique	A	\N	-12.7826202	36.6093926	\N
3331	Sofala Province	150	MZ	Mozambique	S	\N	-19.2039073	34.8624166	\N
3334	Tete Province	150	MZ	Mozambique	T	\N	-15.6596056	32.7181375	\N
3328	Zambezia Province	150	MZ	Mozambique	Q	\N	-16.5638987	36.6093926	\N
2142	Ayeyarwady Region	151	MM	Myanmar	07	\N	17.0342125	95.2266675	\N
2141	Bago	151	MM	Myanmar	02	\N	17.3220711	96.4663286	\N
2137	Chin State	151	MM	Myanmar	14	\N	22.0086978	93.5812692	\N
2143	Kachin State	151	MM	Myanmar	11	\N	25.850904	97.4381355	\N
2144	Kayah State	151	MM	Myanmar	12	\N	19.2342061	97.2652858	\N
2133	Kayin State	151	MM	Myanmar	13	\N	16.9459346	97.9592863	\N
2136	Magway Region	151	MM	Myanmar	03	\N	19.8871386	94.7277528	\N
2134	Mandalay Region	151	MM	Myanmar	04	\N	21.5619058	95.8987139	\N
2147	Mon State	151	MM	Myanmar	15	\N	16.3003133	97.6982272	\N
2146	Naypyidaw Union Territory	151	MM	Myanmar	18	\N	19.9386245	96.1526985	\N
2138	Rakhine State	151	MM	Myanmar	16	\N	20.1040818	93.5812692	\N
2145	Sagaing Region	151	MM	Myanmar	01	\N	24.428381	95.3939551	\N
2139	Shan State	151	MM	Myanmar	17	\N	22.0361985	98.1338558	\N
2140	Tanintharyi Region	151	MM	Myanmar	05	\N	12.4706876	99.0128926	\N
2135	Yangon Region	151	MM	Myanmar	06	\N	16.9143488	96.1526985	\N
43	Erongo Region	152	NA	Namibia	ER	\N	-22.2565682	15.4068079	\N
38	Hardap Region	152	NA	Namibia	HA	\N	-24.2310134	17.668887	\N
45	Karas Region	152	NA	Namibia	KA	\N	-26.8429645	17.2902839	\N
36	Kavango East Region	152	NA	Namibia	KE	\N	-18.271048	18.4276047	\N
35	Kavango West Region	152	NA	Namibia	KW	\N	-18.271048	18.4276047	\N
44	Khomas Region	152	NA	Namibia	KH	\N	-22.6377854	17.1011931	\N
34	Kunene Region	152	NA	Namibia	KU	\N	-19.4086317	13.914399	\N
40	Ohangwena Region	152	NA	Namibia	OW	\N	-17.5979291	16.8178377	\N
41	Omaheke Region	152	NA	Namibia	OH	\N	-21.8466651	19.1880047	\N
39	Omusati Region	152	NA	Namibia	OS	\N	-18.4070294	14.8454619	\N
37	Oshana Region	152	NA	Namibia	ON	\N	-18.4305064	15.6881788	\N
42	Oshikoto Region	152	NA	Namibia	OT	\N	-18.4152575	16.912251	\N
46	Otjozondjupa Region	152	NA	Namibia	OD	\N	-20.5486916	17.668887	\N
47	Zambezi Region	152	NA	Namibia	CA	\N	-17.8193419	23.9536466	\N
4656	Aiwo District	153	NR	Nauru	01	\N	-0.5340012	166.9138873	\N
4658	Anabar District	153	NR	Nauru	02	\N	-0.5133517	166.9484624	\N
4667	Anetan District	153	NR	Nauru	03	\N	-0.5064343	166.9427006	\N
4663	Anibare District	153	NR	Nauru	04	\N	-0.5294758	166.9513432	\N
4660	Baiti District	153	NR	Nauru	05	\N	-0.510431	166.9275744	\N
4665	Boe District	153	NR	Nauru	06	\N	39.0732776	-94.5710498	\N
4662	Buada District	153	NR	Nauru	07	\N	-0.5328777	166.9268541	\N
4666	Denigomodu District	153	NR	Nauru	08	\N	-0.5247964	166.9167689	\N
4654	Ewa District	153	NR	Nauru	09	\N	-0.5087241	166.9369384	\N
4661	Ijuw District	153	NR	Nauru	10	\N	-0.5202767	166.9571046	\N
4657	Meneng District	153	NR	Nauru	11	\N	-0.546724	166.938379	\N
4659	Nibok District	153	NR	Nauru	12	\N	-0.5196208	166.9189301	\N
4655	Uaboe District	153	NR	Nauru	13	\N	-0.5202222	166.9311761	\N
4664	Yaren District	153	NR	Nauru	14	\N	-0.5466857	166.9210913	\N
2082	Bagmati Zone	154	NP	Nepal	BA	\N	28.0367577	85.4375574	\N
2071	Bheri Zone	154	NP	Nepal	BH	\N	28.517456	81.7787021	\N
2073	Central Region	154	NP	Nepal	1	\N	\N	\N	\N
2080	Dhaulagiri Zone	154	NP	Nepal	DH	\N	28.611176	83.5070203	\N
2069	Eastern Development Region	154	NP	Nepal	4	\N	27.3309072	87.0624261	\N
2068	Far-Western Development Region	154	NP	Nepal	5	\N	29.2987871	80.9871074	\N
2081	Gandaki Zone	154	NP	Nepal	GA	\N	28.3732037	84.4382721	\N
2076	Janakpur Zone	154	NP	Nepal	JA	\N	27.2110899	86.0121573	\N
2079	Karnali Zone	154	NP	Nepal	KA	\N	29.3862555	82.3885783	\N
2072	Kosi Zone	154	NP	Nepal	KO	\N	27.0536524	87.3016132	\N
2074	Lumbini Zone	154	NP	Nepal	LU	\N	27.45	83.25	\N
2083	Mahakali Zone	154	NP	Nepal	MA	\N	29.3601079	80.543845	\N
2070	Mechi Zone	154	NP	Nepal	ME	\N	26.8760007	87.9334803	\N
2066	Mid-Western Region	154	NP	Nepal	2	\N	38.4111841	-90.3832098	\N
2075	Narayani Zone	154	NP	Nepal	NA	\N	27.3611766	84.8567932	\N
2077	Rapti Zone	154	NP	Nepal	RA	\N	28.274347	82.3885783	\N
2084	Sagarmatha Zone	154	NP	Nepal	SA	\N	27.3238263	86.7416374	\N
2078	Seti Zone	154	NP	Nepal	SE	\N	29.6905427	81.3399414	\N
2067	Western Region	154	NP	Nepal	3	\N	\N	\N	\N
2624	Bonaire	156	NL	Netherlands	BQ1	special municipality	12.2018902	-68.2623822	\N
2613	Drenthe	156	NL	Netherlands	DR	province	52.9476012	6.6230586	\N
2619	Flevoland	156	NL	Netherlands	FL	province	52.5279781	5.5953508	\N
2622	Friesland	156	NL	Netherlands	FR	province	53.1641642	5.7817542	\N
2611	Gelderland	156	NL	Netherlands	GE	province	52.045155	5.8718235	\N
2617	Groningen	156	NL	Netherlands	GR	province	53.2193835	6.5665017	\N
2615	Limburg	156	NL	Netherlands	LI	province	51.4427238	6.0608726	\N
2623	North Brabant	156	NL	Netherlands	NB	province	51.4826537	5.2321687	\N
2612	North Holland	156	NL	Netherlands	NH	province	52.5205869	4.788474	\N
2618	Overijssel	156	NL	Netherlands	OV	province	52.4387814	6.5016411	\N
2621	Saba	156	NL	Netherlands	BQ2	special municipality	17.6354642	-63.2326763	\N
2616	Sint Eustatius	156	NL	Netherlands	BQ3	special municipality	17.4890306	-62.973555	\N
2614	South Holland	156	NL	Netherlands	ZH	province	41.6008681	-87.6069894	\N
2610	Utrecht	156	NL	Netherlands	UT	province	52.0907374	5.1214201	\N
2620	Zeeland	156	NL	Netherlands	ZE	province	51.4940309	3.8496815	\N
4072	Auckland Region	158	NZ	New Zealand	AUK	\N	-36.6675328	174.7733325	\N
4074	Bay of Plenty Region	158	NZ	New Zealand	BOP	\N	-37.4233917	176.7416374	\N
4066	Canterbury Region	158	NZ	New Zealand	CAN	\N	-43.7542275	171.1637245	\N
4067	Chatham Islands	158	NZ	New Zealand	CIT	\N	-44.0057523	-176.5400674	\N
4068	Gisborne District	158	NZ	New Zealand	GIS	\N	-38.1358174	178.3239309	\N
4075	Hawke's Bay Region	158	NZ	New Zealand	HKB	\N	-39.6016597	176.5804473	\N
4060	Manawatu-Wanganui Region	158	NZ	New Zealand	MWT	\N	-39.7273356	175.4375574	\N
4063	Marlborough Region	158	NZ	New Zealand	MBH	\N	-41.5916883	173.7624053	\N
4070	Nelson Region	158	NZ	New Zealand	NSN	\N	-41.2985397	173.2441491	\N
4059	Northland Region	158	NZ	New Zealand	NTL	\N	-35.4136172	173.9320806	\N
4062	Otago Region	158	NZ	New Zealand	OTA	\N	-45.4790671	170.1547567	\N
4071	Southland Region	158	NZ	New Zealand	STL	\N	-45.8489159	167.6755387	\N
4069	Taranaki Region	158	NZ	New Zealand	TKI	\N	-39.3538149	174.4382721	\N
4073	Tasman District	158	NZ	New Zealand	TAS	\N	-41.4571184	172.820974	\N
4061	Waikato Region	158	NZ	New Zealand	WKO	\N	-37.6190862	175.023346	\N
4065	Wellington Region	158	NZ	New Zealand	WGN	\N	-41.0299323	175.4375574	\N
4064	West Coast Region	158	NZ	New Zealand	WTC	\N	62.4113634	-149.0729714	\N
946	Boaco	159	NI	Nicaragua	BO	department	12.469284	-85.6614682	\N
950	Carazo	159	NI	Nicaragua	CA	department	11.7274729	-86.2158497	\N
954	Chinandega	159	NI	Nicaragua	CI	department	12.8820062	-87.1422895	\N
940	Chontales	159	NI	Nicaragua	CO	department	11.9394717	-85.1894045	\N
945	Estelí	159	NI	Nicaragua	ES	department	13.0851139	-86.3630197	\N
943	Granada	159	NI	Nicaragua	GR	department	11.9344073	-85.9560005	\N
955	Jinotega	159	NI	Nicaragua	JI	department	13.0883907	-85.9993997	\N
944	León	159	NI	Nicaragua	LE	department	12.5092037	-86.6611083	\N
948	Madriz	159	NI	Nicaragua	MD	department	13.4726005	-86.4592091	\N
941	Managua	159	NI	Nicaragua	MN	department	12.1391699	-86.3376761	\N
953	Masaya	159	NI	Nicaragua	MS	department	11.9759328	-86.0733498	\N
947	Matagalpa	159	NI	Nicaragua	MT	department	12.9498436	-85.4375574	\N
951	North Caribbean Coast	159	NI	Nicaragua	AN	autonomous region	13.8394456	-83.9320806	\N
4964	Nueva Segovia	159	NI	Nicaragua	NS	department	13.7657061	-86.5370039	\N
949	Río San Juan	159	NI	Nicaragua	SJ	department	11.478161	-84.7733325	\N
942	Rivas	159	NI	Nicaragua	RI	department	11.402349	-85.684578	\N
952	South Caribbean Coast	159	NI	Nicaragua	AS	autonomous region	12.1918502	-84.1012861	\N
71	Agadez Region	160	NE	Niger	1	\N	20.6670752	12.0718281	\N
72	Diffa Region	160	NE	Niger	2	\N	13.6768647	12.7135121	\N
68	Dosso Region	160	NE	Niger	3	\N	13.1513947	3.4195527	\N
70	Maradi Region	160	NE	Niger	4	\N	13.8018074	7.4381355	\N
73	Tahoua Region	160	NE	Niger	5	\N	16.0902543	5.3939551	\N
67	Tillabéri Region	160	NE	Niger	6	\N	14.6489525	2.1450245	\N
69	Zinder Region	160	NE	Niger	7	\N	15.1718881	10.2600125	\N
303	Abia	161	NG	Nigeria	AB	state	5.4527354	7.5248414	\N
293	Abuja Federal Capital Territory	161	NG	Nigeria	FC	capital territory	8.8940691	7.1860402	\N
320	Adamawa	161	NG	Nigeria	AD	state	9.3264751	12.3983853	\N
304	Akwa Ibom	161	NG	Nigeria	AK	state	4.9057371	7.8536675	\N
315	Anambra	161	NG	Nigeria	AN	state	6.2208997	6.9369559	\N
312	Bauchi	161	NG	Nigeria	BA	state	10.7760624	9.9991943	\N
305	Bayelsa	161	NG	Nigeria	BY	state	4.7719071	6.0698526	\N
291	Benue	161	NG	Nigeria	BE	state	7.3369024	8.7403687	\N
307	Borno	161	NG	Nigeria	BO	state	11.8846356	13.1519665	\N
314	Cross River	161	NG	Nigeria	CR	state	5.8701724	8.5988014	\N
316	Delta	161	NG	Nigeria	DE	state	33.7453784	-90.7354508	\N
311	Ebonyi	161	NG	Nigeria	EB	state	6.2649232	8.0137302	\N
318	Edo	161	NG	Nigeria	ED	state	6.6341831	5.9304056	\N
309	Ekiti	161	NG	Nigeria	EK	state	7.7189862	5.3109505	\N
289	Enugu	161	NG	Nigeria	EN	state	6.536353	7.4356194	\N
310	Gombe	161	NG	Nigeria	GO	state	10.3637795	11.1927587	\N
308	Imo	161	NG	Nigeria	IM	state	5.5720122	7.0588219	\N
288	Jigawa	161	NG	Nigeria	JI	state	12.228012	9.5615867	\N
294	Kaduna	161	NG	Nigeria	KD	state	10.3764006	7.7094537	\N
300	Kano	161	NG	Nigeria	KN	state	11.7470698	8.5247107	\N
313	Katsina	161	NG	Nigeria	KT	state	12.3796707	7.6305748	\N
290	Kebbi	161	NG	Nigeria	KE	state	11.4942003	4.2333355	\N
298	Kogi	161	NG	Nigeria	KO	state	7.7337325	6.6905836	\N
295	Kwara	161	NG	Nigeria	KW	state	8.9668961	4.3874051	\N
306	Lagos	161	NG	Nigeria	LA	state	6.5243793	3.3792057	\N
301	Nasarawa	161	NG	Nigeria	NA	state	8.4997908	8.1996937	\N
317	Niger	161	NG	Nigeria	NI	state	9.9309224	5.598321	\N
323	Ogun	161	NG	Nigeria	OG	state	6.9979747	3.4737378	\N
321	Ondo	161	NG	Nigeria	ON	state	6.9148682	5.1478144	\N
322	Osun	161	NG	Nigeria	OS	state	7.5628964	4.5199593	\N
296	Oyo	161	NG	Nigeria	OY	state	8.1573809	3.6146534	\N
302	Plateau	161	NG	Nigeria	PL	state	9.2182093	9.5179488	\N
4926	Rivers	161	NG	Nigeria	RI	state	5.021342	6.4376022	\N
292	Sokoto	161	NG	Nigeria	SO	state	13.0533143	5.3222722	\N
319	Taraba	161	NG	Nigeria	TA	state	7.9993616	10.7739863	\N
297	Yobe	161	NG	Nigeria	YO	state	12.293876	11.4390411	\N
299	Zamfara	161	NG	Nigeria	ZA	state	12.1221805	6.2235819	\N
3998	Chagang Province	115	KP	North Korea	04	\N	40.7202809	126.5621137	\N
3999	Kangwon Province	115	KP	North Korea	07	\N	38.8432393	127.5597067	\N
3995	North Hamgyong Province	115	KP	North Korea	09	\N	41.8148758	129.4581955	\N
4004	North Hwanghae Province	115	KP	North Korea	06	\N	38.3786085	126.4364363	\N
4002	North Pyongan Province	115	KP	North Korea	03	\N	39.9255618	125.3928025	\N
4005	Pyongyang	115	KP	North Korea	01	\N	39.0392193	125.7625241	\N
4001	Rason	115	KP	North Korea	13	\N	42.2569063	130.2977186	\N
3996	Ryanggang Province	115	KP	North Korea	10	\N	41.2318921	128.5076359	\N
4000	South Hamgyong Province	115	KP	North Korea	08	\N	40.3725339	128.298884	\N
4003	South Hwanghae Province	115	KP	North Korea	05	\N	38.2007215	125.4781926	\N
3997	South Pyongan Province	115	KP	North Korea	02	\N	39.3539178	126.168271	\N
1017	Akershus	165	NO	Norway	02	\N	28.3704203	-81.5468058	\N
1011	Buskerud	165	NO	Norway	06	\N	60.4846025	8.6983764	\N
1016	Finnmark	165	NO	Norway	20	\N	70.4830388	26.0135107	\N
1019	Hedmark	165	NO	Norway	04	\N	61.3967311	11.5627369	\N
1023	Hordaland	165	NO	Norway	12	\N	60.2733674	5.7220194	\N
1026	Jan Mayen	165	NO	Norway	22	\N	71.031818	-8.2920346	\N
1020	Møre og Romsdal	165	NO	Norway	15	\N	62.8406833	7.007143	\N
1012	Nord-Trøndelag	165	NO	Norway	17	\N	64.4370792	11.746295	\N
1025	Nordland	165	NO	Norway	18	\N	67.693058	12.7073936	\N
1009	Oppland	165	NO	Norway	05	\N	61.5422752	9.7166315	\N
1007	Oslo	165	NO	Norway	03	\N	59.9138688	10.7522454	\N
1022	Østfold	165	NO	Norway	01	\N	59.2558286	11.3279006	\N
1021	Rogaland	165	NO	Norway	11	\N	59.1489544	6.0143432	\N
1018	Sogn og Fjordane	165	NO	Norway	14	\N	61.5539435	6.3325879	\N
1010	Sør-Trøndelag	165	NO	Norway	16	\N	63.0136823	10.3487136	\N
1013	Svalbard	165	NO	Norway	21	\N	77.8749725	20.9751821	\N
1024	Telemark	165	NO	Norway	08	\N	59.3913985	8.3211209	\N
1015	Troms	165	NO	Norway	19	\N	69.8178242	18.7819365	\N
1006	Trøndelag	165	NO	Norway	50	\N	63.5420125	10.9369267	\N
1014	Vest-Agder	165	NO	Norway	10	\N	58.0999081	6.5869809	\N
1008	Vestfold	165	NO	Norway	07	\N	59.1707862	10.1144355	\N
3058	Ad Dakhiliyah	166	OM	Oman	DA	\N	22.8588758	57.5394356	\N
3047	Ad Dhahirah	166	OM	Oman	ZA	\N	23.2161674	56.4907444	\N
3048	Al Batinah North	166	OM	Oman	BS	\N	24.3419846	56.7298904	\N
3050	Al Batinah Region	166	OM	Oman	BA	\N	24.3419846	56.7298904	\N
3049	Al Batinah South	166	OM	Oman	BJ	\N	23.4314903	57.4239796	\N
3059	Al Buraimi	166	OM	Oman	BU	\N	24.1671413	56.1142253	\N
3056	Al Wusta	166	OM	Oman	WU	\N	19.9571078	56.2756846	\N
3053	Ash Sharqiyah North	166	OM	Oman	SS	\N	22.7141196	58.5308064	\N
3051	Ash Sharqiyah Region	166	OM	Oman	SH	\N	22.7141196	58.5308064	\N
3054	Ash Sharqiyah South	166	OM	Oman	SJ	\N	22.0158249	59.3251922	\N
3057	Dhofar	166	OM	Oman	ZU	\N	17.0322121	54.1425214	\N
3052	Musandam	166	OM	Oman	MU	\N	26.1986144	56.2460949	\N
3055	Muscat	166	OM	Oman	MA	\N	23.5880307	58.3828717	\N
3172	Azad Kashmir	167	PK	Pakistan	JK	\N	33.9259055	73.7810334	\N
3174	Balochistan	167	PK	Pakistan	BA	\N	28.4907332	65.0957792	\N
3173	Federally Administered Tribal Areas	167	PK	Pakistan	TA	\N	32.667476	69.8597406	\N
3170	Gilgit-Baltistan	167	PK	Pakistan	GB	\N	35.8025667	74.9831808	\N
3169	Islamabad Capital Territory	167	PK	Pakistan	IS	\N	33.7204997	73.0405277	\N
3171	Khyber Pakhtunkhwa	167	PK	Pakistan	KP	\N	34.9526205	72.331113	\N
3176	Punjab	167	PK	Pakistan	PB	\N	31.1471305	75.3412179	\N
3175	Sindh	167	PK	Pakistan	SD	\N	25.8943018	68.5247149	\N
4540	Aimeliik	168	PW	Palau	002	\N	7.4455859	134.5030878	\N
4528	Airai	168	PW	Palau	004	\N	7.3966118	134.5690225	\N
4538	Angaur	168	PW	Palau	010	\N	6.909223	134.1387934	\N
4529	Hatohobei	168	PW	Palau	050	\N	3.0070658	131.1237781	\N
4539	Kayangel	168	PW	Palau	100	\N	8.07	134.702778	\N
4532	Koror	168	PW	Palau	150	\N	7.3375646	134.4889469	\N
4530	Melekeok	168	PW	Palau	212	\N	7.5150286	134.5972518	\N
4537	Ngaraard	168	PW	Palau	214	\N	7.60794	134.6348645	\N
4533	Ngarchelong	168	PW	Palau	218	\N	7.7105469	134.6301646	\N
4527	Ngardmau	168	PW	Palau	222	\N	7.5850486	134.5596089	\N
4531	Ngatpang	168	PW	Palau	224	\N	7.4710994	134.5266466	\N
4536	Ngchesar	168	PW	Palau	226	\N	7.452328	134.5784342	\N
4541	Ngeremlengui	168	PW	Palau	227	\N	7.5198397	134.5596089	\N
4534	Ngiwal	168	PW	Palau	228	\N	7.5614764	134.6160619	\N
4526	Peleliu	168	PW	Palau	350	\N	7.0022906	134.2431628	\N
4535	Sonsorol	168	PW	Palau	370	\N	5.3268119	132.2239117	\N
1393	Bocas del Toro Province	170	PA	Panama	1	\N	9.4165521	-82.5207787	\N
1397	Chiriquí Province	170	PA	Panama	4	\N	8.584898	-82.3885783	\N
1387	Coclé Province	170	PA	Panama	2	\N	8.6266068	-80.365865	\N
1386	Colón Province	170	PA	Panama	3	\N	9.1851989	-80.0534923	\N
1385	Darién Province	170	PA	Panama	5	\N	7.8681713	-77.8367282	\N
1396	Emberá-Wounaan Comarca	170	PA	Panama	EM	\N	8.3766983	-77.6536125	\N
1388	Guna Yala	170	PA	Panama	KY	\N	9.2344395	-78.192625	\N
1389	Herrera Province	170	PA	Panama	6	\N	7.7704282	-80.7214417	\N
1390	Los Santos Province	170	PA	Panama	7	\N	7.5909302	-80.365865	\N
1391	Ngöbe-Buglé Comarca	170	PA	Panama	NB	\N	8.6595833	-81.7787021	\N
1394	Panamá Oeste Province	170	PA	Panama	10	\N	9.1196751	-79.2902133	\N
1395	Panamá Province	170	PA	Panama	8	\N	9.1196751	-79.2902133	\N
1392	Veraguas Province	170	PA	Panama	9	\N	8.1231033	-81.0754657	\N
4831	Bougainville	171	PG	Papua new Guinea	NSB	\N	-6.3753919	155.3807101	\N
4847	Central Province	171	PG	Papua new Guinea	CPM	\N	\N	\N	\N
4846	Chimbu Province	171	PG	Papua new Guinea	CPK	\N	-6.3087682	144.8731219	\N
4834	East New Britain	171	PG	Papua new Guinea	EBR	\N	-4.6128943	151.8877321	\N
4845	Eastern Highlands Province	171	PG	Papua new Guinea	EHG	\N	-6.5861674	145.6689636	\N
4848	Enga Province	171	PG	Papua new Guinea	EPW	\N	-5.3005849	143.5635637	\N
4839	Gulf	171	PG	Papua new Guinea	GPK	\N	37.0548315	-94.4370419	\N
4833	Hela	171	PG	Papua new Guinea	HLA	\N	42.3329516	-83.0482618	\N
4832	Jiwaka Province	171	PG	Papua new Guinea	JWK	\N	-5.8691154	144.6972774	\N
4843	Madang Province	171	PG	Papua new Guinea	MPM	\N	-4.9849733	145.1375834	\N
4842	Manus Province	171	PG	Papua new Guinea	MRL	\N	-2.0941169	146.8760951	\N
4849	Milne Bay Province	171	PG	Papua new Guinea	MBA	\N	-9.5221451	150.6749653	\N
4835	Morobe Province	171	PG	Papua new Guinea	MPL	\N	-6.8013737	146.561647	\N
4841	New Ireland Province	171	PG	Papua new Guinea	NIK	\N	-4.2853256	152.9205918	\N
4838	Oro Province	171	PG	Papua new Guinea	NPP	\N	-8.8988063	148.1892921	\N
4837	Port Moresby	171	PG	Papua new Guinea	NCD	\N	-9.4438004	147.1802671	\N
4836	Sandaun Province	171	PG	Papua new Guinea	SAN	\N	-3.7126179	141.6834275	\N
4844	Southern Highlands Province	171	PG	Papua new Guinea	SHM	\N	-6.4179083	143.5635637	\N
4830	West New Britain Province	171	PG	Papua new Guinea	WBK	\N	-5.7047432	150.0259466	\N
4840	Western Highlands Province	171	PG	Papua new Guinea	WHM	\N	-5.6268128	144.2593118	\N
4850	Western Province	171	PG	Papua new Guinea	WPD	\N	\N	\N	\N
2785	Alto Paraguay Department	172	PY	Paraguay	16	\N	-20.0852508	-59.4720904	\N
2784	Alto Paraná Department	172	PY	Paraguay	10	\N	-25.6075546	-54.9611836	\N
2782	Amambay Department	172	PY	Paraguay	13	\N	-22.5590272	-56.0249982	\N
2780	Boquerón Department	172	PY	Paraguay	19	\N	-21.7449254	-60.9540073	\N
2773	Caaguazú	172	PY	Paraguay	5	\N	-25.4645818	-56.013851	\N
2775	Caazapá	172	PY	Paraguay	6	\N	-26.1827713	-56.3712327	\N
2771	Canindeyú	172	PY	Paraguay	14	\N	-24.1378735	-55.6689636	\N
2777	Central Department	172	PY	Paraguay	11	\N	36.1559229	-95.9662075	\N
2779	Concepción Department	172	PY	Paraguay	1	\N	-23.4214264	-57.4344451	\N
2783	Cordillera Department	172	PY	Paraguay	3	\N	-25.2289491	-57.0111681	\N
2772	Guairá Department	172	PY	Paraguay	4	\N	-25.8810932	-56.2929381	\N
2778	Itapúa	172	PY	Paraguay	7	\N	-26.7923623	-55.6689636	\N
2786	Misiones Department	172	PY	Paraguay	8	\N	-26.8433512	-57.1013188	\N
2781	Ñeembucú Department	172	PY	Paraguay	12	\N	-27.0299114	-57.825395	\N
2774	Paraguarí Department	172	PY	Paraguay	9	\N	-25.6262174	-57.1520642	\N
2770	Presidente Hayes Department	172	PY	Paraguay	15	\N	-23.3512605	-58.7373634	\N
2776	San Pedro Department	172	PY	Paraguay	2	\N	-24.1948668	-56.561647	\N
3685	Amazonas	173	PE	Peru	AMA	\N	\N	\N	\N
3680	Áncash	173	PE	Peru	ANC	\N	-9.3250497	-77.5619419	\N
3699	Apurímac	173	PE	Peru	APU	\N	-14.0504533	-73.087749	\N
3681	Arequipa	173	PE	Peru	ARE	\N	-16.4090474	-71.537451	\N
3692	Ayacucho	173	PE	Peru	AYA	\N	-13.1638737	-74.2235641	\N
3688	Cajamarca	173	PE	Peru	CAJ	\N	-7.1617465	-78.5127855	\N
3701	Callao	173	PE	Peru	CAL	\N	-12.0508491	-77.1259843	\N
3691	Cusco	173	PE	Peru	CUS	\N	-13.53195	-71.9674626	\N
3679	Huancavelica	173	PE	Peru	HUV	\N	-12.7861978	-74.9764024	\N
3687	Huanuco	173	PE	Peru	HUC	\N	-9.9207648	-76.2410843	\N
3700	Ica	173	PE	Peru	ICA	\N	42.3528832	-71.0430097	\N
3693	Junín	173	PE	Peru	JUN	\N	-11.1581925	-75.9926306	\N
3683	La Libertad	173	PE	Peru	LAL	\N	13.490697	-89.3084607	\N
3702	Lambayeque	173	PE	Peru	LAM	\N	-6.7197666	-79.9080757	\N
3695	Lima	173	PE	Peru	LIM	\N	-12.0463731	-77.042754	\N
4922	Loreto	173	PE	Peru	LOR	\N	-4.3741643	-76.1304264	\N
3678	Madre de Dios	173	PE	Peru	MDD	\N	-11.7668705	-70.8119953	\N
3698	Moquegua	173	PE	Peru	MOQ	\N	-17.1927361	-70.9328138	\N
3686	Pasco	173	PE	Peru	PAS	\N	46.2305049	-119.0922316	\N
3697	Piura	173	PE	Peru	PIU	\N	-5.1782884	-80.6548882	\N
3682	Puno	173	PE	Peru	PUN	\N	-15.8402218	-70.0218805	\N
3694	San Martín	173	PE	Peru	SAM	\N	37.0849464	-121.6102216	\N
3696	Tacna	173	PE	Peru	TAC	\N	-18.0065679	-70.2462741	\N
3689	Tumbes	173	PE	Peru	TUM	\N	-3.5564921	-80.4270885	\N
3684	Ucayali	173	PE	Peru	UCA	\N	-9.8251183	-73.087749	\N
1324	Abra	174	PH	Philippines	ABR	province	42.497083	-96.38441	\N
1323	Agusan del Norte	174	PH	Philippines	AGN	province	8.9456259	125.5319234	\N
1326	Agusan del Sur	174	PH	Philippines	AGS	province	8.0463888	126.0615384	\N
1331	Aklan	174	PH	Philippines	AKL	province	11.8166109	122.0941541	\N
1337	Albay	174	PH	Philippines	ALB	province	13.1774827	123.5280072	\N
1336	Antique	174	PH	Philippines	ANT	province	37.0358695	-95.6361694	\N
1334	Apayao	174	PH	Philippines	APA	province	18.0120304	121.1710389	\N
1341	Aurora	174	PH	Philippines	AUR	province	36.970891	-93.717979	\N
1316	Autonomous Region in Muslim Mindanao	174	PH	Philippines	14	region	6.9568313	124.2421597	\N
1346	Basilan	174	PH	Philippines	BAS	province	6.4296349	121.9870165	\N
1344	Bataan	174	PH	Philippines	BAN	province	14.6416842	120.4818446	\N
1352	Batanes	174	PH	Philippines	BTN	province	20.4485074	121.9708129	\N
1359	Batangas	174	PH	Philippines	BTG	province	13.7564651	121.0583076	\N
1363	Benguet	174	PH	Philippines	BEN	province	16.5577257	120.8039474	\N
1304	Bicol	174	PH	Philippines	05	region	13.4209885	123.4136736	\N
1274	Biliran	174	PH	Philippines	BIL	province	11.5833152	124.4641848	\N
1272	Bohol	174	PH	Philippines	BOH	province	9.8499911	124.1435427	\N
1270	Bukidnon	174	PH	Philippines	BUK	province	8.0515054	124.9229946	\N
1278	Bulacan	174	PH	Philippines	BUL	province	14.7942735	120.8799008	\N
1279	Cagayan	174	PH	Philippines	CAG	province	18.2489629	121.8787833	\N
1342	Cagayan Valley	174	PH	Philippines	02	region	16.9753758	121.8107079	\N
1294	Calabarzon	174	PH	Philippines	40	region	14.1007803	121.0793705	\N
1283	Camarines Norte	174	PH	Philippines	CAN	province	14.1390265	122.7633036	\N
1287	Camarines Sur	174	PH	Philippines	CAS	province	13.5250197	123.3486147	\N
1285	Camiguin	174	PH	Philippines	CAM	province	9.1732164	124.7298765	\N
1292	Capiz	174	PH	Philippines	CAP	province	11.5528816	122.740723	\N
1314	Caraga	174	PH	Philippines	13	region	8.8014562	125.7406882	\N
1301	Catanduanes	174	PH	Philippines	CAT	province	13.7088684	124.2421597	\N
1307	Cavite	174	PH	Philippines	CAV	province	14.4791297	120.8969634	\N
1306	Cebu	174	PH	Philippines	CEB	province	10.3156992	123.8854366	\N
1345	Central Luzon	174	PH	Philippines	03	region	15.4827722	120.7120023	\N
1308	Central Visayas	174	PH	Philippines	07	region	9.816875	124.0641419	\N
1311	Compostela Valley	174	PH	Philippines	COM	province	7.512515	126.1762615	\N
1335	Cordillera Administrative	174	PH	Philippines	15	region	17.3512542	121.1718851	\N
1320	Cotabato	174	PH	Philippines	NCO	province	7.2046668	124.2310439	\N
1340	Davao	174	PH	Philippines	11	region	7.3041622	126.0893406	\N
1319	Davao del Norte	174	PH	Philippines	DAV	province	7.5617699	125.6532848	\N
1318	Davao del Sur	174	PH	Philippines	DAS	province	6.7662687	125.3284269	\N
1309	Davao Occidental	174	PH	Philippines	DVO	province	6.0941396	125.6095474	\N
1289	Davao Oriental	174	PH	Philippines	DAO	province	7.3171585	126.5419887	\N
1291	Dinagat Islands	174	PH	Philippines	DIN	province	10.1281816	125.6095474	\N
1290	Eastern Samar	174	PH	Philippines	EAS	province	11.5000731	125.4999908	\N
1322	Eastern Visayas	174	PH	Philippines	08	region	12.2445533	125.0388164	\N
1303	Guimaras	174	PH	Philippines	GUI	province	10.5928661	122.6325081	\N
1300	Ifugao	174	PH	Philippines	IFU	province	16.8330792	121.1710389	\N
1355	Ilocos	174	PH	Philippines	01	region	16.0832144	120.6199895	\N
1298	Ilocos Norte	174	PH	Philippines	ILN	province	18.1647281	120.7115592	\N
1321	Ilocos Sur	174	PH	Philippines	ILS	province	17.2278664	120.5739579	\N
1315	Iloilo	174	PH	Philippines	ILI	province	10.7201501	122.5621063	\N
1313	Isabela	174	PH	Philippines	ISA	province	18.5007759	-67.0243462	\N
1312	Kalinga	174	PH	Philippines	KAL	province	17.4740422	121.3541631	\N
1317	La Union	174	PH	Philippines	LUN	province	38.8766878	-77.1280912	\N
1328	Laguna	174	PH	Philippines	LAG	province	33.5427189	-117.7853568	\N
1327	Lanao del Norte	174	PH	Philippines	LAN	province	7.8721811	123.8857747	\N
1333	Lanao del Sur	174	PH	Philippines	LAS	province	7.823176	124.4198243	\N
1332	Leyte	174	PH	Philippines	LEY	province	10.8624536	124.8811195	\N
1330	Maguindanao	174	PH	Philippines	MAG	province	6.9422581	124.4198243	\N
1329	Marinduque	174	PH	Philippines	MAD	province	13.4767171	121.9032192	\N
1338	Masbate	174	PH	Philippines	MAS	province	12.3574346	123.5504076	\N
1347	Metro Manila	174	PH	Philippines	NCR	province	14.6090537	121.0222565	\N
1299	Mimaropa	174	PH	Philippines	41	region	9.8432065	118.7364783	\N
1343	Misamis Occidental	174	PH	Philippines	MSC	province	8.3374903	123.7070619	\N
1348	Misamis Oriental	174	PH	Philippines	MSR	province	8.5045558	124.6219592	\N
1353	Mountain Province	174	PH	Philippines	MOU	province	40.7075437	-73.9501033	\N
1351	Negros Occidental	174	PH	Philippines	NEC	province	10.2925609	123.0246518	\N
1350	Negros Oriental	174	PH	Philippines	NER	province	9.6282083	122.9888319	\N
1339	Northern Mindanao	174	PH	Philippines	10	region	8.0201635	124.6856509	\N
1349	Northern Samar	174	PH	Philippines	NSA	province	12.3613199	124.7740793	\N
1360	Nueva Ecija	174	PH	Philippines	NUE	province	15.578375	121.1112615	\N
1358	Nueva Vizcaya	174	PH	Philippines	NUV	province	16.3301107	121.1710389	\N
1356	Occidental Mindoro	174	PH	Philippines	MDC	province	13.1024111	120.7651284	\N
1354	Oriental Mindoro	174	PH	Philippines	MDR	province	13.0564598	121.4069417	\N
1361	Palawan	174	PH	Philippines	PLW	province	9.8349493	118.7383615	\N
1365	Pampanga	174	PH	Philippines	PAM	province	15.079409	120.6199895	\N
1364	Pangasinan	174	PH	Philippines	PAN	province	15.8949055	120.2863183	\N
1275	Quezon	174	PH	Philippines	QUE	province	14.0313906	122.1130909	\N
1273	Quirino	174	PH	Philippines	QUI	province	16.2700424	121.5370003	\N
1271	Rizal	174	PH	Philippines	RIZ	province	14.6037446	121.3084088	\N
1269	Romblon	174	PH	Philippines	ROM	province	12.5778016	122.269146	\N
1277	Sarangani	174	PH	Philippines	SAR	province	5.9267175	124.994751	\N
1276	Siquijor	174	PH	Philippines	SIG	province	9.1998779	123.5951925	\N
1310	Soccsksargen	174	PH	Philippines	12	region	6.2706918	124.6856509	\N
1281	Sorsogon	174	PH	Philippines	SOR	province	12.9927095	124.0147464	\N
1280	South Cotabato	174	PH	Philippines	SCO	province	6.3357565	124.7740793	\N
1284	Southern Leyte	174	PH	Philippines	SLE	province	10.3346206	125.1708741	\N
1282	Sultan Kudarat	174	PH	Philippines	SUK	province	6.5069401	124.4198243	\N
1288	Sulu	174	PH	Philippines	SLU	province	5.9749011	121.03351	\N
1286	Surigao del Norte	174	PH	Philippines	SUN	province	9.514828	125.6969984	\N
1296	Surigao del Sur	174	PH	Philippines	SUR	province	8.5404906	126.1144758	\N
1295	Tarlac	174	PH	Philippines	TAR	province	15.4754786	120.5963492	\N
1293	Tawi-Tawi	174	PH	Philippines	TAW	province	5.133811	119.950926	\N
5115	Western Samar	174	PH	Philippines	WSA	province	12.0000206	124.9912452	\N
1305	Western Visayas	174	PH	Philippines	06	region	11.0049836	122.5372741	\N
1297	Zambales	174	PH	Philippines	ZMB	province	15.5081766	119.9697808	\N
1302	Zamboanga del Norte	174	PH	Philippines	ZAN	province	8.3886282	123.1688883	\N
1357	Zamboanga del Sur	174	PH	Philippines	ZAS	province	7.8383054	123.2966657	\N
1325	Zamboanga Peninsula	174	PH	Philippines	09	region	8.154077	123.258793	\N
1362	Zamboanga Sibugay	174	PH	Philippines	ZSI	province	7.5225247	122.3107517	\N
1634	Greater Poland Voivodeship	176	PL	Poland	WP	\N	52.279986	17.3522939	\N
1625	Kuyavian-Pomeranian Voivodeship	176	PL	Poland	KP	\N	53.1648363	18.4834224	\N
1635	Lesser Poland Voivodeship	176	PL	Poland	MA	\N	49.7225306	20.2503358	\N
1629	Lower Silesian Voivodeship	176	PL	Poland	DS	\N	51.1339861	16.8841961	\N
1638	Lublin Voivodeship	176	PL	Poland	LU	\N	51.2493519	23.1011392	\N
1631	Lubusz Voivodeship	176	PL	Poland	LB	\N	52.2274612	15.2559103	\N
1636	Łódź Voivodeship	176	PL	Poland	LD	\N	51.4634771	19.1726974	\N
1637	Masovian Voivodeship	176	PL	Poland	MZ	\N	51.8927182	21.0021679	\N
1622	Opole Voivodeship	176	PL	Poland	OP	\N	50.8003761	17.937989	\N
1626	Podkarpackie Voivodeship	176	PL	Poland	PK	\N	50.0574749	22.0895691	\N
1632	Podlaskie Voivodeship	176	PL	Poland	PD	\N	53.0697159	22.9674639	\N
1624	Pomeranian Voivodeship	176	PL	Poland	PM	\N	54.2944252	18.1531164	\N
1623	Silesian Voivodeship	176	PL	Poland	SL	\N	50.5716595	19.3219768	\N
1630	Świętokrzyskie Voivodeship	176	PL	Poland	SK	\N	50.6261041	20.9406279	\N
1628	Warmian-Masurian Voivodeship	176	PL	Poland	WN	\N	53.8671117	20.7027861	\N
1633	West Pomeranian Voivodeship	176	PL	Poland	ZP	\N	53.4657891	15.1822581	\N
2233	Açores	177	PT	Portugal	20	\N	37.7412488	-25.6755944	\N
2235	Aveiro	177	PT	Portugal	01	\N	40.7209023	-8.5721016	\N
2230	Beja	177	PT	Portugal	02	\N	37.9687786	-7.87216	\N
2244	Braga	177	PT	Portugal	03	\N	41.550388	-8.4261301	\N
2229	Bragança	177	PT	Portugal	04	\N	41.8061652	-6.7567427	\N
2241	Castelo Branco	177	PT	Portugal	05	\N	39.8631323	-7.4814163	\N
2246	Coimbra	177	PT	Portugal	06	\N	40.2057994	-8.41369	\N
2236	Évora	177	PT	Portugal	07	\N	38.5744468	-7.9076553	\N
2239	Faro	177	PT	Portugal	08	\N	37.0193548	-7.9304397	\N
4859	Guarda	177	PT	Portugal	09	\N	40.5385972	-7.2675772	\N
2240	Leiria	177	PT	Portugal	10	\N	39.7709532	-8.7921836	\N
2228	Lisbon	177	PT	Portugal	11	\N	38.7223263	-9.1392714	\N
2231	Madeira	177	PT	Portugal	30	\N	32.7607074	-16.9594723	\N
2232	Portalegre	177	PT	Portugal	12	\N	39.2967086	-7.4284755	\N
2243	Porto	177	PT	Portugal	13	\N	41.1476629	-8.6078973	\N
2238	Santarém	177	PT	Portugal	14	\N	39.2366687	-8.6859944	\N
2242	Setúbal	177	PT	Portugal	15	\N	38.5240933	-8.8925876	\N
2245	Viana do Castelo	177	PT	Portugal	16	\N	41.6918046	-8.834451	\N
2234	Vila Real	177	PT	Portugal	17	\N	41.3003527	-7.7457274	\N
2237	Viseu	177	PT	Portugal	18	\N	40.6588424	-7.914756	\N
5081	Arecibo	178	PR	Puerto Rico	AR	state	18.47055556	-66.72083333	\N
5076	Bayamon	178	PR	Puerto Rico	BY	state	18.17777778	-66.11333333	\N
5079	Caguas	178	PR	Puerto Rico	CG	state	18.23333333	-66.03333333	\N
5077	Carolina	178	PR	Puerto Rico	CL	state	18.38888889	-65.96666667	\N
5080	Guaynabo	178	PR	Puerto Rico	GN	state	18.36666667	-66.1	\N
5083	Mayagüez	178	PR	Puerto Rico	MG	state	18.20111111	-67.13972222	\N
5078	Ponce	178	PR	Puerto Rico	PO	state	18	-66.61666667	\N
5075	San Juan	178	PR	Puerto Rico	SJ	state	18.45	-66.06666667	\N
5082	Toa Baja	178	PR	Puerto Rico	TB	state	18.443889	-66.259722	\N
5084	Trujillo Alto	178	PR	Puerto Rico	TA	state	18.362778	-66.0175	\N
3182	Al Daayen	179	QA	Qatar	ZA	\N	25.5784559	51.4821387	\N
3183	Al Khor	179	QA	Qatar	KH	\N	25.6804078	51.4968502	\N
3177	Al Rayyan Municipality	179	QA	Qatar	RA	\N	25.2522551	51.4388713	\N
3179	Al Wakrah	179	QA	Qatar	WA	\N	25.1659314	51.5975524	\N
3178	Al-Shahaniya	179	QA	Qatar	SH	\N	25.4106386	51.1846025	\N
3181	Doha	179	QA	Qatar	DA	\N	25.2854473	51.5310398	\N
3180	Madinat ash Shamal	179	QA	Qatar	MS	\N	26.1182743	51.2157265	\N
3184	Umm Salal Municipality	179	QA	Qatar	US	\N	25.4875242	51.396568	\N
4724	Alba	181	RO	Romania	AB	\N	44.7009153	8.0356911	\N
4739	Arad County	181	RO	Romania	AR	\N	46.2283651	21.6597819	\N
4722	Arges	181	RO	Romania	AG	\N	45.0722527	24.8142726	\N
4744	Bacău County	181	RO	Romania	BC	\N	46.3258184	26.662378	\N
4723	Bihor County	181	RO	Romania	BH	\N	47.0157516	22.172266	\N
4733	Bistrița-Năsăud County	181	RO	Romania	BN	\N	47.2486107	24.5322814	\N
4740	Botoșani County	181	RO	Romania	BT	\N	47.8924042	26.7591781	\N
4736	Braila	181	RO	Romania	BR	\N	45.2652463	27.9594714	\N
4759	Brașov County	181	RO	Romania	BV	\N	45.7781844	25.22258	\N
4730	Bucharest	181	RO	Romania	B	\N	44.4267674	26.1025384	\N
4756	Buzău County	181	RO	Romania	BZ	\N	45.3350912	26.7107578	\N
4732	Călărași County	181	RO	Romania	CL	\N	44.3658715	26.7548607	\N
4753	Caraș-Severin County	181	RO	Romania	CS	\N	45.1139646	22.0740993	\N
4734	Cluj County	181	RO	Romania	CJ	\N	46.7941797	23.6121492	\N
4737	Constanța County	181	RO	Romania	CT	\N	44.212987	28.2550055	\N
4754	Covasna County	181	RO	Romania	CV	\N	45.9426347	25.8918984	\N
4745	Dâmbovița County	181	RO	Romania	DB	\N	44.9289893	25.425385	\N
4742	Dolj County	181	RO	Romania	DJ	\N	44.1623022	23.6325054	\N
4747	Galați County	181	RO	Romania	GL	\N	45.7800569	27.8251576	\N
4726	Giurgiu County	181	RO	Romania	GR	\N	43.9037076	25.9699265	\N
4750	Gorj County	181	RO	Romania	GJ	\N	44.9485595	23.2427079	\N
4749	Harghita County	181	RO	Romania	HR	\N	46.4928507	25.6456696	\N
4721	Hunedoara County	181	RO	Romania	HD	\N	45.793638	22.9975993	\N
4743	Ialomița County	181	RO	Romania	IL	\N	44.603133	27.3789914	\N
4735	Iași County	181	RO	Romania	IS	\N	47.2679653	27.2185662	\N
4725	Ilfov County	181	RO	Romania	IF	\N	44.535548	26.2324886	\N
4760	Maramureș County	181	RO	Romania	MM	\N	46.5569904	24.6723215	\N
4751	Mehedinți County	181	RO	Romania	MH	\N	44.5515053	22.9044157	\N
4915	Mureș County	181	RO	Romania	MS	\N	46.5569904	24.6723215	\N
4731	Neamț County	181	RO	Romania	NT	\N	46.9758685	26.3818764	\N
4738	Olt County	181	RO	Romania	OT	\N	44.200797	24.5022981	\N
4729	Prahova County	181	RO	Romania	PH	\N	45.0891906	26.0829313	\N
4741	Sălaj County	181	RO	Romania	SJ	\N	47.2090813	23.2121901	\N
4746	Satu Mare County	181	RO	Romania	SM	\N	47.7668905	22.9241377	\N
4755	Sibiu County	181	RO	Romania	SB	\N	45.9269106	24.2254807	\N
4720	Suceava County	181	RO	Romania	SV	\N	47.5505548	25.741062	\N
4728	Teleorman County	181	RO	Romania	TR	\N	44.0160491	25.2986628	\N
4748	Timiș County	181	RO	Romania	TM	\N	45.8138902	21.3331055	\N
4727	Tulcea County	181	RO	Romania	TL	\N	45.0450565	29.0324912	\N
4757	Vâlcea County	181	RO	Romania	VL	\N	45.0798051	24.0835283	\N
4752	Vaslui County	181	RO	Romania	VS	\N	46.4631059	27.7398031	\N
4758	Vrancea County	181	RO	Romania	VN	\N	45.8134876	27.0657531	\N
1911	Altai Krai	182	RU	Russia	ALT	\N	51.7936298	82.6758596	\N
1876	Altai Republic	182	RU	Russia	AL	\N	50.6181924	86.2199308	\N
1858	Amur Oblast	182	RU	Russia	AMU	\N	54.6035065	127.4801721	\N
1849	Arkhangelsk	182	RU	Russia	ARK	\N	64.5458549	40.5505769	\N
1866	Astrakhan Oblast	182	RU	Russia	AST	\N	46.1321166	48.0610115	\N
1903	Belgorod Oblast	182	RU	Russia	BEL	\N	50.7106926	37.7533377	\N
1867	Bryansk Oblast	182	RU	Russia	BRY	\N	53.0408599	33.26909	\N
1893	Chechen Republic	182	RU	Russia	CE	\N	43.4023301	45.7187468	\N
1845	Chelyabinsk Oblast	182	RU	Russia	CHE	\N	54.4319422	60.8788963	\N
1859	Chukotka Autonomous Okrug	182	RU	Russia	CHU	\N	65.6298355	171.6952159	\N
1914	Chuvash Republic	182	RU	Russia	CU	\N	55.5595992	46.9283535	\N
1880	Irkutsk	182	RU	Russia	IRK	\N	52.2854834	104.2890222	\N
1864	Ivanovo Oblast	182	RU	Russia	IVA	\N	57.1056854	41.4830084	\N
1835	Jewish Autonomous Oblast	182	RU	Russia	YEV	\N	48.4808147	131.7657367	\N
1892	Kabardino-Balkar Republic	182	RU	Russia	KB	\N	43.3932469	43.5628498	\N
1902	Kaliningrad	182	RU	Russia	KGD	\N	54.7104264	20.4522144	\N
1844	Kaluga Oblast	182	RU	Russia	KLU	\N	54.3872666	35.1889094	\N
1865	Kamchatka Krai	182	RU	Russia	KAM	\N	61.4343981	166.7884131	\N
1869	Karachay-Cherkess Republic	182	RU	Russia	KC	\N	43.8845143	41.7303939	\N
1897	Kemerovo Oblast	182	RU	Russia	KEM	\N	54.7574648	87.4055288	\N
1873	Khabarovsk Krai	182	RU	Russia	KHA	\N	50.5888431	135	\N
1838	Khanty-Mansi Autonomous Okrug	182	RU	Russia	KHM	\N	62.2287062	70.6410057	\N
1890	Kirov Oblast	182	RU	Russia	KIR	\N	58.4198529	50.2097248	\N
1899	Komi Republic	182	RU	Russia	KO	\N	63.8630539	54.831269	\N
1910	Kostroma Oblast	182	RU	Russia	KOS	\N	58.5501069	43.9541102	\N
1891	Krasnodar Krai	182	RU	Russia	KDA	\N	45.6415289	39.7055977	\N
1840	Krasnoyarsk Krai	182	RU	Russia	KYA	\N	64.2479758	95.1104176	\N
1915	Kurgan Oblast	182	RU	Russia	KGN	\N	55.4481548	65.1180975	\N
1855	Kursk Oblast	182	RU	Russia	KRS	\N	51.7634026	35.3811812	\N
1896	Leningrad Oblast	182	RU	Russia	LEN	\N	60.0793208	31.8926645	\N
1889	Lipetsk Oblast	182	RU	Russia	LIP	\N	52.5264702	39.2032269	\N
1839	Magadan Oblast	182	RU	Russia	MAG	\N	62.6643417	153.914991	\N
1870	Mari El Republic	182	RU	Russia	ME	\N	56.438457	47.9607758	\N
1901	Moscow	182	RU	Russia	MOW	\N	55.755826	37.6172999	\N
1882	Moscow Oblast	182	RU	Russia	MOS	\N	55.340396	38.2917651	\N
1843	Murmansk Oblast	182	RU	Russia	MUR	\N	67.8442674	35.0884102	\N
1836	Nenets Autonomous Okrug	182	RU	Russia	NEN	\N	67.6078337	57.6338331	\N
1857	Nizhny Novgorod Oblast	182	RU	Russia	NIZ	\N	55.7995159	44.0296769	\N
1834	Novgorod Oblast	182	RU	Russia	NGR	\N	58.2427552	32.566519	\N
1888	Novosibirsk	182	RU	Russia	NVS	\N	54.9832693	82.8963831	\N
1846	Omsk Oblast	182	RU	Russia	OMS	\N	55.0554669	73.3167342	\N
1886	Orenburg Oblast	182	RU	Russia	ORE	\N	51.7634026	54.6188188	\N
1908	Oryol Oblast	182	RU	Russia	ORL	\N	52.7856414	36.9242344	\N
1909	Penza Oblast	182	RU	Russia	PNZ	\N	53.1412105	44.0940048	\N
1871	Perm Krai	182	RU	Russia	PER	\N	58.8231929	56.5872481	\N
1833	Primorsky Krai	182	RU	Russia	PRI	\N	45.0525641	135	\N
1863	Pskov Oblast	182	RU	Russia	PSK	\N	56.7708599	29.094009	\N
1852	Republic of Adygea	182	RU	Russia	AD	\N	44.8229155	40.1754463	\N
1854	Republic of Bashkortostan	182	RU	Russia	BA	\N	54.2312172	56.1645257	\N
1842	Republic of Buryatia	182	RU	Russia	BU	\N	54.8331146	112.406053	\N
1850	Republic of Dagestan	182	RU	Russia	DA	\N	42.1431886	47.0949799	\N
1884	Republic of Ingushetia	182	RU	Russia	IN	\N	43.4051698	44.8202999	\N
1883	Republic of Kalmykia	182	RU	Russia	KL	\N	46.1867176	45	\N
1841	Republic of Karelia	182	RU	Russia	KR	\N	63.1558702	32.9905552	\N
1877	Republic of Khakassia	182	RU	Russia	KK	\N	53.0452281	90.3982145	\N
1898	Republic of Mordovia	182	RU	Russia	MO	\N	54.2369441	44.068397	\N
1853	Republic of North Ossetia-Alania	182	RU	Russia	SE	\N	43.0451302	44.2870972	\N
1861	Republic of Tatarstan	182	RU	Russia	TA	\N	55.1802364	50.7263945	\N
1837	Rostov Oblast	182	RU	Russia	ROS	\N	47.6853247	41.8258952	\N
1905	Ryazan Oblast	182	RU	Russia	RYA	\N	54.3875964	41.2595661	\N
1879	Saint Petersburg	182	RU	Russia	SPE	\N	59.9310584	30.3609096	\N
1848	Sakha Republic	182	RU	Russia	SA	\N	66.7613451	124.123753	\N
1875	Sakhalin	182	RU	Russia	SAK	\N	50.6909848	142.9505689	\N
1862	Samara Oblast	182	RU	Russia	SAM	\N	53.4183839	50.4725528	\N
1887	Saratov Oblast	182	RU	Russia	SAR	\N	51.8369263	46.7539397	\N
1912	Sevastopol	182	RU	Russia	UA-40	\N	44.61665	33.5253671	\N
1885	Smolensk Oblast	182	RU	Russia	SMO	\N	54.9882994	32.6677378	\N
1868	Stavropol Krai	182	RU	Russia	STA	\N	44.6680993	43.520214	\N
1894	Sverdlovsk	182	RU	Russia	SVE	\N	56.8430993	60.6454086	\N
1878	Tambov Oblast	182	RU	Russia	TAM	\N	52.6416589	41.4216451	\N
1872	Tomsk Oblast	182	RU	Russia	TOM	\N	58.8969882	82.67655	\N
1895	Tula Oblast	182	RU	Russia	TUL	\N	54.163768	37.5649507	\N
1900	Tuva Republic	182	RU	Russia	TY	\N	51.8872669	95.6260172	\N
1860	Tver Oblast	182	RU	Russia	TVE	\N	57.0021654	33.9853142	\N
1907	Tyumen Oblast	182	RU	Russia	TYU	\N	56.9634387	66.948278	\N
1913	Udmurt Republic	182	RU	Russia	UD	\N	57.0670218	53.0277948	\N
1856	Ulyanovsk Oblast	182	RU	Russia	ULY	\N	53.9793357	47.7762425	\N
1881	Vladimir Oblast	182	RU	Russia	VLA	\N	56.1553465	40.5926685	\N
4916	Volgograd Oblast	182	RU	Russia	VGG	\N	49.2587393	39.8154463	\N
1874	Vologda Oblast	182	RU	Russia	VLG	\N	59.8706711	40.6555411	\N
1906	Voronezh Oblast	182	RU	Russia	VOR	\N	50.8589713	39.8644374	\N
1847	Yamalo-Nenets Autonomous Okrug	182	RU	Russia	YAN	\N	66.0653057	76.9345193	\N
1851	Yaroslavl Oblast	182	RU	Russia	YAR	\N	57.8991523	38.8388633	\N
1904	Zabaykalsky Krai	182	RU	Russia	ZAB	\N	53.0928771	116.9676561	\N
261	Eastern Province	183	RW	Rwanda	02	\N	\N	\N	\N
262	Kigali district	183	RW	Rwanda	01	\N	-1.9440727	30.0618851	\N
263	Northern Province	183	RW	Rwanda	03	\N	\N	\N	\N
259	Southern Province	183	RW	Rwanda	05	\N	\N	\N	\N
260	Western Province	183	RW	Rwanda	04	\N	\N	\N	\N
3833	Christ Church Nichola Town Parish	185	KN	Saint Kitts And Nevis	01	\N	17.3604812	-62.7617837	\N
3832	Nevis	185	KN	Saint Kitts And Nevis	N	\N	17.1553558	-62.5796026	\N
3836	Saint Anne Sandy Point Parish	185	KN	Saint Kitts And Nevis	02	\N	17.3725333	-62.8441133	\N
3837	Saint George Gingerland Parish	185	KN	Saint Kitts And Nevis	04	\N	17.1257759	-62.5619811	\N
3835	Saint James Windward Parish	185	KN	Saint Kitts And Nevis	05	\N	17.1769633	-62.5796026	\N
3845	Saint John Capisterre Parish	185	KN	Saint Kitts And Nevis	06	\N	17.3810341	-62.7911833	\N
3840	Saint John Figtree Parish	185	KN	Saint Kitts And Nevis	07	\N	17.1155748	-62.6031004	\N
3841	Saint Kitts	185	KN	Saint Kitts And Nevis	K	\N	17.3433796	-62.7559043	\N
3844	Saint Mary Cayon Parish	185	KN	Saint Kitts And Nevis	08	\N	17.3462071	-62.7382671	\N
3834	Saint Paul Capisterre Parish	185	KN	Saint Kitts And Nevis	09	\N	17.4016683	-62.8257332	\N
3838	Saint Paul Charlestown Parish	185	KN	Saint Kitts And Nevis	10	\N	17.1346297	-62.6133816	\N
3831	Saint Peter Basseterre Parish	185	KN	Saint Kitts And Nevis	11	\N	17.3102911	-62.7147533	\N
3839	Saint Thomas Lowland Parish	185	KN	Saint Kitts And Nevis	12	\N	17.1650513	-62.6089753	\N
3842	Saint Thomas Middle Island Parish	185	KN	Saint Kitts And Nevis	13	\N	17.3348813	-62.8088251	\N
3843	Trinity Palmetto Point Parish	185	KN	Saint Kitts And Nevis	15	\N	17.3063519	-62.7617837	\N
3757	Anse la Raye Quarter	186	LC	Saint Lucia	01	\N	13.9459424	-61.0369468	\N
3761	Canaries	186	LC	Saint Lucia	12	\N	28.2915637	-16.6291304	\N
3758	Castries Quarter	186	LC	Saint Lucia	02	\N	14.0101094	-60.9874687	\N
3760	Choiseul Quarter	186	LC	Saint Lucia	03	\N	13.7750154	-61.048591	\N
3767	Dauphin Quarter	186	LC	Saint Lucia	04	\N	14.0103396	-60.9190988	\N
3756	Dennery Quarter	186	LC	Saint Lucia	05	\N	13.9267393	-60.9190988	\N
3766	Gros Islet Quarter	186	LC	Saint Lucia	06	\N	14.0843578	-60.9452794	\N
3759	Laborie Quarter	186	LC	Saint Lucia	07	\N	13.7522783	-60.9932889	\N
3762	Micoud Quarter	186	LC	Saint Lucia	08	\N	13.8211871	-60.9001934	\N
3765	Praslin Quarter	186	LC	Saint Lucia	09	\N	13.8752392	-60.8994663	\N
3764	Soufrière Quarter	186	LC	Saint Lucia	10	\N	13.8570986	-61.0573248	\N
3763	Vieux Fort Quarter	186	LC	Saint Lucia	11	\N	13.720608	-60.9496433	\N
3389	Charlotte Parish	188	VC	Saint Vincent And The Grenadines	01	\N	13.2175451	-61.1636244	\N
3388	Grenadines Parish	188	VC	Saint Vincent And The Grenadines	06	\N	13.0122965	-61.2277301	\N
3386	Saint Andrew Parish	188	VC	Saint Vincent And The Grenadines	02	\N	43.0242999	-81.2025	\N
3387	Saint David Parish	188	VC	Saint Vincent And The Grenadines	03	\N	43.8523095	-79.5236654	\N
3384	Saint George Parish	188	VC	Saint Vincent And The Grenadines	04	\N	42.957609	-81.326705	\N
3385	Saint Patrick Parish	188	VC	Saint Vincent And The Grenadines	05	\N	39.7509186	-94.8450556	\N
4763	A'ana	191	WS	Samoa	AA	\N	-13.898418	-171.9752995	\N
4761	Aiga-i-le-Tai	191	WS	Samoa	AL	\N	-13.8513791	-172.0325401	\N
4765	Atua	191	WS	Samoa	AT	\N	-13.9787053	-171.6254283	\N
4764	Fa'asaleleaga	191	WS	Samoa	FA	\N	-13.6307638	-172.2365981	\N
4769	Gaga'emauga	191	WS	Samoa	GE	\N	-13.5428666	-172.366887	\N
4771	Gaga'ifomauga	191	WS	Samoa	GI	\N	-13.5468007	-172.4969331	\N
4767	Palauli	191	WS	Samoa	PA	\N	-13.7294579	-172.4536115	\N
4762	Satupa'itea	191	WS	Samoa	SA	\N	-13.6538214	-172.6159271	\N
4770	Tuamasaga	191	WS	Samoa	TU	\N	-13.9163592	-171.8224362	\N
4768	Va'a-o-Fonoti	191	WS	Samoa	VF	\N	-13.9470903	-171.5431872	\N
4766	Vaisigano	191	WS	Samoa	VS	\N	-13.5413827	-172.7023383	\N
59	Acquaviva	192	SM	San Marino	01	\N	41.8671597	14.7469479	\N
61	Borgo Maggiore	192	SM	San Marino	06	\N	43.9574882	12.4552546	\N
60	Chiesanuova	192	SM	San Marino	02	\N	45.4226172	7.6503854	\N
64	Domagnano	192	SM	San Marino	03	\N	43.9501929	12.4681537	\N
62	Faetano	192	SM	San Marino	04	\N	43.9348967	12.4896554	\N
66	Fiorentino	192	SM	San Marino	05	\N	43.9078337	12.4581209	\N
63	Montegiardino	192	SM	San Marino	08	\N	43.9052999	12.4810542	\N
58	San Marino	192	SM	San Marino	07	\N	43.94236	12.457777	\N
65	Serravalle	192	SM	San Marino	09	\N	44.7232084	8.8574005	\N
270	Príncipe Province	193	ST	Sao Tome and Principe	P	\N	1.6139381	7.4056928	\N
271	São Tomé Province	193	ST	Sao Tome and Principe	S	\N	0.3301924	6.733343	\N
2853	'Asir	194	SA	Saudi Arabia	14	\N	19.0969062	42.8637875	\N
2859	Al Bahah	194	SA	Saudi Arabia	11	\N	20.2722739	41.441251	\N
2857	Al Jawf	194	SA	Saudi Arabia	12	\N	29.887356	39.3206241	\N
2851	Al Madinah	194	SA	Saudi Arabia	03	\N	24.8403977	39.3206241	\N
2861	Al-Qassim	194	SA	Saudi Arabia	05	\N	26.207826	43.483738	\N
2856	Eastern Province	194	SA	Saudi Arabia	04	\N	24.0439932	45.6589225	\N
2855	Ha'il	194	SA	Saudi Arabia	06	\N	27.7076143	41.9196471	\N
2858	Jizan	194	SA	Saudi Arabia	09	\N	17.1738176	42.7076107	\N
2850	Makkah	194	SA	Saudi Arabia	02	\N	21.5235584	41.9196471	\N
2860	Najran	194	SA	Saudi Arabia	10	\N	18.3514664	45.6007108	\N
2854	Northern Borders	194	SA	Saudi Arabia	08	\N	30.0799162	42.8637875	\N
2849	Riyadh	194	SA	Saudi Arabia	01	\N	22.7554385	46.2091547	\N
2852	Tabuk	194	SA	Saudi Arabia	07	\N	28.2453335	37.6386622	\N
473	Dakar	195	SN	Senegal	DK	\N	14.716677	-17.4676861	\N
480	Diourbel Region	195	SN	Senegal	DB	\N	14.7283085	-16.2522143	\N
479	Fatick	195	SN	Senegal	FK	\N	14.3390167	-16.4111425	\N
475	Kaffrine	195	SN	Senegal	KA	\N	14.105202	-15.5415755	\N
483	Kaolack	195	SN	Senegal	KL	\N	14.1652083	-16.0757749	\N
481	Kédougou	195	SN	Senegal	KE	\N	12.5604607	-12.1747077	\N
474	Kolda	195	SN	Senegal	KD	\N	12.9107495	-14.9505671	\N
485	Louga	195	SN	Senegal	LG	\N	15.6141768	-16.22868	\N
476	Matam	195	SN	Senegal	MT	\N	15.6600225	-13.2576906	\N
477	Saint-Louis	195	SN	Senegal	SL	\N	38.6270025	-90.1994042	\N
482	Sédhiou	195	SN	Senegal	SE	\N	12.704604	-15.5562304	\N
486	Tambacounda Region	195	SN	Senegal	TC	\N	13.5619011	-13.1740348	\N
484	Thiès Region	195	SN	Senegal	TH	\N	14.7910052	-16.9358604	\N
478	Ziguinchor	195	SN	Senegal	ZG	\N	12.5641479	-16.2639825	\N
3728	Belgrade	196	RS	Serbia	00	\N	44.786568	20.4489216	\N
3717	Bor District	196	RS	Serbia	14	\N	44.0698918	22.0985086	\N
3732	Braničevo District	196	RS	Serbia	11	\N	44.6982246	21.5446775	\N
3716	Central Banat District	196	RS	Serbia	02	\N	45.4788485	20.6082522	\N
3715	Jablanica District	196	RS	Serbia	23	\N	42.948156	21.8129321	\N
3724	Kolubara District	196	RS	Serbia	09	\N	44.3509811	20.0004305	\N
3719	Mačva District	196	RS	Serbia	08	\N	44.5925314	19.5082246	\N
3727	Moravica District	196	RS	Serbia	17	\N	43.84147	20.2904987	\N
3722	Nišava District	196	RS	Serbia	20	\N	43.3738902	21.9322331	\N
3714	North Bačka District	196	RS	Serbia	01	\N	45.9803394	19.5907001	\N
3736	North Banat District	196	RS	Serbia	03	\N	45.906839	19.9993417	\N
3721	Pčinja District	196	RS	Serbia	24	\N	42.5836362	22.1430215	\N
3712	Pirot District	196	RS	Serbia	22	\N	43.0874036	22.5983044	\N
3741	Podunavlje District	196	RS	Serbia	10	\N	44.4729156	20.9901426	\N
3737	Pomoravlje District	196	RS	Serbia	13	\N	43.9591379	21.271353	\N
3720	Rasina District	196	RS	Serbia	19	\N	43.5263525	21.1588178	\N
3725	Raška District	196	RS	Serbia	18	\N	43.3373461	20.5734005	\N
3711	South Bačka District	196	RS	Serbia	06	\N	45.4890344	19.6976187	\N
3713	South Banat District	196	RS	Serbia	04	\N	45.0027457	21.0542509	\N
3740	Srem District	196	RS	Serbia	07	\N	45.0029171	19.8013773	\N
3734	Šumadija District	196	RS	Serbia	12	\N	44.2050678	20.7856565	\N
3718	Toplica District	196	RS	Serbia	21	\N	43.1906592	21.3407762	\N
3733	Vojvodina	196	RS	Serbia	VO	\N	45.2608651	19.8319338	\N
3726	West Bačka District	196	RS	Serbia	05	\N	45.7355385	19.1897364	\N
3731	Zaječar District	196	RS	Serbia	15	\N	43.9015048	22.2738011	\N
3729	Zlatibor District	196	RS	Serbia	16	\N	43.645417	19.7101455	\N
513	Anse Boileau	197	SC	Seychelles	02	\N	-4.7047268	55.4859363	\N
502	Anse Royale	197	SC	Seychelles	05	\N	-4.7407988	55.5081012	\N
506	Anse-aux-Pins	197	SC	Seychelles	01	\N	-4.6900443	55.5150289	\N
508	Au Cap	197	SC	Seychelles	04	\N	-4.7059723	55.5081012	\N
497	Baie Lazare	197	SC	Seychelles	06	\N	-4.7482525	55.4859363	\N
514	Baie Sainte Anne	197	SC	Seychelles	07	\N	47.05259	-64.9524579	\N
512	Beau Vallon	197	SC	Seychelles	08	\N	-4.6210967	55.4277802	\N
515	Bel Air	197	SC	Seychelles	09	\N	34.1002455	-118.459463	\N
505	Bel Ombre	197	SC	Seychelles	10	\N	-20.5010095	57.4259624	\N
517	Cascade	197	SC	Seychelles	11	\N	44.5162821	-116.0417983	\N
503	Glacis	197	SC	Seychelles	12	\N	47.1157303	-70.3028183	\N
500	Grand'Anse Mahé	197	SC	Seychelles	13	\N	-4.677392	55.463777	\N
504	Grand'Anse Praslin	197	SC	Seychelles	14	\N	-4.3176219	55.7078363	\N
495	La Digue	197	SC	Seychelles	15	\N	49.7666922	-97.1546629	\N
516	La Rivière Anglaise	197	SC	Seychelles	16	\N	-4.610615	55.4540841	\N
499	Les Mamelles	197	SC	Seychelles	24	\N	38.8250505	-90.4834517	\N
494	Mont Buxton	197	SC	Seychelles	17	\N	-4.6166667	55.4457768	\N
498	Mont Fleuri	197	SC	Seychelles	18	\N	-4.6356543	55.4554688	\N
511	Plaisance	197	SC	Seychelles	19	\N	45.607095	-75.1142745	\N
510	Pointe La Rue	197	SC	Seychelles	20	\N	-4.680489	55.5191857	\N
507	Port Glaud	197	SC	Seychelles	21	\N	-4.6488523	55.4194753	\N
501	Roche Caiman	197	SC	Seychelles	25	\N	-4.6396028	55.4679315	\N
496	Saint Louis	197	SC	Seychelles	22	\N	38.6270025	-90.1994042	\N
509	Takamaka	197	SC	Seychelles	23	\N	37.9645917	-1.2217727	\N
914	Eastern Province	198	SL	Sierra Leone	E	\N	\N	\N	\N
911	Northern Province	198	SL	Sierra Leone	N	\N	\N	\N	\N
912	Southern Province	198	SL	Sierra Leone	S	\N	\N	\N	\N
913	Western Area	198	SL	Sierra Leone	W	\N	40.2545969	-80.2455444	\N
4651	Central Singapore Community Development Council	199	SG	Singapore	01	\N	1.289514	103.8143879	\N
4649	North East Community Development Council	199	SG	Singapore	02	\N	45.0118113	-93.2468107	\N
4653	North West Community Development Council	199	SG	Singapore	03	\N	39.107093	-94.457336	\N
4650	South East Community Development Council	199	SG	Singapore	04	\N	39.286307	-76.5691237	\N
4652	South West Community Development Council	199	SG	Singapore	05	\N	39.925691	-75.231058	\N
4352	Banská Bystrica Region	200	SK	Slovakia	BC	\N	48.5312499	19.382874	\N
4356	Bratislava Region	200	SK	Slovakia	BL	\N	48.3118304	17.1973299	\N
4353	Košice Region	200	SK	Slovakia	KI	\N	48.6375737	21.0834225	\N
4357	Nitra Region	200	SK	Slovakia	NI	\N	48.0143765	18.5416504	\N
4354	Prešov Region	200	SK	Slovakia	PV	\N	49.1716773	21.3742001	\N
4358	Trenčín Region	200	SK	Slovakia	TC	\N	48.8086758	18.2324026	\N
4355	Trnava Region	200	SK	Slovakia	TA	\N	48.3943898	17.7216205	\N
4359	Žilina Region	200	SK	Slovakia	ZI	\N	49.2031435	19.3645733	\N
4183	Ajdovščina Municipality	201	SI	Slovenia	001	\N	45.8870776	13.9042818	\N
4326	Ankaran Municipality	201	SI	Slovenia	213	\N	45.578451	13.7369174	\N
4301	Beltinci Municipality	201	SI	Slovenia	002	\N	46.6079153	16.2365127	\N
4166	Benedikt Municipality	201	SI	Slovenia	148	\N	46.6155841	15.8957281	\N
4179	Bistrica ob Sotli Municipality	201	SI	Slovenia	149	\N	46.0565579	15.6625947	\N
4202	Bled Municipality	201	SI	Slovenia	003	\N	46.3683266	14.1145798	\N
4278	Bloke Municipality	201	SI	Slovenia	150	\N	45.7728141	14.5063459	\N
4282	Bohinj Municipality	201	SI	Slovenia	004	\N	46.3005652	13.9427195	\N
4200	Borovnica Municipality	201	SI	Slovenia	005	\N	45.9044525	14.3824189	\N
4181	Bovec Municipality	201	SI	Slovenia	006	\N	46.3380495	13.5524174	\N
4141	Braslovče Municipality	201	SI	Slovenia	151	\N	46.2836192	15.041832	\N
4240	Brda Municipality	201	SI	Slovenia	007	\N	45.9975652	13.5270474	\N
4215	Brežice Municipality	201	SI	Slovenia	009	\N	45.9041096	15.5943639	\N
4165	Brezovica Municipality	201	SI	Slovenia	008	\N	45.9559351	14.4349952	\N
4147	Cankova Municipality	201	SI	Slovenia	152	\N	46.718237	16.0197222	\N
4310	Cerklje na Gorenjskem Municipality	201	SI	Slovenia	012	\N	46.2517054	14.4857979	\N
4162	Cerknica Municipality	201	SI	Slovenia	013	\N	45.7966255	14.392177	\N
4178	Cerkno Municipality	201	SI	Slovenia	014	\N	46.1288414	13.9894027	\N
4176	Cerkvenjak Municipality	201	SI	Slovenia	153	\N	46.5670711	15.9429753	\N
4191	City Municipality of Celje	201	SI	Slovenia	011	\N	46.2397495	15.2677063	\N
4236	City Municipality of Novo Mesto	201	SI	Slovenia	085	\N	45.8010824	15.1710089	\N
4151	Črenšovci Municipality	201	SI	Slovenia	015	\N	46.5720029	16.2877346	\N
4232	Črna na Koroškem Municipality	201	SI	Slovenia	016	\N	46.4704529	14.8499998	\N
4291	Črnomelj Municipality	201	SI	Slovenia	017	\N	45.5361225	15.1944143	\N
4304	Destrnik Municipality	201	SI	Slovenia	018	\N	46.4922368	15.8777956	\N
4167	Divača Municipality	201	SI	Slovenia	019	\N	45.6806069	13.9720312	\N
4295	Dobje Municipality	201	SI	Slovenia	154	\N	46.1370037	15.394129	\N
4216	Dobrepolje Municipality	201	SI	Slovenia	020	\N	45.8524951	14.7083109	\N
4252	Dobrna Municipality	201	SI	Slovenia	155	\N	46.3356141	15.2259732	\N
4308	Dobrova–Polhov Gradec Municipality	201	SI	Slovenia	021	\N	46.0648896	14.3168195	\N
4189	Dobrovnik Municipality	201	SI	Slovenia	156	\N	46.6538662	16.3506594	\N
4173	Dol pri Ljubljani Municipality	201	SI	Slovenia	022	\N	46.0884386	14.6424792	\N
4281	Dolenjske Toplice Municipality	201	SI	Slovenia	157	\N	45.7345711	15.0129493	\N
4159	Domžale Municipality	201	SI	Slovenia	023	\N	46.1438269	14.6375279	\N
4290	Dornava Municipality	201	SI	Slovenia	024	\N	46.4443513	15.9889159	\N
4345	Dravograd Municipality	201	SI	Slovenia	025	\N	46.589219	15.0246021	\N
4213	Duplek Municipality	201	SI	Slovenia	026	\N	46.5010016	15.7546307	\N
4293	Gorenja Vas–Poljane Municipality	201	SI	Slovenia	027	\N	46.1116582	14.1149348	\N
4210	Gorišnica Municipality	201	SI	Slovenia	028	\N	46.4120271	16.0133089	\N
4284	Gorje Municipality	201	SI	Slovenia	207	\N	46.3802458	14.0685339	\N
4343	Gornja Radgona Municipality	201	SI	Slovenia	029	\N	46.6767099	15.9910847	\N
4339	Gornji Grad Municipality	201	SI	Slovenia	030	\N	46.2961712	14.8062347	\N
4271	Gornji Petrovci Municipality	201	SI	Slovenia	031	\N	46.8037128	16.2191379	\N
4217	Grad Municipality	201	SI	Slovenia	158	\N	46.808732	16.109206	\N
4336	Grosuplje Municipality	201	SI	Slovenia	032	\N	45.9557645	14.658899	\N
4145	Hajdina Municipality	201	SI	Slovenia	159	\N	46.4185014	15.8244722	\N
4175	Hoče–Slivnica Municipality	201	SI	Slovenia	160	\N	46.477858	15.6476005	\N
4327	Hodoš Municipality	201	SI	Slovenia	161	\N	46.8314134	16.321068	\N
4193	Horjul Municipality	201	SI	Slovenia	162	\N	46.0225378	14.2986269	\N
4341	Hrastnik Municipality	201	SI	Slovenia	034	\N	46.1417288	15.0844894	\N
4321	Hrpelje–Kozina Municipality	201	SI	Slovenia	035	\N	45.6091192	13.9379148	\N
4152	Idrija Municipality	201	SI	Slovenia	036	\N	46.0040939	13.9775493	\N
4286	Ig Municipality	201	SI	Slovenia	037	\N	45.9588868	14.5270528	\N
4305	Ivančna Gorica Municipality	201	SI	Slovenia	039	\N	45.9395841	14.8047626	\N
4322	Izola Municipality	201	SI	Slovenia	040	\N	45.5313557	13.6664649	\N
4337	Jesenice Municipality	201	SI	Slovenia	041	\N	46.4367047	14.0526057	\N
4203	Jezersko Municipality	201	SI	Slovenia	163	\N	46.3942794	14.4985559	\N
4266	Juršinci Municipality	201	SI	Slovenia	042	\N	46.4898651	15.980923	\N
4180	Kamnik Municipality	201	SI	Slovenia	043	\N	46.2221666	14.6070727	\N
4227	Kanal ob Soči Municipality	201	SI	Slovenia	044	\N	46.067353	13.620335	\N
4150	Kidričevo Municipality	201	SI	Slovenia	045	\N	46.3957572	15.7925906	\N
4243	Kobarid Municipality	201	SI	Slovenia	046	\N	46.2456971	13.5786949	\N
4325	Kobilje Municipality	201	SI	Slovenia	047	\N	46.68518	16.3936719	\N
4335	Kočevje Municipality	201	SI	Slovenia	048	\N	45.6428	14.8615838	\N
4315	Komen Municipality	201	SI	Slovenia	049	\N	45.8175235	13.7482711	\N
4283	Komenda Municipality	201	SI	Slovenia	164	\N	46.206488	14.5382499	\N
4319	Koper City Municipality	201	SI	Slovenia	050	\N	45.548059	13.7301877	\N
4254	Kostanjevica na Krki Municipality	201	SI	Slovenia	197	\N	45.8316638	15.4411906	\N
4331	Kostel Municipality	201	SI	Slovenia	165	\N	45.4928255	14.8708235	\N
4186	Kozje Municipality	201	SI	Slovenia	051	\N	46.0733211	15.5596719	\N
4287	Kranj City Municipality	201	SI	Slovenia	052	\N	46.2585021	14.3543569	\N
4340	Kranjska Gora Municipality	201	SI	Slovenia	053	\N	46.4845293	13.7857145	\N
4238	Križevci Municipality	201	SI	Slovenia	166	\N	46.5701821	16.1092653	\N
4197	Kungota	201	SI	Slovenia	055	\N	46.6418793	15.6036288	\N
4211	Kuzma Municipality	201	SI	Slovenia	056	\N	46.8351038	16.08071	\N
4338	Laško Municipality	201	SI	Slovenia	057	\N	46.1542236	15.2361491	\N
4142	Lenart Municipality	201	SI	Slovenia	058	\N	46.5834424	15.8262125	\N
4225	Lendava Municipality	201	SI	Slovenia	059	\N	46.5513483	16.4419839	\N
4347	Litija Municipality	201	SI	Slovenia	060	\N	46.0573226	14.8309636	\N
4270	Ljubljana City Municipality	201	SI	Slovenia	061	\N	46.0569465	14.5057515	\N
4294	Ljubno Municipality	201	SI	Slovenia	062	\N	46.3443125	14.8335492	\N
4351	Ljutomer Municipality	201	SI	Slovenia	063	\N	46.5190848	16.1893216	\N
4306	Log–Dragomer Municipality	201	SI	Slovenia	208	\N	46.0178747	14.3687767	\N
4350	Logatec Municipality	201	SI	Slovenia	064	\N	45.917611	14.2351451	\N
4174	Loška Dolina Municipality	201	SI	Slovenia	065	\N	45.6477908	14.4973147	\N
4158	Loški Potok Municipality	201	SI	Slovenia	066	\N	45.6909637	14.598597	\N
4156	Lovrenc na Pohorju Municipality	201	SI	Slovenia	167	\N	46.5419638	15.4000443	\N
4219	Luče Municipality	201	SI	Slovenia	067	\N	46.3544925	14.7471504	\N
4302	Lukovica Municipality	201	SI	Slovenia	068	\N	46.1696293	14.6907259	\N
4157	Majšperk Municipality	201	SI	Slovenia	069	\N	46.3503019	15.7340595	\N
4224	Makole Municipality	201	SI	Slovenia	198	\N	46.3168697	15.6664126	\N
4242	Maribor City Municipality	201	SI	Slovenia	070	\N	46.5506496	15.6205439	\N
4244	Markovci Municipality	201	SI	Slovenia	168	\N	46.3879309	15.9586014	\N
4349	Medvode Municipality	201	SI	Slovenia	071	\N	46.141908	14.4032596	\N
4348	Mengeš Municipality	201	SI	Slovenia	072	\N	46.1659122	14.5719694	\N
4323	Metlika Municipality	201	SI	Slovenia	073	\N	45.6480715	15.3177838	\N
4265	Mežica Municipality	201	SI	Slovenia	074	\N	46.5215027	14.852134	\N
4223	Miklavž na Dravskem Polju Municipality	201	SI	Slovenia	169	\N	46.5082628	15.6952065	\N
4220	Miren–Kostanjevica Municipality	201	SI	Slovenia	075	\N	45.8436029	13.6276647	\N
4298	Mirna Municipality	201	SI	Slovenia	212	\N	45.9515647	15.0620977	\N
4237	Mirna Peč Municipality	201	SI	Slovenia	170	\N	45.8481574	15.087945	\N
4212	Mislinja Municipality	201	SI	Slovenia	076	\N	46.4429403	15.1987678	\N
4297	Mokronog–Trebelno Municipality	201	SI	Slovenia	199	\N	45.9088529	15.1596736	\N
4168	Moravče Municipality	201	SI	Slovenia	077	\N	46.1362781	14.746001	\N
4218	Moravske Toplice Municipality	201	SI	Slovenia	078	\N	46.6856932	16.2224582	\N
4190	Mozirje Municipality	201	SI	Slovenia	079	\N	46.339435	14.9602413	\N
4318	Municipality of Apače	201	SI	Slovenia	195	\N	46.6974679	15.9102534	\N
4309	Municipality of Cirkulane	201	SI	Slovenia	196	\N	46.3298322	15.9980666	\N
4344	Municipality of Ilirska Bistrica	201	SI	Slovenia	038	\N	45.5791323	14.2809729	\N
4314	Municipality of Krško	201	SI	Slovenia	054	\N	45.9589609	15.4923555	\N
4187	Municipality of Škofljica	201	SI	Slovenia	123	\N	45.9840962	14.5746626	\N
4313	Murska Sobota City Municipality	201	SI	Slovenia	080	\N	46.6432147	16.1515754	\N
4208	Muta Municipality	201	SI	Slovenia	081	\N	46.6097366	15.1629995	\N
4177	Naklo Municipality	201	SI	Slovenia	082	\N	46.2718663	14.3156932	\N
4329	Nazarje Municipality	201	SI	Slovenia	083	\N	46.2821741	14.9225629	\N
4205	Nova Gorica City Municipality	201	SI	Slovenia	084	\N	45.976276	13.7308881	\N
4320	Odranci Municipality	201	SI	Slovenia	086	\N	46.5901017	16.2788165	\N
4143	Oplotnica	201	SI	Slovenia	171	\N	46.387163	15.4458131	\N
4221	Ormož Municipality	201	SI	Slovenia	087	\N	46.4353333	16.154374	\N
4199	Osilnica Municipality	201	SI	Slovenia	088	\N	45.5418467	14.7156303	\N
4172	Pesnica Municipality	201	SI	Slovenia	089	\N	46.6088755	15.6757051	\N
4201	Piran Municipality	201	SI	Slovenia	090	\N	45.5288856	13.5680735	\N
4184	Pivka Municipality	201	SI	Slovenia	091	\N	45.6789296	14.2542689	\N
4146	Podčetrtek Municipality	201	SI	Slovenia	092	\N	46.1739542	15.6013816	\N
4161	Podlehnik Municipality	201	SI	Slovenia	172	\N	46.3310782	15.8785836	\N
4234	Podvelka Municipality	201	SI	Slovenia	093	\N	46.6221952	15.3889922	\N
4239	Poljčane Municipality	201	SI	Slovenia	200	\N	46.3139853	15.5784791	\N
4272	Polzela Municipality	201	SI	Slovenia	173	\N	46.280897	15.0737321	\N
4330	Postojna Municipality	201	SI	Slovenia	094	\N	45.774939	14.2134263	\N
4188	Prebold Municipality	201	SI	Slovenia	174	\N	46.2359136	15.0936912	\N
4303	Preddvor Municipality	201	SI	Slovenia	095	\N	46.3017139	14.4218165	\N
4274	Prevalje Municipality	201	SI	Slovenia	175	\N	46.5621146	14.8847861	\N
4228	Ptuj City Municipality	201	SI	Slovenia	096	\N	46.4199535	15.8696884	\N
4288	Puconci Municipality	201	SI	Slovenia	097	\N	46.7200418	16.0997792	\N
4204	Rače–Fram Municipality	201	SI	Slovenia	098	\N	46.4542083	15.6329467	\N
4195	Radeče Municipality	201	SI	Slovenia	099	\N	46.0666954	15.1820438	\N
4292	Radenci Municipality	201	SI	Slovenia	100	\N	46.6231121	16.0506903	\N
4275	Radlje ob Dravi Municipality	201	SI	Slovenia	101	\N	46.6135732	15.2354438	\N
4231	Radovljica Municipality	201	SI	Slovenia	102	\N	46.3355827	14.2094534	\N
4155	Ravne na Koroškem Municipality	201	SI	Slovenia	103	\N	46.5521194	14.9599084	\N
4206	Razkrižje Municipality	201	SI	Slovenia	176	\N	46.5226339	16.2668638	\N
4160	Rečica ob Savinji Municipality	201	SI	Slovenia	209	\N	46.323379	14.922367	\N
4253	Renče–Vogrsko Municipality	201	SI	Slovenia	201	\N	45.8954617	13.6785673	\N
4235	Ribnica Municipality	201	SI	Slovenia	104	\N	45.7400303	14.7265782	\N
4207	Ribnica na Pohorju Municipality	201	SI	Slovenia	177	\N	46.5356145	15.2674538	\N
4233	Rogaška Slatina Municipality	201	SI	Slovenia	106	\N	46.2453973	15.6265014	\N
4264	Rogašovci Municipality	201	SI	Slovenia	105	\N	46.8055785	16.0345237	\N
4209	Rogatec Municipality	201	SI	Slovenia	107	\N	46.2286626	15.6991338	\N
4280	Ruše Municipality	201	SI	Slovenia	108	\N	46.5206265	15.4817869	\N
4222	Šalovci Municipality	201	SI	Slovenia	033	\N	46.8533568	16.2591791	\N
4230	Selnica ob Dravi Municipality	201	SI	Slovenia	178	\N	46.5513918	15.492941	\N
4346	Semič Municipality	201	SI	Slovenia	109	\N	45.6520534	15.1820701	\N
4317	Šempeter–Vrtojba Municipality	201	SI	Slovenia	183	\N	45.9290095	13.6415594	\N
4299	Šenčur Municipality	201	SI	Slovenia	117	\N	46.2433699	14.4192223	\N
4324	Šentilj Municipality	201	SI	Slovenia	118	\N	46.6862839	15.7103567	\N
4241	Šentjernej Municipality	201	SI	Slovenia	119	\N	45.843413	15.3378312	\N
4171	Šentjur Municipality	201	SI	Slovenia	120	\N	46.2654339	15.408	\N
4311	Šentrupert Municipality	201	SI	Slovenia	211	\N	45.9873142	15.0829783	\N
4268	Sevnica Municipality	201	SI	Slovenia	110	\N	46.0070317	15.3045679	\N
4149	Sežana Municipality	201	SI	Slovenia	111	\N	45.7275109	13.8661931	\N
4170	Škocjan Municipality	201	SI	Slovenia	121	\N	45.9175454	15.3101736	\N
4316	Škofja Loka Municipality	201	SI	Slovenia	122	\N	46.1409844	14.2811873	\N
4169	Slovenj Gradec City Municipality	201	SI	Slovenia	112	\N	46.4877718	15.0729478	\N
4332	Slovenska Bistrica Municipality	201	SI	Slovenia	113	\N	46.3919813	15.5727869	\N
4198	Slovenske Konjice Municipality	201	SI	Slovenia	114	\N	46.3369191	15.4214708	\N
4285	Šmarje pri Jelšah Municipality	201	SI	Slovenia	124	\N	46.2287025	15.5190353	\N
4289	Šmarješke Toplice Municipality	201	SI	Slovenia	206	\N	45.8680377	15.2347422	\N
4296	Šmartno ob Paki Municipality	201	SI	Slovenia	125	\N	46.3290372	15.0333937	\N
4279	Šmartno pri Litiji Municipality	201	SI	Slovenia	194	\N	46.0454971	14.8410133	\N
4277	Sodražica Municipality	201	SI	Slovenia	179	\N	45.7616565	14.6352853	\N
4261	Solčava Municipality	201	SI	Slovenia	180	\N	46.4023526	14.6802304	\N
4248	Šoštanj Municipality	201	SI	Slovenia	126	\N	46.3782836	15.0461378	\N
4263	Središče ob Dravi	201	SI	Slovenia	202	\N	46.3959282	16.2704915	\N
4259	Starše Municipality	201	SI	Slovenia	115	\N	46.4674331	15.7640546	\N
4185	Štore Municipality	201	SI	Slovenia	127	\N	46.2222514	15.3126116	\N
4333	Straža Municipality	201	SI	Slovenia	203	\N	45.7768428	15.0948694	\N
4164	Sveta Ana Municipality	201	SI	Slovenia	181	\N	46.65	15.845278	\N
4260	Sveta Trojica v Slovenskih Goricah Municipality	201	SI	Slovenia	204	\N	46.5680809	15.8823064	\N
4229	Sveti Andraž v Slovenskih Goricah Municipality	201	SI	Slovenia	182	\N	46.5189747	15.9498262	\N
4255	Sveti Jurij ob Ščavnici Municipality	201	SI	Slovenia	116	\N	46.5687452	16.0222528	\N
4328	Sveti Jurij v Slovenskih Goricah Municipality	201	SI	Slovenia	210	\N	46.6170791	15.7804677	\N
4273	Sveti Tomaž Municipality	201	SI	Slovenia	205	\N	46.4835283	16.079442	\N
4194	Tabor Municipality	201	SI	Slovenia	184	\N	46.2107921	15.0174249	\N
4312	Tišina Municipality	201	SI	Slovenia	010	\N	46.6541884	16.0754781	\N
4247	Tolmin Municipality	201	SI	Slovenia	128	\N	46.1857188	13.7319838	\N
4246	Trbovlje Municipality	201	SI	Slovenia	129	\N	46.1503563	15.0453137	\N
4214	Trebnje Municipality	201	SI	Slovenia	130	\N	45.9080163	15.0131905	\N
4153	Trnovska Vas Municipality	201	SI	Slovenia	185	\N	46.5294035	15.8853118	\N
4250	Tržič Municipality	201	SI	Slovenia	131	\N	46.3593514	14.3006623	\N
4334	Trzin Municipality	201	SI	Slovenia	186	\N	46.1298241	14.5577637	\N
4251	Turnišče Municipality	201	SI	Slovenia	132	\N	46.6137504	16.32021	\N
4267	Velika Polana Municipality	201	SI	Slovenia	187	\N	46.5731715	16.3444126	\N
4144	Velike Lašče Municipality	201	SI	Slovenia	134	\N	45.8336591	14.6362363	\N
4257	Veržej Municipality	201	SI	Slovenia	188	\N	46.5841135	16.16208	\N
4300	Videm Municipality	201	SI	Slovenia	135	\N	46.363833	15.8781212	\N
4196	Vipava Municipality	201	SI	Slovenia	136	\N	45.8412674	13.9609613	\N
4148	Vitanje Municipality	201	SI	Slovenia	137	\N	46.3815323	15.2950687	\N
4154	Vodice Municipality	201	SI	Slovenia	138	\N	46.1896643	14.4938539	\N
4245	Vojnik Municipality	201	SI	Slovenia	139	\N	46.2920581	15.302058	\N
4163	Vransko Municipality	201	SI	Slovenia	189	\N	46.239006	14.9527249	\N
4262	Vrhnika Municipality	201	SI	Slovenia	140	\N	45.9502719	14.3276422	\N
4226	Vuzenica Municipality	201	SI	Slovenia	141	\N	46.5980836	15.1657237	\N
4269	Zagorje ob Savi Municipality	201	SI	Slovenia	142	\N	46.1345202	14.9964384	\N
4258	Žalec Municipality	201	SI	Slovenia	190	\N	46.2519712	15.1650072	\N
4182	Zavrč Municipality	201	SI	Slovenia	143	\N	46.35713	16.0477747	\N
4256	Železniki Municipality	201	SI	Slovenia	146	\N	46.2256377	14.1693617	\N
4249	Žetale Municipality	201	SI	Slovenia	191	\N	46.2742833	15.7913359	\N
4192	Žiri Municipality	201	SI	Slovenia	147	\N	46.0472499	14.1098451	\N
4276	Žirovnica Municipality	201	SI	Slovenia	192	\N	46.3954403	14.1539632	\N
4342	Zreče Municipality	201	SI	Slovenia	144	\N	46.4177786	15.3709431	\N
4307	Žužemberk Municipality	201	SI	Slovenia	193	\N	45.820035	14.9535919	\N
4784	Central Province	202	SB	Solomon Islands	CE	\N	\N	\N	\N
4781	Choiseul Province	202	SB	Solomon Islands	CH	\N	-7.0501494	156.9511459	\N
4785	Guadalcanal Province	202	SB	Solomon Islands	GU	\N	-9.5773284	160.1455805	\N
4778	Honiara	202	SB	Solomon Islands	CT	\N	-9.4456381	159.9728999	\N
4780	Isabel Province	202	SB	Solomon Islands	IS	\N	-8.0592353	159.1447081	\N
4782	Makira-Ulawa Province	202	SB	Solomon Islands	MK	\N	-10.5737447	161.8096941	\N
4783	Malaita Province	202	SB	Solomon Islands	ML	\N	-8.9446168	160.9071236	\N
4787	Rennell and Bellona Province	202	SB	Solomon Islands	RB	\N	-11.6131435	160.1693949	\N
4779	Temotu Province	202	SB	Solomon Islands	TE	\N	-10.686929	166.0623979	\N
4786	Western Province	202	SB	Solomon Islands	WE	\N	\N	\N	\N
925	Awdal Region	203	SO	Somalia	AW	\N	10.6334285	43.329466	\N
917	Bakool	203	SO	Somalia	BK	\N	4.3657221	44.0960311	\N
927	Banaadir	203	SO	Somalia	BN	\N	2.1187375	45.3369459	\N
930	Bari	203	SO	Somalia	BR	\N	41.1171432	16.8718715	\N
926	Bay	203	SO	Somalia	BY	\N	37.0365534	-95.6174767	\N
918	Galguduud	203	SO	Somalia	GA	\N	5.1850128	46.8252838	\N
928	Gedo	203	SO	Somalia	GE	\N	3.5039227	42.2362435	\N
915	Hiran	203	SO	Somalia	HI	\N	4.321015	45.2993862	\N
924	Lower Juba	203	SO	Somalia	JH	\N	0.224021	41.6011814	\N
921	Lower Shebelle	203	SO	Somalia	SH	\N	1.8766458	44.2479015	\N
922	Middle Juba	203	SO	Somalia	JD	\N	2.0780488	41.6011814	\N
923	Middle Shebelle	203	SO	Somalia	SD	\N	2.9250247	45.9039689	\N
916	Mudug	203	SO	Somalia	MU	\N	6.5656726	47.7637565	\N
920	Nugal	203	SO	Somalia	NU	\N	43.2793861	17.0339205	\N
919	Sanaag Region	203	SO	Somalia	SA	\N	10.3938218	47.7637565	\N
929	Togdheer Region	203	SO	Somalia	TO	\N	9.4460587	45.2993862	\N
938	Eastern Cape	204	ZA	South Africa	EC	\N	-32.2968402	26.419389	\N
932	Free State	204	ZA	South Africa	FS	\N	37.6858525	-97.2811256	\N
936	Gauteng	204	ZA	South Africa	GP	\N	-26.2707593	28.1122679	\N
935	KwaZulu-Natal	204	ZA	South Africa	KZN	\N	-28.5305539	30.8958242	\N
933	Limpopo	204	ZA	South Africa	LP	\N	-23.4012946	29.4179324	\N
937	Mpumalanga	204	ZA	South Africa	MP	\N	-25.565336	30.5279096	\N
934	North West	204	ZA	South Africa	NW	\N	32.758852	-97.328806	\N
931	Northern Cape	204	ZA	South Africa	NC	\N	-29.0466808	21.8568586	\N
939	Western Cape	204	ZA	South Africa	WC	\N	-33.2277918	21.8568586	\N
3860	Busan	116	KR	South Korea	26	\N	35.1795543	129.0756416	\N
3846	Daegu	116	KR	South Korea	27	\N	35.8714354	128.601445	\N
3850	Daejeon	116	KR	South Korea	30	\N	36.3504119	127.3845475	\N
3862	Gangwon Province	116	KR	South Korea	42	\N	37.8228	128.1555	\N
3858	Gwangju	116	KR	South Korea	29	\N	35.1595454	126.8526012	\N
3847	Gyeonggi Province	116	KR	South Korea	41	\N	37.4138	127.5183	\N
3848	Incheon	116	KR	South Korea	28	\N	37.4562557	126.7052062	\N
3853	Jeju	116	KR	South Korea	49	\N	33.9568278	-84.13135	\N
3854	North Chungcheong Province	116	KR	South Korea	43	\N	36.8	127.7	\N
3855	North Gyeongsang Province	116	KR	South Korea	47	\N	36.4919	128.8889	\N
3851	North Jeolla Province	116	KR	South Korea	45	\N	35.7175	127.153	\N
3861	Sejong City	116	KR	South Korea	50	\N	34.0523323	-118.3084897	\N
3849	Seoul	116	KR	South Korea	11	\N	37.566535	126.9779692	\N
3859	South Chungcheong Province	116	KR	South Korea	44	\N	36.5184	126.8	\N
3857	South Gyeongsang Province	116	KR	South Korea	48	\N	35.4606	128.2132	\N
3856	South Jeolla Province	116	KR	South Korea	46	\N	34.8679	126.991	\N
3852	Ulsan	116	KR	South Korea	31	\N	35.5383773	129.3113596	\N
2092	Central Equatoria	206	SS	South Sudan	EC	\N	4.6144063	31.2626366	\N
2093	Eastern Equatoria	206	SS	South Sudan	EE	\N	5.0692995	33.438353	\N
2094	Jonglei State	206	SS	South Sudan	JG	\N	7.1819619	32.3560952	\N
2090	Lakes	206	SS	South Sudan	LK	\N	37.1628255	-95.6911623	\N
2088	Northern Bahr el Ghazal	206	SS	South Sudan	BN	\N	8.5360449	26.7967849	\N
2085	Unity	206	SS	South Sudan	UY	\N	37.7871276	-122.4034079	\N
2086	Upper Nile	206	SS	South Sudan	NU	\N	9.8894202	32.7181375	\N
2087	Warrap	206	SS	South Sudan	WR	\N	8.0886238	28.6410641	\N
2091	Western Bahr el Ghazal	206	SS	South Sudan	BW	\N	8.6452399	25.2837585	\N
2089	Western Equatoria	206	SS	South Sudan	EW	\N	5.3471799	28.299435	\N
5089	A Coruña	207	ES	Spain	C	province	43.361904	-8.4301932	\N
5109	Albacete	207	ES	Spain	AB	province	38.9922312	-1.8780989	\N
5108	Alicante	207	ES	Spain	A	province	38.3579546	-0.5425634	\N
5095	Almeria	207	ES	Spain	AL	province	36.8415268	-2.4746261	\N
5093	Araba	207	ES	Spain	VI	province	42.8395119	-3.8423774	\N
1160	Asturias	207	ES	Spain	O	province	43.3613953	-5.8593267	\N
1189	Ávila	207	ES	Spain	AV	province	40.6934511	-4.8935627	\N
5092	Badajoz	207	ES	Spain	BA	province	38.8793748	-7.0226983	\N
1174	Balearic Islands	207	ES	Spain	PM	province	39.3587759	2.7356328	\N
5102	Barcelona	207	ES	Spain	B	province	41.3926679	2.1401891	\N
5094	Bizkaia	207	ES	Spain	BI	province	43.2192199	-3.2111087	\N
1146	Burgos	207	ES	Spain	BU	province	42.3380758	-3.5812692	\N
1190	Caceres	207	ES	Spain	CC	province	39.4716313	-6.4257384	\N
5096	Cádiz	207	ES	Spain	CA	province	36.5163851	-6.2999767	\N
1170	Cantabria	207	ES	Spain	S	province	43.1828396	-3.9878427	\N
5110	Castellón	207	ES	Spain	CS	province	39.9811435	0.0088407	\N
5105	Ciudad Real	207	ES	Spain	CR	province	38.9860758	-3.9444975	\N
5097	Córdoba	207	ES	Spain	CO	province	36.5163851	-6.2999767	\N
5106	Cuenca	207	ES	Spain	CU	province	40.0620036	-2.1655344	\N
1191	Gipuzkoa	207	ES	Spain	SS	province	43.145236	-2.4461825	\N
5103	Girona	207	ES	Spain	GI	province	41.9803445	2.8011577	\N
5098	Granada	207	ES	Spain	GR	province	37.1809411	-3.626291	\N
5107	Guadalajara	207	ES	Spain	GU	province	40.6322214	-3.190682	\N
5099	Huelva	207	ES	Spain	H	province	37.2708666	-6.9571999	\N
1177	Huesca	207	ES	Spain	HU	province	41.5976275	-0.9056623	\N
5100	Jaén	207	ES	Spain	J	province	37.7800931	-3.8143745	\N
1171	La Rioja	207	ES	Spain	LO	province	42.2870733	-2.539603	\N
1185	Las Palmas	207	ES	Spain	GC	province	28.2915637	-16.6291304	\N
1200	Léon	207	ES	Spain	LE	province	42.5987041	-5.5670839	\N
5104	Lleida	207	ES	Spain	L	province	41.6183731	0.6024253	\N
5090	Lugo	207	ES	Spain	LU	province	43.0123137	-7.5740096	\N
1158	Madrid	207	ES	Spain	M	province	40.4167515	-3.7038322	\N
5101	Málaga	207	ES	Spain	MA	province	36.7182015	-4.519306	\N
1176	Murcia	207	ES	Spain	MU	province	38.1398141	-1.366216	\N
1204	Navarra	207	ES	Spain	NA	province	42.6953909	-1.6760691	\N
5091	Ourense	207	ES	Spain	OR	province	42.3383613	-7.8811951	\N
1157	Palencia	207	ES	Spain	P	province	42.0096832	-4.5287949	\N
1167	Pontevedra	207	ES	Spain	PO	province	42.4338595	-8.6568552	\N
1147	Salamanca	207	ES	Spain	SA	province	40.9515263	-6.2375947	\N
5112	Santa Cruz de Tenerife	207	ES	Spain	TF	province	28.4578914	-16.3213539	\N
1192	Segovia	207	ES	Spain	SG	province	40.9429296	-4.1088942	\N
1193	Sevilla	207	ES	Spain	SE	province	37.3753501	-6.0250973	\N
1208	Soria	207	ES	Spain	SO	province	41.7665464	-2.4790306	\N
1203	Tarragona	207	ES	Spain	T	province	41.1258642	1.2035642	\N
5111	Teruel	207	ES	Spain	TE	province	40.345041	-1.1184744	\N
1205	Toledo	207	ES	Spain	TO	province	39.86232	-4.0694692	\N
1175	Valencia	207	ES	Spain	V	province	39.4840108	-0.7532809	\N
1183	Valladolid	207	ES	Spain	VA	province	41.6517375	-4.724495	\N
1161	Zamora	207	ES	Spain	ZA	province	41.6095744	-5.8987139	\N
5113	Zaragoza	207	ES	Spain	Z	province	41.6517501	-0.9300002	\N
2799	Ampara District	208	LK	Sri Lanka	52	\N	7.2911685	81.6723761	\N
2816	Anuradhapura District	208	LK	Sri Lanka	71	\N	8.3318305	80.4029017	\N
2790	Badulla District	208	LK	Sri Lanka	81	\N	6.9934009	81.0549815	\N
2818	Batticaloa District	208	LK	Sri Lanka	51	\N	7.8292781	81.4718387	\N
2798	Central Province	208	LK	Sri Lanka	2	\N	\N	\N	\N
2815	Colombo District	208	LK	Sri Lanka	11	\N	6.9269557	79.8617306	\N
2808	Eastern Province	208	LK	Sri Lanka	5	\N	\N	\N	\N
2792	Galle District	208	LK	Sri Lanka	31	\N	6.057749	80.2175572	\N
2804	Gampaha District	208	LK	Sri Lanka	12	\N	7.0712619	80.0087746	\N
2791	Hambantota District	208	LK	Sri Lanka	33	\N	6.1535816	81.127149	\N
2787	Jaffna District	208	LK	Sri Lanka	41	\N	9.6930468	80.1651854	\N
2789	Kalutara District	208	LK	Sri Lanka	13	\N	6.6084686	80.1428584	\N
2788	Kandy District	208	LK	Sri Lanka	21	\N	7.2931588	80.6350107	\N
2797	Kegalle District	208	LK	Sri Lanka	92	\N	7.1204053	80.3213106	\N
2793	Kilinochchi District	208	LK	Sri Lanka	42	\N	9.3677971	80.3213106	\N
2805	Mannar District	208	LK	Sri Lanka	43	\N	8.9809531	79.9043975	\N
2810	Matale District	208	LK	Sri Lanka	22	\N	7.4659646	80.6234259	\N
2806	Matara District	208	LK	Sri Lanka	32	\N	5.9449348	80.5487997	\N
2819	Monaragala District	208	LK	Sri Lanka	82	\N	6.8727781	81.3506832	\N
2814	Mullaitivu District	208	LK	Sri Lanka	45	\N	9.2675388	80.8128254	\N
2800	North Central Province	208	LK	Sri Lanka	7	\N	8.1995638	80.6326916	\N
2817	North Western Province	208	LK	Sri Lanka	6	\N	7.7584091	80.1875065	\N
2813	Northern Province	208	LK	Sri Lanka	4	\N	\N	\N	\N
2794	Nuwara Eliya District	208	LK	Sri Lanka	23	\N	6.9606532	80.7692758	\N
2812	Polonnaruwa District	208	LK	Sri Lanka	72	\N	7.9395567	81.0003403	\N
2796	Puttalam District	208	LK	Sri Lanka	62	\N	8.0259915	79.8471272	\N
2807	Ratnapura district	208	LK	Sri Lanka	91	\N	6.7055168	80.3848389	\N
2803	Sabaragamuwa Province	208	LK	Sri Lanka	9	\N	6.7395941	80.365865	\N
2801	Southern Province	208	LK	Sri Lanka	3	\N	\N	\N	\N
2795	Trincomalee District	208	LK	Sri Lanka	53	\N	8.6013069	81.1196075	\N
2811	Uva Province	208	LK	Sri Lanka	8	\N	6.8427612	81.3399414	\N
2809	Vavuniya District	208	LK	Sri Lanka	44	\N	8.7594739	80.5000334	\N
2802	Western Province	208	LK	Sri Lanka	1	\N	\N	\N	\N
885	Al Jazirah	209	SD	Sudan	GZ	\N	14.8859611	33.438353	\N
886	Al Qadarif	209	SD	Sudan	GD	\N	14.024307	35.3685679	\N
887	Blue Nile	209	SD	Sudan	NB	\N	47.598673	-122.334419	\N
896	Central Darfur	209	SD	Sudan	DC	\N	14.3782747	24.9042208	\N
892	East Darfur	209	SD	Sudan	DE	\N	14.3782747	24.9042208	\N
884	Kassala	209	SD	Sudan	KA	\N	15.4581332	36.4039629	\N
881	Khartoum	209	SD	Sudan	KH	\N	15.5006544	32.5598994	\N
890	North Darfur	209	SD	Sudan	DN	\N	15.7661969	24.9042208	\N
893	North Kordofan	209	SD	Sudan	KN	\N	13.8306441	29.4179324	\N
895	Northern	209	SD	Sudan	NO	\N	38.063817	-84.4628648	\N
880	Red Sea	209	SD	Sudan	RS	\N	20.280232	38.512573	\N
891	River Nile	209	SD	Sudan	NR	\N	23.9727595	32.8749206	\N
882	Sennar	209	SD	Sudan	SI	\N	13.567469	33.5672045	\N
894	South Darfur	209	SD	Sudan	DS	\N	11.6488639	24.9042208	\N
883	South Kordofan	209	SD	Sudan	KS	\N	11.1990192	29.4179324	\N
888	West Darfur	209	SD	Sudan	DW	\N	12.8463561	23.0011989	\N
889	West Kordofan	209	SD	Sudan	GK	\N	11.1990192	29.4179324	\N
879	White Nile	209	SD	Sudan	NW	\N	9.3321516	31.46153	\N
2846	Brokopondo District	210	SR	Suriname	BR	\N	4.7710247	-55.0493375	\N
2839	Commewijne District	210	SR	Suriname	CM	\N	5.740211	-54.8731219	\N
2842	Coronie District	210	SR	Suriname	CR	\N	5.6943271	-56.2929381	\N
2845	Marowijne District	210	SR	Suriname	MA	\N	5.6268128	-54.2593118	\N
2840	Nickerie District	210	SR	Suriname	NI	\N	5.5855469	-56.8311117	\N
2841	Para District	210	SR	Suriname	PR	\N	5.4817318	-55.2259207	\N
2843	Paramaribo District	210	SR	Suriname	PM	\N	5.8520355	-55.2038278	\N
2848	Saramacca District	210	SR	Suriname	SA	\N	5.7240813	-55.6689636	\N
2847	Sipaliwini District	210	SR	Suriname	SI	\N	3.6567382	-56.2035387	\N
2844	Wanica District	210	SR	Suriname	WA	\N	5.7323762	-55.2701235	\N
969	Hhohho District	212	SZ	Swaziland	HH	\N	-26.1365662	31.3541631	\N
970	Lubombo District	212	SZ	Swaziland	LU	\N	-26.7851773	31.8107079	\N
968	Manzini District	212	SZ	Swaziland	MA	\N	-26.5081999	31.3713164	\N
971	Shiselweni District	212	SZ	Swaziland	SH	\N	-26.9827577	31.3541631	\N
1537	Blekinge	213	SE	Sweden	K	\N	56.2783837	15.0180058	\N
1534	Dalarna County	213	SE	Sweden	W	\N	61.0917012	14.6663653	\N
1533	Gävleborg County	213	SE	Sweden	X	\N	61.3011993	16.1534214	\N
1546	Gotland County	213	SE	Sweden	I	\N	57.4684121	18.4867447	\N
1548	Halland County	213	SE	Sweden	N	\N	56.8966805	12.8033993	\N
1550	Jönköping County	213	SE	Sweden	F	\N	57.3708434	14.3439174	\N
1544	Kalmar County	213	SE	Sweden	H	\N	57.2350156	16.1849349	\N
1542	Kronoberg County	213	SE	Sweden	G	\N	56.7183403	14.4114673	\N
1538	Norrbotten County	213	SE	Sweden	BD	\N	66.8309216	20.3991966	\N
1539	Örebro County	213	SE	Sweden	T	\N	59.535036	15.0065731	\N
1536	Östergötland County	213	SE	Sweden	E	\N	58.3453635	15.5197844	\N
1541	Skåne County	213	SE	Sweden	M	\N	55.9902572	13.5957692	\N
1540	Södermanland County	213	SE	Sweden	D	\N	59.0336349	16.7518899	\N
1551	Stockholm County	213	SE	Sweden	AB	\N	59.6024958	18.1384383	\N
1545	Uppsala County	213	SE	Sweden	C	\N	60.0092262	17.2714588	\N
1535	Värmland County	213	SE	Sweden	S	\N	59.7294065	13.2354024	\N
1543	Västerbotten County	213	SE	Sweden	AC	\N	65.3337311	16.5161694	\N
1552	Västernorrland County	213	SE	Sweden	Y	\N	63.4276473	17.7292444	\N
1549	Västmanland County	213	SE	Sweden	U	\N	59.6713879	16.2158953	\N
1547	Västra Götaland County	213	SE	Sweden	O	\N	58.2527926	13.0596425	\N
1639	Aargau	214	CH	Switzerland	AG	canton	47.3876664	8.2554295	\N
1655	Appenzell Ausserrhoden	214	CH	Switzerland	AR	canton	47.366481	9.3000916	\N
1649	Appenzell Innerrhoden	214	CH	Switzerland	AI	canton	47.3161925	9.4316573	\N
1641	Basel-Land	214	CH	Switzerland	BL	canton	47.4418122	7.7644002	\N
4957	Basel-Stadt	214	CH	Switzerland	BS	canton	47.566667	7.6	\N
1645	Bern	214	CH	Switzerland	BE	canton	46.7988621	7.7080701	\N
1640	Fribourg	214	CH	Switzerland	FR	canton	46.6816748	7.1172635	\N
1647	Geneva	214	CH	Switzerland	GE	canton	46.2180073	6.1216925	\N
1661	Glarus	214	CH	Switzerland	GL	canton	47.0411232	9.0679	\N
1660	Graubünden	214	CH	Switzerland	GR	canton	46.6569871	9.5780257	\N
1658	Jura	214	CH	Switzerland	JU	canton	47.3444474	7.1430608	\N
1663	Lucerne	214	CH	Switzerland	LU	canton	47.0795671	8.1662445	\N
1659	Neuchâtel	214	CH	Switzerland	NE	canton	46.9899874	6.9292732	\N
1652	Nidwalden	214	CH	Switzerland	NW	canton	46.9267016	8.3849982	\N
1650	Obwalden	214	CH	Switzerland	OW	canton	46.877858	8.251249	\N
1654	Schaffhausen	214	CH	Switzerland	SH	canton	47.7009364	8.568004	\N
1653	Schwyz	214	CH	Switzerland	SZ	canton	47.0207138	8.6529884	\N
1662	Solothurn	214	CH	Switzerland	SO	canton	47.3320717	7.6388385	\N
1644	St. Gallen	214	CH	Switzerland	SG	canton	47.1456254	9.3504332	\N
1657	Thurgau	214	CH	Switzerland	TG	canton	47.6037856	9.0557371	\N
1643	Ticino	214	CH	Switzerland	TI	canton	46.331734	8.8004529	\N
1642	Uri	214	CH	Switzerland	UR	canton	41.4860647	-71.5308537	\N
1648	Valais	214	CH	Switzerland	VS	canton	46.1904614	7.5449226	\N
1651	Vaud	214	CH	Switzerland	VD	canton	46.5613135	6.536765	\N
1646	Zug	214	CH	Switzerland	ZG	canton	47.1661505	8.5154749	\N
1656	Zürich	214	CH	Switzerland	ZH	canton	47.359536	8.6356452	\N
2941	Al-Hasakah	215	SY	Syria	HA	\N	36.405515	40.7969149	\N
2944	Al-Raqqah	215	SY	Syria	RA	\N	35.9594106	38.9981052	\N
2946	Aleppo	215	SY	Syria	HL	\N	36.2262393	37.4681396	\N
2936	As-Suwayda	215	SY	Syria	SU	\N	32.7989156	36.7819505	\N
2939	Damascus	215	SY	Syria	DI	\N	33.5151444	36.3931354	\N
2945	Daraa	215	SY	Syria	DR	\N	32.9248813	36.1762615	\N
2937	Deir ez-Zor	215	SY	Syria	DY	\N	35.2879798	40.3088626	\N
2934	Hama	215	SY	Syria	HM	\N	35.1887865	37.2115829	\N
2942	Homs	215	SY	Syria	HI	\N	34.2567123	38.3165725	\N
2940	Idlib	215	SY	Syria	ID	\N	35.8268798	36.6957216	\N
2938	Latakia	215	SY	Syria	LA	\N	35.6129791	36.0023225	\N
2943	Quneitra	215	SY	Syria	QU	\N	33.0776318	35.8934136	\N
2935	Rif Dimashq	215	SY	Syria	RD	\N	33.5167289	36.954107	\N
2947	Tartus	215	SY	Syria	TA	\N	35.0006652	36.0023225	\N
3404	Changhua	216	TW	Taiwan	CHA	county	24.0517963	120.5161352	\N
3408	Chiayi	216	TW	Taiwan	CYI	city	23.4518428	120.2554615	\N
3418	Chiayi	216	TW	Taiwan	CYQ	county	23.4800751	120.4491113	\N
3423	Hsinchu	216	TW	Taiwan	HSQ	county	24.8387226	121.0177246	\N
3417	Hsinchu	216	TW	Taiwan	HSZ	city	24.8138287	120.9674798	\N
3411	Hualien	216	TW	Taiwan	HUA	county	23.9871589	121.6015714	\N
3412	Kaohsiung	216	TW	Taiwan	KHH	special municipality	22.6272784	120.3014353	\N
4965	Keelung	216	TW	Taiwan	KEE	city	25.1241862	121.6475834	\N
3415	Kinmen	216	TW	Taiwan	KIN	county	24.3487792	118.3285644	\N
3420	Lienchiang	216	TW	Taiwan	LIE	county	26.1505556	119.9288889	\N
3413	Miaoli	216	TW	Taiwan	MIA	county	24.560159	120.8214265	\N
3407	Nantou	216	TW	Taiwan	NAN	county	23.9609981	120.9718638	\N
4966	New Taipei	216	TW	Taiwan	NWT	special municipality	24.9875278	121.3645947	\N
3403	Penghu	216	TW	Taiwan	PEN	county	23.5711899	119.5793157	\N
3405	Pingtung	216	TW	Taiwan	PIF	county	22.5519759	120.5487597	\N
3406	Taichung	216	TW	Taiwan	TXG	special municipality	24.1477358	120.6736482	\N
3421	Tainan	216	TW	Taiwan	TNN	special municipality	22.9997281	120.2270277	\N
3422	Taipei	216	TW	Taiwan	TPE	special municipality	25.0329694	121.5654177	\N
3410	Taitung	216	TW	Taiwan	TTT	county	22.7972447	121.0713702	\N
3419	Taoyuan	216	TW	Taiwan	TAO	special municipality	24.9936281	121.3009798	\N
3402	Yilan	216	TW	Taiwan	ILA	county	24.7021073	121.7377502	\N
3416	Yunlin	216	TW	Taiwan	YUN	county	23.7092033	120.4313373	\N
3397	districts of Republican Subordination	217	TJ	Tajikistan	RA	\N	39.0857902	70.2408325	\N
3399	Gorno-Badakhshan Autonomous Province	217	TJ	Tajikistan	GB	\N	38.412732	73.087749	\N
3398	Khatlon Province	217	TJ	Tajikistan	KT	\N	37.9113562	69.097023	\N
3400	Sughd Province	217	TJ	Tajikistan	SU	\N	39.5155326	69.097023	\N
1491	Arusha	218	TZ	Tanzania	01	Region	-3.3869254	36.6829927	\N
1490	Dar es Salaam	218	TZ	Tanzania	02	Region	-6.792354	39.2083284	\N
1466	Dodoma	218	TZ	Tanzania	03	Region	-6.5738228	36.2630846	\N
1481	Geita	218	TZ	Tanzania	27	Region	-2.8242257	32.2653887	\N
1489	Iringa	218	TZ	Tanzania	04	Region	-7.7887442	35.5657862	\N
1465	Kagera	218	TZ	Tanzania	05	Region	-1.3001115	31.2626366	\N
1482	Katavi	218	TZ	Tanzania	28	Region	-6.3677125	31.2626366	\N
1478	Kigoma	218	TZ	Tanzania	08	Region	-4.8824092	29.6615055	\N
1467	Kilimanjaro	218	TZ	Tanzania	09	Region	-4.1336927	37.8087693	\N
1483	Lindi	218	TZ	Tanzania	12	Region	-9.2343394	38.3165725	\N
1484	Manyara	218	TZ	Tanzania	26	Region	-4.3150058	36.954107	\N
1468	Mara	218	TZ	Tanzania	13	Region	-1.7753538	34.1531947	\N
4955	Mbeya	218	TZ	Tanzania	14	Region	-8.2866112	32.8132537	\N
1470	Morogoro	218	TZ	Tanzania	16	Region	-8.8137173	36.954107	\N
1476	Mtwara	218	TZ	Tanzania	17	Region	-10.3398455	40.1657466	\N
1479	Mwanza	218	TZ	Tanzania	18	Region	-2.4671197	32.8986812	\N
1480	Njombe	218	TZ	Tanzania	29	Region	-9.2422632	35.1268781	\N
1488	Pemba North	218	TZ	Tanzania	06	Region	-5.0319352	39.7755571	\N
1472	Pemba South	218	TZ	Tanzania	10	Region	-5.3146961	39.7549511	\N
1485	Pwani	218	TZ	Tanzania	19	Region	-7.3237714	38.8205454	\N
1477	Rukwa	218	TZ	Tanzania	20	Region	-8.0109444	31.4456179	\N
1486	Ruvuma	218	TZ	Tanzania	21	Region	-10.6878717	36.2630846	\N
1463	Shinyanga	218	TZ	Tanzania	22	Region	-3.6809961	33.4271403	\N
1464	Simiyu	218	TZ	Tanzania	30	Region	-2.8308738	34.1531947	\N
1474	Singida	218	TZ	Tanzania	23	Region	-6.7453352	34.1531947	\N
4956	Songwe	218	TZ	Tanzania	31	Region	-8.272612	31.7113174	\N
1469	Tabora	218	TZ	Tanzania	24	Region	-5.0342138	32.8084496	\N
1487	Tanga	218	TZ	Tanzania	25	Region	-5.3049789	38.3165725	\N
1473	Zanzibar North	218	TZ	Tanzania	07	Region	-5.9395093	39.2791011	\N
1471	Zanzibar South	218	TZ	Tanzania	11	Region	-6.2642851	39.4450281	\N
1475	Zanzibar West	218	TZ	Tanzania	15	Region	-6.2298136	39.2583293	\N
3523	Amnat Charoen	219	TH	Thailand	37	\N	15.8656783	104.6257774	\N
3519	Ang Thong	219	TH	Thailand	15	\N	14.5896054	100.455052	\N
3554	Bangkok	219	TH	Thailand	10	\N	13.7563309	100.5017651	\N
3533	Bueng Kan	219	TH	Thailand	38	\N	18.3609104	103.6464463	\N
3534	Buri Ram	219	TH	Thailand	31	\N	14.9951003	103.1115915	\N
3552	Chachoengsao	219	TH	Thailand	24	\N	13.6904194	101.0779596	\N
3522	Chai Nat	219	TH	Thailand	18	\N	15.1851971	100.125125	\N
4954	Chaiyaphum	219	TH	Thailand	36	\N	16.0074974	101.6129172	\N
3486	Chanthaburi	219	TH	Thailand	22	\N	12.6112485	102.1037806	\N
3491	Chiang Mai	219	TH	Thailand	50	\N	18.7883439	98.9853008	\N
3498	Chiang Rai	219	TH	Thailand	57	\N	19.9104798	99.840576	\N
3513	Chon Buri	219	TH	Thailand	20	\N	13.3611431	100.9846717	\N
3526	Chumphon	219	TH	Thailand	86	\N	10.4930496	99.1800199	\N
3550	Kalasin	219	TH	Thailand	46	\N	16.438508	103.5060994	\N
3516	Kamphaeng Phet	219	TH	Thailand	62	\N	16.4827798	99.5226618	\N
3511	Kanchanaburi	219	TH	Thailand	71	\N	14.1011393	99.4179431	\N
3485	Khon Kaen	219	TH	Thailand	40	\N	16.4321938	102.8236214	\N
3478	Krabi	219	TH	Thailand	81	\N	8.0862997	98.9062835	\N
3544	Lampang	219	TH	Thailand	52	\N	18.2855395	99.5127895	\N
3483	Lamphun	219	TH	Thailand	51	\N	18.5744606	99.0087221	\N
3509	Loei	219	TH	Thailand	42	\N	17.4860232	101.7223002	\N
3543	Lop Buri	219	TH	Thailand	16	\N	14.7995081	100.6533706	\N
3505	Mae Hong Son	219	TH	Thailand	58	\N	19.3020296	97.9654368	\N
3517	Maha Sarakham	219	TH	Thailand	44	\N	16.0132015	103.1615169	\N
3546	Mukdahan	219	TH	Thailand	49	\N	16.5435914	104.7024121	\N
3535	Nakhon Nayok	219	TH	Thailand	26	\N	14.2069466	101.2130511	\N
3503	Nakhon Pathom	219	TH	Thailand	73	\N	13.8140293	100.0372929	\N
3548	Nakhon Phanom	219	TH	Thailand	48	\N	17.392039	104.7695508	\N
3497	Nakhon Ratchasima	219	TH	Thailand	30	\N	14.9738493	102.083652	\N
3492	Nakhon Sawan	219	TH	Thailand	60	\N	15.6987382	100.11996	\N
3520	Nakhon Si Thammarat	219	TH	Thailand	80	\N	8.4324831	99.9599033	\N
3530	Nan	219	TH	Thailand	55	\N	45.522208	-122.9863281	\N
3553	Narathiwat	219	TH	Thailand	96	\N	6.4254607	101.8253143	\N
3480	Nong Bua Lam Phu	219	TH	Thailand	39	\N	17.2218247	102.4260368	\N
3484	Nong Khai	219	TH	Thailand	43	\N	17.8782803	102.7412638	\N
3495	Nonthaburi	219	TH	Thailand	12	\N	13.8591084	100.5216508	\N
3500	Pathum Thani	219	TH	Thailand	13	\N	14.0208391	100.5250276	\N
3540	Pattani	219	TH	Thailand	94	\N	6.7618308	101.3232549	\N
3507	Pattaya	219	TH	Thailand	S	\N	12.9235557	100.8824551	\N
3549	Phangnga	219	TH	Thailand	82	\N	8.4501414	98.5255317	\N
3488	Phatthalung	219	TH	Thailand	93	\N	7.6166823	100.0740231	\N
3538	Phayao	219	TH	Thailand	56	\N	19.2154367	100.2023692	\N
3515	Phetchabun	219	TH	Thailand	67	\N	16.301669	101.1192804	\N
3532	Phetchaburi	219	TH	Thailand	76	\N	12.9649215	99.6425883	\N
3514	Phichit	219	TH	Thailand	66	\N	16.2740876	100.3346991	\N
3506	Phitsanulok	219	TH	Thailand	65	\N	16.8211238	100.2658516	\N
3494	Phra Nakhon Si Ayutthaya	219	TH	Thailand	14	\N	14.3692325	100.5876634	\N
3528	Phrae	219	TH	Thailand	54	\N	18.1445774	100.1402831	\N
3536	Phuket	219	TH	Thailand	83	\N	7.8804479	98.3922504	\N
3542	Prachin Buri	219	TH	Thailand	25	\N	14.0420699	101.6600874	\N
3508	Prachuap Khiri Khan	219	TH	Thailand	77	\N	11.7938389	99.7957564	\N
3479	Ranong	219	TH	Thailand	85	\N	9.9528702	98.6084641	\N
3499	Ratchaburi	219	TH	Thailand	70	\N	13.5282893	99.8134211	\N
3518	Rayong	219	TH	Thailand	21	\N	12.6813957	101.2816261	\N
3510	Roi Et	219	TH	Thailand	45	\N	16.0538196	103.6520036	\N
3529	Sa Kaeo	219	TH	Thailand	27	\N	13.824038	102.0645839	\N
3501	Sakon Nakhon	219	TH	Thailand	47	\N	17.1664211	104.1486055	\N
3481	Samut Prakan	219	TH	Thailand	11	\N	13.5990961	100.5998319	\N
3504	Samut Sakhon	219	TH	Thailand	74	\N	13.5475216	100.2743956	\N
3502	Samut Songkhram	219	TH	Thailand	75	\N	13.4098217	100.0022645	\N
3487	Saraburi	219	TH	Thailand	19	\N	14.5289154	100.9101421	\N
3537	Satun	219	TH	Thailand	91	\N	6.6238158	100.0673744	\N
3547	Si Sa Ket	219	TH	Thailand	33	\N	15.1186009	104.3220095	\N
3490	Sing Buri	219	TH	Thailand	17	\N	14.8936253	100.3967314	\N
3539	Songkhla	219	TH	Thailand	90	\N	7.1897659	100.5953813	\N
3545	Sukhothai	219	TH	Thailand	64	\N	43.6485556	-79.3746639	\N
3524	Suphan Buri	219	TH	Thailand	72	\N	14.4744892	100.1177128	\N
3482	Surat Thani	219	TH	Thailand	84	\N	9.1341949	99.3334198	\N
3531	Surin	219	TH	Thailand	32	\N	37.0358271	-95.6276367	\N
3525	Tak	219	TH	Thailand	63	\N	45.0299646	-93.1049815	\N
3541	Trang	219	TH	Thailand	92	\N	7.5644833	99.6239334	\N
3496	Trat	219	TH	Thailand	23	\N	12.2427563	102.5174734	\N
3512	Ubon Ratchathani	219	TH	Thailand	34	\N	15.2448453	104.8472995	\N
3527	Udon Thani	219	TH	Thailand	41	\N	17.3646969	102.8158924	\N
3551	Uthai Thani	219	TH	Thailand	61	\N	15.3835001	100.0245527	\N
3489	Uttaradit	219	TH	Thailand	53	\N	17.6200886	100.0992942	\N
3493	Yala	219	TH	Thailand	95	\N	44.0579117	-123.1653848	\N
3521	Yasothon	219	TH	Thailand	35	\N	15.792641	104.1452827	\N
3601	Acklins	17	BS	The Bahamas	AK	\N	22.3657708	-74.0535126	\N
3628	Acklins and Crooked Islands	17	BS	The Bahamas	AC	\N	22.3657708	-74.0535126	\N
3593	Berry Islands	17	BS	The Bahamas	BY	\N	25.6250042	-77.8252203	\N
3629	Bimini	17	BS	The Bahamas	BI	\N	24.6415325	-79.8506226	\N
3605	Black Point	17	BS	The Bahamas	BP	\N	41.3951024	-71.4650556	\N
3611	Cat Island	17	BS	The Bahamas	CI	\N	30.2280136	-89.1014933	\N
3603	Central Abaco	17	BS	The Bahamas	CO	\N	26.3555029	-77.1485163	\N
3631	Central Andros	17	BS	The Bahamas	CS	\N	24.4688482	-77.973865	\N
3596	Central Eleuthera	17	BS	The Bahamas	CE	\N	25.1362037	-76.1435915	\N
3621	Crooked Island	17	BS	The Bahamas	CK	\N	22.6390982	-74.006509	\N
3614	East Grand Bahama	17	BS	The Bahamas	EG	\N	26.6582823	-78.2248291	\N
3612	Exuma	17	BS	The Bahamas	EX	\N	23.6192598	-75.9695465	\N
3626	Freeport	17	BS	The Bahamas	FP	\N	42.2966861	-89.6212271	\N
3619	Fresh Creek	17	BS	The Bahamas	FC	\N	40.6543756	-73.8947939	\N
3597	Governor's Harbour	17	BS	The Bahamas	GH	\N	25.1948096	-76.2439622	\N
3632	Grand Cay	17	BS	The Bahamas	GC	\N	27.2162615	-78.3230559	\N
3595	Green Turtle Cay	17	BS	The Bahamas	GT	\N	26.7747107	-77.3295708	\N
3613	Harbour Island	17	BS	The Bahamas	HI	\N	25.50011	-76.6340511	\N
3598	High Rock	17	BS	The Bahamas	HR	\N	46.6843415	-121.9017461	\N
3624	Hope Town	17	BS	The Bahamas	HT	\N	26.5009504	-76.9959872	\N
3609	Inagua	17	BS	The Bahamas	IN	\N	21.0656066	-73.323708	\N
3618	Kemps Bay	17	BS	The Bahamas	KB	\N	24.02364	-77.545349	\N
3610	Long Island	17	BS	The Bahamas	LI	\N	40.789142	-73.134961	\N
3625	Mangrove Cay	17	BS	The Bahamas	MC	\N	24.1481425	-77.7680952	\N
3604	Marsh Harbour	17	BS	The Bahamas	MH	\N	26.5241653	-77.0909809	\N
3633	Mayaguana District	17	BS	The Bahamas	MG	\N	22.4017714	-73.0641396	\N
4881	New Providence	17	BS	The Bahamas	NP	\N	40.6984348	-74.4015405	\N
3594	Nichollstown and Berry Islands	17	BS	The Bahamas	NB	\N	25.7236234	-77.8310104	\N
3616	North Abaco	17	BS	The Bahamas	NO	\N	26.7871697	-77.4357739	\N
3617	North Andros	17	BS	The Bahamas	NS	\N	24.7063805	-78.0195387	\N
3602	North Eleuthera	17	BS	The Bahamas	NE	\N	25.4647517	-76.675922	\N
3615	Ragged Island	17	BS	The Bahamas	RI	\N	41.597431	-71.260202	\N
3623	Rock Sound	17	BS	The Bahamas	RS	\N	39.0142443	-95.6708989	\N
3600	Rum Cay District	17	BS	The Bahamas	RC	\N	23.6854676	-74.8390162	\N
3620	San Salvador and Rum Cay	17	BS	The Bahamas	SR	\N	23.6854676	-74.8390162	\N
3627	San Salvador Island	17	BS	The Bahamas	SS	\N	24.0775546	-74.4760088	\N
3606	Sandy Point	17	BS	The Bahamas	SP	\N	39.0145464	-76.3998925	\N
3608	South Abaco	17	BS	The Bahamas	SO	\N	26.0640591	-77.2635038	\N
3622	South Andros	17	BS	The Bahamas	SA	\N	23.9713556	-77.6077865	\N
3607	South Eleuthera	17	BS	The Bahamas	SE	\N	24.7708562	-76.2131474	\N
3630	Spanish Wells	17	BS	The Bahamas	SW	\N	26.3250599	-81.7980328	\N
3599	West Grand Bahama	17	BS	The Bahamas	WG	\N	26.659447	-78.52065	\N
2575	Centrale Region	220	TG	Togo	C	\N	8.6586029	1.0586135	\N
2579	Kara Region	220	TG	Togo	K	\N	9.7216393	1.0586135	\N
2576	Maritime	220	TG	Togo	M	\N	41.6551493	-83.5278467	\N
2577	Plateaux Region	220	TG	Togo	P	\N	7.6101378	1.0586135	\N
2578	Savanes Region	220	TG	Togo	S	\N	10.5291781	0.5257823	\N
3913	Haʻapai	222	TO	Tonga	02	\N	-19.75	-174.366667	\N
3915	ʻEua	222	TO	Tonga	01	\N	37.09024	-95.712891	\N
3914	Niuas	222	TO	Tonga	03	\N	-15.9594	-173.783	\N
3912	Tongatapu	222	TO	Tonga	04	\N	-21.1465968	-175.2515482	\N
3911	Vavaʻu	222	TO	Tonga	05	\N	-18.622756	-173.9902982	\N
3362	Arima	223	TT	Trinidad And Tobago	ARI	\N	46.7931604	-71.2584311	\N
3366	Chaguanas	223	TT	Trinidad And Tobago	CHA	\N	10.5168387	-61.4114482	\N
3354	Couva-Tabaquite-Talparo Regional Corporation	223	TT	Trinidad And Tobago	CTT	\N	10.4297145	-61.373521	\N
3367	Diego Martin Regional Corporation	223	TT	Trinidad And Tobago	DMN	\N	10.7362286	-61.5544836	\N
3355	Eastern Tobago	223	TT	Trinidad And Tobago	ETO	\N	11.2979348	-60.5588524	\N
3365	Penal-Debe Regional Corporation	223	TT	Trinidad And Tobago	PED	\N	10.1337402	-61.4435474	\N
3360	Point Fortin	223	TT	Trinidad And Tobago	PTF	\N	10.1702737	-61.6713386	\N
3363	Port of Spain	223	TT	Trinidad And Tobago	POS	\N	10.6603196	-61.5085625	\N
3368	Princes Town Regional Corporation	223	TT	Trinidad And Tobago	PRT	\N	10.1786746	-61.2801996	\N
3356	Rio Claro-Mayaro Regional Corporation	223	TT	Trinidad And Tobago	MRC	\N	10.2412832	-61.0937206	\N
3359	San Fernando	223	TT	Trinidad And Tobago	SFO	\N	34.2819461	-118.4389719	\N
3357	San Juan-Laventille Regional Corporation	223	TT	Trinidad And Tobago	SJL	\N	10.6908578	-61.4552213	\N
3361	Sangre Grande Regional Corporation	223	TT	Trinidad And Tobago	SGE	\N	10.5852939	-61.1315813	\N
3364	Siparia Regional Corporation	223	TT	Trinidad And Tobago	SIP	\N	10.1245626	-61.5603244	\N
3358	Tunapuna-Piarco Regional Corporation	223	TT	Trinidad And Tobago	TUP	\N	10.6859096	-61.3035248	\N
3353	Western Tobago	223	TT	Trinidad And Tobago	WTO	\N	11.1897072	-60.7795452	\N
2550	Ariana	224	TN	Tunisia	12	governorate	36.9922751	10.1255164	\N
2566	Ben Arous	224	TN	Tunisia	13	governorate	36.6435606	10.2151578	\N
2551	Bizerte	224	TN	Tunisia	23	governorate	37.1609397	9.634135	\N
2558	Gabès	224	TN	Tunisia	81	governorate	33.9459648	9.7232673	\N
2556	Gafsa	224	TN	Tunisia	71	governorate	34.3788505	8.6600586	\N
2552	Jendouba	224	TN	Tunisia	32	governorate	36.7181862	8.7481167	\N
2564	Kairouan	224	TN	Tunisia	41	governorate	35.6711663	10.1005469	\N
2570	Kasserine	224	TN	Tunisia	42	governorate	35.0809148	8.6600586	\N
2572	Kassrine	224	TN	Tunisia	31	governorate	35.1722716	8.8307626	\N
2562	Kebili	224	TN	Tunisia	73	governorate	33.7071551	8.9714623	\N
2561	Kef	224	TN	Tunisia	33	governorate	36.1230512	8.6600586	\N
2568	Mahdia	224	TN	Tunisia	53	governorate	35.3352558	10.8903099	\N
2555	Manouba	224	TN	Tunisia	14	governorate	36.8446504	9.8571416	\N
2560	Medenine	224	TN	Tunisia	82	governorate	33.2280565	10.8903099	\N
2553	Monastir	224	TN	Tunisia	52	governorate	35.7642515	10.8112885	\N
5116	Nabeul	224	TN	Tunisia	21	governorate	36.4524591	10.6803222	\N
2557	Sfax	224	TN	Tunisia	61	governorate	34.8606581	10.3497895	\N
2567	Sidi Bouzid	224	TN	Tunisia	43	governorate	35.0354386	9.4839392	\N
2563	Siliana	224	TN	Tunisia	34	governorate	36.0887208	9.3645335	\N
2571	Sousse	224	TN	Tunisia	51	governorate	35.9022267	10.3497895	\N
2559	Tataouine	224	TN	Tunisia	83	governorate	32.1344122	10.0807298	\N
2569	Tozeur	224	TN	Tunisia	72	governorate	33.9789491	8.0465185	\N
2554	Tunis	224	TN	Tunisia	11	governorate	36.8374946	10.1927389	\N
2565	Zaghouan	224	TN	Tunisia	22	governorate	36.4091188	10.1423172	\N
2212	Adana	225	TR	Turkey	01	province	37.2612315	35.3905046	\N
2155	Adıyaman	225	TR	Turkey	02	province	37.9078291	38.4849923	\N
2179	Afyonkarahisar	225	TR	Turkey	03	province	38.7391099	30.7120023	\N
2193	Ağrı	225	TR	Turkey	04	province	39.6269218	43.0215965	\N
2210	Aksaray	225	TR	Turkey	68	province	38.3352043	33.9750018	\N
2161	Amasya	225	TR	Turkey	05	province	40.6516608	35.9037966	\N
2217	Ankara	225	TR	Turkey	06	province	39.7805245	32.7181375	\N
2169	Antalya	225	TR	Turkey	07	province	37.0951672	31.0793705	\N
2185	Ardahan	225	TR	Turkey	75	province	41.1112964	42.7831674	\N
2191	Artvin	225	TR	Turkey	08	province	41.078664	41.7628223	\N
2187	Aydın	225	TR	Turkey	09	province	37.8117033	28.4863963	\N
2175	Balıkesir	225	TR	Turkey	10	province	39.7616782	28.1122679	\N
2148	Bartın	225	TR	Turkey	74	province	41.5810509	32.4609794	\N
2194	Batman	225	TR	Turkey	72	province	37.8362496	41.3605739	\N
2177	Bayburt	225	TR	Turkey	69	province	40.26032	40.228048	\N
2221	Bilecik	225	TR	Turkey	11	province	40.0566555	30.0665236	\N
2153	Bingöl	225	TR	Turkey	12	province	39.0626354	40.7696095	\N
2215	Bitlis	225	TR	Turkey	13	province	38.6523133	42.4202028	\N
2172	Bolu	225	TR	Turkey	14	province	40.5759766	31.5788086	\N
2209	Burdur	225	TR	Turkey	15	province	37.4612669	30.0665236	\N
2163	Bursa	225	TR	Turkey	16	province	40.0655459	29.2320784	\N
2216	Çanakkale	225	TR	Turkey	17	province	40.0510104	26.9852422	\N
2168	Çankırı	225	TR	Turkey	18	province	40.5369073	33.5883893	\N
2173	Çorum	225	TR	Turkey	19	province	40.4998211	34.5986263	\N
2157	Denizli	225	TR	Turkey	20	province	37.6128395	29.2320784	\N
2226	Diyarbakır	225	TR	Turkey	21	province	38.1066372	40.5426896	\N
2202	Düzce	225	TR	Turkey	81	province	40.8770531	31.3192713	\N
2151	Edirne	225	TR	Turkey	22	province	41.1517222	26.5137964	\N
2159	Elazığ	225	TR	Turkey	23	province	38.4964804	39.2199029	\N
2160	Erzincan	225	TR	Turkey	24	province	39.7681914	39.0501306	\N
2165	Erzurum	225	TR	Turkey	25	province	40.0746799	41.6694562	\N
2164	Eskişehir	225	TR	Turkey	26	province	39.6329657	31.2626366	\N
2203	Gaziantep	225	TR	Turkey	27	province	37.0763882	37.3827234	\N
2186	Giresun	225	TR	Turkey	28	province	40.6461672	38.5935511	\N
2204	Gümüşhane	225	TR	Turkey	29	province	40.2803673	39.3143253	\N
2190	Hakkâri	225	TR	Turkey	30	province	37.4459319	43.7449841	\N
2211	Hatay	225	TR	Turkey	31	province	36.4018488	36.3498097	\N
2166	Iğdır	225	TR	Turkey	76	province	39.8879841	44.0048365	\N
2222	Isparta	225	TR	Turkey	32	province	38.0211464	31.0793705	\N
2170	Istanbul	225	TR	Turkey	34	province	41.1634302	28.7664408	\N
2205	İzmir	225	TR	Turkey	35	province	38.3591693	27.2676116	\N
2227	Kahramanmaraş	225	TR	Turkey	46	province	37.7503036	36.954107	\N
2223	Karabük	225	TR	Turkey	78	province	41.187489	32.7417419	\N
2184	Karaman	225	TR	Turkey	70	province	37.2436336	33.617577	\N
2208	Kars	225	TR	Turkey	36	province	40.2807636	42.9919527	\N
2197	Kastamonu	225	TR	Turkey	37	province	41.4103863	33.6998334	\N
2200	Kayseri	225	TR	Turkey	38	province	38.6256854	35.7406882	\N
2154	Kilis	225	TR	Turkey	79	province	36.8204775	37.1687339	\N
2178	Kırıkkale	225	TR	Turkey	71	province	39.8876878	33.7555248	\N
2176	Kırklareli	225	TR	Turkey	39	province	41.7259795	27.483839	\N
2180	Kırşehir	225	TR	Turkey	40	province	39.2268905	33.9750018	\N
2195	Kocaeli	225	TR	Turkey	41	province	40.8532704	29.8815203	\N
2171	Konya	225	TR	Turkey	42	province	37.9838134	32.7181375	\N
2149	Kütahya	225	TR	Turkey	43	province	39.358137	29.6035495	\N
2158	Malatya	225	TR	Turkey	44	province	38.4015057	37.9536298	\N
2198	Manisa	225	TR	Turkey	45	province	38.8419373	28.1122679	\N
2224	Mardin	225	TR	Turkey	47	province	37.3442929	40.6196487	\N
2156	Mersin	225	TR	Turkey	33	province	36.8120858	34.641475	\N
2182	Muğla	225	TR	Turkey	48	province	37.1835819	28.4863963	\N
2162	Muş	225	TR	Turkey	49	province	38.9461888	41.7538931	\N
2196	Nevşehir	225	TR	Turkey	50	province	38.6939399	34.6856509	\N
2189	Niğde	225	TR	Turkey	51	province	38.0993086	34.6856509	\N
2174	Ordu	225	TR	Turkey	52	province	40.799058	37.3899005	\N
2214	Osmaniye	225	TR	Turkey	80	province	37.2130258	36.1762615	\N
2219	Rize	225	TR	Turkey	53	province	40.9581497	40.9226985	\N
2150	Sakarya	225	TR	Turkey	54	province	40.788855	30.405954	\N
2220	Samsun	225	TR	Turkey	55	province	41.1864859	36.1322678	\N
2183	Şanlıurfa	225	TR	Turkey	63	province	37.3569102	39.1543677	\N
2207	Siirt	225	TR	Turkey	56	province	37.8658862	42.1494523	\N
4854	Sinop	225	TR	Turkey	57	province	41.5594749	34.8580532	\N
2181	Sivas	225	TR	Turkey	58	province	39.4488039	37.1294497	\N
2225	Şırnak	225	TR	Turkey	73	province	37.4187481	42.4918338	\N
2167	Tekirdağ	225	TR	Turkey	59	province	41.1121227	27.2676116	\N
2199	Tokat	225	TR	Turkey	60	province	40.3902713	36.6251863	\N
2206	Trabzon	225	TR	Turkey	61	province	40.799241	39.5847944	\N
2192	Tunceli	225	TR	Turkey	62	province	39.3073554	39.4387778	\N
2201	Uşak	225	TR	Turkey	64	province	38.5431319	29.2320784	\N
2152	Van	225	TR	Turkey	65	province	38.3679417	43.7182787	\N
2218	Yalova	225	TR	Turkey	77	province	40.5775986	29.2088303	\N
2188	Yozgat	225	TR	Turkey	66	province	39.7271979	35.1077858	\N
2213	Zonguldak	225	TR	Turkey	67	province	41.3124917	31.8598251	\N
3374	Ahal Region	226	TM	Turkmenistan	A	\N	38.6399398	59.4720904	\N
3371	Ashgabat	226	TM	Turkmenistan	S	\N	37.9600766	58.3260629	\N
3372	Balkan Region	226	TM	Turkmenistan	B	\N	41.8101472	21.0937311	\N
3373	Daşoguz Region	226	TM	Turkmenistan	D	\N	41.8368737	59.9651904	\N
3370	Lebap Region	226	TM	Turkmenistan	L	\N	38.1272462	64.7162415	\N
3369	Mary Region	226	TM	Turkmenistan	M	\N	36.9481623	62.4504154	\N
3951	Funafuti	228	TV	Tuvalu	FUN	\N	-8.5211471	179.1961926	\N
3947	Nanumanga	228	TV	Tuvalu	NMG	\N	-6.2858019	176.319928	\N
3949	Nanumea	228	TV	Tuvalu	NMA	\N	-5.6881617	176.1370148	\N
3946	Niutao Island Council	228	TV	Tuvalu	NIT	\N	-6.1064258	177.3438429	\N
3948	Nui	228	TV	Tuvalu	NUI	\N	-7.2388768	177.1485232	\N
3952	Nukufetau	228	TV	Tuvalu	NKF	\N	-8	178.5	\N
3953	Nukulaelae	228	TV	Tuvalu	NKL	\N	-9.381111	179.852222	\N
3950	Vaitupu	228	TV	Tuvalu	VAI	\N	-7.4767327	178.6747675	\N
329	Abim District	229	UG	Uganda	314	\N	2.706698	33.6595337	\N
361	Adjumani District	229	UG	Uganda	301	\N	3.2548527	31.7195459	\N
392	Agago District	229	UG	Uganda	322	\N	2.925082	33.3486147	\N
344	Alebtong District	229	UG	Uganda	323	\N	2.2545773	33.3486147	\N
416	Amolatar District	229	UG	Uganda	315	\N	1.6054402	32.8084496	\N
353	Amudat District	229	UG	Uganda	324	\N	1.7916224	34.906551	\N
352	Amuria District	229	UG	Uganda	216	\N	2.03017	33.6427533	\N
335	Amuru District	229	UG	Uganda	316	\N	2.9667878	32.0837445	\N
328	Apac District	229	UG	Uganda	302	\N	1.8730263	32.6277455	\N
447	Arua District	229	UG	Uganda	303	\N	2.9959846	31.1710389	\N
441	Budaka District	229	UG	Uganda	217	\N	1.1016277	33.9303991	\N
349	Bududa District	229	UG	Uganda	218	\N	1.0029693	34.3338123	\N
387	Bugiri District	229	UG	Uganda	201	\N	0.5316127	33.7517723	\N
391	Buhweju District	229	UG	Uganda	420	\N	-0.2911359	30.2974199	\N
377	Buikwe District	229	UG	Uganda	117	\N	0.3144046	32.9888319	\N
343	Bukedea District	229	UG	Uganda	219	\N	1.3556898	34.1086793	\N
375	Bukomansimbi District	229	UG	Uganda	118	\N	-0.1432752	31.6054893	\N
385	Bukwo District	229	UG	Uganda	220	\N	1.2818651	34.7298765	\N
428	Bulambuli District	229	UG	Uganda	225	\N	1.4798846	34.3754414	\N
389	Buliisa District	229	UG	Uganda	416	\N	2.0299607	31.5370003	\N
419	Bundibugyo District	229	UG	Uganda	401	\N	0.6851763	30.0202964	\N
381	Bunyangabu District	229	UG	Uganda	430	\N	0.4870918	30.2051096	\N
386	Bushenyi District	229	UG	Uganda	402	\N	-0.4870918	30.2051096	\N
431	Busia District	229	UG	Uganda	202	\N	0.4044731	34.0195827	\N
365	Butaleja District	229	UG	Uganda	221	\N	0.8474922	33.8411288	\N
384	Butambala District	229	UG	Uganda	119	\N	0.17425	32.1064668	\N
388	Butebo District	229	UG	Uganda	233	\N	1.2141124	33.9080896	\N
414	Buvuma District	229	UG	Uganda	120	\N	-0.3764912	33.258793	\N
380	Buyende District	229	UG	Uganda	226	\N	1.2413682	33.1239049	\N
396	Central Region	229	UG	Uganda	C	\N	44.296875	-94.7401733	\N
341	Dokolo District	229	UG	Uganda	317	\N	1.9636421	33.0338767	\N
372	Eastern Region	229	UG	Uganda	E	\N	6.2374036	-0.4502368	\N
366	Gomba District	229	UG	Uganda	121	\N	0.2229791	31.6739371	\N
413	Gulu District	229	UG	Uganda	304	\N	2.8185776	32.4467238	\N
339	Ibanda District	229	UG	Uganda	417	\N	-0.096489	30.5739579	\N
340	Iganga District	229	UG	Uganda	203	\N	0.6600137	33.4831906	\N
383	Isingiro District	229	UG	Uganda	418	\N	-0.843543	30.8039474	\N
367	Jinja District	229	UG	Uganda	204	\N	0.5343743	33.3037143	\N
434	Kaabong District	229	UG	Uganda	318	\N	3.5126215	33.9750018	\N
426	Kabale District	229	UG	Uganda	404	\N	-1.2493084	30.0665236	\N
326	Kabarole District	229	UG	Uganda	405	\N	0.5850791	30.2512728	\N
336	Kaberamaido District	229	UG	Uganda	213	\N	1.6963322	33.213851	\N
403	Kagadi District	229	UG	Uganda	427	\N	0.9400761	30.8125638	\N
399	Kakumiro District	229	UG	Uganda	428	\N	0.7808035	31.3241389	\N
405	Kalangala District	229	UG	Uganda	101	\N	-0.6350578	32.5372741	\N
398	Kaliro District	229	UG	Uganda	222	\N	1.0431107	33.4831906	\N
394	Kalungu District	229	UG	Uganda	122	\N	-0.0952831	31.7651362	\N
382	Kampala District	229	UG	Uganda	102	\N	0.3475964	32.5825197	\N
334	Kamuli District	229	UG	Uganda	205	\N	0.9187107	33.1239049	\N
360	Kamwenge District	229	UG	Uganda	413	\N	0.225793	30.4818446	\N
373	Kanungu District	229	UG	Uganda	414	\N	-0.8195253	29.742604	\N
432	Kapchorwa District	229	UG	Uganda	206	\N	1.3350205	34.3976356	\N
440	Kasese District	229	UG	Uganda	406	\N	0.0646285	30.0665236	\N
420	Katakwi District	229	UG	Uganda	207	\N	1.973103	34.0641419	\N
368	Kayunga District	229	UG	Uganda	112	\N	0.9860182	32.8535755	\N
436	Kibaale District	229	UG	Uganda	407	\N	0.9066802	31.0793705	\N
347	Kiboga District	229	UG	Uganda	103	\N	0.965759	31.7195459	\N
338	Kibuku District	229	UG	Uganda	227	\N	1.0452874	33.7992536	\N
355	Kiruhura District	229	UG	Uganda	419	\N	-0.1927998	30.8039474	\N
346	Kiryandongo District	229	UG	Uganda	421	\N	2.0179907	32.0837445	\N
409	Kisoro District	229	UG	Uganda	408	\N	-1.220943	29.6499162	\N
348	Kitgum District	229	UG	Uganda	305	\N	3.3396829	33.1688883	\N
345	Koboko District	229	UG	Uganda	319	\N	3.5237058	31.03351	\N
401	Kole District	229	UG	Uganda	325	\N	2.3701097	32.7633036	\N
443	Kotido District	229	UG	Uganda	306	\N	3.0415679	33.8857747	\N
425	Kumi District	229	UG	Uganda	208	\N	1.4876999	33.9303991	\N
369	Kween District	229	UG	Uganda	228	\N	1.443879	34.597132	\N
325	Kyankwanzi District	229	UG	Uganda	123	\N	1.0966037	31.7195459	\N
437	Kyegegwa District	229	UG	Uganda	422	\N	0.4818193	31.0550093	\N
402	Kyenjojo District	229	UG	Uganda	415	\N	0.6092923	30.6401231	\N
448	Kyotera District	229	UG	Uganda	125	\N	-0.6358988	31.5455637	\N
411	Lamwo District	229	UG	Uganda	326	\N	3.5707568	32.5372741	\N
342	Lira District	229	UG	Uganda	307	\N	2.2316169	32.9437667	\N
445	Luuka District	229	UG	Uganda	229	\N	0.7250599	33.3037143	\N
433	Luwero District	229	UG	Uganda	104	\N	0.8271118	32.6277455	\N
417	Lwengo District	229	UG	Uganda	124	\N	-0.4165288	31.3998995	\N
376	Lyantonde District	229	UG	Uganda	114	\N	-0.2240696	31.2168466	\N
438	Manafwa District	229	UG	Uganda	223	\N	0.9063599	34.2866091	\N
421	Maracha District	229	UG	Uganda	320	\N	3.2873127	30.9403023	\N
356	Masaka District	229	UG	Uganda	105	\N	-0.4463691	31.9017954	\N
354	Masindi District	229	UG	Uganda	409	\N	1.4920363	31.7195459	\N
418	Mayuge District	229	UG	Uganda	214	\N	-0.2182982	33.5728027	\N
350	Mbale District	229	UG	Uganda	209	\N	1.0344274	34.1976882	\N
415	Mbarara District	229	UG	Uganda	410	\N	-0.6071596	30.6545022	\N
435	Mitooma District	229	UG	Uganda	423	\N	-0.6193276	30.0202964	\N
364	Mityana District	229	UG	Uganda	115	\N	0.4454845	32.0837445	\N
395	Moroto District	229	UG	Uganda	308	\N	2.6168545	34.597132	\N
363	Moyo District	229	UG	Uganda	309	\N	3.5696464	31.6739371	\N
327	Mpigi District	229	UG	Uganda	106	\N	0.2273528	32.3249236	\N
371	Mubende District	229	UG	Uganda	107	\N	0.5772758	31.5370003	\N
410	Mukono District	229	UG	Uganda	108	\N	0.2835476	32.7633036	\N
393	Nakapiripirit District	229	UG	Uganda	311	\N	1.9606173	34.597132	\N
423	Nakaseke District	229	UG	Uganda	116	\N	1.2230848	32.0837445	\N
406	Nakasongola District	229	UG	Uganda	109	\N	1.3489721	32.4467238	\N
351	Namayingo District	229	UG	Uganda	230	\N	-0.2803575	33.7517723	\N
400	Namisindwa District	229	UG	Uganda	234	\N	0.907101	34.3574037	\N
337	Namutumba District	229	UG	Uganda	224	\N	0.849261	33.6623301	\N
430	Napak District	229	UG	Uganda	327	\N	2.3629945	34.2421597	\N
446	Nebbi District	229	UG	Uganda	310	\N	2.4409392	31.3541631	\N
424	Ngora District	229	UG	Uganda	231	\N	1.4908115	33.7517723	\N
332	Northern Region	229	UG	Uganda	N	\N	9.5439269	-0.9056623	\N
422	Ntoroko District	229	UG	Uganda	424	\N	1.0788178	30.3896651	\N
404	Ntungamo District	229	UG	Uganda	411	\N	-0.9807341	30.2512728	\N
378	Nwoya District	229	UG	Uganda	328	\N	2.562444	31.9017954	\N
374	Omoro District	229	UG	Uganda	331	\N	2.715223	32.4920088	\N
390	Otuke District	229	UG	Uganda	329	\N	2.5214059	33.3486147	\N
397	Oyam District	229	UG	Uganda	321	\N	2.2776281	32.4467238	\N
408	Pader District	229	UG	Uganda	312	\N	2.9430682	32.8084496	\N
357	Pakwach District	229	UG	Uganda	332	\N	2.4607141	31.4941738	\N
412	Pallisa District	229	UG	Uganda	210	\N	1.2324206	33.7517723	\N
439	Rakai District	229	UG	Uganda	110	\N	-0.7069135	31.5370003	\N
358	Rubanda District	229	UG	Uganda	429	\N	-1.186119	29.8453576	\N
442	Rubirizi District	229	UG	Uganda	425	\N	-0.264241	30.1084033	\N
331	Rukiga District	229	UG	Uganda	431	\N	-1.1326337	30.043412	\N
324	Rukungiri District	229	UG	Uganda	412	\N	-0.751849	29.9277947	\N
427	Sembabule District	229	UG	Uganda	111	\N	0.0637715	31.3541631	\N
333	Serere District	229	UG	Uganda	232	\N	1.4994033	33.5490078	\N
407	Sheema District	229	UG	Uganda	426	\N	-0.5515298	30.3896651	\N
429	Sironko District	229	UG	Uganda	215	\N	1.2302274	34.2491064	\N
444	Soroti District	229	UG	Uganda	211	\N	1.7229117	33.5280072	\N
359	Tororo District	229	UG	Uganda	212	\N	0.6870994	34.0641419	\N
362	Wakiso District	229	UG	Uganda	113	\N	0.063019	32.4467238	\N
370	Western Region	229	UG	Uganda	W	\N	40.7667215	-111.8877203	\N
330	Yumbe District	229	UG	Uganda	313	\N	3.4698023	31.2483291	\N
379	Zombo District	229	UG	Uganda	330	\N	2.5544293	30.9417368	\N
4689	Autonomous Republic of Crimea	230	UA	Ukraine	43	republic	44.952117	34.102417	\N
2502	Saint Helena	232	GB	United Kingdom	SH-HL	\N	-15.9650104	-5.7089241	\N
4680	Cherkaska oblast	230	UA	Ukraine	71	region	49.444433	32.059767	\N
4692	Chernihivska oblast	230	UA	Ukraine	74	region	51.4982	31.2893499	\N
4678	Chernivetska oblast	230	UA	Ukraine	77	region	48.291683	25.935217	\N
4675	Dnipropetrovska oblast	230	UA	Ukraine	12	region	48.464717	35.046183	\N
4691	Donetska oblast	230	UA	Ukraine	14	region	48.015883	37.80285	\N
4682	Ivano-Frankivska oblast	230	UA	Ukraine	26	region	48.922633	24.711117	\N
4686	Kharkivska oblast	230	UA	Ukraine	63	region	49.9935	36.230383	\N
4684	Khersonska oblast	230	UA	Ukraine	65	region	46.635417	32.616867	\N
4681	Khmelnytska oblast	230	UA	Ukraine	68	region	49.422983	26.9871331	\N
4677	Kirovohradska oblast	230	UA	Ukraine	35	region	48.507933	32.262317	\N
4676	Kyiv	230	UA	Ukraine	30	city	50.4501	30.5234	\N
4671	Kyivska oblast	230	UA	Ukraine	32	region	50.0529506	30.7667134	\N
4673	Luhanska oblast	230	UA	Ukraine	09	region	48.574041	39.307815	\N
4672	Lvivska oblast	230	UA	Ukraine	46	region	49.839683	24.029717	\N
4679	Mykolaivska oblast	230	UA	Ukraine	48	region	46.975033	31.9945829	\N
4688	Odeska oblast	230	UA	Ukraine	51	region	46.484583	30.7326	\N
5071	Poltavska oblast	230	UA	Ukraine	53	region	49.6429196	32.6675339	\N
4683	Rivnenska oblast	230	UA	Ukraine	56	region	50.6199	26.251617	\N
4685	Sumska oblast	230	UA	Ukraine	59	region	50.9077	34.7981	\N
4674	Ternopilska oblast	230	UA	Ukraine	61	region	49.553517	25.594767	\N
4669	Vinnytska oblast	230	UA	Ukraine	05	region	49.233083	28.4682169	\N
4690	Volynska oblast	230	UA	Ukraine	07	region	50.747233	25.325383	\N
4670	Zakarpatska Oblast	230	UA	Ukraine	21	region	48.6208	22.287883	\N
4687	Zaporizka oblast	230	UA	Ukraine	23	region	47.8388	35.139567	\N
4668	Zhytomyrska oblast	230	UA	Ukraine	18	region	50.25465	28.6586669	\N
3396	Abu Dhabi Emirate	231	AE	United Arab Emirates	AZ	\N	24.453884	54.3773438	\N
3395	Ajman Emirate	231	AE	United Arab Emirates	AJ	\N	25.4052165	55.5136433	\N
3391	Dubai	231	AE	United Arab Emirates	DU	\N	25.2048493	55.2707828	\N
3393	Fujairah	231	AE	United Arab Emirates	FU	\N	25.1288099	56.3264849	\N
3394	Ras al-Khaimah	231	AE	United Arab Emirates	RK	\N	25.6741343	55.9804173	\N
3390	Sharjah Emirate	231	AE	United Arab Emirates	SH	\N	25.0753974	55.7578403	\N
3392	Umm al-Quwain	231	AE	United Arab Emirates	UQ	\N	25.5426324	55.5475348	\N
2463	Aberdeen	232	GB	United Kingdom	ABE	\N	57.149717	-2.094278	\N
2401	Aberdeenshire	232	GB	United Kingdom	ABD	\N	57.2868723	-2.3815684	\N
2387	Angus	232	GB	United Kingdom	ANS	\N	37.2757886	-95.6501033	\N
2533	Antrim	232	GB	United Kingdom	ANT	\N	54.7195338	-6.2072498	\N
2412	Antrim and Newtownabbey	232	GB	United Kingdom	ANN	\N	54.6956887	-5.9481069	\N
2498	Ards	232	GB	United Kingdom	ARD	\N	42.1391851	-87.8614972	\N
2523	Ards and North Down	232	GB	United Kingdom	AND	\N	54.5899645	-5.5984972	\N
2392	Argyll and Bute	232	GB	United Kingdom	AGB	\N	56.4006214	-5.480748	\N
2331	Armagh City and District Council	232	GB	United Kingdom	ARM	\N	54.3932592	-6.4563401	\N
2324	Armagh, Banbridge and Craigavon	232	GB	United Kingdom	ABC	\N	54.3932592	-6.4563401	\N
2378	Ascension Island	232	GB	United Kingdom	SH-AC	\N	-7.9467166	-14.3559158	\N
2363	Ballymena Borough	232	GB	United Kingdom	BLA	\N	54.86426	-6.2791074	\N
2361	Ballymoney	232	GB	United Kingdom	BLY	\N	55.0704888	-6.5173708	\N
2315	Banbridge	232	GB	United Kingdom	BNB	\N	54.348729	-6.2704803	\N
2499	Barnsley	232	GB	United Kingdom	BNS	\N	34.2994956	-84.9845809	\N
2339	Bath and North East Somerset	232	GB	United Kingdom	BAS	\N	51.3250102	-2.4766241	\N
2507	Bedford	232	GB	United Kingdom	BDF	\N	32.844017	-97.1430671	\N
2311	Belfast district	232	GB	United Kingdom	BFS	\N	54.6170366	-5.9531861	\N
2425	Birmingham	232	GB	United Kingdom	BIR	\N	33.5185892	-86.8103567	\N
2329	Blackburn with Darwen	232	GB	United Kingdom	BBD	\N	53.6957522	-2.4682985	\N
2451	Blackpool	232	GB	United Kingdom	BPL	\N	53.8175053	-3.0356748	\N
2530	Blaenau Gwent County Borough	232	GB	United Kingdom	BGW	\N	51.7875779	-3.2043931	\N
2504	Bolton	232	GB	United Kingdom	BOL	\N	44.3726476	-72.8787625	\N
2342	Bournemouth	232	GB	United Kingdom	BMH	\N	50.719164	-1.880769	\N
2470	Bracknell Forest	232	GB	United Kingdom	BRC	\N	51.4153828	-0.7536495	\N
2529	Bradford	232	GB	United Kingdom	BRD	\N	53.795984	-1.759398	\N
2452	Bridgend County Borough	232	GB	United Kingdom	BGE	\N	51.5083199	-3.5812075	\N
2395	Brighton and Hove	232	GB	United Kingdom	BNH	\N	50.8226288	-0.137047	\N
2405	Buckinghamshire	232	GB	United Kingdom	BKM	\N	51.8072204	-0.8127664	\N
2459	Bury	232	GB	United Kingdom	BUR	\N	53.5933498	-2.2966054	\N
2298	Caerphilly County Borough	232	GB	United Kingdom	CAY	\N	51.6604465	-3.2178724	\N
2517	Calderdale	232	GB	United Kingdom	CLD	\N	53.7247845	-1.8658357	\N
2423	Cambridgeshire	232	GB	United Kingdom	CAM	\N	52.2052973	0.1218195	\N
2484	Carmarthenshire	232	GB	United Kingdom	CMN	\N	51.8572309	-4.3115959	\N
2439	Carrickfergus Borough Council	232	GB	United Kingdom	CKF	\N	54.7256843	-5.8093719	\N
2525	Castlereagh	232	GB	United Kingdom	CSR	\N	54.575679	-5.8884028	\N
2316	Causeway Coast and Glens	232	GB	United Kingdom	CCG	\N	55.043183	-6.6741288	\N
2303	Central Bedfordshire	232	GB	United Kingdom	CBF	\N	52.0029744	-0.4651389	\N
2509	Ceredigion	232	GB	United Kingdom	CGN	\N	52.2191429	-3.9321256	\N
2444	Cheshire East	232	GB	United Kingdom	CHE	\N	53.1610446	-2.2185932	\N
2442	Cheshire West and Chester	232	GB	United Kingdom	CHW	\N	53.2302974	-2.7151117	\N
2528	City and County of Cardiff	232	GB	United Kingdom	CRF	\N	51.481581	-3.17909	\N
2433	City and County of Swansea	232	GB	United Kingdom	SWA	\N	51.62144	-3.943646	\N
2413	City of Bristol	232	GB	United Kingdom	BST	\N	41.673522	-72.9465375	\N
2485	City of Derby	232	GB	United Kingdom	DER	\N	37.5483755	-97.2485191	\N
2493	Salford	232	GB	United Kingdom	SLF	\N	53.4875235	-2.2901264	\N
2475	City of Kingston upon Hull	232	GB	United Kingdom	KHL	\N	53.7676236	-0.3274198	\N
2318	City of Leicester	232	GB	United Kingdom	LCE	\N	52.6368778	-1.1397592	\N
2424	City of London	232	GB	United Kingdom	LND	\N	51.5123443	-0.0909852	\N
2359	City of Nottingham	232	GB	United Kingdom	NGM	\N	52.9547832	-1.1581086	\N
2297	City of Peterborough	232	GB	United Kingdom	PTE	\N	44.3093636	-78.320153	\N
2514	City of Plymouth	232	GB	United Kingdom	PLY	\N	42.3708941	-83.4697141	\N
2305	City of Portsmouth	232	GB	United Kingdom	POR	\N	36.832915	-76.2975549	\N
2294	City of Southampton	232	GB	United Kingdom	STH	\N	50.9097004	-1.4043509	\N
2506	City of Stoke-on-Trent	232	GB	United Kingdom	STE	\N	53.002668	-2.179404	\N
2372	City of Sunderland	232	GB	United Kingdom	SND	\N	54.8861489	-1.4785797	\N
2357	City of Westminster	232	GB	United Kingdom	WSM	\N	39.5765977	-76.9972126	\N
2489	City of Wolverhampton	232	GB	United Kingdom	WLV	\N	52.588912	-2.156463	\N
2426	City of York	232	GB	United Kingdom	YOR	\N	53.9599651	-1.0872979	\N
2450	Clackmannanshire	232	GB	United Kingdom	CLK	\N	56.1075351	-3.7529409	\N
2461	Coleraine Borough Council	232	GB	United Kingdom	CLR	\N	55.145157	-6.6759814	\N
2352	Conwy County Borough	232	GB	United Kingdom	CWY	\N	53.2935013	-3.7265161	\N
2445	Cookstown District Council	232	GB	United Kingdom	CKT	\N	54.6418158	-6.7443895	\N
2312	Cornwall	232	GB	United Kingdom	CON	\N	50.2660471	-5.0527125	\N
2406	County Durham	232	GB	United Kingdom	DUR	\N	54.7294099	-1.8811598	\N
2438	Coventry	232	GB	United Kingdom	COV	\N	52.406822	-1.519693	\N
2449	Craigavon Borough Council	232	GB	United Kingdom	CGV	\N	54.3932592	-6.4563401	\N
2334	Cumbria	232	GB	United Kingdom	CMA	\N	54.5772323	-2.7974835	\N
2389	Darlington	232	GB	United Kingdom	DAL	\N	34.2998762	-79.8761741	\N
2497	Denbighshire	232	GB	United Kingdom	DEN	\N	53.1842288	-3.4224985	\N
2403	Derbyshire	232	GB	United Kingdom	DBY	\N	53.1046782	-1.5623885	\N
2446	Derry City and Strabane	232	GB	United Kingdom	DRS	\N	55.0047443	-7.3209222	\N
2417	Derry City Council	232	GB	United Kingdom	DRY	\N	54.9690778	-7.1958351	\N
2491	Devon	232	GB	United Kingdom	DEV	\N	50.7155591	-3.530875	\N
2364	Doncaster	232	GB	United Kingdom	DNC	\N	53.52282	-1.128462	\N
2345	Dorset	232	GB	United Kingdom	DOR	\N	50.7487635	-2.3444786	\N
2304	Down District Council	232	GB	United Kingdom	DOW	\N	54.2434287	-5.9577959	\N
2457	Dudley	232	GB	United Kingdom	DUD	\N	42.0433661	-71.9276033	\N
2415	Dumfries and Galloway	232	GB	United Kingdom	DGY	\N	55.0701073	-3.6052581	\N
2511	Dundee	232	GB	United Kingdom	DND	\N	56.462018	-2.970721	\N
2508	Dungannon and South Tyrone Borough Council	232	GB	United Kingdom	DGN	\N	54.5082684	-6.7665891	\N
2374	East Ayrshire	232	GB	United Kingdom	EAY	\N	55.4518496	-4.2644478	\N
2454	East Dunbartonshire	232	GB	United Kingdom	EDU	\N	55.9743162	-4.202298	\N
2462	East Lothian	232	GB	United Kingdom	ELN	\N	55.9493383	-2.7704464	\N
2333	East Renfrewshire	232	GB	United Kingdom	ERW	\N	55.7704735	-4.3359821	\N
2370	East Riding of Yorkshire	232	GB	United Kingdom	ERY	\N	53.8416168	-0.4344106	\N
2414	East Sussex	232	GB	United Kingdom	ESX	\N	50.9085955	0.2494166	\N
2428	Edinburgh	232	GB	United Kingdom	EDH	\N	55.953252	-3.188267	\N
2336	England	232	GB	United Kingdom	ENG	\N	52.3555177	-1.1743197	\N
2410	Essex	232	GB	United Kingdom	ESS	\N	51.5742447	0.4856781	\N
2344	Falkirk	232	GB	United Kingdom	FAL	\N	56.0018775	-3.7839131	\N
2366	Fermanagh and Omagh	232	GB	United Kingdom	FMO	\N	54.4513524	-7.7125018	\N
2531	Fermanagh District Council	232	GB	United Kingdom	FER	\N	54.3447978	-7.6384218	\N
2479	Fife	232	GB	United Kingdom	FIF	\N	56.2082078	-3.1495175	\N
2437	Flintshire	232	GB	United Kingdom	FLN	\N	53.1668658	-3.1418908	\N
2431	Gateshead	232	GB	United Kingdom	GAT	\N	54.95268	-1.603411	\N
2404	Glasgow	232	GB	United Kingdom	GLG	\N	55.864237	-4.251806	\N
2373	Gloucestershire	232	GB	United Kingdom	GLS	\N	51.8642112	-2.2380335	\N
2379	Gwynedd	232	GB	United Kingdom	GWN	\N	52.9277266	-4.1334836	\N
2466	Halton	232	GB	United Kingdom	HAL	\N	43.5325372	-79.8744836	\N
2435	Hampshire	232	GB	United Kingdom	HAM	\N	51.0576948	-1.3080629	\N
2309	Hartlepool	232	GB	United Kingdom	HPL	\N	54.691745	-1.212926	\N
2500	Herefordshire	232	GB	United Kingdom	HEF	\N	52.0765164	-2.6544182	\N
2369	Hertfordshire	232	GB	United Kingdom	HRT	\N	51.8097823	-0.2376744	\N
2383	Highland	232	GB	United Kingdom	HLD	\N	36.2967508	-95.8380366	\N
2388	Inverclyde	232	GB	United Kingdom	IVC	\N	55.9316569	-4.6800158	\N
2289	Isle of Wight	232	GB	United Kingdom	IOW	\N	50.6938479	-1.304734	\N
2343	Isles of Scilly	232	GB	United Kingdom	IOS	\N	49.9277261	-6.3274966	\N
2464	Kent	232	GB	United Kingdom	KEN	\N	41.1536674	-81.3578859	\N
2371	Kirklees	232	GB	United Kingdom	KIR	\N	53.5933432	-1.8009509	\N
2330	Knowsley	232	GB	United Kingdom	KWL	\N	53.454594	-2.852907	\N
2495	Lancashire	232	GB	United Kingdom	LAN	\N	53.7632254	-2.7044052	\N
2515	Larne Borough Council	232	GB	United Kingdom	LRN	\N	54.8578003	-5.8236224	\N
2503	Leeds	232	GB	United Kingdom	LDS	\N	53.8007554	-1.5490774	\N
2516	Leicestershire	232	GB	United Kingdom	LEC	\N	52.772571	-1.2052126	\N
2382	Limavady Borough Council	232	GB	United Kingdom	LMV	\N	55.051682	-6.9491944	\N
2355	Lincolnshire	232	GB	United Kingdom	LIN	\N	52.9451889	-0.1601246	\N
2460	Lisburn and Castlereagh	232	GB	United Kingdom	LBC	\N	54.4981584	-6.1306791	\N
2494	Lisburn City Council	232	GB	United Kingdom	LSB	\N	54.4981584	-6.1306791	\N
2340	Liverpool	232	GB	United Kingdom	LIV	\N	32.6564981	-115.4763241	\N
2356	London Borough of Barking and Dagenham	232	GB	United Kingdom	BDG	\N	51.5540666	0.134017	\N
2520	London Borough of Barnet	232	GB	United Kingdom	BNE	\N	51.6049673	-0.2076295	\N
2307	London Borough of Bexley	232	GB	United Kingdom	BEX	\N	51.4519021	0.1171786	\N
2291	London Borough of Brent	232	GB	United Kingdom	BEN	\N	51.5672808	-0.2710568	\N
2490	London Borough of Bromley	232	GB	United Kingdom	BRY	\N	51.3679705	0.070062	\N
2349	London Borough of Camden	232	GB	United Kingdom	CMD	\N	51.5454736	-0.1627902	\N
2512	London Borough of Croydon	232	GB	United Kingdom	CRY	\N	51.3827446	-0.0985163	\N
2532	London Borough of Ealing	232	GB	United Kingdom	EAL	\N	51.5250366	-0.3413965	\N
2476	London Borough of Enfield	232	GB	United Kingdom	ENF	\N	51.6622909	-0.1180651	\N
2411	London Borough of Hackney	232	GB	United Kingdom	HCK	\N	51.573445	-0.0724376	\N
2448	London Borough of Hammersmith and Fulham	232	GB	United Kingdom	HMF	\N	51.4990156	-0.22915	\N
2306	London Borough of Haringey	232	GB	United Kingdom	HRY	\N	51.5906113	-0.1109709	\N
2385	London Borough of Harrow	232	GB	United Kingdom	HRW	\N	51.5881627	-0.3422851	\N
2347	London Borough of Havering	232	GB	United Kingdom	HAV	\N	51.577924	0.2120829	\N
2376	London Borough of Hillingdon	232	GB	United Kingdom	HIL	\N	51.5351832	-0.4481378	\N
2380	London Borough of Hounslow	232	GB	United Kingdom	HNS	\N	51.4828358	-0.3882062	\N
2319	London Borough of Islington	232	GB	United Kingdom	ISL	\N	51.5465063	-0.1058058	\N
2396	London Borough of Lambeth	232	GB	United Kingdom	LBH	\N	51.4571477	-0.1230681	\N
2358	London Borough of Lewisham	232	GB	United Kingdom	LEW	\N	51.4414579	-0.0117006	\N
2483	London Borough of Merton	232	GB	United Kingdom	MRT	\N	51.4097742	-0.2108084	\N
2418	London Borough of Newham	232	GB	United Kingdom	NWM	\N	51.5255162	0.0352163	\N
2397	London Borough of Redbridge	232	GB	United Kingdom	RDB	\N	51.5886121	0.0823982	\N
2501	London Borough of Richmond upon Thames	232	GB	United Kingdom	RIC	\N	51.4613054	-0.3037709	\N
2432	London Borough of Southwark	232	GB	United Kingdom	SWK	\N	51.4880572	-0.0762838	\N
2313	London Borough of Sutton	232	GB	United Kingdom	STN	\N	51.3573762	-0.1752796	\N
2390	London Borough of Tower Hamlets	232	GB	United Kingdom	TWH	\N	51.5202607	-0.0293396	\N
2326	London Borough of Waltham Forest	232	GB	United Kingdom	WFT	\N	51.5886383	-0.0117625	\N
2434	London Borough of Wandsworth	232	GB	United Kingdom	WND	\N	51.4568274	-0.1896638	\N
2322	Magherafelt District Council	232	GB	United Kingdom	MFT	\N	54.7553279	-6.6077487	\N
2398	Manchester	232	GB	United Kingdom	MAN	\N	53.4807593	-2.2426305	\N
2381	Medway	232	GB	United Kingdom	MDW	\N	42.1417641	-71.3967256	\N
2328	Merthyr Tydfil County Borough	232	GB	United Kingdom	MTY	\N	51.7467474	-3.3813275	\N
2320	Metropolitan Borough of Wigan	232	GB	United Kingdom	WGN	\N	53.5134812	-2.6106999	\N
2429	Mid and East Antrim	232	GB	United Kingdom	MEA	\N	54.9399341	-6.1137423	\N
2399	Mid Ulster	232	GB	United Kingdom	MUL	\N	54.6411301	-6.7522549	\N
2332	Middlesbrough	232	GB	United Kingdom	MDB	\N	54.574227	-1.234956	\N
2519	Midlothian	232	GB	United Kingdom	MLN	\N	32.475335	-97.0103181	\N
2416	Milton Keynes	232	GB	United Kingdom	MIK	\N	52.0852038	-0.7333133	\N
2402	Monmouthshire	232	GB	United Kingdom	MON	\N	51.81161	-2.7163417	\N
2360	Moray	232	GB	United Kingdom	MRY	\N	57.6498476	-3.3168039	\N
2348	Moyle District Council	232	GB	United Kingdom	MYL	\N	55.2047327	-6.253174	\N
2351	Neath Port Talbot County Borough	232	GB	United Kingdom	NTL	\N	51.5978519	-3.7839668	\N
2458	Newcastle upon Tyne	232	GB	United Kingdom	NET	\N	54.978252	-1.61778	\N
2524	Newport	232	GB	United Kingdom	NWP	\N	37.5278234	-94.1043876	\N
2350	Newry and Mourne District Council	232	GB	United Kingdom	NYM	\N	54.1742505	-6.3391992	\N
2534	Newry, Mourne and Down	232	GB	United Kingdom	NMD	\N	54.2434287	-5.9577959	\N
2317	Newtownabbey Borough Council	232	GB	United Kingdom	NTA	\N	54.6792422	-5.9591102	\N
2473	Norfolk	232	GB	United Kingdom	NFK	\N	36.8507689	-76.2858726	\N
2535	North Ayrshire	232	GB	United Kingdom	NAY	\N	55.6416731	-4.75946	\N
2513	North Down Borough Council	232	GB	United Kingdom	NDN	\N	54.6536297	-5.6724925	\N
2384	North East Lincolnshire	232	GB	United Kingdom	NEL	\N	53.5668201	-0.0815066	\N
2487	North Lanarkshire	232	GB	United Kingdom	NLK	\N	55.8662432	-3.9613144	\N
2453	North Lincolnshire	232	GB	United Kingdom	NLN	\N	53.6055592	-0.5596582	\N
2430	North Somerset	232	GB	United Kingdom	NSM	\N	51.3879028	-2.7781091	\N
2521	North Tyneside	232	GB	United Kingdom	NTY	\N	55.0182399	-1.4858436	\N
2522	North Yorkshire	232	GB	United Kingdom	NYK	\N	53.9915028	-1.5412015	\N
2480	Northamptonshire	232	GB	United Kingdom	NTH	\N	52.2729944	-0.8755515	\N
2337	Northern Ireland	232	GB	United Kingdom	NIR	\N	54.7877149	-6.4923145	\N
2365	Northumberland	232	GB	United Kingdom	NBL	\N	55.2082542	-2.0784138	\N
2456	Nottinghamshire	232	GB	United Kingdom	NTT	\N	53.100319	-0.9936306	\N
2477	Oldham	232	GB	United Kingdom	OLD	\N	42.2040598	-71.2048119	\N
2314	Omagh District Council	232	GB	United Kingdom	OMH	\N	54.4513524	-7.7125018	\N
2474	Orkney Islands	232	GB	United Kingdom	ORK	\N	58.9809401	-2.9605206	\N
2353	Outer Hebrides	232	GB	United Kingdom	ELS	\N	57.7598918	-7.0194034	\N
2321	Oxfordshire	232	GB	United Kingdom	OXF	\N	51.7612056	-1.2464674	\N
2486	Pembrokeshire	232	GB	United Kingdom	PEM	\N	51.674078	-4.9088785	\N
2325	Perth and Kinross	232	GB	United Kingdom	PKN	\N	56.3953817	-3.4283547	\N
2302	Poole	232	GB	United Kingdom	POL	\N	50.71505	-1.987248	\N
2441	Powys	232	GB	United Kingdom	POW	\N	52.6464249	-3.3260904	\N
2455	Reading	232	GB	United Kingdom	RDG	\N	36.1486659	-95.9840012	\N
2527	Redcar and Cleveland	232	GB	United Kingdom	RCC	\N	54.5971344	-1.0775997	\N
2443	Renfrewshire	232	GB	United Kingdom	RFW	\N	55.846654	-4.5331259	\N
2301	Rhondda Cynon Taf	232	GB	United Kingdom	RCT	\N	51.6490207	-3.4288692	\N
2327	Rochdale	232	GB	United Kingdom	RCH	\N	53.6097136	-2.1561	\N
2308	Rotherham	232	GB	United Kingdom	ROT	\N	53.4326035	-1.3635009	\N
2492	Royal Borough of Greenwich	232	GB	United Kingdom	GRE	\N	51.4834627	0.0586202	\N
2368	Royal Borough of Kensington and Chelsea	232	GB	United Kingdom	KEC	\N	51.4990805	-0.1938253	\N
2481	Royal Borough of Kingston upon Thames	232	GB	United Kingdom	KTT	\N	51.378117	-0.292709	\N
2472	Rutland	232	GB	United Kingdom	RUT	\N	43.6106237	-72.9726065	\N
2341	Sandwell	232	GB	United Kingdom	SAW	\N	52.5361674	-2.010793	\N
2335	Scotland	232	GB	United Kingdom	SCT	\N	56.4906712	-4.2026458	\N
2346	Scottish Borders	232	GB	United Kingdom	SCB	\N	55.5485697	-2.7861388	\N
2518	Sefton	232	GB	United Kingdom	SFT	\N	53.5034449	-2.970359	\N
2295	Sheffield	232	GB	United Kingdom	SHF	\N	36.0950743	-80.2788466	\N
2300	Shetland Islands	232	GB	United Kingdom	ZET	\N	60.5296507	-1.2659409	\N
2407	Shropshire	232	GB	United Kingdom	SHR	\N	52.7063657	-2.7417849	\N
2427	Slough	232	GB	United Kingdom	SLG	\N	51.5105384	-0.5950406	\N
2469	Solihull	232	GB	United Kingdom	SOL	\N	52.411811	-1.77761	\N
2386	Somerset	232	GB	United Kingdom	SOM	\N	51.105097	-2.9262307	\N
2377	South Ayrshire	232	GB	United Kingdom	SAY	\N	55.4588988	-4.6291994	\N
2400	South Gloucestershire	232	GB	United Kingdom	SGC	\N	51.5264361	-2.4728487	\N
2362	South Lanarkshire	232	GB	United Kingdom	SLK	\N	55.6735909	-3.7819661	\N
2409	South Tyneside	232	GB	United Kingdom	STY	\N	54.9636693	-1.4418634	\N
2323	Southend-on-Sea	232	GB	United Kingdom	SOS	\N	51.5459269	0.7077123	\N
2290	St Helens	232	GB	United Kingdom	SHN	\N	45.858961	-122.8212356	\N
2447	Staffordshire	232	GB	United Kingdom	STS	\N	52.8792745	-2.0571868	\N
2488	Stirling	232	GB	United Kingdom	STG	\N	56.1165227	-3.9369029	\N
2394	Stockport	232	GB	United Kingdom	SKP	\N	53.4106316	-2.1575332	\N
2421	Stockton-on-Tees	232	GB	United Kingdom	STT	\N	54.5704551	-1.3289821	\N
2393	Strabane District Council	232	GB	United Kingdom	STB	\N	54.8273865	-7.4633103	\N
2467	Suffolk	232	GB	United Kingdom	SFK	\N	52.1872472	0.9707801	\N
2526	Surrey	232	GB	United Kingdom	SRY	\N	51.3147593	-0.5599501	\N
2422	Swindon	232	GB	United Kingdom	SWD	\N	51.5557739	-1.7797176	\N
2367	Tameside	232	GB	United Kingdom	TAM	\N	53.4805828	-2.0809891	\N
2310	Telford and Wrekin	232	GB	United Kingdom	TFW	\N	52.7409916	-2.4868586	\N
2468	Thurrock	232	GB	United Kingdom	THR	\N	51.4934557	0.3529197	\N
2478	Torbay	232	GB	United Kingdom	TOB	\N	50.4392329	-3.5369899	\N
2496	Torfaen	232	GB	United Kingdom	TOF	\N	51.7002253	-3.0446015	\N
2293	Trafford	232	GB	United Kingdom	TRF	\N	40.3856246	-79.7589347	\N
2375	United Kingdom	232	GB	United Kingdom	UKM	\N	55.378051	-3.435973	\N
2299	Vale of Glamorgan	232	GB	United Kingdom	VGL	\N	51.4095958	-3.4848167	\N
2465	Wakefield	232	GB	United Kingdom	WKF	\N	42.5039395	-71.0723391	\N
2338	Wales	232	GB	United Kingdom	WLS	\N	52.1306607	-3.7837117	\N
2292	Walsall	232	GB	United Kingdom	WLL	\N	52.586214	-1.982919	\N
2420	Warrington	232	GB	United Kingdom	WRT	\N	40.2492741	-75.1340604	\N
2505	Warwickshire	232	GB	United Kingdom	WAR	\N	52.2671353	-1.4675216	\N
2471	West Berkshire	232	GB	United Kingdom	WBK	\N	51.4308255	-1.1444927	\N
2440	West Dunbartonshire	232	GB	United Kingdom	WDU	\N	55.9450925	-4.5646259	\N
2354	West Lothian	232	GB	United Kingdom	WLN	\N	55.9070198	-3.5517167	\N
2296	West Sussex	232	GB	United Kingdom	WSX	\N	50.9280143	-0.4617075	\N
2391	Wiltshire	232	GB	United Kingdom	WIL	\N	51.3491996	-1.9927105	\N
2482	Windsor and Maidenhead	232	GB	United Kingdom	WNM	\N	51.4799712	-0.6242565	\N
2408	Wirral	232	GB	United Kingdom	WRL	\N	53.3727181	-3.073754	\N
2419	Wokingham	232	GB	United Kingdom	WOK	\N	51.410457	-0.833861	\N
2510	Worcestershire	232	GB	United Kingdom	WOR	\N	52.2545225	-2.2668382	\N
2436	Wrexham County Borough	232	GB	United Kingdom	WRX	\N	53.0301378	-3.0261487	\N
1456	Alabama	233	US	United States	AL	state	32.3182314	-86.902298	\N
1400	Alaska	233	US	United States	AK	state	64.2008413	-149.4936733	\N
1424	American Samoa	233	US	United States	AS	outlying area	-14.270972	-170.132217	\N
1434	Arizona	233	US	United States	AZ	state	34.0489281	-111.0937311	\N
1444	Arkansas	233	US	United States	AR	state	35.20105	-91.8318334	\N
1402	Baker Island	233	US	United States	UM-81	islands / groups of islands	0.1936266	-176.476908	\N
1416	California	233	US	United States	CA	state	36.778261	-119.4179324	\N
1450	Colorado	233	US	United States	CO	state	39.5500507	-105.7820674	\N
1435	Connecticut	233	US	United States	CT	state	41.6032207	-73.087749	\N
1399	Delaware	233	US	United States	DE	state	38.9108325	-75.5276699	\N
1437	District of Columbia	233	US	United States	DC	district	38.9071923	-77.0368707	\N
1436	Florida	233	US	United States	FL	state	27.6648274	-81.5157535	\N
1455	Georgia	233	US	United States	GA	state	32.1656221	-82.9000751	\N
1412	Guam	233	US	United States	GU	outlying area	13.444304	144.793731	\N
1411	Hawaii	233	US	United States	HI	state	19.8967662	-155.5827818	\N
1398	Howland Island	233	US	United States	UM-84	islands / groups of islands	0.8113219	-176.6182736	\N
1460	Idaho	233	US	United States	ID	state	44.0682019	-114.7420408	\N
1425	Illinois	233	US	United States	IL	state	40.6331249	-89.3985283	\N
1440	Indiana	233	US	United States	IN	state	40.2671941	-86.1349019	\N
1459	Iowa	233	US	United States	IA	state	41.8780025	-93.097702	\N
1410	Jarvis Island	233	US	United States	UM-86	islands / groups of islands	-0.3743503	-159.9967206	\N
1428	Johnston Atoll	233	US	United States	UM-67	islands / groups of islands	16.7295035	-169.5336477	\N
1406	Kansas	233	US	United States	KS	state	39.011902	-98.4842465	\N
1419	Kentucky	233	US	United States	KY	state	37.8393332	-84.2700179	\N
1403	Kingman Reef	233	US	United States	UM-89	islands / groups of islands	6.383333	-162.416667	\N
1457	Louisiana	233	US	United States	LA	state	30.9842977	-91.9623327	\N
1453	Maine	233	US	United States	ME	state	45.253783	-69.4454689	\N
1401	Maryland	233	US	United States	MD	state	39.0457549	-76.6412712	\N
1433	Massachusetts	233	US	United States	MA	state	42.4072107	-71.3824374	\N
1426	Michigan	233	US	United States	MI	state	44.3148443	-85.6023643	\N
1438	Midway Atoll	233	US	United States	UM-71	islands / groups of islands	28.2072168	-177.3734926	\N
1420	Minnesota	233	US	United States	MN	state	46.729553	-94.6858998	\N
1430	Mississippi	233	US	United States	MS	state	32.3546679	-89.3985283	\N
1451	Missouri	233	US	United States	MO	state	37.9642529	-91.8318334	\N
1446	Montana	233	US	United States	MT	state	46.8796822	-110.3625658	\N
1439	Navassa Island	233	US	United States	UM-76	islands / groups of islands	18.4100689	-75.0114612	\N
1408	Nebraska	233	US	United States	NE	state	41.4925374	-99.9018131	\N
1458	Nevada	233	US	United States	NV	state	38.8026097	-116.419389	\N
1404	New Hampshire	233	US	United States	NH	state	43.1938516	-71.5723953	\N
1417	New Jersey	233	US	United States	NJ	state	40.0583238	-74.4056612	\N
1423	New Mexico	233	US	United States	NM	state	34.5199402	-105.8700901	\N
1452	New York	233	US	United States	NY	state	40.7127753	-74.0059728	\N
1447	North Carolina	233	US	United States	NC	state	35.7595731	-79.0192997	\N
1418	North Dakota	233	US	United States	ND	state	47.5514926	-101.0020119	\N
1431	Northern Mariana Islands	233	US	United States	MP	outlying area	15.0979	145.6739	\N
4851	Ohio	233	US	United States	OH	state	40.4172871	-82.907123	\N
1421	Oklahoma	233	US	United States	OK	state	35.4675602	-97.5164276	\N
1415	Oregon	233	US	United States	OR	state	43.8041334	-120.5542012	\N
1448	Palmyra Atoll	233	US	United States	UM-95	islands / groups of islands	5.8885026	-162.0786656	\N
1422	Pennsylvania	233	US	United States	PA	state	41.2033216	-77.1945247	\N
1449	Puerto Rico	233	US	United States	PR	outlying area	18.220833	-66.590149	\N
1461	Rhode Island	233	US	United States	RI	state	41.5800945	-71.4774291	\N
1443	South Carolina	233	US	United States	SC	state	33.836081	-81.1637245	\N
1445	South Dakota	233	US	United States	SD	state	43.9695148	-99.9018131	\N
1454	Tennessee	233	US	United States	TN	state	35.5174913	-86.5804473	\N
1407	Texas	233	US	United States	TX	state	31.9685988	-99.9018131	\N
1432	United States Minor Outlying Islands	233	US	United States	UM	outlying area	19.2823192	166.647047	\N
1413	United States Virgin Islands	233	US	United States	VI	outlying area	18.335765	-64.896335	\N
1414	Utah	233	US	United States	UT	state	39.3209801	-111.0937311	\N
1409	Vermont	233	US	United States	VT	state	44.5588028	-72.5778415	\N
1427	Virginia	233	US	United States	VA	state	37.4315734	-78.6568942	\N
1405	Wake Island	233	US	United States	UM-79	islands / groups of islands	19.279619	166.6499348	\N
1462	Washington	233	US	United States	WA	state	47.7510741	-120.7401385	\N
1429	West Virginia	233	US	United States	WV	state	38.5976262	-80.4549026	\N
1441	Wisconsin	233	US	United States	WI	state	43.7844397	-88.7878678	\N
1442	Wyoming	233	US	United States	WY	state	43.0759678	-107.2902839	\N
3205	Artigas Department	235	UY	Uruguay	AR	\N	-30.6175112	-56.9594559	\N
3213	Canelones Department	235	UY	Uruguay	CA	\N	-34.5408717	-55.93076	\N
3211	Cerro Largo Department	235	UY	Uruguay	CL	\N	-32.4411032	-54.3521753	\N
3208	Colonia Department	235	UY	Uruguay	CO	\N	-34.1294678	-57.6605184	\N
3209	Durazno Department	235	UY	Uruguay	DU	\N	-33.0232454	-56.0284644	\N
3203	Flores Department	235	UY	Uruguay	FS	\N	-33.5733753	-56.8945028	\N
3217	Florida Department	235	UY	Uruguay	FD	\N	28.0359495	-82.4579289	\N
3215	Lavalleja Department	235	UY	Uruguay	LA	\N	-33.9226175	-54.9765794	\N
3206	Maldonado Department	235	UY	Uruguay	MA	\N	-34.5597932	-54.8628552	\N
3218	Montevideo Department	235	UY	Uruguay	MO	\N	-34.8181587	-56.2138256	\N
3212	Paysandú Department	235	UY	Uruguay	PA	\N	-32.0667366	-57.3364789	\N
3210	Río Negro Department	235	UY	Uruguay	RN	\N	-32.7676356	-57.4295207	\N
3207	Rivera Department	235	UY	Uruguay	RV	\N	-31.4817421	-55.2435759	\N
3216	Rocha Department	235	UY	Uruguay	RO	\N	-33.9690081	-54.021485	\N
3220	Salto Department	235	UY	Uruguay	SA	\N	-31.388028	-57.9612455	\N
3204	San José Department	235	UY	Uruguay	SJ	\N	37.3492968	-121.9056049	\N
3219	Soriano Department	235	UY	Uruguay	SO	\N	-33.5102792	-57.7498103	\N
3221	Tacuarembó Department	235	UY	Uruguay	TA	\N	-31.7206837	-55.9859887	\N
3214	Treinta y Tres Department	235	UY	Uruguay	TT	\N	-33.0685086	-54.2858627	\N
2540	Andijan Region	236	UZ	Uzbekistan	AN	\N	40.7685941	72.236379	\N
2541	Bukhara Region	236	UZ	Uzbekistan	BU	\N	40.2504162	63.2032151	\N
2538	Fergana Region	236	UZ	Uzbekistan	FA	\N	40.4568081	71.2874209	\N
2545	Jizzakh Region	236	UZ	Uzbekistan	JI	\N	40.4706415	67.5708536	\N
2548	Karakalpakstan	236	UZ	Uzbekistan	QR	\N	43.8041334	59.4457988	\N
2537	Namangan Region	236	UZ	Uzbekistan	NG	\N	41.0510037	71.097317	\N
2542	Navoiy Region	236	UZ	Uzbekistan	NW	\N	42.6988575	64.6337685	\N
2543	Qashqadaryo Region	236	UZ	Uzbekistan	QA	\N	38.8986231	66.0463534	\N
2544	Samarqand Region	236	UZ	Uzbekistan	SA	\N	39.627012	66.9749731	\N
2547	Sirdaryo Region	236	UZ	Uzbekistan	SI	\N	40.3863808	68.7154975	\N
2546	Surxondaryo Region	236	UZ	Uzbekistan	SU	\N	37.9409005	67.5708536	\N
2536	Tashkent	236	UZ	Uzbekistan	TK	\N	41.2994958	69.2400734	\N
2549	Tashkent Region	236	UZ	Uzbekistan	TO	\N	41.2213234	69.8597406	\N
2539	Xorazm Region	236	UZ	Uzbekistan	XO	\N	41.3565336	60.8566686	\N
4775	Malampa	237	VU	Vanuatu	MAP	\N	-16.4011405	167.6077865	\N
4773	Penama	237	VU	Vanuatu	PAM	\N	-15.3795758	167.9053182	\N
4776	Sanma	237	VU	Vanuatu	SAM	\N	-15.4840017	166.9182097	\N
4774	Shefa	237	VU	Vanuatu	SEE	\N	32.805765	35.169971	\N
4777	Tafea	237	VU	Vanuatu	TAE	\N	-18.7237827	169.0645056	\N
4772	Torba	237	VU	Vanuatu	TOB	\N	37.07653	27.456573	\N
2044	Amazonas	239	VE	Venezuela	Z	state	-3.4168427	-65.8560646	\N
2050	Anzoátegui	239	VE	Venezuela	B	state	8.5913073	-63.9586111	\N
4856	Apure	239	VE	Venezuela	C	state	6.9269483	-68.5247149	\N
2047	Aragua	239	VE	Venezuela	D	state	10.0635758	-67.2847875	\N
2049	Barinas	239	VE	Venezuela	E	state	8.6231498	-70.2371045	\N
2039	Bolívar	239	VE	Venezuela	F	state	37.6144838	-93.4104749	\N
2040	Carabobo	239	VE	Venezuela	G	state	10.1176433	-68.0477509	\N
2034	Cojedes	239	VE	Venezuela	H	state	9.3816682	-68.3339275	\N
2051	Delta Amacuro	239	VE	Venezuela	Y	state	8.8499307	-61.1403196	\N
4855	Distrito Capital	239	VE	Venezuela	A	capital district	41.2614846	-95.9310807	\N
2035	Falcón	239	VE	Venezuela	I	state	11.1810674	-69.8597406	\N
2046	Federal Dependencies of Venezuela	239	VE	Venezuela	W	federal dependency	10.9377053	-65.3569573	\N
2045	Guárico	239	VE	Venezuela	J	state	8.7489309	-66.2367172	\N
2055	La Guaira	239	VE	Venezuela	X	state	29.3052268	-94.7913854	\N
2038	Lara	239	VE	Venezuela	K	state	33.9822165	-118.1322747	\N
2053	Mérida	239	VE	Venezuela	L	state	20.9673702	-89.5925857	\N
2037	Miranda	239	VE	Venezuela	M	state	42.3519383	-71.5290766	\N
2054	Monagas	239	VE	Venezuela	N	state	9.3241652	-63.0147578	\N
2052	Nueva Esparta	239	VE	Venezuela	O	state	10.9970723	-63.9113296	\N
2036	Portuguesa	239	VE	Venezuela	P	state	9.0943999	-69.097023	\N
2056	Sucre	239	VE	Venezuela	R	state	-19.035345	-65.2592128	\N
2048	Táchira	239	VE	Venezuela	S	state	7.9137001	-72.1416132	\N
2043	Trujillo	239	VE	Venezuela	T	state	36.6734343	-121.6287588	\N
2041	Yaracuy	239	VE	Venezuela	U	state	10.339389	-68.8108849	\N
2042	Zulia	239	VE	Venezuela	V	state	10.2910237	-72.1416132	\N
3794	An Giang	240	VN	Vietnam	44	\N	10.5215836	105.1258955	\N
3770	Bà Rịa-Vũng Tàu	240	VN	Vietnam	43	\N	10.5417397	107.2429976	\N
3815	Bắc Giang	240	VN	Vietnam	54	\N	21.2819921	106.1974769	\N
3822	Bắc Kạn	240	VN	Vietnam	53	\N	22.3032923	105.876004	\N
3804	Bạc Liêu	240	VN	Vietnam	55	\N	9.2940027	105.7215663	\N
3791	Bắc Ninh	240	VN	Vietnam	56	\N	21.121444	106.1110501	\N
3796	Bến Tre	240	VN	Vietnam	50	\N	10.2433556	106.375551	\N
3785	Bình Dương	240	VN	Vietnam	57	\N	11.3254024	106.477017	\N
3830	Bình Định	240	VN	Vietnam	31	\N	14.1665324	108.902683	\N
3797	Bình Phước	240	VN	Vietnam	58	\N	11.7511894	106.7234639	\N
3787	Bình Thuận	240	VN	Vietnam	40	\N	11.0903703	108.0720781	\N
3778	Cà Mau	240	VN	Vietnam	59	\N	9.1526728	105.1960795	\N
4925	Cần Thơ	240	VN	Vietnam	CT	\N	10.0341851	105.7225507	\N
3782	Cao Bằng	240	VN	Vietnam	04	\N	22.635689	106.2522143	\N
3806	Đà Nẵng	240	VN	Vietnam	DN	\N	16.0544068	108.2021667	\N
3829	Đắk Lắk	240	VN	Vietnam	33	\N	12.7100116	108.2377519	\N
3823	Đắk Nông	240	VN	Vietnam	72	\N	12.2646476	107.609806	\N
3773	Điện Biên	240	VN	Vietnam	71	\N	21.8042309	103.1076525	\N
3821	Đồng Nai	240	VN	Vietnam	39	\N	11.0686305	107.1675976	\N
3769	Đồng Tháp	240	VN	Vietnam	45	\N	10.4937989	105.6881788	\N
3813	Gia Lai	240	VN	Vietnam	30	\N	13.8078943	108.109375	\N
3779	Hà Giang	240	VN	Vietnam	03	\N	22.8025588	104.9784494	\N
3802	Hà Nam	240	VN	Vietnam	63	\N	20.5835196	105.92299	\N
3810	Hà Nội	240	VN	Vietnam	HN	\N	21.0277644	105.8341598	\N
3816	Hà Tĩnh	240	VN	Vietnam	23	\N	18.3559537	105.8877494	\N
3827	Hải Dương	240	VN	Vietnam	61	\N	20.9373413	106.3145542	\N
3783	Hải Phòng	240	VN	Vietnam	HP	\N	20.8449115	106.6880841	\N
3777	Hậu Giang	240	VN	Vietnam	73	\N	9.757898	105.6412527	\N
3811	Hồ Chí Minh	240	VN	Vietnam	SG	\N	10.8230989	106.6296638	\N
3799	Hòa Bình	240	VN	Vietnam	14	\N	20.6861265	105.3131185	\N
3768	Hưng Yên	240	VN	Vietnam	66	\N	20.8525711	106.0169971	\N
3793	Khánh Hòa	240	VN	Vietnam	34	\N	12.2585098	109.0526076	\N
3800	Kiên Giang	240	VN	Vietnam	47	\N	9.8249587	105.1258955	\N
3772	Kon Tum	240	VN	Vietnam	28	\N	14.3497403	108.0004606	\N
3825	Lai Châu	240	VN	Vietnam	01	\N	22.3862227	103.4702631	\N
3818	Lâm Đồng	240	VN	Vietnam	35	\N	11.5752791	108.1428669	\N
3792	Lạng Sơn	240	VN	Vietnam	09	\N	21.853708	106.761519	\N
3817	Lào Cai	240	VN	Vietnam	02	\N	22.4809431	103.9754959	\N
3808	Long An	240	VN	Vietnam	41	\N	10.5607168	106.6497623	\N
3789	Nam Định	240	VN	Vietnam	67	\N	20.4388225	106.1621053	\N
3780	Nghệ An	240	VN	Vietnam	22	\N	19.2342489	104.9200365	\N
3786	Ninh Bình	240	VN	Vietnam	18	\N	20.2506149	105.9744536	\N
3788	Ninh Thuận	240	VN	Vietnam	36	\N	11.6738767	108.8629572	\N
3801	Phú Thọ	240	VN	Vietnam	68	\N	21.268443	105.2045573	\N
3824	Phú Yên	240	VN	Vietnam	32	\N	13.0881861	109.0928764	\N
3809	Quảng Bình	240	VN	Vietnam	24	\N	17.6102715	106.3487474	\N
3776	Quảng Nam	240	VN	Vietnam	27	\N	15.5393538	108.019102	\N
3828	Quảng Ngãi	240	VN	Vietnam	29	\N	15.1213873	108.8044145	\N
3814	Quảng Ninh	240	VN	Vietnam	13	\N	21.006382	107.2925144	\N
3803	Quảng Trị	240	VN	Vietnam	25	\N	16.7403074	107.1854679	\N
3819	Sóc Trăng	240	VN	Vietnam	52	\N	9.602521	105.9739049	\N
3812	Sơn La	240	VN	Vietnam	05	\N	21.1022284	103.7289167	\N
3826	Tây Ninh	240	VN	Vietnam	37	\N	11.3351554	106.1098854	\N
3775	Thái Bình	240	VN	Vietnam	20	\N	20.4463471	106.3365828	\N
3807	Thái Nguyên	240	VN	Vietnam	69	\N	21.5671559	105.8252038	\N
3771	Thanh Hóa	240	VN	Vietnam	21	\N	19.806692	105.7851816	\N
3798	Thừa Thiên-Huế	240	VN	Vietnam	26	\N	16.467397	107.5905326	\N
3781	Tiền Giang	240	VN	Vietnam	46	\N	10.4493324	106.3420504	\N
3805	Trà Vinh	240	VN	Vietnam	51	\N	9.812741	106.2992912	\N
3795	Tuyên Quang	240	VN	Vietnam	07	\N	21.7767246	105.2280196	\N
3790	Vĩnh Long	240	VN	Vietnam	49	\N	10.239574	105.9571928	\N
3774	Vĩnh Phúc	240	VN	Vietnam	70	\N	21.3608805	105.5474373	\N
3784	Yên Bái	240	VN	Vietnam	06	\N	21.7167689	104.8985878	\N
5074	Saint Croix	242	VI	Virgin Islands (US)	SC	district	17.729352	-64.7343705	\N
5073	Saint John	242	VI	Virgin Islands (US)	SJ	district	18.3356169	-64.80028	\N
5072	Saint Thomas	242	VI	Virgin Islands (US)	ST	district	18.3428459	-65.077018	\N
1242	'Adan	245	YE	Yemen	AD	\N	12.8257481	44.7943804	\N
1250	'Amran	245	YE	Yemen	AM	\N	16.2569214	43.9436788	\N
1237	Abyan	245	YE	Yemen	AB	\N	13.6343413	46.0563212	\N
1240	Al Bayda'	245	YE	Yemen	BA	\N	14.3588662	45.4498065	\N
1241	Al Hudaydah	245	YE	Yemen	HU	\N	15.3053072	43.0194897	\N
1243	Al Jawf	245	YE	Yemen	JA	\N	16.7901819	45.2993862	\N
1251	Al Mahrah	245	YE	Yemen	MR	\N	16.5238423	51.6834275	\N
1235	Al Mahwit	245	YE	Yemen	MW	\N	15.3963229	43.5606946	\N
1246	Dhamar	245	YE	Yemen	DH	\N	14.7195344	44.2479015	\N
1238	Hadhramaut	245	YE	Yemen	HD	\N	16.9304135	49.3653149	\N
1244	Hajjah	245	YE	Yemen	HJ	\N	16.1180631	43.329466	\N
1233	Ibb	245	YE	Yemen	IB	\N	14.1415717	44.2479015	\N
1245	Lahij	245	YE	Yemen	LA	\N	13.1489588	44.8505495	\N
1234	Ma'rib	245	YE	Yemen	MA	\N	15.515888	45.4498065	\N
1248	Raymah	245	YE	Yemen	RA	\N	14.6277682	43.7142484	\N
1249	Saada	245	YE	Yemen	SD	\N	16.8476528	43.9436788	\N
1236	Sana'a	245	YE	Yemen	SN	\N	15.3168913	44.4748018	\N
1232	Sana'a	245	YE	Yemen	SA	\N	15.3694451	44.1910066	\N
1247	Shabwah	245	YE	Yemen	SH	\N	14.7546303	46.516262	\N
1239	Socotra	245	YE	Yemen	SU	\N	12.4634205	53.8237385	\N
1231	Ta'izz	245	YE	Yemen	TA	\N	13.5775886	44.0177989	\N
1986	Central Province	246	ZM	Zambia	02	\N	7.2564996	80.7214417	\N
1984	Copperbelt Province	246	ZM	Zambia	08	\N	-13.0570073	27.5495846	\N
1991	Eastern Province	246	ZM	Zambia	03	\N	23.1669688	49.3653149	\N
1987	Luapula Province	246	ZM	Zambia	04	\N	-11.564831	29.0459927	\N
1988	Lusaka Province	246	ZM	Zambia	09	\N	-15.3657129	29.2320784	\N
1989	Muchinga Province	246	ZM	Zambia	10	\N	-15.382193	28.26158	\N
1982	Northern Province	246	ZM	Zambia	05	\N	8.8855027	80.2767327	\N
1985	Northwestern Province	246	ZM	Zambia	06	\N	-13.0050258	24.9042208	\N
1990	Southern Province	246	ZM	Zambia	07	\N	6.237375	80.543845	\N
1983	Western Province	246	ZM	Zambia	01	\N	6.9016086	80.0087746	\N
1956	Bulawayo Province	247	ZW	Zimbabwe	BU	\N	-20.1489505	28.5331038	\N
1958	Harare Province	247	ZW	Zimbabwe	HA	\N	-17.8216288	31.0492259	\N
1959	Manicaland	247	ZW	Zimbabwe	MA	\N	-18.9216386	32.174605	\N
1955	Mashonaland Central Province	247	ZW	Zimbabwe	MC	\N	-16.7644295	31.0793705	\N
1951	Mashonaland East Province	247	ZW	Zimbabwe	ME	\N	-18.5871642	31.2626366	\N
1953	Mashonaland West Province	247	ZW	Zimbabwe	MW	\N	-17.4851029	29.7889248	\N
1960	Masvingo Province	247	ZW	Zimbabwe	MV	\N	-20.6241509	31.2626366	\N
1954	Matabeleland North Province	247	ZW	Zimbabwe	MN	\N	-18.5331566	27.5495846	\N
1952	Matabeleland South Province	247	ZW	Zimbabwe	MS	\N	-21.052337	29.0459927	\N
1957	Midlands Province	247	ZW	Zimbabwe	MI	\N	-19.0552009	29.6035495	\N
\.


--
-- Data for Name: Store; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Store" (id, "ownerId", name, tag, status, domain, address, "addressCoordinates", phone, order_email, language, currency, logo, banner, description, public, "createdAt", "updatedAt", "processingTime", "localPickup", "countryId", currency_symbol) FROM stdin;
\.


--
-- Data for Name: Tax; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Tax" (id, name, rate, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, email, "emailVerified", active, "avatarUrl", password, "passwordUpdatedAt", plan, "hashedRefreshToken", prefs, "magicSecret", "magicSecretExpiry", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Video" (id, "userId", "productId", url, description, "sortOrder", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: _CategoryToProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_CategoryToProduct" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _CategoryToStore; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_CategoryToStore" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _CollectionToProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_CollectionToProduct" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _PricingRuleToProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_PricingRuleToProduct" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _RelatedProducts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_RelatedProducts" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
fea86f99-c404-4437-9906-f0e77f322eb2	6b194dbb048df9e6f261ce5cb2dfd6d8a3ae9de26b07b680eefa968777023056	2024-09-22 17:27:22.14623+00	20230106222303_currency	\N	\N	2024-09-22 17:27:22.140156+00	1
e54c220d-1dc3-4460-8537-42c8deb5d66b	a4c121674f31907c0741b895111de497010e0c3472422897d4d8b1c5e4698776	2024-09-22 17:27:21.822374+00	20220807153157_init	\N	\N	2024-09-22 17:27:21.709629+00	1
ed75136e-4ce5-4679-8a34-197fb3c2525b	67fe523861c3df66b978dd40b31a5090e100fc804ae8a0fd9ba8284bf6dd9879	2024-09-22 17:27:21.943858+00	20221022162942_updates	\N	\N	2024-09-22 17:27:21.936155+00	1
32671b36-6f40-4515-81b3-556e63d00ef2	4700d69e46688c732c4c83dde46a490bc613c08e78505090bcfba92b3cfa3473	2024-09-22 17:27:21.834059+00	20220807155136_init	\N	\N	2024-09-22 17:27:21.824498+00	1
05676016-6500-4e72-8bec-2c7c6d96b2d7	902bea616bfb71f0d1cc713e8289ddf51293d9e1170db49b120a9a575d4e7d83	2024-09-22 17:27:21.846062+00	20220814034639_init	\N	\N	2024-09-22 17:27:21.835919+00	1
a509e8c5-6026-447b-a852-65bc2863f367	9c761836d5ac8d178ee795803f19a6e0efdfa54238a25f4aa0e76a134b693dc3	2024-09-22 17:27:22.037829+00	20221231225644_cart	\N	\N	2024-09-22 17:27:22.018742+00	1
9fdc9b26-0328-41d6-b5be-8f645a7b8943	96b7a69368404018e0411396dadc06fc4ead943a925fc7b91635c8c2baa4f410	2024-09-22 17:27:21.854181+00	20220814050133_init	\N	\N	2024-09-22 17:27:21.848418+00	1
ab765c0b-4533-4a00-aec5-b7be957219a5	c20ebf01a84f840d1c924a4f8eb179465b4758040e17288450010a9c0149a5ba	2024-09-22 17:27:21.951752+00	20221022163026_updates	\N	\N	2024-09-22 17:27:21.945746+00	1
a5a7df83-72db-4c66-a1d8-7e0804ae6941	a6d418048a277e03165a4e3bc1571cb6b9d564d76ca8aea2220b85f9f37d4128	2024-09-22 17:27:21.862382+00	20220815001143_init	\N	\N	2024-09-22 17:27:21.856034+00	1
c4235d92-a8b0-40c7-b7f4-63af18ad44d6	575f2ca5820177f6237747f62de30ad3c616f88fc85bead1e09af6bacd423ed5	2024-09-22 17:27:21.87079+00	20220907175936_init	\N	\N	2024-09-22 17:27:21.86428+00	1
2daa46a8-66c6-487b-a9a9-f9d6dc648156	3035c36cd3fc9f549c05301995f1f15e67b296f58268040416df3f907c8f244f	2024-09-22 17:27:21.878806+00	20220924224818_update_field	\N	\N	2024-09-22 17:27:21.872997+00	1
59ee17fb-75aa-4ea6-be1f-fb01a68d09f9	e23aab37b8a7244ac9bb8964c4a2dc4541b6e9402bbf5743873bd2fd0c248088	2024-09-22 17:27:21.960864+00	20221023190509_country_updates	\N	\N	2024-09-22 17:27:21.953694+00	1
c772f9b9-bc6c-4561-ac1b-cfc86b681524	66a7bf4747ab268d9aa9b4367ee5c6c68c488143599fe5c71ee614f8e1f7eba5	2024-09-22 17:27:21.886455+00	20220925000609_change_type	\N	\N	2024-09-22 17:27:21.880624+00	1
e4b2bce7-69c5-4ddb-ab2e-80125ba1775a	46c6bee440cc19c98e5fe450c0d4029fc777dc604bf5cda8ebd7f9dd2383e996	2024-09-22 17:27:21.894107+00	20220925011042_change_types	\N	\N	2024-09-22 17:27:21.888329+00	1
e63a3752-47df-4342-bbb6-7192aecc3168	e1e18da3dbaafb246322c908181b4cf75ae00638d6443a4315980369c046bd7e	2024-09-22 17:27:22.089656+00	20230101113919_cart	\N	\N	2024-09-22 17:27:22.083882+00	1
059904a1-9720-40b2-9436-e39e36b4b2c0	8b5ac03fb85cf867dbc6b0e6dd5fbc18524b2b0718803d735afded40500d6e1c	2024-09-22 17:27:21.901794+00	20220925012253_change_types	\N	\N	2024-09-22 17:27:21.896192+00	1
6c15b890-318a-41f2-9f33-f0b95800aca8	1dbd67f038ebc358c182f42aa5c5c164150509c30d920bf79a876bdac3b301b6	2024-09-22 17:27:21.970289+00	20221030233743_constraint	\N	\N	2024-09-22 17:27:21.962887+00	1
d1786929-9af0-44ce-904c-3915c7ee2059	2161fceb7168bd5ae5c2a26b9a75770d1f2aec26e48633be04d061a4e71d8a4a	2024-09-22 17:27:21.90991+00	20220927002249_fixed_type	\N	\N	2024-09-22 17:27:21.903678+00	1
b5f9ad0d-3218-40da-bf4e-be0d96e63999	4ba02b84d5da86cb554f5660accaba87f2c915c3d4c1f3b51bd06f565e719fd7	2024-09-22 17:27:21.917435+00	20221002150738_add_short_url	\N	\N	2024-09-22 17:27:21.911903+00	1
78f0f59f-290d-40d0-9cfc-fdb67172619f	231c1d32a40995b4fe83e18d03604a271b6cd6c3c97f286a190687641dd27a83	2024-09-22 17:27:22.045782+00	20221231225741_cart	\N	\N	2024-09-22 17:27:22.040015+00	1
7f154c3e-e9a1-4272-a28e-e0ed80163bcb	9989e4acac0b562a7136c445f67c45a9b6738cc094203ebc8a7a527f760db8a0	2024-09-22 17:27:21.926218+00	20221002174831_add_slug	\N	\N	2024-09-22 17:27:21.919633+00	1
e3a83426-5da1-4043-b69d-d5a6bc757fcb	5693679b47a510a5bc946dbf7c2995776d82a5a59e2698c2e03b2bd4d3f42cf0	2024-09-22 17:27:21.978827+00	20221113145714_opengraph_image	\N	\N	2024-09-22 17:27:21.972435+00	1
ae9cbb09-1b0d-41ed-b93c-6f14457f8f3f	f560dca6cd7282bd6f4eaf6cfa3df10a34a5cb632ddd6bcec97bf3db705e2701	2024-09-22 17:27:21.934124+00	20221002174956_add_slug	\N	\N	2024-09-22 17:27:21.92815+00	1
0176c017-f34b-47ab-825e-0ba387f11c84	4ba02b84d5da86cb554f5660accaba87f2c915c3d4c1f3b51bd06f565e719fd7	2024-09-22 17:27:21.986647+00	20221113150435_short_url	\N	\N	2024-09-22 17:27:21.980627+00	1
b3592870-522b-4fb3-9d37-f965376e5fcf	c555d5c9aa07d78618268e752a0673e3cc8a499932d08876ba17937f33cd17fa	2024-09-22 17:27:21.997931+00	20221113170432_follows	\N	\N	2024-09-22 17:27:21.988993+00	1
4d7fac1f-9d8f-4fbd-a9e8-c8aa9aaa8c76	20fe798bc82779b769d0065e301a20b506c40caf60da9118a504fb518036f4d9	2024-09-22 17:27:22.054507+00	20230101014936_cart	\N	\N	2024-09-22 17:27:22.047992+00	1
1df55c41-c696-47e8-bf5f-5d4fa02865e8	ecc51730bb6f35f7ff397b0ccde47540c3afb8673805321c84c5663a88665ea4	2024-09-22 17:27:22.007438+00	20221218143956_follows_new	\N	\N	2024-09-22 17:27:22.000129+00	1
e8658369-eb45-4a3c-9993-c61d9cffa7a8	f377aa297d80f1a083823bffc55f2e2b55f32a39076ae0e8cd304e9199e4de96	2024-09-22 17:27:22.016772+00	20221218144915_follows	\N	\N	2024-09-22 17:27:22.009742+00	1
9cd5993c-6320-491d-a64d-c08ce4e44af8	d5540e9399499645af4bf3826d51a584868a0f84ef815ff8a7f3bdf2baf1e908	2024-09-22 17:27:22.12203+00	20230105173748_currency	\N	\N	2024-09-22 17:27:22.116221+00	1
85350445-b550-4866-be3c-ff883de97528	709e800e5ecfdcca15dd1ac90029399b13034139be30648f65d2c12fab4f72db	2024-09-22 17:27:22.062652+00	20230101110505_cart	\N	\N	2024-09-22 17:27:22.056748+00	1
92969a64-5422-4f42-aebc-be9bb72b396a	5ae759e22b6e0a752b6aa25845ee528076147d8c0642f5b1e67fa0569c797c9b	2024-09-22 17:27:22.097813+00	20230105164738_currency	\N	\N	2024-09-22 17:27:22.091649+00	1
1c567e9e-77d2-48bf-a1d6-35518b4d114c	16d49ddf0e62652406df50fbdc6a59957050cae2522d387d146404834cabc34a	2024-09-22 17:27:22.072591+00	20230101112849_cart	\N	\N	2024-09-22 17:27:22.064483+00	1
0af8a843-9ec8-41d2-852b-cb39732acbee	37cd18f582729eb685c53d2836a844e271700ce7a6eaa9e581cfea47035b2a9f	2024-09-22 17:27:22.081787+00	20230101113054_cart	\N	\N	2024-09-22 17:27:22.074806+00	1
8b54e11f-f6e6-4365-a0b7-6f14d592554f	ae96dd2ee245d6c81735201404e6e78a2de04c138dff92fd29cb842246c467ae	2024-09-22 17:27:22.105816+00	20230105164751_currency	\N	\N	2024-09-22 17:27:22.09974+00	1
0655e4e5-7dbc-49b9-b492-8506b21942d4	023eb6acd86e1a9a9cf7b5d942fb217a2739a029f5fba0262b80e0fdc37bbf82	2024-09-22 17:27:22.138145+00	20230105180708_currency	\N	\N	2024-09-22 17:27:22.132436+00	1
6ca9bc63-69ae-4d83-b3ff-9f6cb67a9e8e	a706bb776f77b7f4f292d50bc437efffc883e98dc1a77bf36734c23760cd53e7	2024-09-22 17:27:22.114253+00	20230105170945_currency	\N	\N	2024-09-22 17:27:22.108085+00	1
b2fb6874-d50c-420e-9c11-ccd3bdaaca12	fc674830383ce17add9f7cb89f3cff72307b83918dbe51b56e22ce6e59c73ae2	2024-09-22 17:27:22.130333+00	20230105180656_currency	\N	\N	2024-09-22 17:27:22.124179+00	1
1523f350-cfe5-4e30-8e3f-a55970b901e4	5c043be5f5015f89f2601e2b3793e0f0e9fae0d94e277be92b876346722bfcc4	2024-09-22 17:27:22.154357+00	20230106222316_currency	\N	\N	2024-09-22 17:27:22.148336+00	1
c8f8d170-a703-4f81-9f95-79c72ea50e47	f690d4b182b41e55b0c44127b401dc6b3d9862cb3f5d33e4b914bb40a2ec1fd8	2024-09-22 17:27:22.162213+00	20230225194606_cart_is_selected	\N	\N	2024-09-22 17:27:22.156212+00	1
c9829261-f309-4a79-96bd-0a10ed099e72	04bb5acd8dafe7af4bcfc0297fa3aa6f5ac8fb66eb03dd2e8a251f3768a1db6a	2024-09-22 17:27:22.17003+00	20230227223739_removed_is_selected	\N	\N	2024-09-22 17:27:22.164079+00	1
\.


--
-- Name: Address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Address_id_seq"', 1, false);


--
-- Name: Brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Brand_id_seq"', 1, false);


--
-- Name: CartItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CartItem_id_seq"', 1, false);


--
-- Name: Cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cart_id_seq"', 1, false);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 135, true);


--
-- Name: Collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Collection_id_seq"', 1, false);


--
-- Name: Country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Country_id_seq"', 1, false);


--
-- Name: DeliveryZone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."DeliveryZone_id_seq"', 1, false);


--
-- Name: FulfillmentService_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FulfillmentService_id_seq"', 1, false);


--
-- Name: GiftWrapOption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."GiftWrapOption_id_seq"', 1, false);


--
-- Name: Image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Image_id_seq"', 1, false);


--
-- Name: LineItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."LineItem_id_seq"', 1, false);


--
-- Name: Location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Location_id_seq"', 1, false);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1, false);


--
-- Name: PricingRule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PricingRule_id_seq"', 1, false);


--
-- Name: ProductOption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductOption_id_seq"', 1, false);


--
-- Name: ProductVariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductVariant_id_seq"', 1, false);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 1, false);


--
-- Name: ShippingRate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ShippingRate_id_seq"', 1, false);


--
-- Name: ShippingZone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ShippingZone_id_seq"', 1, false);


--
-- Name: State_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."State_id_seq"', 1, false);


--
-- Name: Store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Store_id_seq"', 1, false);


--
-- Name: Tax_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tax_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: Video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Video_id_seq"', 1, false);


--
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- Name: Brand Brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);


--
-- Name: CartItem CartItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_pkey" PRIMARY KEY (id);


--
-- Name: Cart Cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Collection Collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Collection"
    ADD CONSTRAINT "Collection_pkey" PRIMARY KEY (id);


--
-- Name: Country Country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Country"
    ADD CONSTRAINT "Country_pkey" PRIMARY KEY (id);


--
-- Name: DeliveryZone DeliveryZone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeliveryZone"
    ADD CONSTRAINT "DeliveryZone_pkey" PRIMARY KEY (id);


--
-- Name: Follows Follows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Follows"
    ADD CONSTRAINT "Follows_pkey" PRIMARY KEY ("followerId", "followingId");


--
-- Name: FulfillmentService FulfillmentService_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FulfillmentService"
    ADD CONSTRAINT "FulfillmentService_pkey" PRIMARY KEY (id);


--
-- Name: GiftWrapOption GiftWrapOption_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GiftWrapOption"
    ADD CONSTRAINT "GiftWrapOption_pkey" PRIMARY KEY (id);


--
-- Name: Image Image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_pkey" PRIMARY KEY (id);


--
-- Name: LineItem LineItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LineItem"
    ADD CONSTRAINT "LineItem_pkey" PRIMARY KEY (id);


--
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: PricingRule PricingRule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PricingRule"
    ADD CONSTRAINT "PricingRule_pkey" PRIMARY KEY (id);


--
-- Name: ProductOption ProductOption_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductOption"
    ADD CONSTRAINT "ProductOption_pkey" PRIMARY KEY (id);


--
-- Name: ProductVariant ProductVariant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: ShippingRate ShippingRate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingRate"
    ADD CONSTRAINT "ShippingRate_pkey" PRIMARY KEY (id);


--
-- Name: ShippingZone ShippingZone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingZone"
    ADD CONSTRAINT "ShippingZone_pkey" PRIMARY KEY (id);


--
-- Name: State State_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State"
    ADD CONSTRAINT "State_pkey" PRIMARY KEY (id);


--
-- Name: Store Store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_pkey" PRIMARY KEY (id);


--
-- Name: Tax Tax_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tax"
    ADD CONSTRAINT "Tax_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Video Video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video"
    ADD CONSTRAINT "Video_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: PricingRule_code_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "PricingRule_code_key" ON public."PricingRule" USING btree (code);


--
-- Name: Product_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Product_slug_key" ON public."Product" USING btree (slug);


--
-- Name: Store_tag_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Store_tag_key" ON public."Store" USING btree (tag);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: _CategoryToProduct_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_CategoryToProduct_AB_unique" ON public."_CategoryToProduct" USING btree ("A", "B");


--
-- Name: _CategoryToProduct_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_CategoryToProduct_B_index" ON public."_CategoryToProduct" USING btree ("B");


--
-- Name: _CategoryToStore_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_CategoryToStore_AB_unique" ON public."_CategoryToStore" USING btree ("A", "B");


--
-- Name: _CategoryToStore_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_CategoryToStore_B_index" ON public."_CategoryToStore" USING btree ("B");


--
-- Name: _CollectionToProduct_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_CollectionToProduct_AB_unique" ON public."_CollectionToProduct" USING btree ("A", "B");


--
-- Name: _CollectionToProduct_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_CollectionToProduct_B_index" ON public."_CollectionToProduct" USING btree ("B");


--
-- Name: _PricingRuleToProduct_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_PricingRuleToProduct_AB_unique" ON public."_PricingRuleToProduct" USING btree ("A", "B");


--
-- Name: _PricingRuleToProduct_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_PricingRuleToProduct_B_index" ON public."_PricingRuleToProduct" USING btree ("B");


--
-- Name: _RelatedProducts_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_RelatedProducts_AB_unique" ON public."_RelatedProducts" USING btree ("A", "B");


--
-- Name: _RelatedProducts_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_RelatedProducts_B_index" ON public."_RelatedProducts" USING btree ("B");


--
-- Name: Address Address_countryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES public."Country"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Address Address_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CartItem CartItem_cartId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES public."Cart"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CartItem CartItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CartItem CartItem_variantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_variantId_fkey" FOREIGN KEY ("variantId") REFERENCES public."ProductVariant"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Cart Cart_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Category Category_parentCategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_parentCategoryId_fkey" FOREIGN KEY ("parentCategoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Collection Collection_pricingRuleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Collection"
    ADD CONSTRAINT "Collection_pricingRuleId_fkey" FOREIGN KEY ("pricingRuleId") REFERENCES public."PricingRule"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DeliveryZone DeliveryZone_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeliveryZone"
    ADD CONSTRAINT "DeliveryZone_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Follows Follows_followerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Follows"
    ADD CONSTRAINT "Follows_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Follows Follows_followingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Follows"
    ADD CONSTRAINT "Follows_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: FulfillmentService FulfillmentService_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FulfillmentService"
    ADD CONSTRAINT "FulfillmentService_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GiftWrapOption GiftWrapOption_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GiftWrapOption"
    ADD CONSTRAINT "GiftWrapOption_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Image Image_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Image Image_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LineItem LineItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LineItem"
    ADD CONSTRAINT "LineItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Location Location_countryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES public."Country"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Location Location_shippingZoneId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_shippingZoneId_fkey" FOREIGN KEY ("shippingZoneId") REFERENCES public."ShippingZone"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_billingAddressId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_billingAddressId_fkey" FOREIGN KEY ("billingAddressId") REFERENCES public."Address"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_shippingAddressId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_shippingAddressId_fkey" FOREIGN KEY ("shippingAddressId") REFERENCES public."Address"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PricingRule PricingRule_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PricingRule"
    ADD CONSTRAINT "PricingRule_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ProductOption ProductOption_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductOption"
    ADD CONSTRAINT "ProductOption_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductVariant ProductVariant_imageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES public."Image"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ProductVariant ProductVariant_pricingRuleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_pricingRuleId_fkey" FOREIGN KEY ("pricingRuleId") REFERENCES public."PricingRule"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ProductVariant ProductVariant_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductVariant ProductVariant_videoId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_videoId_fkey" FOREIGN KEY ("videoId") REFERENCES public."Video"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Product Product_brandId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Product Product_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Product Product_taxId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_taxId_fkey" FOREIGN KEY ("taxId") REFERENCES public."Tax"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ShippingRate ShippingRate_shippingZoneId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingRate"
    ADD CONSTRAINT "ShippingRate_shippingZoneId_fkey" FOREIGN KEY ("shippingZoneId") REFERENCES public."ShippingZone"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ShippingZone ShippingZone_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingZone"
    ADD CONSTRAINT "ShippingZone_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: State State_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State"
    ADD CONSTRAINT "State_country_id_fkey" FOREIGN KEY (country_id) REFERENCES public."Country"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: State State_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State"
    ADD CONSTRAINT "State_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Store Store_countryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES public."Country"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Store Store_ownerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Video Video_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video"
    ADD CONSTRAINT "Video_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Video Video_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Video"
    ADD CONSTRAINT "Video_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CategoryToProduct _CategoryToProduct_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CategoryToProduct"
    ADD CONSTRAINT "_CategoryToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CategoryToProduct _CategoryToProduct_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CategoryToProduct"
    ADD CONSTRAINT "_CategoryToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CategoryToStore _CategoryToStore_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CategoryToStore"
    ADD CONSTRAINT "_CategoryToStore_A_fkey" FOREIGN KEY ("A") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CategoryToStore _CategoryToStore_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CategoryToStore"
    ADD CONSTRAINT "_CategoryToStore_B_fkey" FOREIGN KEY ("B") REFERENCES public."Store"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CollectionToProduct _CollectionToProduct_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CollectionToProduct"
    ADD CONSTRAINT "_CollectionToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES public."Collection"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CollectionToProduct _CollectionToProduct_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CollectionToProduct"
    ADD CONSTRAINT "_CollectionToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _PricingRuleToProduct _PricingRuleToProduct_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_PricingRuleToProduct"
    ADD CONSTRAINT "_PricingRuleToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES public."PricingRule"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _PricingRuleToProduct _PricingRuleToProduct_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_PricingRuleToProduct"
    ADD CONSTRAINT "_PricingRuleToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _RelatedProducts _RelatedProducts_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_RelatedProducts"
    ADD CONSTRAINT "_RelatedProducts_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _RelatedProducts _RelatedProducts_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_RelatedProducts"
    ADD CONSTRAINT "_RelatedProducts_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

