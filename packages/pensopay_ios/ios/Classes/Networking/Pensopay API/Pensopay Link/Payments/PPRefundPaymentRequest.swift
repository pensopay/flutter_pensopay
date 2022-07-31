//
//  PPRefundPaymentRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPRefundPaymentRequest: PPRequest {
    
    // MARK: - Properties
    
    var parameters: PPRefundPaymentParams
    
    
    // MARK: Init
    
    public init(parameters: PPRefundPaymentParams) {
        self.parameters = parameters
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPPayment) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/payment/\(self.parameters.id)/refund"), let postData = try? JSONEncoder().encode(parameters) else {
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

public class PPRefundPaymentParams: Codable {
    
    // MARK: - Properties
    
    public var id: Int
    public var amount: Int?

    // MARK: - Init
    
    public init(id: Int, amount: Int?) {
        self.id = id
        self.amount = amount
    }
}
