import 'package:flutter/services.dart';
import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/mandate.dart';
import 'package:flutter_pensopay/payment.dart';

import 'subscription.dart';

/// Pensopay class and method declaration.
class Pensopay {
  /// Pensopay MethodChannel.
  static const MethodChannel _channel = MethodChannel('pensopay');

  /// Initializes the Pensopay client.
  static Future<void> init({required String apiKey}) async {
    _channel.invokeMethod('init', {'api-key': apiKey});
  }

  /// Creates a new Pensopay Payment.
  static Future<Payment> createPayment(
      {required String currency,
      required String orderId,
      required int amount,
      required String facilitator,
      String? callbackUrl,
      bool autocapture = false,
      bool testmode = false,
      bool sheet = true}) async {
    try {
      final result = await _channel.invokeMethod(
        'createPayment',
        <String, dynamic>{
          'currency': currency,
          'order_id': orderId,
          'amount': amount,
          'callback_url': callbackUrl,
          'facilitator': facilitator,
          'autocapture': autocapture,
          'testmode': testmode,
          'sheet': sheet,
        },
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Fetches an existing Pensopay Payment.
  static Future<Payment> getPayment({required int paymentId}) async {
    try {
      final result = await _channel.invokeMethod(
        'getPayment',
        <String, dynamic>{'payment_id': paymentId},
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Captures a Pensopay Payment.
  static Future<Payment> capturePayment(
      {required int paymentId, int? amount}) async {
    try {
      final result = await _channel.invokeMethod(
        'capturePayment',
        <String, dynamic>{'payment_id': paymentId, 'amount': amount},
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Refunds a Pensopay Payment.
  static Future<Payment> refundPayment(
      {required int paymentId, int? amount}) async {
    try {
      final result = await _channel.invokeMethod(
        'refundPayment',
        <String, dynamic>{'payment_id': paymentId, 'amount': amount},
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Cancels a Pensopay Payment.
  static Future<Payment> cancelPayment({required int paymentId}) async {
    try {
      final result = await _channel.invokeMethod(
        'cancelPayment',
        <String, dynamic>{'payment_id': paymentId},
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Anonymizes a Pensopay Payment.
  static Future<Payment> anonymizePayment({required int paymentId}) async {
    try {
      final result = await _channel.invokeMethod(
        'anonymizePayment',
        <String, dynamic>{'payment_id': paymentId},
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Creates a new Pensopay Subscription.
  static Future<Subscription> createSubscription(
      {required String subscriptionId,
      required int amount,
      required String currency,
      required String description,
      String? callbackUrl}) async {
    try {
      final result = await _channel.invokeMethod(
        'createSubscription',
        <String, dynamic>{
          'subscription_id': subscriptionId,
          'amount': amount,
          'currency': currency,
          'description': description,
          'callback_url': callbackUrl,
        },
      );

      return Subscription.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Fetches a Pensopay Subscription.
  static Future<Subscription> getSubscription({required int id}) async {
    try {
      final result = await _channel.invokeMethod(
        'getSubscription',
        <String, dynamic>{
          'id': id,
        },
      );

      return Subscription.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Cancels a Pensopay Subscription.
  static Future<Subscription> cancelSubscription({required int id}) async {
    try {
      final result = await _channel.invokeMethod(
        'cancelSubscription',
        <String, dynamic>{
          'id': id,
        },
      );

      return Subscription.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Updates a Pensopay Subscription.
  static Future<Subscription> updateSubscription(
      {required int id,
      String? subscriptionId,
      int? amount,
      String? currency,
      String? description,
      String? callbackUrl}) async {
    try {
      final result = await _channel.invokeMethod(
        'updateSubscription',
        <String, dynamic>{
          'id': id,
          'subscription_id': subscriptionId,
          'amount': amount,
          'currency': currency,
          'description': description,
          'callback_url': callbackUrl,
        },
      );

      return Subscription.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Creates a new Pensopay Subscription Payment.
  static Future<Payment> createSubscriptionPayment({
    required int subscriptionId,
    required String currency,
    required String orderId,
    required int amount,
    String? callbackUrl,
    bool testmode = false,
  }) async {
    try {
      final result = await _channel.invokeMethod(
        'recurringSubscription',
        <String, dynamic>{
          'subscription_id': subscriptionId,
          'currency': currency,
          'order_id': orderId,
          'amount': amount,
          'callback_url': callbackUrl,
          'testmode': testmode,
        },
      );

      return Payment.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }

  /// Creates a Pensopay Mandate.
  static Future<Mandate> createMandate(
      {required int subscriptionId,
      required String mandateId,
      required String facilitator}) async {
    try {
      final result = await _channel.invokeMethod(
        'createMandate',
        <String, dynamic>{
          'subscription_id': subscriptionId,
          'mandate_id': mandateId,
          'facilitator': facilitator,
        },
      );

      return Mandate.fromMap(result);
    } on PlatformException catch (error) {
      switch (error.code) {
        case "0":
          throw PensoPaySetupException(error.message!);
        case "1":
          throw CreatePaymentException(error.details);
        case "2":
          throw CreatePaymentLinkException(error.details);
        case "3":
          throw ActivityException(error.details);
        case "4":
          throw ActivityFailureException(error.details);
        case "5":
          throw PaymentFailureException(error.details);
        default:
          rethrow;
      }
    }
  }
}
