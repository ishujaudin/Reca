//
//  ContentView.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @AppStorage(AppStorageManager.Key.onboardingCompleted) private var onboardingCompleted = false

    var body: some View {
        mainContent
            .raToastContainer()
    }

    @ViewBuilder
    private var mainContent: some View {
        HomeScreen(viewModel: HomeViewModel())
    }
}

#Preview {
    ContentView()
}
