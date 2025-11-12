//
//  View+List.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

extension View {

    func raListAppearance<T: ListStyle>(style: T) -> some View {
        modifier(ListAppearanceModifier(style: style))
    }

    func raListHeaderPadding(_ edges: Edge.Set = .all, length: CGFloat = .zero) -> some View {
        modifier(ListHeaderPadding(edges: edges, length: length))
    }

    func raSectionHeaderStyle() -> some View {
        modifier(SectionHeaderStyle())
    }
}

private struct ListAppearanceModifier<T: ListStyle>: ViewModifier {

    let style: T

    func body(content: Content) -> some View {
        content
            .listStyle(style)
            .onAppear {
                if #available(iOS 15.0, *) {
                    UITableView.appearance().sectionHeaderTopPadding = 0
                }

                UITableView.appearance().separatorColor = .clear
                UITableView.appearance().tableFooterView = UIView()
            }
            .environment(\.defaultMinListRowHeight, .zero)
    }
}

private struct ListHeaderPadding: ViewModifier {

    let edges: Edge.Set
    let length: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(edges, length)
            .listRowInsets(EdgeInsets())
    }
}

private struct SectionHeaderStyle: ViewModifier {

    func body(content: Content) -> some View {
        Group {
            if #available(iOS 14, *) {
                AnyView(content.textCase(.none))
            } else {
                content
            }
        }
    }
}
