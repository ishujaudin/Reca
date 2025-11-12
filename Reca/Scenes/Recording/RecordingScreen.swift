//
//  RecordingScreen.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI
import AVFoundation

// MARK: - Constants

extension RecordingScreen {
    enum Constant {
        enum Size {
            static let controlButtonSize: CGFloat = Global.Height.xxlarge
            static let srttingsAndZoomButtonSize: CGFloat = Global.Height.xlarge
            static let recordButtonSize: CGFloat = 80
            static let zoomButtonSize: CGFloat = 28.0
            static let topPadding: CGFloat = Global.Margin.medium
            static let bottomPadding: CGFloat = Global.Margin.large
            static let horizontalPadding: CGFloat = Global.Margin.medium
            static let controlSpacing: CGFloat = Global.Margin.medium
            static let liveButtonSize: CGFloat = 60.0

            static let srttingsAndZoomButtonCornerRadius: CGFloat = 15.0
            static let sideControlsWidth: CGFloat = 100
        }

        enum Colors {
            static let buttonsOpacity: Color = Color.black.opacity(Global.Opacity.medium)
            static let liveColor: Color = Color(hex: "2C0085")
        }
    }
}

// MARK: - RecordingScreen

struct RecordingScreen: View {
    @ObservedObject var viewModel: RecordingViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        mainContent
            .navigate(
                route: viewModel.route,
                shouldPush: $viewModel.shouldPush,
                shouldPresent: $viewModel.shouldPresent,
                shouldPresentFullscreen: $viewModel.shouldPresentFullscreen
            )
            .onRotate { newOrientation in
                // Update orientation asynchronously to avoid blocking UI
                Task { @MainActor in
                    viewModel.orientation = newOrientation
                }
                // Update video orientation on background thread
                viewModel.updateVideoOrientation()
            }
            .onAppear {
                viewModel.orientation = UIDevice.current.orientation
                // Delay video orientation update slightly to ensure session is ready
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    viewModel.updateVideoOrientation()
                }
            }
    }

    private var mainContent: some View {
        ZStack {
            if viewModel.orientation.isPortrait {
                portraitLayout
            } else if viewModel.orientation == .landscapeLeft {
                landscapeLeftLayout
            } else {
                landscapeRightLayout
            }
        }
        .background(.black)
        .animation(.none, value: viewModel.orientation) // No animation to prevent lag
    }
}

// MARK: - Portrait Layout

private extension RecordingScreen {

    var portraitLayout: some View {
        VStack(spacing: .zero) {
            // Camera view
            ZStack {
                cameraView

                // Video thumbnail (if available)
                if let videoURL = viewModel.lastRecordedVideoURL {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            videoThumbnail(url: videoURL)
                                .padding(.trailing, Constant.Size.horizontalPadding)
                                .padding(.bottom, Constant.Size.bottomPadding)
                        }
                    }
                }

                // Overlay controls
                VStack {
                    portraitTopControls

                    if !viewModel.isRecording {
                        ss2Badge
                    }

                    Spacer()

                    if !viewModel.isRecording {
                        portraitBottomControls
                    } else {
                        // When recording, show zoom controls and record button
                        VStack(spacing: Constant.Size.controlSpacing) {
                            zoomControlsHorizontal
                            recordButton
                        }
                        .padding(.bottom, Constant.Size.bottomPadding)
                    }
                }
            }

            // Save and upload controls at bottom
            if !viewModel.isRecording {
                portraitSaveAndUploadControls
            }
        }
    }

    var portraitTopControls: some View {
        HStack {
            if !viewModel.isRecording {
                closeButton
            } else {
                // Keep spacing balanced when recording
                Color.clear
                    .frame(width: Constant.Size.controlButtonSize, height: Constant.Size.controlButtonSize)
            }
            Spacer()
            if viewModel.isRecording {
                recordingTimer
            }
            Spacer()
            if !viewModel.isRecording {
                uploadButton
            } else {
                // Keep spacing balanced
                Color.clear
                    .frame(width: Constant.Size.controlButtonSize, height: Constant.Size.controlButtonSize)
            }
        }
        .padding(.horizontal, Constant.Size.horizontalPadding)
        .padding(.top, Constant.Size.topPadding)
    }

    var portraitBottomControls: some View {
        VStack(spacing: Constant.Size.controlSpacing) {
            zoomControlsHorizontal
            HStack(spacing: Constant.Size.controlSpacing) {
                settingsButton
                recordButton
                lensButton
            }
        }
        .padding(.horizontal, Constant.Size.horizontalPadding)
        .padding(.bottom, Constant.Size.bottomPadding)
    }
}

