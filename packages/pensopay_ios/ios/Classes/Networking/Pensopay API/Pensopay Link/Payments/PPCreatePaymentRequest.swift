//
//  PPCreatePaymentRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCreatePaymentRequest: PPRequest {
    
    // MARK: - Properties
    
    var parameters: PPCreatePaymentParameters

    
    // MARK: Init
    
    public init(parameters: PPCreatePaymentParameters) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPPayment) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {

        parameters.success_url = "https://pensopay.payment.success"
        parameters.cancel_url = "https://pensopay.payment.failure"

        guard let url = URL(string: "\(PensopayAPIBaseUrl)/payment"), let postData = try? JSONEncoder().encode(parameters) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.setValue(headers.encodedAuthorization(), forHTTPHeaderField: "Authorization")
        request.setValue(String(format: "%lu", postData.count), forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        super.sendRequest(request: request, success: success, failure: failure)
    }
}

public class PPCreatePaymentParameters: Codable {
    
    // MARK: - Properties

    public var currency: String
    public var order_id: String
    public var amount: Int
    public var facilitator: String
    public var callback_url: String?
    public var testmode: Bool?
    public var autocapture: Bool?

    public var branding_id: Int?
    public var text_on_statement: String?
    public var basket: Array<PPBasket>? = Array<PPBasket>()
    public var shipping: PPShipping?
    public var invoice_address: PPAddress?
    public var shipping_address:PPAddress?
    public var shopSystem:PPShopSystem?

    public var success_url: String
    public var cancel_url: String
    
    
    // MARK: Init
    
    public init(currency: String, order_id: String, amount: Int, facilitator: String, callback_url: String?, autocapture: Bool?, testmode: Bool?) {
        self.currency = currency
        self.order_id = order_id
        self.amount = amount
        self.facilitator = facilitator
        self.callback_url = callback_url
        self.autocapture = autocapture
        self.testmode = testmode
        self.success_url = "https://pensopay.payment.success"
        self.cancel_url = "https://pensopay.payment.failure"
        
        self.shopSystem = PPShopSystem(name: "iOS-SDK", version: "0.0.1")
    }
    
}
