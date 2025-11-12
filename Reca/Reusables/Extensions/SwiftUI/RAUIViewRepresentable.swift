//
//  RAUIViewRepresentable.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

protocol RAUIViewRepresentable: UIViewRepresentable {

    var dynamicHeight: Binding<CGFloat> { get }
}

extension RAUIViewRepresentable {

    var dynamicHeight: Binding<CGFloat> { .constant(.zero) }

    func updateUIView(_ uiView: Self.UIViewType, context: Self.Context) {}
}
