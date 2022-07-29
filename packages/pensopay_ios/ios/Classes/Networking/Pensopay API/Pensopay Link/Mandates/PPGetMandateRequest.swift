//
//  PPGetMandateRequest.swift
//  PensopaySDK
//
//  Created on 07/28/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPGetMandateRequest : PPRequest {
    
    // MARK: - Properties
    
    public var subscription_id: Int
    public var mandate_id: String

    
    // MARK: - Init
    
    public init(subscription_id: Int, mandate_id: String) {
        self.subscription_id = subscription_id
        self.mandate_id = mandate_id
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPMandate) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/subscription/\(self.subscription_id)/mandate/\(self.mandate_id)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(headers.encodedAuthorization(), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        super.sendRequest(request: request, success: success, failure: failure)
    }
}
