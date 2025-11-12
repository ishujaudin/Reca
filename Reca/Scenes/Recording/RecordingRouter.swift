//
//  RecordingRouter.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI

enum RecordingRouter: SwiftUIRouting {
    case settings(RecordingViewModel)
    case recordingComplete(RecordingViewModel, videoURL: URL, duration: TimeInterval)

    var dismissHandler: (() -> Void)? {
        switch self {
        case .settings(let viewModel):
            return {
                viewModel.showSettings = false
                viewModel.resetNavigationState()
            }
        case .recordingComplete(let viewModel, _, _):
            return {
                viewModel.resetNavigationState()
            }
        }
    }

    func destination() -> AnyView? {
        switch self {
        case .settings(let viewModel):
            return RecordingSettingsView(viewModel: viewModel)
                .eraseToAnyView()
        case .recordingComplete(let viewModel, let videoURL, let duration):
            return RecordingCompleteView(viewModel: viewModel, videoURL: videoURL, duration: duration)
                .eraseToAnyView()
        }
    }
}

