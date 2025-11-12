//
//  RAUIViewControllerRepresentable.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import Foundation
import SwiftUI

protocol RAUIViewControllerRepresentable: UIViewControllerRepresentable { }

extension RAUIViewControllerRepresentable {

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> () -> Void {
        return {}
    }
}
