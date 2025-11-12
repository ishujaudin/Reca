//
//  HomeRouter.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

enum HomeRouter: SwiftUIRouting {
    case recording

    func destination() -> AnyView? {
        switch self {
        case .recording:
            return RecordingScreen(viewModel: RecordingViewModel())
                .eraseToAnyView()
        }
    }
} 
