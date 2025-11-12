//
//  View+DismissButton.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func setPMDismissButton(
        _ animated: Bool = true,
        dismissHandler: (() -> Void)? = nil
    ) -> some View {
        self
            .navigationBarItems(
                trailing: dismissBarButton(animated: animated, dismissHandler: dismissHandler)
            )
    }

    private func dismissBarButton(animated: Bool = true, dismissHandler: (() -> Void)?) -> some View {
        BarButtonItemView(barItem: .dismiss) {
            dismiss(animated: animated, completion: dismissHandler)
        }
    }

    private func dismiss(animated: Bool, completion: (() -> Void)?) {
        UIApplication.raVisibleViewController()?.dismiss(
            animated: animated,
            completion: completion
        )
    }
}
