//
//  PPDefaultHeaders.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

class PPHeaders {
    
    // MARK: - Properties

    var apiKey: String {
        get {
            return Pensopay.apiKey ?? ""
        }
    }

        
    // MARK: Auth
    
    func encodedAuthorization() -> String {
        return String(format: "Bearer %@", apiKey)
    }
}
