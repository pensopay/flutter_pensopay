//
//  PPRecurringSubscriptionRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPRecurringSubscriptionRequest: PPRequest {

    // MARK: - Properties
    
    var parameters: PPRecurringSubscriptionParams
    
    
    // MARK: Init
    
    public init(parameters: PPRecurringSubscriptionParams) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPPayment) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {

        parameters.success_url = "https://pensopay.payment.success"
        parameters.cancel_url = "https://pensopay.payment.failure"

        guard let url = URL(string: "\(PensopayAPIBaseUrl)/subscription/\(self.parameters.id)/payment"), let postData = try? JSONEncoder().encode(parameters) else {
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

public class PPRecurringSubscriptionParams: Codable {

    // MARK: - Properties

    public var id: Int
    public var amount: Int
    public var currency: String
    public var order_id: String

    public var callback_url: String?
    public var testmode: Bool?

    public var success_url: String
    public var cancel_url: String


    // MARK: Init

    public init(id: Int, amount: Int, currency: String, order_id: String, callback_url: String?, testmode: Bool?) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.order_id = order_id
        self.callback_url = callback_url
        self.testmode = testmode

        self.success_url = "https://pensopay.payment.success"
        self.cancel_url = "https://pensopay.payment.failure"
    }
}