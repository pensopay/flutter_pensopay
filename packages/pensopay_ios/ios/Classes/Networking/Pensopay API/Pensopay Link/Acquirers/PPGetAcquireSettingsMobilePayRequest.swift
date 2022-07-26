//
//  PPGetAcquireSettingsMobilePayRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPGetAcquireSettingsMobilePayRequest: PPRequest {

    // MARK: - Init
    
    public override init() {
        super.init()
    }

    
    // MARK: - URL Request
    
    public func sendRequest(success: @escaping (_ result: PPMobilePaySettings) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        guard let url = URL(string: "\(PensopayAPIBaseUrl)/acquirers/mobilepayonline") else {
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
                    Pensopay.logDelegate?.log("The API key needs permissions for 'GET  /acquirers/mobilepayonline'")
                }
            }
            
            failure?(data, response, error)
        }
    }
    
}


public class PPMobilePaySettings: Codable {

    public var active: Bool
    public var merchant_id: String?
    public var delivery_limited_to: String?
    
}
