//
//  View+Navigate.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

@MainActor
protocol SwiftUIRouting {

    var dismissHandler: (() -> Void)? { get }

    // TODO: Nil case is not handled. It is not allowed to return nil with current implementation.
    func destination() -> AnyView?
}

extension SwiftUIRouting {

    var dismissHandler: (() -> Void)? { nil }
    var shouldAddDismissButtonForPresentedView: Bool { true }
}

extension View {

    func navigate(
        route: SwiftUIRouting?,
        shouldPush: Binding<Bool> = .constant(false),
        shouldPresent: Binding<Bool> = .constant(false),
        shouldPresentFullscreen: Binding<Bool> = .constant(false)
    ) -> some View {
        // TODO: Modifier method is not called due to iOs 13 bug
        ZStack {
//            NavigationLink("", isActive: shouldPush) {
//                route?.destination()
//            }

            NavigationLink(value: "") { }
                .navigationDestination(isPresented: shouldPush) { route?.destination() }

            self.sheet(isPresented: shouldPresent) {
                route?.dismissHandler?()
            } content: {
                route?.destination()
            }

            if shouldPresentFullscreen.wrappedValue {
                self.fullScreenCover(isPresented: shouldPresentFullscreen) {
                    route?.dismissHandler?()
                } content: {
                    route?.destination()
                }
            }
        }
    }
}
