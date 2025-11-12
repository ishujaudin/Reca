//
//  RetryPolicy.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation
import Alamofire

final class RetryPolicy: RequestInterceptor {
    private let maxRetries = 3
    private let retryDelay: TimeInterval = 2.0

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < maxRetries else {
            completion(.doNotRetry)
            return
        }

        // Retry only for server errors (500-599)
        if let response = request.response, (500...599).contains(response.statusCode) {
            print("Retry attempt \(request.retryCount)...")
            // Exponential backoff
            let delay = pow(retryDelay, Double(request.retryCount))
            completion(.retryWithDelay(delay))
        } else {
            // Do not retry on 404 or other client errors
            completion(.doNotRetry)
        }
    }
}
