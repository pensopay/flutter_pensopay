//
//  PPBasket.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPBasket : Codable {

    // MARK: - Properties
    
    public var qty: Int
    public var item_no: String
    public var item_name: String
    public var item_price: Double
    public var vat_rate: Double
 
    
    // MARK: Init
    
    public init(qty: Int, item_no: String, item_name: String, item_price: Double, vat_rate: Double) {
        self.qty = qty
        self.item_no = item_no
        self.item_name = item_name
        self.item_price = item_price
        self.vat_rate = vat_rate
    }
    
}
