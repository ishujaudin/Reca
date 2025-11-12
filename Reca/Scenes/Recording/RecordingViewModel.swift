//
//  RecordingViewModel.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI
import AVFoundation
import Photos

@MainActor
final class RecordingViewModel: BaseViewModel {
    typealias Router = RecordingRouter
    
    // Routing
    @Published var shouldPush = false
    @Published var shouldPresent = false
    @Published var shouldPresentFullscreen = false
    @Published private(set) var route: Router?
    
    // Networking
    private let networkController: RecordingNetworkController
    
    // Published Properties
    @Published var isLoading = false
    @Published var error: Error?
    
    // Orientation
    @Published var orientation = UIDeviceOrientation.unknown
    
    // Recording State
    @Published var isRecording = false
    @Published var recordingDuration: TimeInterval = 0
    @Published var selectedZoom: CGFloat = 1.0
    @Published var selectedLens: String = "24mm"
    @Published var isOneHandedMode: Bool = true
    @Published var isRightHanded: Bool = true
    @Published var autoSaveToDevice: Bool = false
    @Published var preserveSettings: Bool = true
    @Published var showSettings: Bool = false
    @Published var pendingUploads: Int = 0
    
    // Camera
    @Published var cameraSession: AVCaptureSession?
    @Published var hasCameraPermission: Bool = false
    @Published var hasMicrophonePermission: Bool = false
    
    // Recording
    private var videoOutput: AVCaptureMovieFileOutput?
    private var videoDeviceInput: AVCaptureDeviceInput?
    private var audioDeviceInput: AVCaptureDeviceInput?
    private var currentVideoURL: URL?
    @Published var lastRecordedVideoURL: URL?
    private var recordingDelegate: RecordingDelegate?
    
    // Timer
    private var recordingTimer: Timer?
    
    init(networkController: RecordingNetworkController = RecordingNetworkController()) {
        self.networkController = networkController
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        Task { @MainActor in
            await setupCamera()
        }
    }
    
    deinit {
        // Use a nonisolated helper to avoid main actor isolation issues in deinit
        endOrientationNotifications()
        stopCameraSessionNonisolated()
    }
    
    nonisolated private func endOrientationNotifications() {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    nonisolated private func stopCameraSessionNonisolated() {
        // Note: We can't access @Published properties from nonisolated context
        // The session will be cleaned up when the ViewModel is deallocated
        // This is acceptable as AVCaptureSession handles cleanup gracefully
    }
    
    private func stopCameraSession() {
        cameraSession?.stopRunning()
        cameraSession = nil
    }

    // Pause camera session to reduce memory pressure
    func pauseCameraSession() {
        print("📹 [RecordingViewModel] pauseCameraSession - Pausing camera to save memory")
        if let session = cameraSession {
            DispatchQueue.global(qos: .userInitiated).async {
                if session.isRunning {
                    session.stopRunning()
                }
            }
        }
    }

    // Resume camera session
    func resumeCameraSession() {
        print("📹 [RecordingViewModel] resumeCameraSession - Resuming camera")
        if let session = cameraSession {
            DispatchQueue.global(qos: .userInitiated).async {
                if !session.isRunning {
                    session.startRunning()
                }
            }
        }
    }
}

// MARK: - Actions

extension RecordingViewModel {
    
    func didTapClose() {
        if isRecording {
            stopRecording()
        }
        clearPostRecordingState()
        // Dismiss will be handled by parent
    }
    
    func clearPostRecordingState() {
        lastRecordedVideoURL = nil
    }
    
    func didTapRecord() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    func didTapSettings() {
        showSettings = true
        route = .settings(self)
        shouldPresent = true
    }
    
    func didTapUpload() {
        // TODO: Show upload options
    }
    
    func didSelectZoom(_ zoom: CGFloat) {
        selectedZoom = zoom
        applyZoom(zoom)
    }
    
    private func applyZoom(_ zoom: CGFloat) {
        guard let device = videoDeviceInput?.device else { return }
        
        do {
            try device.lockForConfiguration()
            let maxZoom = min(device.activeFormat.videoMaxZoomFactor, 5.0)
            let clampedZoom = min(max(zoom, 1.0), maxZoom)
            device.videoZoomFactor = clampedZoom
            device.unlockForConfiguration()
        } catch {
            print("Error applying zoom: \(error)")
        }
    }
    
    func didSelectLens(_ lens: String) {
        selectedLens = lens
    }
    
    func toggleOneHandedMode() {
        isOneHandedMode.toggle()
    }
    
    func toggleRightHanded() {
        isRightHanded.toggle()
    }
    
    func toggleAutoSave() {
        autoSaveToDevice.toggle()
    }
    
    func togglePreserveSettings() {
        preserveSettings.toggle()
    }
    
    private func startRecording() {
        guard hasCameraPermission && hasMicrophonePermission else {
            print("Missing camera or microphone permission")
            return
        }
        
        isRecording = true
        recordingDuration = 0
        startRecordingTimer()
        startVideoRecording()
    }
    
