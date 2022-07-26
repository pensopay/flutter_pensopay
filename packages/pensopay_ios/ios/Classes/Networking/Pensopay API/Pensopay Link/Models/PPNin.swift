//
//  PPNin.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPNin: Codable {

    // MARK: - Enums
    
    private enum Gender: String {
        case male
        case female
    }
    
    
    // MARK: - Properties
    
    public var number: String?
    public var country_code: String?
    public var gender: String? //TODO: Convert this into the Gender enum
    
}
