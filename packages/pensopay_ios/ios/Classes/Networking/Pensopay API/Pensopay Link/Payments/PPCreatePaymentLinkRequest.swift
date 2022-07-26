//
//  PPCreatePaymentRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCreatePaymentLinkRequest : PPRequest {

    // MARK: - Properties
    
    var parameters: PPCreatePaymentLinkParameters

    
    // MARK: Init
    
    public init(parameters: PPCreatePaymentLinkParameters) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPPaymentLink) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
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
        
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/payments/\(parameters.id)/link"), let putData = try? JSONEncoder().encode(parameters) else {
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


public class PPCreatePaymentLinkParameters: Codable {
    
    // MARK: - Properties
    
    public var id: Int
    public var amount: Int
    public var agreement_id: Int?
    public var language: String?
    public var continue_url: String?
    public var cancel_url: String?
    public var callback_url: String?
    public var payment_methods: String?
    public var auto_fee: Bool?
    public var branding_id: Int?
    public var google_analytics_tracking_id: String?
    public var google_analytics_client_id: String?
    public var acquirer: String?
    public var deadline: String?
    public var framed: Int?
    //    public var branding_config: Any?
    public var customer_email: String?
    public var invoice_address_selection: Bool?
    public var shipping_address_selection: Bool?
    public var auto_capture: Int?
    
    
    // MARK: Init
    
    public init(id: Int, amount: Int) {
        self.id = id
        self.amount = amount
    }
    
}
