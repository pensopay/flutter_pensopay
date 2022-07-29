//
//  PPCancelPaymentRequest.swift
//  PensopaySDK
//
//  Created on 07/28/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCancelPaymentRequest: PPRequest {
    
    // MARK: - Properties
    public var id: Int

    // MARK: - Init

    public init(id: Int) {
        self.id = id
    }
    
    
    // MARK: - URL Request

    public func sendRequest(success: @escaping (_ result: PPPayment) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/payment/\(self.id)/cancel") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(headers.encodedAuthorization(), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        super.sendRequest(request: request, success: success, failure: failure)
    }
    
}