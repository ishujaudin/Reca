//
//  NetworkManager.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let session: Session

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        session = Session(configuration: configuration, interceptor: RetryPolicy())
    }


    func request<T: Codable>(endpoint: Endpoint, parameters: [String: Any]? = nil, responseModel: T.Type, useCache: Bool = true) async throws -> T {
        let url = "\(Endpoint.baseURL)\(endpoint.path)"

        if useCache, endpoint.method == .get {
            if let cachedResponse: T = CacheManager.shared.retrieveResponse(forKey: url) {
                return cachedResponse
            }
        }

        let request = session.request(url, method: endpoint.method, parameters: parameters, encoding: endpoint.encoding)
        let response = await request.serializingData().response
        guard let statusCode = response.response?.statusCode else { throw NetworkError.invalidResponse }

        // Handle different status codes
        switch statusCode {
        case 200:
            guard let data = response.data else { throw NetworkError.noData }
            let decodedModel = try JSONDecoder().decode(T.self, from: data)
            if endpoint.method == .get { CacheManager.shared.saveResponse(decodedModel, forKey: url) }
            return decodedModel
        case 401: throw NetworkError.unauthorized
        case 404: throw NetworkError.notFound
        case 500...599: throw NetworkError.serverError
        default: throw NetworkError.unknown
        }
    }
}


// Usage
//
/*
private func fetchUsers() { // Call from ViewModel
    Task {
        do {
            let networkController = UserNetworkController()
            users = try await networkController.fetchUsers()
            print(users)
        } catch {
            print("Error " + error.localizedDescription)
        }
    }
}

class UserNetworkController { // Every Screen has separete NetworkController
    struct User: Codable {
        let id: Int
        let name: String
        let email: String
    }

    func fetchUsers() async throws -> [User] {
        try await NetworkManager.shared.request(endpoint: .fetchUsers, responseModel: [User].self)
    }
}
 */
