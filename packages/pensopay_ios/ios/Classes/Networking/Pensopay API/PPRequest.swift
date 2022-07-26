//
//  PPRequest.swift
//  PensopaySDK
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import Foundation


/**
 PPRequest handles the real request and parse the JSON response
 */
public class PPRequest {
    
    // MARK: - Properties
    
    internal let PensopayAPIBaseUrl = "https://api.pensopay.com/v1"
    internal let headers = PPHeaders()
    
    
    // MARK: - URL Request
    
    internal func sendRequest<T: Decodable>(request: URLRequest, success: @escaping (_ result: T) -> Void, failure: ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)?) {
        // Logging
        // -------
        if let requestUrl = request.url {
            Pensopay.logDelegate?.log("Requesting URL: \(requestUrl)")
        }
        else {
            Pensopay.logDelegate?.log("Requesting unknown URL")
        }

        if let headers = request.allHTTPHeaderFields {
            Pensopay.logDelegate?.log("Headers: \(headers)")
        }
        
        if let postBody = request.httpBody, let json = String(data: postBody, encoding: String.Encoding.utf8) {
            Pensopay.logDelegate?.log("Body: \(json)")
        }
        
        Pensopay.logDelegate?.log("\n\n")
        // -------
        
        // Create a memory-only session.
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        // Create a new data-task for the session, which queues the HTTP call and parse the response
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let responseData = data, error == nil else {
                failure?(data, response, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Pensopay.logDelegate?.log("Response is not of type HTTPURLResponse")
                failure?(data, response, error)
                return
            }
            
            // If HTTP Success state we parse the result into the corresponding API Model
            if(PensopayHttpStatusCodes.isSuccessCode(statusCode: httpResponse.statusCode)) {
                do {
                    if let responseString = String(data: responseData, encoding: String.Encoding.utf8) {
                        Pensopay.logDelegate?.log("Response")
                        Pensopay.logDelegate?.log(responseString)
                    }
                    
                    let result: T = try JSONDecoder().decode(T.self, from: responseData)
                    success(result)
                }
                catch {
                    Pensopay.logDelegate?.log("Could not parse JSON response into type (\(T.self)): \(error)")
                    failure?(data, response, error)
                }
            }
            else {
                Pensopay.logDelegate?.log("HTTP response code is not in the success range (200-299): \(httpResponse.statusCode)")
                failure?(data, response, error)
            }
        }
        
        task.resume()
        
        // Tell the session to close down, and free all associated objects, once the data-task is completed.
        session.finishTasksAndInvalidate()
    }
}

/**
 A model representation of the error json returned by Pensopay in case of an error
 */
public struct PPRequestError : Codable {
    public let message: String
    public let errors: Dictionary<String, Array<String>>
    public let error_code: String
}
