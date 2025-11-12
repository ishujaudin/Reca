//
//  BarButtonItemView.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

struct BarButtonItemView: View {

    let barItem: BarItem

    var action: (() -> Void)?
    @Environment(\.presentationMode) var presentation

    var body: some View {
        Button {
            action?()
        } label: {
            VStack(alignment: .center, spacing: .zero) {
                if barItem.imageName != nil {
                    HStack(spacing: .zero) {
                        sizedImage
                        Text("") // Workaround for ios 14 weak leading buttons
                    }
                }

                if let title = barItem.title {
                    Text(title)
                        .foregroundColor((barItem.color ??
                                          Global.theme.navigationBarTintColor).color)
                        .font(barItem.font.with(barItem.fontSize))
                }
            }
        }
    }

    private var sizedImage: some View {
        Image(barItem.imageName ?? "")
            .renderingMode(.original)
            .frame(width: barItem.size.width, height: barItem.size.height)
            .foregroundColor((barItem.color ?? Global.theme.navigationBarTintColor).color)
    }
}