// MARK: - Landscape Left Layout

private extension RecordingScreen {

    var landscapeLeftLayout: some View {
        HStack(spacing: .zero) {
            // Left side controls
            if !viewModel.isRecording {
                landscapeLeftSideControls
            }

            // Camera view with overlays
            ZStack {
                cameraView

                // Video thumbnail (if available)
                if let videoURL = viewModel.lastRecordedVideoURL {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            videoThumbnail(url: videoURL)
                                .padding(.trailing, Constant.Size.horizontalPadding)
                                .padding(.bottom, Constant.Size.bottomPadding)
                        }
                    }
                }

                // Top left badges
                VStack {
                    HStack {
                        if !viewModel.isRecording {
                            HStack(spacing: Global.Margin.small) {
                                uploadButton
                                ss2BadgeOnly
                            }
                            .padding(.top, Constant.Size.topPadding)
                            .padding(.leading, Constant.Size.horizontalPadding)
                        }
                        Spacer()
                    }
                    Spacer()
                }

                // Bottom right close button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if !viewModel.isRecording {
                            closeButton
                                .padding(.trailing, Constant.Size.horizontalPadding)
                                .padding(.bottom, Constant.Size.bottomPadding)
                        }
                    }
                }

                // Center controls (always vertically centered)
                VStack {
                    HStack {
                        if viewModel.isRecording {
                            recordingTimer
                        }
                    }
                    .padding(.top, Constant.Size.topPadding)

                    // Always vertically centered
                    Spacer()
                    HStack {
                        landscapeLeftBottomControls
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }

    var landscapeLeftSideControls: some View {
        VStack {
            Spacer()
            uploadMediaButton
            Spacer()
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(width: Constant.Size.sideControlsWidth / 2, height: 1)
            Spacer()
            saveToDeviceToggle
            Spacer()
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(width: Constant.Size.sideControlsWidth / 2, height: 1)
            Spacer()
            liveButton
            Spacer()
        }
        .frame(width: Constant.Size.sideControlsWidth)
        .frame(maxHeight: .infinity)
        .padding(.vertical, Global.Margin.xxlarge)
        .background(.black)
    }

    var landscapeLeftBottomControls: some View {
        HStack(spacing: viewModel.isOneHandedMode ? Constant.Size.controlSpacing : 0) {
            // First column: Lens+Record+Settings
            if !viewModel.isRecording {
                VStack(spacing: Global.Margin.small) {
                    lensButton
                    recordButton
                    settingsButton
                }
            } else {
                recordButton
            }

            if !viewModel.isOneHandedMode {
                Spacer()
            }

            // Second column: Zoom buttons
            VStack(spacing: Global.Margin.small) {
                zoomButton(zoom: 5.0)
                zoomButton(zoom: 2.0)
                zoomButton(zoom: 1.0)
            }
        }
        .padding(.leading, Constant.Size.horizontalPadding)
    }
}

// MARK: - Landscape Right Layout

private extension RecordingScreen {

    var landscapeRightLayout: some View {
        HStack(spacing: .zero) {
            // Camera view with overlays
            ZStack {
                cameraView

                // Video thumbnail (if available)
                if let videoURL = viewModel.lastRecordedVideoURL {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            videoThumbnail(url: videoURL)
                                .padding(.trailing, Constant.Size.horizontalPadding)
                                .padding(.bottom, Constant.Size.bottomPadding)
                        }
                    }
                }

                // Top left badges
                VStack {
                    HStack {
                        if !viewModel.isRecording {
                            HStack(spacing: Global.Margin.small) {
                                uploadButton
                                ss2BadgeOnly
                            }
                            .padding(.top, Constant.Size.topPadding)
                            .padding(.leading, Constant.Size.horizontalPadding)
                        }
                        Spacer()
                    }
                    Spacer()
                }

                // Bottom left close button
                VStack {
                    Spacer()
                    HStack {
                        if !viewModel.isRecording {
                            closeButton
                                .padding(.leading, Constant.Size.horizontalPadding)
                                .padding(.bottom, Constant.Size.bottomPadding)
                        }
                        Spacer()
                    }
                }

                // Center controls (always vertically centered)
                VStack {
                    HStack {
                        if viewModel.isRecording {
                            recordingTimer
                        }
                    }
                    .padding(.top, Constant.Size.topPadding)

                    // Always vertically centered
                    Spacer()
                    HStack {
                        Spacer()
                        landscapeRightBottomControls
                    }
                    Spacer()
                }
            }

