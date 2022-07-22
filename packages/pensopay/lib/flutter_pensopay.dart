import 'package:flutter/services.dart';
import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/mandate.dart';
import 'package:flutter_pensopay/payment.dart';

import 'subscription.dart';

class Pensopay {
  static const MethodChannel _channel = MethodChannel('pensopay');

  static Future<void> init({required String apiKey}) async {
    print(apiKey);
    _channel.invokeMethod('init', {'api-key': apiKey});
  }

  static Future<Payment> createPayment({required String currency, required String order_id, required int amount, required String facilitator, bool autocapture = false, bool testmode = false,}) async {
    try {
      final result = await _channel.invokeMethod(
        'createPayment',
        <String, dynamic>{
          'currency': currency,
          'order_id': order_id,
          'amount': amount,
          'facilitator': facilitator,
          'autocapture': autocapture,
          'testmode': testmode
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