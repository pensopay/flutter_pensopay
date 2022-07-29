//
//  PPPayment.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPPayment: Codable {
    
    // MARK: - Properties

    public var id: Int
    public var order_id: String
    public var type: String
    public var amount: Int
    public var captured: Int
    public var refunded: Int
    public var currency: String
    public var state: String
    public var facilitator: String

    //public var reference: String {
    //    get {
    //        return reference
    //    }
    //    set (value) {
    //        reference = String(value ?? "")
    //    }
    //}

    public var testmode: Bool
    public var autocapture: Bool
    public var link: String
    public var callback_url: String?
    public var success_url: String?
    public var cancel_url: String?
    public var order: Array<String>?
    public var variables: Array<String>?
    public var expires_at: String
    public var created_at: String
    public var updated_at: String
}