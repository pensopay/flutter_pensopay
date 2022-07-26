//
//  PPPaymentLink.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPPaymentLink: Codable {
    
    // MARK: Properties
    
    public var url: String
    
    
    // MARK: Init
    
    public init(url: String) {
        self.url = url
    }
}

