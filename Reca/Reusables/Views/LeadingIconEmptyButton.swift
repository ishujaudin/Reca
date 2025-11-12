//
//  LeadingIconButton.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

struct LeadingIconEmptyButton: View {
    let iconName: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Global.Margin.small) {
                Image(iconName)
                    .frame(width: 34, height: 34)
                    .padding(.leading, Global.Margin.xsmall)

                Text(title)

                Spacer()
            }
            .applyEmptyButtonStyling(with: .secondary)
        }
    }
}

#Preview {
    LeadingIconEmptyButton(iconName: "ic_paymentLink_share", title: "Button Title", action: {})
}
