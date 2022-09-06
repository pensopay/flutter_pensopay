class Mandate {
  final int id;
  final int subscriptionId;
  final String mandateId;
  final String state;
  final String facilitator;
  final String? callbackUrl;
  final String link;
  final String reference;
  final String createdAt;
  final String updatedAt;

  Mandate({
    required this.id,
    required this.subscriptionId,
    required this.mandateId,
    required this.state,
    required this.facilitator,
    required this.callbackUrl,
    required this.link,
    required this.reference,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Mapping from map to Mandate.
  factory Mandate.fromMap(Map map) {
    return Mandate(
      id: map['id'] as int,
      subscriptionId: map['subscription_id'] as int,
      mandateId: map['mandate_id'] as String,
      state: map['state'] as String,
      facilitator: map['facilitator'] as String,
      callbackUrl: map['callback_url'] as String?,
      link: map['link'] as String,
      reference: map['reference'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