            // Right side controls
            if !viewModel.isRecording {
                landscapeRightSideControls
            }
        }
    }

    var landscapeRightSideControls: some View {
        VStack {
            Spacer()
            liveButton
            Spacer()
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(width: Constant.Size.sideControlsWidth / 2, height: 1)
            Spacer()
            saveToDeviceToggle
            Spacer()
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(width: Constant.Size.sideControlsWidth / 2, height: 1)
            Spacer()
            uploadMediaButton
            Spacer()
        }
        .frame(width: Constant.Size.sideControlsWidth)
        .frame(maxHeight: .infinity)
        .padding(.vertical, Global.Margin.xxlarge)
        .background(.black)
    }

    var landscapeRightBottomControls: some View {
        HStack(spacing: viewModel.isOneHandedMode ? Constant.Size.controlSpacing : 0) {
            // First column: Zoom buttons
            VStack(spacing: Global.Margin.small) {
                zoomButton(zoom: 5.0)
                zoomButton(zoom: 2.0)
                zoomButton(zoom: 1.0)
            }

            if !viewModel.isOneHandedMode {
                Spacer()
            }

            // Second column: Lens+Record+Settings
            if !viewModel.isRecording {
                VStack(spacing: Global.Margin.small) {
                    lensButton
                    recordButton
                    settingsButton
                }
            } else {
                recordButton
            }
        }
        .padding(.trailing, Constant.Size.horizontalPadding)
    }
}

// MARK: - View Components

private extension RecordingScreen {

    var cameraView: some View {
        Group {
            if let session = viewModel.cameraSession {
                CameraPreview(session: session)
                    .cornerRadius(Global.CornerRadius.mediumHigh, corners: .allCorners)
                    .id("camera-preview") // Stable ID to prevent recreation
            } else {
                Color.black
                    .id("camera-placeholder")
            }
        }
    }

    func videoThumbnail(url: URL) -> some View {
        Button(action: {
            // Show recording complete view when tapping thumbnail
            viewModel.showRecordingComplete(videoURL: url, duration: viewModel.recordingDuration)
        }) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "video.fill")
                            .foregroundColor(.white)
                    )
            }
        }
    }
}

// MARK: - Control Components

private extension RecordingScreen {

    var closeButton: some View {
        Button {
            viewModel.didTapClose()
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .frame(width: Constant.Size.controlButtonSize, height: Constant.Size.controlButtonSize)
                .background( Circle().fill(Constant.Colors.buttonsOpacity))
        }
    }

    var uploadButton: some View {
        Button(action: viewModel.didTapUpload) {
            Image(.icUpload)
                .frame(width: Constant.Size.controlButtonSize, height: Constant.Size.controlButtonSize)
                .background(Circle().fill(Constant.Colors.buttonsOpacity).stroke(Color.yellow, lineWidth: 1))
                .overlay(alignment: .topTrailing) {
                    if viewModel.pendingUploads > 0 { uplaodsBadge }
                }
        }
    }

    var ss2Badge: some View {
        HStack {
            Spacer()
            Text("SS2")
                .font(RAFont.medium.with(FontSize.tinyText))
                .foregroundColor(Global.theme.tertiaryTextColor.color)
                .frame(width: Constant.Size.controlButtonSize, height: Constant.Size.controlButtonSize)
                .background(Constant.Colors.buttonsOpacity)
                .clipShape(Circle())
        }
        .padding(.top, 16)
        .padding(.horizontal, Constant.Size.horizontalPadding)
    }

    var ss2BadgeOnly: some View {
        Text("SS2")
            .font(RAFont.medium.with(FontSize.tinyText))
            .foregroundColor(Global.theme.tertiaryTextColor.color)
            .frame(width: Constant.Size.controlButtonSize, height: Constant.Size.controlButtonSize)
            .background(Constant.Colors.buttonsOpacity)
            .clipShape(Circle())
    }

    var uplaodsBadge: some View {
        Circle().fill(Color.red)
            .frame(width: 20, height: 20)
            .overlay(uplaodsBadgeText)
            .offset(x: 10, y: 20)
    }

