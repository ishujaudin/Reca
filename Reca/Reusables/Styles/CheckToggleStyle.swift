//
//  CheckToggleStyle.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

struct CheckToggleStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundStyle(configuration.isOn ? Global.theme.appThemeColor.color : Global.theme.lightGreyBorderColor.color)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(.plain)
    }
}
