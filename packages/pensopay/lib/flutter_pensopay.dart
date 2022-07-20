import 'package:flutter/services.dart';
import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/payment.dart';

class Pensopay {
  static const MethodChannel _channel = MethodChannel('pensopay');

  static Future<void> init({required String apiKey}) async {
    print(apiKey);
    _channel.invokeMethod('init', {'api-key': apiKey});
  }

  static Future<Payment> makePayment({required String currency, required String order_id, required int amount, required String facilitator, bool autocapture = false, bool testmode = false,}) async {
    try {
      final result = await _channel.invokeMethod(
        'makePayment',
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
}