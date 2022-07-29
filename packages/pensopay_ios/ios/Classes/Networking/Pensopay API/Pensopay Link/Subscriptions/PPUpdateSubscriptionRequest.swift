//
//  PPUpdateSubscriptionRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPUpdateSubscriptionRequest: PPRequest {

    // MARK: - Properties
    
    var parameters: PPUpdateSubscriptionParams
    
    
    // MARK: Init
    
    public init(parameters: PPUpdateSubscriptionParams) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPSubscription) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/subscription/\(self.parameters.id)"), let postData = try? JSONEncoder().encode(parameters) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.httpBody = postData
        request.setValue(headers.encodedAuthorization(), forHTTPHeaderField: "Authorization")
        request.setValue(String(format: "%lu", postData.count), forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        super.sendRequest(request: request, success: success, failure: failure)
    }
}

public class PPUpdateSubscriptionParams: Codable {

    // MARK: - Properties

    public var id: Int
    public var subscription_id: String?
    public var amount: Int?
    public var currency: String?
    public var description: String?
    public var callback_url: String?


    // MARK: Init

    public init(id: Int, subscription_id: String?, amount: Int?, currency: String?, description: String?, callback_url: String?) {
        self.id = id
        self.subscription_id = subscription_id
        self.amount = amount
        self.currency = currency
    }
}