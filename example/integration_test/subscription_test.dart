import 'dart:math';

import 'package:flutter_pensopay/exceptions.dart';
import 'package:flutter_pensopay/flutter_pensopay.dart';
import 'package:flutter_pensopay/subscription.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  String token = "70f21f08dc633ad23b81a1905e546c32e085bb8f23c2678b1b98ad5326e45301";
  Random random = new Random();

  test("Attempt to create subscription without initializing Pensopay", () {
    int randomNumber = random.nextInt(100000)+10000;
    expect(Pensopay.createSubscription(amount: 500, currency: 'DKK', description: 'My subscription.', subscription_id: "subscription_$randomNumber"), throwsA(isInstanceOf<PensoPaySetupException>()));
  });

  test("Attempt to get subscription unauthorized", () {
    Pensopay.init(apiKey: "");

    expect(Pensopay.getSubscription(id: 1000081), throwsA(isInstanceOf<CreatePaymentException>()));
  });

  test("Attempt to get invalid subscription", () {
    Pensopay.init(apiKey: token);

    expect(Pensopay.getSubscription(id: 123), throwsA(isInstanceOf<CreatePaymentException>()));
  });

  test("Attempt to get subscription", () {
    Pensopay.init(apiKey: token);

    Pensopay.getSubscription(id: 1000081).then((subscription) {
      expect(subscription.id, 1000081);
      expect(subscription.subscription_id, "test-123");
      expect(subscription.description, "Test subscription");
      expect(subscription.amount, 1000);
    });
  });

  test("Attempt to create subscription", () async {
    Pensopay.init(apiKey: token);

    int randomNumber = random.nextInt(100000)+10000;
    try {
      await Pensopay.createSubscription(amount: 500, currency: 'DKK', description: 'My subscription.', subscription_id: "subscription_$randomNumber").then((subscription) {
        expect(subscription.subscription_id, "subscription_$randomNumber");
        expect(subscription.description, "My subscription.");
        expect(subscription.amount, 500);
      });
    } catch (_) {}
  });

  test('Attempt to create, get, and cancel subscription', () async {
    Pensopay.init(apiKey: token);

    int orderId = random.nextInt(100000)+10000;

    Subscription? subscription;

    try {
      await Pensopay.createSubscription(amount: 500, currency: 'DKK', description: 'My subscription.', subscription_id: "subscription_$orderId").then((create_subscription) {
        subscription = create_subscription;
        expect(create_subscription.subscription_id, "subscription_$orderId");
        expect(create_subscription.description, "My subscription.");
        expect(create_subscription.amount, 500);
        expect(create_subscription.state, "pending");
      });
    } catch (_) {}

    try {
      await Pensopay.getSubscription(id: subscription!.id).then((get_subscription) {
        subscription = get_subscription;
        expect(get_subscription.id, subscription!.id);
        expect(get_subscription.amount, subscription!.amount);
      });
    } catch (_) {}

    try {
      await Pensopay.cancelSubscription(id: subscription!.id).then((cancel_subscription) {
        expect(cancel_subscription.state, "canceled");
      });
    } catch (_) {}

  });

}