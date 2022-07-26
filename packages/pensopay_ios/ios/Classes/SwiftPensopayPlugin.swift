import Flutter
import UIKit

public class SwiftPensopayPlugin: NSObject, FlutterPlugin {
    private let METHOD_CALL_INIT = "init"
    private let METHOD_CALL_MAKE_PAYMENT = "makePayment"

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
        if (call.method == METHOD_CALL_INIT) {
            let args = call.arguments as! NSDictionary
            guard let apiKey : String = args.value(forKey: "api-key") as? String  else { return }
            initQuickPay(apiKey: apiKey)
        } else if (call.method == METHOD_CALL_MAKE_PAYMENT) {
            let args = call.arguments as! NSDictionary
            guard let currency : String = args.value(forKey: "currency") as? String  else { return }
            guard let orderId : String = args.value(forKey: "order-id") as? String  else { return }
            guard let price : Double = args.value(forKey: "price") as? Double  else { return }
            let autoCapture : Int? = args.value(forKey: "auto-capture") as? Int
            makePayment(currency: currency, orderId: orderId, price: price, autoCapture: autoCapture)
        }
    }

    private func initQuickPay(apiKey: String) {
        QuickPay.initWith(api_key: apiKey)
    }

    private func makePayment(currency: String, orderId: String, price: Double, autoCapture: Int?) {
        let createPeymentParams = QPCreatePaymentParameters(currency: currency, order_id: orderId)
        let createPaymentRequest = QPCreatePaymentRequest(parameters: createPeymentParams)

        createPaymentRequest.sendRequest(success: { (payment) in
            self.currentPaymentId = payment.id

            let createPaymentLinkParams = QPCreatePaymentLinkParameters(id: payment.id, amount: price)
            createPaymentLinkParams.auto_capture = autoCapture
            let createPaymentLinkRequest = QPCreatePaymentLinkRequest(parameters: createPaymentLinkParams)

            createPaymentLinkRequest.sendRequest(success: { (paymentLink) in
                QuickPay.openPaymentLink(paymentUrl: paymentLink.url, onCancel: {
                    self.pendingResult!(FlutterError(code: self.ACTIVITY_ERROR, message: "User cancel payment", details: "User cancel payment"))
                }, onResponse: { (success) in
                    if (success) {
                        if let paymentId = self.currentPaymentId {
                            self.currentPaymentId = nil

                            QPGetPaymentRequest(id: paymentId).sendRequest(success: { (payment) in
                                self.pendingResult!(self.convertQPPaymentToDictionary(payment: payment))
                            }, failure: { (data, response, error) in
                                self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
                            })
                        }
                    } else {
                        self.pendingResult!(FlutterError(code: self.ACTIVITY_FAILURE_ERROR, message: "User cancel payment", details: "User cancel payment"))
                    }
                }, presentation: .present(controller: self.viewController!, animated: true, completion: nil))
            }, failure: { (data, response, error) in
                self.pendingResult!(FlutterError(code: self.CREATE_PAYMENT_LINK_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
            })
        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.CREATE_PAYMENT_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func convertQPPaymentToDictionary(payment: QPPayment) -> Dictionary<String, Any?> {
        return [
            "id" : payment.id,
            "order_id" : payment.order_id,
            "accepted" : payment.accepted,
            "type" : payment.type,
            "text_on_statement" : payment.text_on_statement,
            "currency" : payment.currency,
            "state" : payment.state,
            "test_mode" : payment.test_mode,
            "created_at" : payment.created_at,
            "updated_at" : payment.updated_at,
            "balance" : payment.balance,
            "branding_id" : payment.branding_id,
            "acquirer" : payment.acquirer,
            "facilitator" : payment.facilitator,
            "retented_at" : payment.retented_at,
            "fee" : payment.fee,
            "subscriptionId" : payment.subscriptionId,
            "deadline_at" : payment.deadline_at,
            "metadata" : [
                "type" : payment.metadata?.type,
                "origin" : payment.metadata?.origin,
                "brand" : payment.metadata?.brand,
                "bin" : payment.metadata?.bin,
                "corporate" : payment.metadata?.corporate,
                "last4" : payment.metadata?.last4,
                "exp_month" : payment.metadata?.exp_month,
                "exp_year" : payment.metadata?.exp_year,
                "country" : payment.metadata?.country,
                "is_3d_secure" : payment.metadata?.is_3d_secure,
                "issued_to" : payment.metadata?.issued_to,
                "hash" : payment.metadata?.hash,
                "number" : payment.metadata?.number,
                "customer_ip" : payment.metadata?.customer_ip,
                "customer_country" : payment.metadata?.customer_country,
                "shopsystem_name" : payment.metadata?.shopsystem_name,
                "shopsystem_version" : payment.metadata?.shopsystem_version
            ],
            "operatinons" : payment.operations?.map {
                [
                    "id" : $0.id,
                    "type" : $0.type,
                    "amount" : $0.amount,
                    "pending" : $0.pending,
                    "qp_status_code" : $0.qp_status_code,
                    "qp_status_msg" : $0.qp_status_msg,
                    "aq_status_msg" : $0.aq_status_msg,
                    "acquirer" : $0.acquirer
                ]
            }
        ]
    }
}