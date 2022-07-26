//
//  HttpStatusCodes.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//
// The Pensopay API only operates with a subset of alle the HTTP status codes.
// https://learn.Pensopay.net/tech-talk/api/#introduction

private let successStatusCodes = [PensopayHttpStatusCodes.ok, PensopayHttpStatusCodes.created, PensopayHttpStatusCodes.accepted]

public enum PensopayHttpStatusCodes: Int {
    // 200 Success
    case ok = 200
    case created
    case accepted

    // 400 Client Error
    case badRequest = 400
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case conflict = 409
    
    // 500 Server Error
    case internalServerError = 500
    
    
    // Utils
    
    /**
     Test if an Integer HTTP Status code is in the Success range defined in the Pensopay API
     */
    public static func isSuccessCode(statusCode: Int) -> Bool {
        if let PensopayStatus = PensopayHttpStatusCodes(rawValue: statusCode) {
            return successStatusCodes.contains(PensopayStatus)
        }
        return false
    }
}
