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
    private let METHOD_CALL_GET_MANDATE = "getMandate"

    private let PENSO_PAY_SETUP_ERROR = "0"
    private let CREATE_PAYMENT_ERROR = "1"
    private let CREATE_PAYMENT_LINK_ERROR = "2"
    private let ACTIVITY_ERROR = "3"
    private let ACTIVITY_FAILURE_ERROR = "4"
    private let PAYMENT_FAILURE_ERROR = "5"

    private var currentId: Int? = nil
    private var currentType: String? = nil
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

        let args = call.arguments as! NSDictionary
        switch call.method {
            case METHOD_CALL_INIT:
                guard let apiKey : String = args.value(forKey: "api-key") as? String  else { return }
                initPensopay(apiKey: apiKey)

            case METHOD_CALL_CREATE_PAYMENT:
                guard let currency : String = args.value(forKey: "currency") as? String  else { return }
                guard let order_id : String = args.value(forKey: "order_id") as? String  else { return }
                guard let amount : Int = args.value(forKey: "amount") as? Int  else { return }
                guard let facilitator : String = args.value(forKey: "facilitator") as? String  else { return }
                let callback_url : String? = args.value(forKey: "callback_url") as? String
                let autocapture : Bool? = args.value(forKey: "autocapture") as? Bool
                let testmode : Bool? = args.value(forKey: "testmode") as? Bool
                createPayment(currency: currency, order_id: order_id, amount: amount, facilitator: facilitator, callback_url: callback_url, autocapture: autocapture, testmode: testmode)

            case METHOD_CALL_GET_PAYMENT:
                guard let payment_id : Int = args.value(forKey: "payment_id") as? Int  else { return }
                getPayment(payment_id: payment_id)

            case METHOD_CALL_CAPTURE_PAYMENT:
                guard let payment_id : Int = args.value(forKey: "payment_id") as? Int  else { return }
                let amount : Int? = args.value(forKey: "amount") as? Int
                capturePayment(payment_id: payment_id, amount: amount)

            case METHOD_CALL_REFUND_PAYMENT:
                guard let payment_id : Int = args.value(forKey: "payment_id") as? Int  else { return }
                let amount : Int? = args.value(forKey: "amount") as? Int
                refundPayment(payment_id: payment_id, amount: amount)

            case METHOD_CALL_CANCEL_PAYMENT:
                guard let payment_id : Int = args.value(forKey: "payment_id") as? Int  else { return }
                cancelPayment(payment_id: payment_id)

            case METHOD_CALL_ANONYMIZE_PAYMENT:
                guard let payment_id : Int = args.value(forKey: "payment_id") as? Int  else { return }
                anonymizePayment(payment_id: payment_id)

            // Subscription methods
            case METHOD_CALL_CREATE_SUBSCRIPTION:
                guard let subscription_id : String = args.value(forKey: "subscription_id") as? String  else { return }
                guard let amount : Int = args.value(forKey: "amount") as? Int  else { return }
                guard let currency : String = args.value(forKey: "currency") as? String  else { return }
                guard let description : String = args.value(forKey: "description") as? String  else { return }
                let callback_url : String? = args.value(forKey: "callback_url") as? String
                createSubscription(subscription_id: subscription_id, amount: amount, currency: currency, description: description, callback_url: callback_url)

            case METHOD_CALL_GET_SUBSCRIPTION:
                guard let subscription_id : Int = args.value(forKey: "subscription_id") as? Int  else { return }
                getSubscription(subscription_id: subscription_id)

            case METHOD_CALL_UPDATE_SUBSCRIPTION:
                guard let id : Int = args.value(forKey: "id") as? Int  else { return }
                guard let subscription_id : String = args.value(forKey: "subscription_id") as? String  else { return }
                let amount : Int? = args.value(forKey: "amount") as? Int
                let currency : String? = args.value(forKey: "currency") as? String
                let description : String? = args.value(forKey: "description") as? String
                let callback_url : String? = args.value(forKey: "callback_url") as? String
                updateSubscription(id: id, subscription_id: subscription_id, amount: amount, currency: currency, description: description, callback_url: callback_url)

            case METHOD_CALL_CANCEL_SUBSCRIPTION:
                guard let id : Int = args.value(forKey: "id") as? Int  else { return }
                cancelSubscription(id: id)

            case METHOD_CALL_RECURRING_SUBSCRIPTION:
                guard let subscription_id : Int = args.value(forKey: "subscription_id") as? Int  else { return }
                guard let order_id : String = args.value(forKey: "order_id") as? String  else { return }
                guard let amount : Int = args.value(forKey: "amount") as? Int  else { return }
                guard let currency : String = args.value(forKey: "currency") as? String  else { return }
                let callback_url : String? = args.value(forKey: "callback_url") as? String
                let testmode : Bool? = args.value(forKey: "testmode") as? Bool
                recurringSubscription(subscription_id: subscription_id, currency: currency, order_id: order_id, amount: amount, callback_url: callback_url, testmode: testmode)

            // Mandate methods
            case METHOD_CALL_CREATE_MANDATE:
                guard let subscription_id : Int = args.value(forKey: "subscription_id") as? Int  else { return }
                guard let mandate_id : String = args.value(forKey: "mandate_id") as? String  else { return }
                guard let facilitator : String = args.value(forKey: "facilitator") as? String  else { return }
                createMandate(subscription_id: subscription_id, mandate_id: mandate_id, facilitator: facilitator)

            case METHOD_CALL_GET_MANDATE:
                guard let subscription_id : Int = args.value(forKey: "subscription_id") as? Int  else { return }
                guard let mandate_id : String = args.value(forKey: "mandate_id") as? String  else { return }
                getMandate(subscription_id: subscription_id, mandate_id: mandate_id)

            default:
                print("DEFAULT")
        }
    }

    private func initPensopay(apiKey: String) {
        Pensopay.initWith(api_key: apiKey)
    }

    private func createPayment(currency: String, order_id: String, amount: Int, facilitator: String, callback_url: String?, autocapture: Bool?, testmode: Bool?) {
        let createPaymentParams = PPCreatePaymentParameters(currency: currency, order_id: order_id, amount: amount, facilitator: facilitator, callback_url: callback_url, autocapture: autocapture, testmode: testmode)
        let createPaymentRequest = PPCreatePaymentRequest(parameters: createPaymentParams)

        createPaymentRequest.sendRequest(success: { (payment) in
            self.currentId = payment.id
            self.currentType = "payment"

            Pensopay.openPaymentLink(paymentUrl: payment.link!, onCancel: {
                self.pendingResult!(FlutterError(code: self.ACTIVITY_ERROR, message: "User cancel payment", details: "User cancel payment"))
            }, onResponse: { (success) in
                if (success) {
                    if let paymentId = self.currentId {
                        self.currentId = nil
                        self.currentType = nil

                        PPGetPaymentRequest(id: paymentId).sendRequest(success: { (fetchPayment) in
                            self.pendingResult!(self.convertPPPaymentToDictionary(payment: fetchPayment))
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

    private func getPayment(payment_id: Int) {
        let getPaymentRequest = PPGetPaymentRequest(id: payment_id)

        getPaymentRequest.sendRequest(success: { (payment) in

            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func capturePayment(payment_id: Int, amount: Int?) {
        let capturePaymentParams = PPCapturePaymentParams(id: payment_id, amount: amount)
        let capturePaymentRequest = PPCapturePaymentRequest(parameters: capturePaymentParams)

        capturePaymentRequest.sendRequest(success: { (payment) in

            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func refundPayment(payment_id: Int, amount: Int?) {
        let refundPaymentParams = PPRefundPaymentParams(id: payment_id, amount: amount)
        let refundPaymentRequest = PPRefundPaymentRequest(parameters: refundPaymentParams)

        refundPaymentRequest.sendRequest(success: { (payment) in

            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func cancelPayment(payment_id: Int) {
        let cancelPaymentRequest = PPCancelPaymentRequest(id: payment_id)

        cancelPaymentRequest.sendRequest(success: { (payment) in

            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func anonymizePayment(payment_id: Int) {
        let anonymizePaymentRequest = PPAnonymizePaymentRequest(id: payment_id)

        anonymizePaymentRequest.sendRequest(success: { (payment) in

            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func createSubscription(subscription_id: String, amount: Int, currency: String, description: String, callback_url: String?) {
        let createSubscriptionParams = PPCreateSubscriptionParameters(subscription_id: subscription_id, amount: amount, currency: currency, description: description, callback_url: callback_url)
        let createSubscriptionRequest = PPCreateSubscriptionRequest(parameters: createSubscriptionParams)

        createSubscriptionRequest.sendRequest(success: { (subscription) in

            self.currentId = subscription.id
            self.currentType = "subscription"

            self.pendingResult!(self.convertPPSubsriptionToDictionary(subscription: subscription))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func getSubscription(subscription_id: Int) {
        let getSubscriptionRequest = PPGetSubscriptionRequest(subscription_id: subscription_id)

        getSubscriptionRequest.sendRequest(success: { (subscription) in

            self.pendingResult!(self.convertPPSubsriptionToDictionary(subscription: subscription))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func cancelSubscription(id: Int) {
        let cancelSubscriptionRequest = PPCancelSubscriptionRequest(subscription_id: id)

        cancelSubscriptionRequest.sendRequest(success: { (subscription) in

            self.pendingResult!(self.convertPPSubsriptionToDictionary(subscription: subscription))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func updateSubscription(id: Int, subscription_id: String?, amount: Int?, currency: String?, description: String?, callback_url: String?) {
        let updateSubscriptionParams = PPUpdateSubscriptionParams(id: id, subscription_id: subscription_id, amount: amount, currency: currency, description: description, callback_url: callback_url)
        let updateSubscriptionRequest = PPUpdateSubscriptionRequest(parameters: updateSubscriptionParams)

        updateSubscriptionRequest.sendRequest(success: { (subscription) in

            self.pendingResult!(self.convertPPSubsriptionToDictionary(subscription: subscription))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func recurringSubscription(subscription_id: Int, currency: String, order_id: String, amount: Int, callback_url: String?, testmode: Bool?) {
        let recurringSubscriptionParams = PPRecurringSubscriptionParams(id: subscription_id, amount: amount, currency: currency, order_id: order_id, callback_url: callback_url, testmode: testmode)
        let recurringSubscriptionRequest = PPRecurringSubscriptionRequest(parameters: recurringSubscriptionParams)

        recurringSubscriptionRequest.sendRequest(success: { (payment) in

            self.pendingResult!(self.convertPPPaymentToDictionary(payment: payment))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func createMandate(subscription_id: Int, mandate_id: String, facilitator: String) {
        let createMandateParams = PPCreateMandateParams(subscription_id: subscription_id, mandate_id: mandate_id, facilitator: facilitator)
        let createMandateRequest = PPCreateMandateRequest(parameters: createMandateParams)

        createMandateRequest.sendRequest(success: { (mandate) in

            self.currentId = mandate.id
            self.currentType = "mandate"

            Pensopay.openPaymentLink(paymentUrl: mandate.link, onCancel: {
                self.pendingResult!(FlutterError(code: self.ACTIVITY_ERROR, message: "User cancelled mandate", details: "User cancelled mandate"))
            }, onResponse: { (success) in
                if (success) {
                    if let mandateId = self.currentId {
                        self.currentId = nil
                        self.currentType = nil

                        PPGetMandateRequest(subscription_id: subscription_id, mandate_id: String(mandateId)).sendRequest(success: { (mandate) in
                            self.pendingResult!(self.convertPPMandateToDictionary(mandate: mandate))
                        }, failure: { (data, response, error) in
                            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
                        })
                    }
                } else {
                    self.pendingResult!(FlutterError(code: self.ACTIVITY_FAILURE_ERROR, message: "User cancelled mandate", details: "User cancelled mandate"))
                }
            }, presentation: .present(controller: self.viewController!, animated: true, completion: nil))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
        })
    }

    private func getMandate(subscription_id: Int, mandate_id: String) {
        let getMandateRequest = PPGetMandateRequest(subscription_id: subscription_id, mandate_id: mandate_id)

        getMandateRequest.sendRequest(success: { (mandate) in

            self.pendingResult!(self.convertPPMandateToDictionary(mandate: mandate))

        }, failure: { (data, response, error) in
            self.pendingResult!(FlutterError(code: self.PAYMENT_FAILURE_ERROR, message: String(data: data!, encoding: String.Encoding.utf8)!, details: String(data: data!, encoding: String.Encoding.utf8)!))
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

    private func convertPPSubsriptionToDictionary(subscription: PPSubscription) -> Dictionary<String, Any?> {
        return [
            "id": subscription.id,
            "subscription_id": subscription.subscription_id,
            "amount": subscription.amount,
            "currency": subscription.currency,
            "state": subscription.state,
            "description": subscription.description,
            "callback_url": subscription.callback_url,
            "variables": subscription.variables,
            "created_at": subscription.created_at,
            "updated_at": subscription.updated_at
        ]
    }

        private func convertPPMandateToDictionary(mandate: PPMandate) -> Dictionary<String, Any?> {
            return [
                "id": mandate.id,
                "subscription_id": mandate.subscription_id,
                "mandate_id": mandate.mandate_id,
                "state": mandate.state,
                "facilitator": mandate.facilitator,
                "callback_url": mandate.callback_url,
                "link": mandate.link,
                "reference": mandate.reference,
                "created_at": mandate.created_at,
                "updated_at": mandate.updated_at
            ]
        }
    }