import 'package:flutter/services.dart';
import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/payment.dart';

class Pensopay {
  static const MethodChannel _channel = MethodChannel('pensopay');

  static Future<void> init({required String apiKey}) async {
    print(apiKey);
    _channel.invokeMethod('init', {'api-key': apiKey});
  }

  static Future<Payment> makePayment({required String currency, required String order_id, required double amount, required String facilitator, bool autocapture = false, bool testmode = false,}) async {
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
}