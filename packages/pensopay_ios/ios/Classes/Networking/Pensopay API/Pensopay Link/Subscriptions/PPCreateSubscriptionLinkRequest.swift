//
//  PPCreateSubscriptionLinkRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCreateSubscriptionLinkRequest : PPRequest {
    
    // MARK: - Properties
    
    var parameters: PPCreateSubscriptionLinkParameters
    
    
    // MARK: Init
    
    public init(parameters: PPCreateSubscriptionLinkParameters) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPSubscriptionLink) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        if parameters.cancel_url == nil {
            parameters.cancel_url = "https://PP.payment.failure"
        }
        else {
            Pensopay.logDelegate?.log("Warning: You have set cancelUrl manually. PPViewController will not be able to detect unsuccessfull input of payment details")
        }
        
        if parameters.continue_url == nil {
            parameters.continue_url = "https://PP.payment.success"
        }
        else {
            Pensopay.logDelegate?.log("Warning: You have set continueUrl manually. PPViewController will not be able to detect successfull input of payment details");
        }
        
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/subscriptions/\(parameters.id)/link"), let putData = try? JSONEncoder().encode(parameters) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = putData
        request.setValue(headers.encodedAuthorization(), forHTTPHeaderField: "Authorization")
        request.setValue(String(format: "%lu", putData.count), forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        super.sendRequest(request: request, success: success, failure: failure)
    }
}
