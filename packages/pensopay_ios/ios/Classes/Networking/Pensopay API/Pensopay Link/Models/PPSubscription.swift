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
    public var merchant_id: Int
    public var order_id: String
    public var accepted: Bool
    public var type: String
    public var text_on_statement: String?
    public var currency: String
    public var state: String
    public var test_mode: Bool
    public var created_at: String
    public var updated_at: String
    
    public var branding_id: String?
    public var acquirer: String?
    public var facilitator: String?
    public var retented_at: String?
    public var description: String?
    public var group_ids: [Int]?
    public var deadline_at: String?
    
    public var operations: Array<PPOperation>?
    public var shipping_address: PPAddress?
    public var invoice_address: PPAddress?
    public var basket: Array<PPBasket>?
    public var shipping: PPShipping?
    public var metadata: PPMetadata?
    public var link: PPPaymentLink?
}
