//
//  PPShipping.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPShipping : Codable {

    // MARK: - Properties
    
    public var method: String?
    public var company: String?
    public var amount: Int?
    public var vat_rate: Double?
    public var tracking_number: String?
    public var tracking_url: String?
    
    
    // MARK: Init
    
    public init() {
        
    }
    
}
