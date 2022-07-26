//
//  PPOperation.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPOperation : Codable {
    
    // MARK: - Properties
    
    public var id: Int
    public var type: String?
    public var amount: Int?
    public var pending: Bool?
    public var PP_status_code: String?
    public var PP_status_msg: String?
    public var aq_status_msg: String?
    public var aqStatusMsg: String?
    public var data: Dictionary<String, String>?
    public var callback_url: String?
    public var callback_success: Bool?
    public var callback_response_code: Int?
    public var callback_duration: Int?
    public var acquirer: String?
    public var callback_at: String?
    public var created_at: String?
    
}
