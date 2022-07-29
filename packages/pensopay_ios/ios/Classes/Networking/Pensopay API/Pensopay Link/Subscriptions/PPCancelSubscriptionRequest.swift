//
//  PPCancelSubscriptionRequest.swift
//  PensopaySDK
//
//  Created on 07/28/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCancelSubscriptionRequest : PPRequest {
    
    // MARK: - Properties
    
    public var subscription_id: Int

    
    // MARK: - Init
    
    public init(subscription_id: Int) {
        self.subscription_id = subscription_id
    }
    
    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPSubscription) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/subscription/\(self.subscription_id)/cancel") else {
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
