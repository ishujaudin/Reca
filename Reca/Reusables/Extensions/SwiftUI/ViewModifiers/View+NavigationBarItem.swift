//
//  View+NavigationBarItem.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func raNavigationBarLeadingItems(_ firstBarButton: AnyView,
                                      secondBarButton: AnyView? = nil) -> some View {
        modifier(RANavigationBarLeadingContainer(firstBarButton: firstBarButton,
                                                  secondBarButton: secondBarButton))
    }

    func raNavigationBarTrailingItems(_ firstBarButton: AnyView,
                                       secondBarButton: AnyView? = nil) -> some View {
        modifier(RANavigationBarTrailingContainer(firstBarButton: firstBarButton,
                                                   secondBarButton: secondBarButton))
    }

    func raNavigationBarItems(isBackButtonVisible: Bool = true,
                               shouldGoBacktoHome: Bool = false,
                               firstLeadingBarButton: AnyView? = nil,
                               secondLeadingBarButton: AnyView? = nil,
                               firstTrailingBarButton: AnyView? = nil,
                               secondTrailingBarButton: AnyView? = nil) -> some View {
        modifier(RANavigationBarContainer(
            isBackButtonVisible: isBackButtonVisible,
            shouldGoBacktoHome: shouldGoBacktoHome,
            firstLeadingBarButton: firstLeadingBarButton,
            secondLeadingBarButton: secondLeadingBarButton,
            firstTrailingBarButton: firstTrailingBarButton,
            secondTrailingBarButton: secondTrailingBarButton)
        )
    }
}

/// This modifier is necessary because navigationBarItems' leading and trailing items needs to be set in one step.
private struct RANavigationBarContainer: ViewModifier {

    let isBackButtonVisible: Bool
    let shouldGoBacktoHome: Bool

    let firstLeadingBarButton: AnyView?
    let secondLeadingBarButton: AnyView?
    let firstTrailingBarButton: AnyView?
    let secondTrailingBarButton: AnyView?

    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        if #available(iOS 14.2, *) {
            content
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if isBackButtonVisible {
                            backBarButton
                                .eraseToAnyView()
                        }
                        firstLeadingBarButton
                        secondLeadingBarButton
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        firstTrailingBarButton
                        secondTrailingBarButton
                    }
                }
        } else {
            content
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        HStack(spacing: Global.Margin.medium) {
                            if isBackButtonVisible {
                                backBarButton
                                    .eraseToAnyView()
                            }
                            firstLeadingBarButton
                            secondLeadingBarButton
                        },
                    trailing:
                        HStack(spacing: Global.Margin.medium) {
                            firstTrailingBarButton
                            secondTrailingBarButton
                        }
                )
        }
    }

    private var backBarButton: some View {
        BarButtonItemView(barItem: .back) {
            if shouldGoBacktoHome {
                // TODO: go home
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

private struct RANavigationBarLeadingContainer: ViewModifier {

    let firstBarButton: AnyView
    let secondBarButton: AnyView?

    func body(content: Content) -> some View {
        if #available(iOS 14.2, *) {
            content
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        firstBarButton
                        secondBarButton
                    }
                }
        } else {
            content
                .navigationBarItems(
                    leading:
                        HStack(spacing: Global.Margin.medium) {
                            firstBarButton
                            secondBarButton
                        }
                )
        }
    }
}

private struct RANavigationBarTrailingContainer: ViewModifier {

    let firstBarButton: AnyView
    let secondBarButton: AnyView?

    func body(content: Content) -> some View {
        if #available(iOS 14.2, *) {
            content
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        firstBarButton
                        secondBarButton
                    }
                }
        } else {
            content
                .navigationBarItems(
                    trailing:
                        HStack(spacing: Global.Margin.medium) {
                            firstBarButton
                            secondBarButton
                        }
                )
        }
    }
}
