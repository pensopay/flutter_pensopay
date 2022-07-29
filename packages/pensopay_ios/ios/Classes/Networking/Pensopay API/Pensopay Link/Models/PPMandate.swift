//
//  PPMandate.swift
//  PensopaySDK
//
//  Created on 07/28/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPMandate : Codable {

    // MARK: - Properties

    public var id: Int
    public var subscription_id: String
    public var mandate_id: String
    public var state: String
    public var facilitator: String
    public var callback_url: String?
    public var link: String
    public var reference: String
    public var created_at: String
    public var updated_at: String
    
}
