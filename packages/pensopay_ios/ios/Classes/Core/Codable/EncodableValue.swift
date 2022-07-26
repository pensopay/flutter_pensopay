//
//  EncodableValue.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public struct EncodableValue: Encodable {
    public var value: Encodable?
    
    public func encode(to encoder: Encoder) throws {
        try value?.encode(to: encoder)
    }
}
