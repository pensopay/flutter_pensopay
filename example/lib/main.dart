import 'package:flutter/material.dart';
import 'package:flutter_pensopay/flutter_pensopay.dart';
import 'dart:math';

import 'package:flutter_pensopay/payment.dart';

void main() {
  runApp(const MyApp());
  //Pensopay.init(apiKey: "17c3236315ec4df3d236895330f314fd00110bde4b01f368ec1e059e176957f0");
  Pensopay.init(apiKey: "f38af28dfa5e3da5cbcbb673d36da8f638f9dcf95d28ae91c0f3110ecb06236f");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    Random random = new Random();
    int randomNumber = random.nextInt(10000)+1000;

    // Create subscription
    // try {
    //   Pensopay.createSubscription(
    //       subscription_id: "test-" + randomNumber.toString(),
    //       amount: 500,
    //       currency: "DKK",
    //       description: "Some test fra Android SDK"
    //   ).then((subscription) {
    //     print("CREATE SUBSCRIPTION SUCCESS");
    //     print(subscription.description);
    //     Pensopay.createMandate(
    //       subscription_id: subscription.id,
    //       mandate_id: subscription.subscription_id,
    //       facilitator: "quickpay"
    //     ).then((mandate) {
    //       print("CREATE MANDATE SUCCESS");
    //       print(mandate.id);
    //     });
    //   });
    // } catch (error) {
    //   print("CREATE MANDATE ERROR");
    //   print(error.toString());
    // }

    //try {
    //  Pensopay.createSubscriptionPayment(subscription_id: 1000096, currency: "DKK", order_id: "recurring-" + randomNumber.toString(), amount: 500, testmode: true).then((payment) {
    //    print(payment.id);
    //    print(payment);
    //  });
    //} catch (error) {
    //  print("CREATE MANDATE ERROR");
    //  print(error.toString());
    //}

    // Update subscription
    // try {
    //   Pensopay.updateSubscription(
    //     id: 1000094,
    //     description: "Some test from Android SDK"
    //   );
    // } catch (error) {
    //   print("UPDATE SUBSCRIPTION ERROR");
    //   print(error.toString());
    // }
    //
    // try {
    //   Pensopay.cancelSubscription(
    //       id: 1000094
    //   );
    // } catch (error) {
    //   print("CANCEL SUBSCRIPTION ERROR");
    //   print(error.toString());
    // }


    //Create payment
    print("CLICK");

    try {
      print("GOT HERE");
      Pensopay.createPayment(
        currency: 'DKK',
        order_id: "first-" + randomNumber.toString(),
        amount: 500,
        facilitator: 'quickpay',
        testmode: true
      ).then((payment) {
        print("CREATE SUCCESS");
        print(payment.id);
        print(payment.order_id);

        try {
         Pensopay.capturePayment(
           payment_id: payment.id
         ).then((payment) {
           print("CAPTURE SUCCESS");
           print(payment.id);
           print(payment.order_id);

           try {
             Pensopay.refundPayment(
               payment_id: payment.id
             ).then((payment) {
               print("REFUND SUCCESS");
               print(payment.id);
               print(payment.order_id);
             });
           } catch (error) {
             print("REFUND ERROR");
             print(error.toString());
           }
         });
        } catch (error) {
         print("CAPTURE ERROR");
         print(error.toString());
        }
      });
    } catch (error) {
      print("CREATE ERROR");
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
