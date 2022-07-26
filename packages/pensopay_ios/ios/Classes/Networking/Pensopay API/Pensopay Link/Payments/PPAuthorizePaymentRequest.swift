//
//  PPAuthorizePayment.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPAuthorizePaymentRequest: PPRequest {
    
    // MARK: - Properties
    
    var parameters: PPAuthorizePaymentParams
    
    
    // MARK: Init
    
    public init(parameters: PPAuthorizePaymentParams) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPPayment) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/payments/\(parameters.id)/authorize"), let postData = try? JSONEncoder().encode(parameters) else {
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

public class PPAuthorizePaymentParams: Codable {
    
    // MARK: - Properties
    
    public var id: Int
    public var amount: Int
    
    public var PensopayCallbackUrl: String? // TODO: Must be encoded/decoded into 'Pensopay-Callback-Url'
    public var synchronized: Bool?
    public var vat_rate: Double?
    public var mobile_number: String?
    public var auto_capture: Bool?
    public var acquirer: String?
    public var autofee: Bool?
    public var customer_ip: String?
//    public var extras: Any?
    public var zero_auth: Bool?
    
    public var card: PPCard?
    public var nin: PPNin?
    public var person: PPPerson?

    
    // MARK: - Init
    
    public init(id: Int, amount: Int) {
        self.id = id
        self.amount = amount
    }
}
