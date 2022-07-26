//
//  PPCreateSubscriptionParameters.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPCreateSubscriptionParameters: Codable {
    
    // MARK: - Properties
    
    public var order_id: String
    public var currency: String
    public var description: String
    
    public var branding_id: Int?
    public var text_on_statement: String?
    public var basket: Array<PPBasket>?
    public var shipping: PPShipping?
    public var invoice_address: PPAddress?
    public var shipping_address:PPAddress?
    public var group_ids: [Int]?
    public var shopsystem: [PPShopSystem]?
    
    
    // MARK: Init
    
    public init(currency: String, order_id: String, description: String) {
        self.currency = currency
        self.order_id = order_id
        self.description = description
    }
}
