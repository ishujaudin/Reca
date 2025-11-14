//
//  UploadersBadge.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - Constants

private extension UploadersBadge {
    enum Constant {
        enum Size {
            static let horizontalPadding: CGFloat = Global.Margin.small
            static let height: CGFloat = Global.Height.largeMedium
            static let cornerRadius: CGFloat = Global.CornerRadius.regular
        }
        
        enum Color {
            static let background = Global.theme.tertiaryButtonColor.color // Light pink
            static let text = Global.theme.tertiaryButtonTextColor.color // Dark pink
        }
    }
}

// MARK: - UploadersBadge

struct UploadersBadge: View {
    let count: Int
    
    var body: some View {
        mainContent
    }

    private var mainContent: some View {
        Text("\(count) uploaders")
            .font(RAFont.sfProBold.with(FontSize.smallBody))
            .foregroundColor(Constant.Color.text)
            .frame(height: Constant.Size.height)
            .padding(.horizontal, Constant.Size.horizontalPadding)
            .background(Constant.Color.background)
            .cornerRadius(Constant.Size.cornerRadius)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        UploadersBadge(count: 0)
        UploadersBadge(count: 5)
        UploadersBadge(count: 100)
    }
    .padding()
    .background(Color.black)
}

