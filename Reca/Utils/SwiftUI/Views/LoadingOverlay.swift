//
//  LoadingOverlay.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

struct LoadingOverlay: View {
    
    enum State {
        case loaded
        case loading
    }

    @Binding var state: State

    var body: some View {
        ZStack {
            Color.white.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
        }
    }
}
