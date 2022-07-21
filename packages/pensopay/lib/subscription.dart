import 'dart:collection';

class Subscription {
  final int id;
  final String subscription_id;
  final int amount;
  final String currency;
  final String state;
  final String description;
  final String? callback_url;
  final Map<String, dynamic>? variables;
  final String created_at;
  final String updated_at;

  Subscription({
    required this.id,
    required this.subscription_id,
    required this.amount,
    required this.currency,
    required this.state,
    required this.description,
    required this.callback_url,
    required this.variables,
    required this.created_at,
    required this.updated_at,
  });

  factory Subscription.fromMap(Map map) {
    return Subscription(
      id: map['id'] as int,
      subscription_id: map['subscription_id'] as String,
      amount: map['amount'] as int,
      currency: map['currency'] as String,
      state: map['state'] as String,
      description: map['description'] as String,
      callback_url: map['callback_url'] as String?,
      variables: map['variables'] as HashMap<String, dynamic>?,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }
}
