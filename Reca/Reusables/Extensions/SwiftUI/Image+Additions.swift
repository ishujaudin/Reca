//
//  Image+Additions.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension Image {
    /// A view modifier that fills the available space with the image, preserving its center and cropping overflow.
    ///
    /// This method overlays a resizable, scaled-to-fill image on a transparent background and clips any overflow/spilling.
    /// Useful when displaying images in containers like `TabView`, ensuring full coverage without layout issues.
    ///
    /// - Returns: A view that renders the image centered and scaled to fill its container.
    ///
    /// ### Example:
    /// ```
    /// TabView {
    ///     ForEach(images, id: \.self) { image in
    ///         Image(image)
    ///             .centerFilled()
    ///             .clipShape(.rect(cornerRadius: 10))
    ///     }
    /// }
    ///
    func centerFilled() -> some View {
        Color.clear
        .overlay(
            self
            .resizable()
            .scaledToFill()
        )
        .clipped()
    }
}
