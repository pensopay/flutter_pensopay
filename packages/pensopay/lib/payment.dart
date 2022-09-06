class Payment {
  final int id;
  final String orderId;
  final String type;
  final int amount;
  final int captured;
  final int refunded;
  final String currency;
  final String state;
  final String facilitator;
  final String reference;
  final bool testmode;
  final bool autocapture;
  final String? link;
  final String? callbackUrl;
  final String successUrl;
  final String cancelUrl;
  final List<Order> order;
  final List<dynamic> variables;
  final String expiresAt;
  final String createdAt;
  final String updatedAt;

  Payment({
    required this.id,
    required this.orderId,
    required this.type,
    required this.amount,
    required this.captured,
    required this.refunded,
    required this.currency,
    required this.state,
    required this.facilitator,
    required this.reference,
    required this.testmode,
    required this.autocapture,
    required this.link,
    required this.callbackUrl,
    required this.successUrl,
    required this.cancelUrl,
    required this.order,
    required this.variables,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Mapping from map to Payment.
  factory Payment.fromMap(Map map) {
    return Payment(
      id: map['id'] as int,
      orderId: map['order_id'] as String,
      type: map['type'] as String,
      amount: map['amount'] as int,
      captured: map['captured'] as int,
      refunded: map['refunded'] as int,
      currency: map['currency'] as String,
      state: map['state'] as String,
      facilitator: map['facilitator'] as String,
      reference: map['reference'] as String,
      testmode: map['testmode'] as bool,
      autocapture: map['autocapture'] as bool,
      link: map['link'] as String?,
      callbackUrl: map['callback_url'] as String?,
      successUrl: map['success_url'] as String,
      cancelUrl: map['cancel_url'] as String,
      order: (map['order'] as List<dynamic>)
          .map((entry) => Order.fromMap(entry))
          .toList(),
      variables: map['variables'] as List<dynamic>,
      expiresAt: map['expires_at'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}

class Order {
  final BillingAddress? billingAddress;
  final ShippingAddress? shippingAddress;
  final Basket? basket;
  final Shipping? shipping;

  Order(
      {this.billingAddress, this.shippingAddress, this.basket, this.shipping});

  factory Order.fromMap(Map map) {
    return Order(
      billingAddress: map['billing_address'] as BillingAddress?,
      shippingAddress: map['shipping_address'] as ShippingAddress?,
      basket: map['basket'] as Basket?,
      shipping: map['shipping'] as Shipping?,
    );
  }
}

class BillingAddress {
  final String? name;
  final String? address;
  final String? zipcode;
  final String? city;
  final String? email;
  final String? phoneNumber;
  final String? mobileNumber;

  BillingAddress({
    this.name,
    this.address,
    this.zipcode,
    this.city,
    this.email,
    this.phoneNumber,
    this.mobileNumber,
  });

  factory BillingAddress.fromMap(Map map) {
    return BillingAddress(
      name: map['name'] as String?,
      address: map['address'] as String?,
      zipcode: map['zipcode'] as String?,
      city: map['city'] as String?,
      email: map['email'] as String?,
      phoneNumber: map['phone_number'] as String?,
      mobileNumber: map['mobile_number'] as String?,
    );
  }
}

class ShippingAddress {
  final String? name;
  final String? address;
  final String? zipcode;
  final String? city;
  final String? email;
  final String? phoneNumber;
  final String? mobileNumber;

  ShippingAddress({
    this.name,
    this.address,
    this.zipcode,
    this.city,
    this.email,
    this.phoneNumber,
    this.mobileNumber,
  });

  factory ShippingAddress.fromMap(Map map) {
    return ShippingAddress(
      name: map['name'] as String?,
      address: map['address'] as String?,
      zipcode: map['zipcode'] as String?,
      city: map['city'] as String?,
      email: map['email'] as String?,
      phoneNumber: map['phone_number'] as String?,
      mobileNumber: map['mobile_number'] as String?,
    );
  }
}

class Basket {
  final int qty;
  final String sku;
  final double vat;
  final String name;
  final int price;

  Basket({
    required this.qty,
    required this.sku,
    required this.vat,
    required this.name,
    required this.price,
  });

  factory Basket.fromMap(Map map) {
    return Basket(
      qty: map['qty'] as int,
      sku: map['sku'] as String,
      vat: map['vat'] as double,
      name: map['name'] as String,
      price: map['price'] as int,
    );
  }
}

class Shipping {
  final int amount;
  final String method;
  final String company;
  final double vatRate;

  Shipping({
    required this.amount,
    required this.method,
    required this.company,
    required this.vatRate,
  });

  factory Shipping.fromMap(Map map) {
    return Shipping(
      amount: map['amount'] as int,
      method: map['method'] as String,
      company: map['company'] as String,
      vatRate: map['vatRate'] as double,
    );
  }
}
