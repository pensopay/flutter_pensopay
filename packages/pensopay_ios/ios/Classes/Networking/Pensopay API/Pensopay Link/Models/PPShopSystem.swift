//
//  PPShopSystem.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PPShopSystem : Codable {
    
    // MARK: - Properties
    
    public var name: String
    public var version: String
    
    
    // MARK: Init
    
    public init(name: String, version: String) {
        self.name = name
        self.version = version
    }
}
