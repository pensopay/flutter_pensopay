import Flutter
import UIKit

public class SwiftPensopayPlugin: NSObject, FlutterPlugin {
    private let METHOD_CALL_INIT = "init"

    // Payment calls
    private let METHOD_CALL_CREATE_PAYMENT = "createPayment"
    private let METHOD_CALL_GET_PAYMENT = "getPayment"
    private let METHOD_CALL_CAPTURE_PAYMENT = "capturePayment"
    private let METHOD_CALL_REFUND_PAYMENT = "refundPayment"
    private let METHOD_CALL_CANCEL_PAYMENT = "cancelPayment"
    private let METHOD_CALL_ANONYMIZE_PAYMENT = "anonymizePayment"

    // Subscription calls
    private let METHOD_CALL_CREATE_SUBSCRIPTION = "createSubscription"
    private let METHOD_CALL_GET_SUBSCRIPTION = "getSubscription"
    private let METHOD_CALL_UPDATE_SUBSCRIPTION = "updateSubscription"
    private let METHOD_CALL_CANCEL_SUBSCRIPTION = "cancelSubscription"
    private let METHOD_CALL_RECURRING_SUBSCRIPTION = "recurringSubscription"

    // Mandate calls
    private let METHOD_CALL_CREATE_MANDATE = "createMandate"

    private let PENSO_PAY_SETUP_ERROR = "0"
    private let CREATE_PAYMENT_ERROR = "1"
    private let CREATE_PAYMENT_LINK_ERROR = "2"
    private let ACTIVITY_ERROR = "3"
    private let ACTIVITY_FAILURE_ERROR = "4"
    private let PAYMENT_FAILURE_ERROR = "5"

    private var currentPaymentId: Int? = nil
    private var pendingResult: FlutterResult? = nil
    private var viewController: UIViewController? = nil

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let viewController: UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!;
        let channel = FlutterMethodChannel(name: "pensopay", binaryMessenger: registrar.messenger())
        let instance = SwiftPensopayPlugin(viewController: viewController)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        pendingResult = result

        switch call.method {
            case METHOD_CALL_INIT:
                let args = call.arguments as! NSDictionary
                guard let apiKey : String = args.value(forKey: "api-key") as? String  else { return }
                initPensopay(apiKey: apiKey)

            case METHOD_CALL_CREATE_PAYMENT:
                print("GOT sjdjkfjsdklfjslkdf");
                let args = call.arguments as! NSDictionary
                guard let currency : String = args.value(forKey: "currency") as? String  else { return }
                guard let order_id : String = args.value(forKey: "order_id") as? String  else { return }
                guard let amount : Int = args.value(forKey: "amount") as? Int  else { return }
                guard let facilitator : String = args.value(forKey: "facilitator") as? String  else { return }
                let callback_url : String? = args.value(forKey: "callback_url") as? String
                let autocapture : Int? = args.value(forKey: "autocapture") as? Int
                let testmode : Int? = args.value(forKey: "testmode") as? Int
                createPayment(currency: currency, order_id: order_id, amount: amount, facilitator: facilitator, callback_url: callback_url, autocapture: autocapture, testmode: testmode)

            default:
                print("DEFAULT")
        }
    }

    private func initPensopay(apiKey: String) {
        Pensopay.initWith(api_key: apiKey)
    }

    private func createPayment(currency: String, order_id: String, amount: Int, facilitator: String, callback_url: String?, autocapture: Int?, testmode: Int?) {
    print("GOT fasdfasdfasdfasdf");
        let createPaymentParams = PPCreatePaymentParameters(currency: currency, order_id: order_id, amount: amount, facilitator: facilitator, callback_url: callback_url, autocapture: autocapture, testmode: testmode)
        let createPaymentRequest = PPCreatePaymentRequest(parameters: createPaymentParams)

        print("SDFSDFSDF")

        createPaymentRequest.sendRequest(success: { (payment) in
            self.currentPaymentId = payment.id

            print(payment.id)

            Pensopay.openPaymentLink(paymentUrl: payment.link, onCancel: {
                self.pendingResult!(FlutterError(code: self.ACTIVITY_ERROR, message: "User cancel payment", details: "User cancel payment"))
            }, onResponse: { (success) in
                if (success) {
                    if let paymentId = self.currentPaymentId {
                        self.currentPaymentId = nil

                        PPGetPaymentRequest(id: paymentId).sendRequest(success: { (payment) in
                            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))
                        }, failure: { (data, response, error) in
                            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
                        })
                    }
                } else {
                    self.pendingResult!(FlutterError(code: self.ACTIVITY_FAILURE_ERROR, message: "User cancel payment", details: "User cancel payment"))
                }
            }, presentation: .present(controller: self.viewController!, animated: true, completion: nil))


        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.CREATE_PAYMENT_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func convertPPPaymentToDictionary(payment: PPPayment) -> Dictionary<String, Any?> {
        return [
           "id": payment.id,
           "order_id": payment.order_id,
           "type": payment.type,
           "amount": payment.amount,
           "captured": payment.captured,
           "refunded": payment.refunded,
           "currency": payment.currency,
           "state": payment.state,
           "facilitator": payment.facilitator,
           "reference": payment.reference,
           "testmode": payment.testmode,
           "autocapture": payment.autocapture,
           "link": payment.link,
           "callback_url": payment.callback_url,
           "success_url": payment.success_url,
           "cancel_url": payment.cancel_url,
           "order": payment.order,
           "variables": payment.variables,
           "expires_at": payment.expires_at,
           "created_at": payment.created_at,
           "updated_at": payment.updated_at
        ]
    }
}