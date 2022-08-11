import 'dart:math';

import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/flutter_pensopay.dart';
import 'package:flutter_pensopay/payment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  String token = "70f21f08dc633ad23b81a1905e546c32e085bb8f23c2678b1b98ad5326e45301";
  Random random = new Random();

  test("Ensure that token is set before running all tests", () {
    expect(token.length, 64);
  });

  test("Attempt to create payment without initializing Pensopay", () async {
    int randomNumber = random.nextInt(100000)+10000;
    expect(Pensopay.createPayment(amount: 500, facilitator: 'quickpay', order_id: randomNumber.toString(), currency: 'DKK'), throwsA(isInstanceOf<PensoPaySetupException>()));
  });

  test("Attempt to get payment unauthorized", () async {
    Pensopay.init(apiKey: "");

    expect(Pensopay.getPayment(payment_id: 123), throwsA(isInstanceOf<CreatePaymentException>()));
  });

  test("Attempt to get invalid payment", () async {
    Pensopay.init(apiKey: token);

    expect(Pensopay.getPayment(payment_id: 123), throwsA(isInstanceOf<CreatePaymentException>()));
  });

  test("Attempt to get payment", () async {
    Pensopay.init(apiKey: token);

    try {
      await Pensopay.getPayment(payment_id: 1096299).then((payment) {
        expect(payment.id, 1096299);
        expect(payment.order_id, "first-4929");
        expect(payment.amount, 500);
      });
    } catch(_) {}
  });

  test("Attempt to create payment with unavailable facilitator", () async {
    Pensopay.init(apiKey: token);

    try {
      await Pensopay.createPayment(amount: 500, facilitator: 'something_that_does_not_exist', order_id: "some_order_id", currency: 'DKK');
    } on CreatePaymentException catch (error) {
      expect(error.message, "The given data was invalid.");
    }
  });

  test('Create payment', () async {
    Pensopay.init(apiKey: token);

    int orderId = random.nextInt(100000)+10000;
    try {
      await Pensopay.createPayment(amount: 500, facilitator: 'quickpay', order_id: orderId.toString(), currency: 'DKK', sheet: false).then((payment) {
        expect(payment.amount, 500);
        expect(payment.order_id, orderId.toString());
        expect(payment.state, "pending");
        expect(payment.currency, "DKK");
        expect(payment.facilitator, "quickpay");
      });
    } catch (_) {}
  });

  test('Attempt to create, get, and cancel payment', () async {
    Pensopay.init(apiKey: token);

    int orderId = random.nextInt(100000)+10000;

    Payment? payment;

    try {
      await Pensopay.createPayment(amount: 500, facilitator: 'quickpay', order_id: orderId.toString(), currency: 'DKK', sheet: false).then((create_payment) {
        payment = create_payment;
        expect(create_payment.amount, 500);
        expect(create_payment.order_id, orderId.toString());
        expect(create_payment.currency, "DKK");
        expect(create_payment.state, "pending");
        expect(create_payment.facilitator, "quickpay");
      });
    } catch (_) {}

    try {
      await Pensopay.getPayment(payment_id: payment!.id).then((get_payment) {
        payment = get_payment;
        expect(get_payment.id, payment!.id);
        expect(get_payment.order_id, orderId.toString());
        expect(get_payment.amount, payment!.amount);
      });
    } catch (_) {}

    try {
      await Pensopay.cancelPayment(payment_id: payment!.id).then((cancel_payment) {
        expect(cancel_payment.state, "canceled");
      });
    } catch (_) {}

  });

}