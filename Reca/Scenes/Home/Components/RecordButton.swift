//
//  RecordButton.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

// MARK: - Constants

private extension RecordButton {
    enum Constant {
        static let title = "Record"
        
        enum Size {
            static let height: CGFloat = 44
            static let cornerRadius: CGFloat = Global.CornerRadius.mediumHigh
            static let iconSize: CGFloat = 24
            static let spacing: CGFloat = 6
        }
        
        enum Color {
            static let text = Global.theme.primaryTextColor.color
        }
    }
}

// MARK: - RecordButton

struct RecordButton: View {
    let action: () -> Void
    
    var body: some View {
        mainContent
    }
    
    private var mainContent: some View {
        Button(action: action) {
            HStack(spacing: Constant.Size.spacing) {
                recordIcon
                Text(Constant.title)
                    .font(RAFont.kuunariBold.with(FontSize.body))
                    .foregroundColor(Constant.Color.text)
            }
            .frame(maxWidth: .infinity)
            .frame(height: Constant.Size.height)
            .background(AppGradients.lightToDeepMagentaHorozontal)
            .cornerRadius(Constant.Size.cornerRadius)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var recordIcon: some View {
        Image(.icVideo)
            .frame(width: Constant.Size.iconSize, height: Constant.Size.iconSize)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        RecordButton(action: {})
    }
    .padding()
    .background(Color.black)
}

