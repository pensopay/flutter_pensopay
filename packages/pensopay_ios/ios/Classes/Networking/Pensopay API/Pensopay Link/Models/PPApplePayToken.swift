//
//  PPApplePayToken.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation
import PassKit

public class PPApplePayToken: Codable {
    
    // MARK: - Properties
    public let paymentData: PPPaymentData
    public let transactionIdentifier: String
    public let paymentMethod: PPApplePayPaymentMethod
    
    // MARK: - Init
    
    public init(pkPaymentToken: PKPaymentToken) {
        self.transactionIdentifier = pkPaymentToken.transactionIdentifier
        self.paymentMethod = PPApplePayPaymentMethod(pkPaymentMethod: pkPaymentToken.paymentMethod)

        do {
            paymentData = try JSONDecoder().decode(PPPaymentData.self, from: pkPaymentToken.paymentData)
        }
        catch {
            fatalError("Could not parse PKPaymentData")
        }
    }
}

public class PPPaymentData: Codable {
    
    // MARK: - Properties
    
    public var version: String?
    public var data: String?
    public var header: PPPaymentHeader?
    public var signature: String?
}

public class PPPaymentHeader: Codable {
    
    // MARK: - Properties
    
    public var ephemeralPublicKey: String?
    public var publicKeyHash: String?
    public var transactionId: String?
    
}


public class PPApplePayPaymentMethod: Codable {
    
    // MARK: - Properties
    
    public let displayName: String?
    public let network: String?
    public let type: String?
//    var paymentPass: PKPaymentPass?
    
    // MARK: - Init
    
    public init(pkPaymentMethod: PKPaymentMethod) {
        self.displayName = pkPaymentMethod.displayName
        self.network = pkPaymentMethod.network?.rawValue
        self.type = pkPaymentMethod.type.stringRepresentation()
    }
}

extension PKPaymentMethodType {
    
    func stringRepresentation() -> String {
        switch self {
        case PKPaymentMethodType.debit:
            return "debit"
        case PKPaymentMethodType.credit:
            return "credit"
        case PKPaymentMethodType.prepaid:
            return "prepaid"
        case PKPaymentMethodType.store:
            return "store"
        default:
            return "unknown"
        }
    }
}