    private func startRecordingTimer() {
        recordingTimer?.invalidate()
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self = self, self.isRecording else { return }
                self.recordingDuration += 1.0
            }
        }
    }
    
    private func stopRecording() {
        isRecording = false
        recordingTimer?.invalidate()
        recordingTimer = nil
        stopVideoRecording()
    }
    
    // MARK: - Camera Setup
    
    private func setupCamera() async {
        // Request camera permission
        let cameraStatus = await AVCaptureDevice.requestAccess(for: .video)
        await MainActor.run {
            hasCameraPermission = cameraStatus
        }
        
        // Request microphone permission
        let microphoneStatus = await AVCaptureDevice.requestAccess(for: .audio)
        await MainActor.run {
            hasMicrophonePermission = microphoneStatus
        }
        
        guard cameraStatus && microphoneStatus else {
            print("Camera or microphone permission denied")
            return
        }
        
        await MainActor.run {
            configureCaptureSession()
        }
    }
    
    private func configureCaptureSession() {
        // Don't recreate if session already exists
        guard cameraSession == nil else { return }
        
        let session = AVCaptureSession()
        session.sessionPreset = .high
        
        // Configure for 1080p if supported
        if session.canSetSessionPreset(.hd1920x1080) {
            session.sessionPreset = .hd1920x1080
        }
        
        // Setup video input
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get video device")
            return
        }
        
        do {
            // Configure frame rate to 30 FPS
            try videoDevice.lockForConfiguration()
            let frameDuration = CMTime(value: 1, timescale: 30)
            videoDevice.activeVideoMinFrameDuration = frameDuration
            videoDevice.activeVideoMaxFrameDuration = frameDuration
            videoDevice.unlockForConfiguration()
            
            // Create video input
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
                videoDeviceInput = videoInput
            }
            
            // Setup audio input
            guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
                print("Failed to get audio device")
                return
            }
            
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            if session.canAddInput(audioInput) {
                session.addInput(audioInput)
                audioDeviceInput = audioInput
            }
            
            // Setup video output
            let movieOutput = AVCaptureMovieFileOutput()
            
            // Configure for video stabilization and orientation
            if let connection = movieOutput.connection(with: .video) {
                if connection.isVideoStabilizationSupported {
                    connection.preferredVideoStabilizationMode = .auto
                }
                // Handle orientation changes
                if connection.isVideoOrientationSupported {
                    connection.videoOrientation = .portrait
                }
            }
            
            if session.canAddOutput(movieOutput) {
                session.addOutput(movieOutput)
                videoOutput = movieOutput
                recordingDelegate = RecordingDelegate(viewModel: self)
            }
            
            cameraSession = session
            
            // Start session on background queue
            DispatchQueue.global(qos: .userInitiated).async { [weak session] in
                session?.startRunning()
            }
            
        } catch {
            print("Error setting up camera: \(error)")
            self.error = error
        }
    }
    
    func updateVideoOrientation() {
        // Run on background queue to avoid blocking UI
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self,
                  let videoOutput = self.videoOutput,
                  let connection = videoOutput.connection(with: .video),
                  connection.isVideoOrientationSupported else {
                return
            }
            
            let orientation: AVCaptureVideoOrientation
            switch UIDevice.current.orientation {
            case .portrait:
                orientation = .portrait
            case .portraitUpsideDown:
                orientation = .portraitUpsideDown
            case .landscapeLeft:
                orientation = .landscapeRight
            case .landscapeRight:
                orientation = .landscapeLeft
            default:
                orientation = .portrait
            }
            
            // Update connection on background queue
            connection.videoOrientation = orientation
        }
    }
    
    // MARK: - Video Recording
    
    private func startVideoRecording() {
        guard let videoOutput = videoOutput,
              let session = cameraSession,
              session.isRunning else {
            print("Cannot start recording: session not ready")
            return
        }
        
        // Create output URL
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let videoURL = documentsPath.appendingPathComponent("recording_\(Date().timeIntervalSince1970).mov")
        currentVideoURL = videoURL
        
        // Start recording (HEVC is default on supported devices)
        if let delegate = recordingDelegate {
            videoOutput.startRecording(to: videoURL, recordingDelegate: delegate)
        }
    }
    
    private func stopVideoRecording() {
        videoOutput?.stopRecording()
    }
    
    func saveVideoToLocalStorage(url: URL) async {
        if autoSaveToDevice {
            // Save to Photos library
            let status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
            
            guard status == .authorized || status == .limited else {
                print("Photo library access denied")
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            }) { [weak self] success, error in
                Task { @MainActor in
                    if let error = error {
                        print("Error saving to Photos: \(error)")
                        self?.error = error
                    }
                }
            }
        }
        
        // Always keep a copy in Documents for sharing/deleting
        await MainActor.run {
            lastRecordedVideoURL = url
        }
    }
    
    func showRecordingComplete(videoURL: URL, duration: TimeInterval) {
        print("📹 [RecordingViewModel] showRecordingComplete - showing completion screen")

        // Pause camera to reduce memory pressure
        pauseCameraSession()

        route = .recordingComplete(self, videoURL: videoURL, duration: duration)
        shouldPresentFullscreen = true
    }

    func resetNavigationState() {
        shouldPush = false
        shouldPresent = false
        shouldPresentFullscreen = false
        route = nil
    }
}


