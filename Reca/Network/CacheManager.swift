//
//  CacheManager.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()

    private init() {}

    private var cache = NSCache<NSString, AnyObject>()

    /// Save data to cache as Data (serialized from the model)
    func saveResponse<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            cache.setObject(data as NSData, forKey: key as NSString)
        } catch {
            print("Failed to encode and cache value for key \(key): \(error)")
        }
    }

    /// Retrieve data from cache and decode it into the expected model
    func retrieveResponse<T: Codable>(forKey key: String) -> T? {
        guard let data = cache.object(forKey: key as NSString) as? Data else { return nil }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode cached value for key \(key): \(error)")
            return nil
        }
    }
}
