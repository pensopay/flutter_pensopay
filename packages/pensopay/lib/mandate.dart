import 'dart:collection';

class Mandate {
  final int id;
  final int subscription_id;
  final String mandate_id;
  final String state;
  final String facilitator;
  final String? callback_url;
  final String link;
  final String reference;
  final String created_at;
  final String updated_at;

  Mandate({
    required this.id,
    required this.subscription_id,
    required this.mandate_id,
    required this.state,
    required this.facilitator,
    required this.callback_url,
    required this.link,
    required this.reference,
    required this.created_at,
    required this.updated_at,
  });

  factory Mandate.fromMap(Map map) {
    return Mandate(
      id: map['id'] as int,
      subscription_id: map['subscription_id'] as int,
      mandate_id: map['mandate_id'] as String,
      state: map['state'] as String,
      facilitator: map['facilitator'] as String,
      callback_url: map['callback_url'] as String?,
      link: map['link'] as String,
      reference: map['reference'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }
}
