//
//  RecordingCompleteView.swift
//  Reca
//
//  Created by Claude on 11/12/2025.
//

import SwiftUI
import AVKit

struct RecordingCompleteView: View {
    @ObservedObject var viewModel: RecordingViewModel
    @Environment(\.dismiss) private var dismiss

    let videoURL: URL
    let duration: TimeInterval

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if viewModel.orientation == .landscapeLeft {
                landscapeLeftLayout
            } else if viewModel.orientation == .landscapeRight {
                landscapeRightLayout
            } else {
                portraitLayout
            }
        }
        .onRotate { newOrientation in
            // Filter out invalid orientations
            guard newOrientation == .portrait ||
                  newOrientation == .portraitUpsideDown ||
                  newOrientation == .landscapeLeft ||
                  newOrientation == .landscapeRight else {
                return
            }

            Task { @MainActor in
                viewModel.orientation = newOrientation
            }
        }
        .onDisappear {
            // Resume camera when dismissing
            print("📹 [RecordingCompleteView] onDisappear - Resuming camera")
            viewModel.resumeCameraSession()
        }
    }

    // MARK: - Portrait Layout

    private var portraitLayout: some View {
        ZStack {
            videoPlayer

            VStack {
                // Top: Upload button and duration
                HStack {
                    closeButton
                        .padding(.leading, Global.Margin.medium)
                    Spacer()
                    durationBadge
                    Spacer()
                    deleteButton
                        .padding(.trailing, Global.Margin.medium)
                }
                .padding(.top, Global.Margin.medium)
                .padding(.horizontal, Global.Margin.large)

                Spacer()


                // Bottom: Share and Close buttons
                HStack(spacing: Global.Margin.xlarge) {
                    shareButton
                }
                .padding(.bottom, Global.Margin.xxxlarge)
            }
            .padding(.vertical, Global.Margin.xlarge)
        }
        .padding(.bottom, 60)
    }

    // MARK: - Landscape Left Layout

    private var landscapeLeftLayout: some View {
        videoPlayer
            .overlay(alignment: .top) {
                // Top center: Duration badge
                durationBadge
                    .padding(.top, Global.Margin.medium)
            }
            .overlay(alignment: .topTrailing) {
                // Top right: Delete button
                deleteButton
                    .padding(.top, Global.Margin.medium)
                    .padding(.trailing, Global.Margin.medium)
            }
            .overlay(alignment: .leading) {
                // Left side: Share button (vertically centered)
                shareButton
                    .padding(.leading, Global.Margin.large)
            }
            .overlay(alignment: .bottomTrailing) {
                // Bottom right: Close button
                closeButton
                    .padding(.trailing, Global.Margin.medium)
                    .padding(.bottom, Global.Margin.medium)
            }
    }

    // MARK: - Landscape Right Layout

    private var landscapeRightLayout: some View {
        videoPlayer
            .overlay(alignment: .top) {
                // Top center: Duration badge
                durationBadge
                    .padding(.top, Global.Margin.medium)
            }
            .overlay(alignment: .topLeading) {
                // Top left: Delete button
                deleteButton
                    .padding(.top, Global.Margin.medium)
                    .padding(.leading, Global.Margin.medium)
            }
            .overlay(alignment: .trailing) {
                // Right side: Share button (vertically centered)
                shareButton
                    .padding(.trailing, Global.Margin.large)
            }
            .overlay(alignment: .bottomLeading) {
                // Bottom left: Close button
                closeButton
                    .padding(.leading, Global.Margin.medium)
                    .padding(.bottom, Global.Margin.medium)
            }
    }

    // MARK: - Components

    private var videoPlayer: some View {
        VideoThumbnailView(url: videoURL)
            .clipped()
            .cornerRadius(Global.CornerRadius.mediumHigh, corners: .allCorners)
            .padding(Global.Margin.small)
    }

    private var durationBadge: some View {
        Text(formatTime(duration))
            .font(RAFont.sfProMedium.with(FontSize.tinyText))
            .foregroundColor(.white)
            .frame(width: 54, height: 32)
            .background(Color.black.opacity(Global.Opacity.medium))
            .cornerRadius(Global.CornerRadius.high)
    }

    private var deleteButton: some View {
        Button(action: handleDelete) {
            Image(.icBin)
                .frame(width: Global.Height.xxlarge, height: Global.Height.xxlarge)
                .background(Circle().fill(Color.black.opacity(Global.Opacity.medium)))
        }
    }

    private var shareButton: some View {
        Button(action: handleShare) {
            Image(.icUpload)
                .frame(width: 60, height: 60)
                .background(Circle().fill(Color(hex: "CC00A7")))
        }
    }

    private var closeButton: some View {
        Button(action: handleClose) {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .frame(width: Global.Height.xxlarge, height: Global.Height.xxlarge)
                .background(Circle().fill(Color.black.opacity(Global.Opacity.medium)))
        }
    }
    

    // MARK: - Actions

    private func handleUpload() {
        // Show native share sheet on upload button tap
        handleShare()
    }

    private func handleShare() {
        print("📹 [RecordingCompleteView] handleShare - Starting share")

        // Show native share sheet
        let activityVC = UIActivityViewController(
            activityItems: [videoURL],
            applicationActivities: nil
        )

        // Handle completion
        activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            print("📹 [RecordingCompleteView] handleShare - Completion: type=\(String(describing: activityType)), completed=\(completed)")

            if completed {
                // User successfully shared the video
                Task { @MainActor in
                    self.viewModel.pendingUploads += 1
                    print("📹 [RecordingCompleteView] handleShare - Incremented uploads count to \(self.viewModel.pendingUploads)")

                    // Clear and dismiss
                    self.viewModel.clearPostRecordingState()
                    self.dismiss()
                }
            } else {
                // User cancelled, just stay on the screen
                print("📹 [RecordingCompleteView] handleShare - User cancelled")
            }
        }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {

            // Find the topmost presented view controller
            var topVC = window.rootViewController
            while let presented = topVC?.presentedViewController {
                topVC = presented
            }

            guard let presentingVC = topVC else {
                print("📹 [RecordingCompleteView] handleShare - ⚠️ No presenting VC found")
                return
            }

            // For iPad support
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = presentingVC.view
                popover.sourceRect = CGRect(x: presentingVC.view.bounds.midX, y: presentingVC.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }

            print("📹 [RecordingCompleteView] handleShare - Presenting share sheet")
            presentingVC.present(activityVC, animated: true) {
                print("📹 [RecordingCompleteView] handleShare - Share sheet presented")
            }
        } else {
            print("📹 [RecordingCompleteView] handleShare - ⚠️ No window found")
        }
    }

    private func handleDelete() {
        print("📹 [RecordingCompleteView] handleDelete - Deleting video")

        // Delete the video file
        try? FileManager.default.removeItem(at: videoURL)

        // Clear the last recorded URL
        viewModel.clearPostRecordingState()

        // Dismiss back to camera (do NOT increment uploads count)
        dismiss()
    }

    private func handleClose() {
        print("📹 [RecordingCompleteView] handleClose - Keeping video for later")

        // Update pending uploads count (video is kept for later upload)
        viewModel.pendingUploads += 1

        // Clear the last recorded URL
        viewModel.clearPostRecordingState()

        // Dismiss back to camera
        dismiss()
    }

    // MARK: - Helpers

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - Video Thumbnail View

struct VideoThumbnailView: View {
    let url: URL
    @State private var thumbnail: UIImage?

    var body: some View {
        GeometryReader { geometry in
            Group {
                if let thumbnail = thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                } else {
                    Color.black
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        .onAppear {
            generateThumbnail()
        }
    }

    private func generateThumbnail() {
        Task {
            let asset = AVURLAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            imageGenerator.maximumSize = CGSize(width: 1920, height: 1080)

            do {
                let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
                await MainActor.run {
                    thumbnail = UIImage(cgImage: cgImage)
                }
            } catch {
                print("Error generating thumbnail: \(error)")
            }
        }
    }
}
