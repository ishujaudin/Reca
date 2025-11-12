//
//  RecaApp.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

@main
struct RecaApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(appState)
            }
        }
    }
}
