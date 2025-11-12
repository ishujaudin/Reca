//
//  RoundedTextFieldStyle.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    var isValid: Bool = true

    init(isValid: Bool = true) {
        self.isValid = isValid
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .tint(Global.theme.appThemeColor.color)
            .font(RAFont.regular.with(FontSize.textField))
            .foregroundStyle(Global.theme.coolDarkGreyTextColor.color)
            .padding(Global.Margin.medium)
            .frame(height: Global.Height.xxxlarge)
            .background(
                RoundedRectangle(cornerRadius: Global.CornerRadius.midHigh)
                    .stroke(isValid ? Global.theme.lightGreyBorderColor.color : Global.theme.errorColor.color, lineWidth: Global.StrokeWidth.tiny)
                    .background(Global.theme.primaryBackgroundColor.color)
            )
    }
}
