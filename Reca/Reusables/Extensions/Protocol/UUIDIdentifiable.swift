//
//  UUIDIdentifiable.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation

protocol UUIDIdentifiable: Identifiable {

    var id: UUID { get }
}
