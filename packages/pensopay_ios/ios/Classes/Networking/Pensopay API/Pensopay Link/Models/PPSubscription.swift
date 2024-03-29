//
//  PPSubscription.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPSubscription: Codable {
    
    // MARK: - Properties

    public var id: Int
    public var subscription_id: String
    public var amount: Int
    public var currency: String
    public var state: String
    public var description: String
    public var callback_url: String?
    public var variables: Array<String>?
    public var created_at: String
    public var updated_at: String

}