    var uplaodsBadgeText: some View {
        Text("\(viewModel.pendingUploads)")
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.white)
    }

    var recordingTimer: some View {
        Text(formatTime(viewModel.recordingDuration))
            .font(RAFont.medium.with(FontSize.body))
            .foregroundColor(.white)
            .padding(.horizontal, Global.Margin.medium)
            .padding(.vertical, Global.Margin.small)
            .background(Constant.Colors.buttonsOpacity)
            .cornerRadius(Global.CornerRadius.mid)
    }

    var recordButton: some View {
        Button(action: viewModel.didTapRecord) {
            ZStack {
                Circle()
                    .fill(viewModel.isRecording ? Color.red : Color.red.opacity(0.3))
                    .frame(width: Constant.Size.recordButtonSize, height: Constant.Size.recordButtonSize)
                if !viewModel.isRecording {
                    Circle()
                        .stroke(Color.red, lineWidth: 4)
                        .frame(width: Constant.Size.recordButtonSize - 8, height: Constant.Size.recordButtonSize - 8)
                }
            }
        }
    }

    var zoomControlsHorizontal: some View {
        HStack(spacing: Global.Margin.small) {
            ForEach([1.0, 2.0, 5.0], id: \.self) { zoom in
                zoomButton(zoom: zoom)
            }
        }
    }

    func zoomButton(zoom: CGFloat) -> some View {
        Button(action: { viewModel.didSelectZoom(zoom) }) {
            Text("\(Int(zoom))x")
                .font(RAFont.medium.with(FontSize.tinyText))
                .foregroundColor(viewModel.selectedZoom == zoom ? Color.yellow : Color.white)
                .frame(width: Constant.Size.zoomButtonSize, height: Constant.Size.zoomButtonSize)
                .background(Constant.Colors.buttonsOpacity)
                .clipShape(Circle())
        }
    }

    var settingsButton: some View {
        Button(action: viewModel.didTapSettings) {
            HStack(spacing: 8) {
                Image(systemName: "gearshape")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .regular))
                Text("Settings")
                    .font(RAFont.regular.with(FontSize.tinyText))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, Global.Margin.small)
            .frame(height: Constant.Size.srttingsAndZoomButtonSize)
            .background(Constant.Colors.buttonsOpacity)
            .cornerRadius(Constant.Size.srttingsAndZoomButtonCornerRadius)
        }
    }

    var lensButton: some View {
        Button(action: { viewModel.didSelectLens("24mm") }) {
            HStack(spacing: 8) {
                Image(systemName: "camera")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .regular))
                Text(viewModel.selectedLens)
                    .font(RAFont.regular.with(FontSize.tinyText))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, Global.Margin.small)
            .frame(height: Constant.Size.srttingsAndZoomButtonSize)
            .background(Constant.Colors.buttonsOpacity)
            .cornerRadius(Constant.Size.srttingsAndZoomButtonCornerRadius)
        }
    }

    private var portraitSaveAndUploadControls: some View {
        HStack(spacing: Global.Margin.small) {
            uploadMediaButton
            Divider()
                .background(Color.white.opacity(0.3))
            saveToDeviceToggle
            Divider()
                .background(Color.white.opacity(0.3))
            liveButton
        }
        .frame(height: 50)
        .padding(.top, Global.Margin.medium)
        .padding(.horizontal, Global.Margin.medium)
        .background(.black)
    }

    private var uploadMediaButton: some View {
        Button(action: viewModel.didTapUpload) {
            VStack(spacing: 8) {
                Text("Upload Media")
                    .font(RAFont.bold.with(FontSize.tinyText))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Image(.icUpload)
            }
        }
    }

    private var saveToDeviceToggle: some View {
        VStack(spacing: 4) {
            Text("Save to Device")
                .font(RAFont.bold.with(FontSize.smallBody))
                .foregroundColor(Global.theme.secondaryButtonTextColor.color)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            HStack(alignment: .center) {
                Spacer()
                Toggle("", isOn: $viewModel.autoSaveToDevice)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                Spacer()
            }
        }
        .padding(.horizontal, Global.Margin.small)
        .padding(.vertical, Global.Margin.tiny)
    }

    private var liveButton: some View {
        Button(action: {}) {
            HStack(spacing: .zero) {
                Image(.icLive)
            }
            .frame(height: Constant.Size.liveButtonSize)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, viewModel.orientation.isPortrait ? Global.Margin.xxlarge : Global.Margin.small)
            .background(Constant.Colors.liveColor)
            .cornerRadius(Global.CornerRadius.extraHigh)
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - Preview

#Preview {
    RecordingScreen(viewModel: RecordingViewModel())
}
