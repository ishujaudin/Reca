//
//  RecordingDelegate.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import AVFoundation
import Foundation

final class RecordingDelegate: NSObject, AVCaptureFileOutputRecordingDelegate {
    weak var viewModel: RecordingViewModel?
    
    init(viewModel: RecordingViewModel) {
        self.viewModel = viewModel
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("Started recording to: \(fileURL)")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording: \(error)")
            Task { @MainActor [weak self] in
                self?.viewModel?.error = error
                self?.viewModel?.isRecording = false
            }
            return
        }

        print("Finished recording to: \(outputFileURL)")

        Task { @MainActor [weak self] in
            guard let viewModel = self?.viewModel else { return }

            // Save to local storage if needed
            await viewModel.saveVideoToLocalStorage(url: outputFileURL)

            // If autoSaveToDevice is ON, skip the completion screen
            // Just save to photos in background and increment uploads count
            if viewModel.autoSaveToDevice {
                print("📹 [RecordingDelegate] Auto-save enabled, skipping completion screen")
                // Increment pending uploads count
                viewModel.pendingUploads += 1
                // Clear the last recorded URL since we're not showing it
                viewModel.clearPostRecordingState()
            } else {
                // Show recording complete screen with the recorded duration
                print("📹 [RecordingDelegate] Showing completion screen")
                viewModel.showRecordingComplete(videoURL: outputFileURL, duration: viewModel.recordingDuration)
            }
        }
    }
}

