//
//  PPGetAcquireSettingsVippsRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPGetAcquireSettingsVippsRequest: PPRequest {

    // MARK: - Init
    
    public override init() {
        super.init()
    }

    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPVippsSettings) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/acquirers/vipps") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(headers.encodedAuthorization(), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        super.sendRequest(request: request, success: success) { (data, response, error) in
            if let httpUrlResponse = response as? HTTPURLResponse {
                if httpUrlResponse.statusCode == PensopayHttpStatusCodes.unauthorized.rawValue {
                    Pensopay.logDelegate?.log("The API key needs permissions for 'GET  /acquirers/vipps'")
                }
            }
            
            failure?(data, response, error)
        }
    }

}

public class PPVippsSettings: Codable {

    public var active: Bool
    public var client_id: String?
    public var client_secret: String?
    public var serial_number: String?
    public var access_token_subscription_key: String?
    public var ecommerce_subscription_key: String?
    
}
