//
//  Image+Base64.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension Image {

    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String),
                let uiImage = UIImage(data: data) else {
            return nil
        }
        self.init(uiImage: uiImage)
    }
}
