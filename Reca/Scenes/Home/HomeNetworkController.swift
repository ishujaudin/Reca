
//
//  HomeNetworkController.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

class HomeNetworkController {

    func signup(email: String, phone: String, password: String) async throws { // ->  HomeResponse
//        let target = PreLoginAPIService.signup(email: email, phone: phone, password: password)
//        return try await NetworkManager.request(target, modelType: HomeResponse.self)
    }
}

// MARK: - Model

extension HomeNetworkController {
    
    struct HomeResponse: Decodable {
        let responseCode: Int
        let success: Bool
        let message: String
        let data: Data?
    }
}
