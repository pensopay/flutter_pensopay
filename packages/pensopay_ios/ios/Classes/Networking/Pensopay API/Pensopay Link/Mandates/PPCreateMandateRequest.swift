//
//  PPCreateMandateRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCreateMandateRequest: PPRequest {
    
    // MARK: - Properties
    
    var parameters: PPCreateMandateParams
    
    
    // MARK: Init
    
    public init(parameters: PPCreateMandateParams) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPMandate) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/subscription/\(parameters.subscription_id)/mandate"), let postData = try? JSONEncoder().encode(parameters) else {
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

public class PPCreateMandateParams: Codable {
    
    // MARK: - Properties

    public var subscription_id: Int
    public var mandate_id: String
    public var facilitator: String

    public var success_url: String
    public var cancel_url: String

    // MARK: - Init
    
    public init(subscription_id: Int, mandate_id: String, facilitator: String) {
        self.subscription_id = subscription_id
        self.mandate_id = mandate_id
        self.facilitator = facilitator

        self.success_url = "https://pensopay.payment.success"
        self.cancel_url = "https://pensopay.payment.failure"
    }
}
