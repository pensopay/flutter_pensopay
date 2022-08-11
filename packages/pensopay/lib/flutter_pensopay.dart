import 'package:flutter/services.dart';
import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/mandate.dart';
import 'package:flutter_pensopay/payment.dart';

import 'subscription.dart';

class Pensopay {
  static const MethodChannel _channel = MethodChannel('pensopay');

  static Future<void> init({required String apiKey}) async {
    _channel.invokeMethod('init', {'api-key': apiKey});
  }

  static Future<Payment> createPayment({required String currency, required String order_id, required int amount, required String facilitator, String? callback_url, bool autocapture = false, bool testmode = false, bool sheet = true}) async {
    try {
      final result = await _channel.invokeMethod(
        'createPayment',
        <String, dynamic>{
          'currency': currency,
          'order_id': order_id,
          'amount': amount,
          'callback_url': callback_url,
          'facilitator': facilitator,
          'autocapture': autocapture,
          'testmode': testmode,
          'sheet': sheet,
        },
      );

      print(result.toString());
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

  static Future<Payment> getPayment({required int payment_id}) async {
    try {
      final result = await _channel.invokeMethod(
        'getPayment',
        <String, dynamic>{
          'payment_id': payment_id
        },
      );

      print(result.toString());
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

  static Future<Payment> capturePayment({required int payment_id, int? amount}) async {
    try {
      final result = await _channel.invokeMethod(
        'capturePayment',
        <String, dynamic>{
          'payment_id': payment_id,
          'amount': amount
        },
      );

      print(result.toString());
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

  static Future<Payment> refundPayment({required int payment_id, int? amount}) async {
    try {
      final result = await _channel.invokeMethod(
        'refundPayment',
        <String, dynamic>{
          'payment_id': payment_id,
          'amount': amount
        },
      );

      print(result.toString());
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

  static Future<Payment> cancelPayment({required int payment_id}) async {
    try {
      final result = await _channel.invokeMethod(
        'cancelPayment',
        <String, dynamic>{
          'payment_id': payment_id
        },
      );

      print(result.toString());
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

  static Future<Payment> anonymizePayment({required int payment_id}) async {
    try {
      final result = await _channel.invokeMethod(
        'anonymizePayment',
        <String, dynamic>{
          'payment_id': payment_id
        },
      );

      print(result.toString());
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

  static Future<Subscription> createSubscription({required String subscription_id, required int amount, required String currency, required String description, String? callback_url}) async {
    try {
      final result = await _channel.invokeMethod(
        'createSubscription',
        <String, dynamic>{
          'subscription_id': subscription_id,
          'amount': amount,
          'currency': currency,
          'description': description,
          'callback_url': callback_url,
        },
      );

      print(result.toString());
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

  static Future<Subscription> getSubscription({required int id}) async {
    try {
      final result = await _channel.invokeMethod(
        'getSubscription',
        <String, dynamic>{
          'id': id,
        },
      );

      print(result.toString());
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

  static Future<Subscription> cancelSubscription({required int id}) async {
    try {
      final result = await _channel.invokeMethod(
        'cancelSubscription',
        <String, dynamic>{
          'id': id,
        },
      );

      print(result.toString());
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

  static Future<Subscription> updateSubscription({required int id, String? subscription_id, int? amount, String? currency, String? description, String? callback_url}) async {
    try {
      final result = await _channel.invokeMethod(
        'updateSubscription',
        <String, dynamic>{
          'id': id,
          'subscription_id': subscription_id,
          'amount': amount,
          'currency': currency,
          'description': description,
          'callback_url': callback_url,
        },
      );

      print(result.toString());
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

  static Future<Payment> createSubscriptionPayment({required int subscription_id, required String currency, required String order_id, required int amount, String? callback_url, bool testmode = false,}) async {
    try {
      final result = await _channel.invokeMethod(
        'recurringSubscription',
        <String, dynamic>{
          'subscription_id': subscription_id,
          'currency': currency,
          'order_id': order_id,
          'amount': amount,
          'callback_url': callback_url,
          'testmode': testmode,
        },
      );

      print(result.toString());
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

  static Future<Mandate> createMandate({required int subscription_id, required String mandate_id, required String facilitator}) async {
    try {
      final result = await _channel.invokeMethod(
        'createMandate',
        <String, dynamic>{
          'subscription_id': subscription_id,
          'mandate_id': mandate_id,
          'facilitator': facilitator,
        },
      );

      print(result.toString());
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