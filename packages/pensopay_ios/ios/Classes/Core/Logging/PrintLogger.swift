//
//  ConsoleLogger.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation

public class PrintLogger {

    public init() {
        
    }
    
}

extension PrintLogger: LogDelegate {

    public func log(_ msg: Any) {
        OperationQueue.main.addOperation {
            print(msg)
        }
    }
    
}
