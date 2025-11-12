//
//  Endpoint.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Alamofire

enum Endpoint {
    static let baseURL = "https://jsonplaceholder.typicode.com"

    case fetchUsers
    case createUser(parameters: [String: Any])

    var path: String {
        switch self {
        case .fetchUsers: return "/users"
        case .createUser: return "/users/create"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchUsers: return .get
        case .createUser: return .post
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .fetchUsers:
            return URLEncoding.default
        case .createUser:
            return JSONEncoding.default
        }
    }

    var headers: HTTPHeaders {
        return [
            "Accept": "application/json"
        ]
    }
}
