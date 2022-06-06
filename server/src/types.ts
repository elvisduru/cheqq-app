export type LineItemAttributes = {
  dimension: string;
  value: string;
};

export type AdditionalFee = {
  name: string;
  price: number;
  currency: string;
};

export type Return = {
  creationDate: Date;
  returnedBy: Actors;
  quantity: number;
  reason: ReturnReason;
  reasonText: string;
};

export type Cancellation = {
  creationDate: Date;
  cancelledBy: Actors;
  quantity: number;
  reason: CancelReason;
  reasonText: string;
};

enum CancelReason {
  invalidBillingAddress,
  noInventory,
  priceError,
  undeliverableShippingAddress,
  customerCanceled,
  customerInitiatedCancel,
  customerSupportRequested,
  invalidCoupon,
  malformedShippingAddress,
  merchantDidNotShipOnTimem,
  orderTimeout,
  other,
  paymentAbuse,
  paymentDeclined,
  returnRefundAbuse,
  shippingPriceError,
  taxError,
  unsupportedPoBoxAddress,
  failedToCaptureFunds,
}

enum ReturnReason {
  customerDiscretionaryReturn,
  customerInitiatedMerchantCance,
  deliveredTooLate,
  expiredItem,
  invalidCoupon,
  malformedShippingAddress,
  other,
  productArrivedDamaged,
  productNotAsDescribed,
  qualityNotAsExpected,
  undeliverableShippingAddress,
  unsupportedPoBoxAddress,
  wrongProductShipped,
}

enum Actors {
  CUSTOMER,
  MERCHANT,
}
