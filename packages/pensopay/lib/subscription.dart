import 'dart:collection';

class Subscription {
  final int id;
  final String subscriptionId;
  final int amount;
  final String currency;
  final String state;
  final String description;
  final String? callbackUrl;
  final Map<String, dynamic>? variables;
  final String createdAt;
  final String updatedAt;

  Subscription({
    required this.id,
    required this.subscriptionId,
    required this.amount,
    required this.currency,
    required this.state,
    required this.description,
    required this.callbackUrl,
    required this.variables,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Mapping from map to Subscription.
  factory Subscription.fromMap(Map map) {
    return Subscription(
      id: map['id'] as int,
      subscriptionId: map['subscription_id'] as String,
      amount: map['amount'] as int,
      currency: map['currency'] as String,
      state: map['state'] as String,
      description: map['description'] as String,
      callbackUrl: map['callback_url'] as String?,
      variables: map['variables'] as HashMap<String, dynamic>?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
