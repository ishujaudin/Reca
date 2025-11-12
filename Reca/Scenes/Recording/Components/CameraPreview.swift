//
//  CameraPreview.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI
import AVFoundation
import UIKit

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession?
    
    func makeUIView(context: Context) -> CameraPreviewView {
        let view = CameraPreviewView()
        view.setupPreviewLayer(session: session)
        return view
    }
    
    func updateUIView(_ uiView: CameraPreviewView, context: Context) {
        uiView.updateSession(session)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        // Coordinator for future use if needed
    }
}

class CameraPreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    func setupPreviewLayer(session: AVCaptureSession?) {
        videoPreviewLayer.session = session
        videoPreviewLayer.videoGravity = .resizeAspectFill
        updateOrientation()
    }
    
    func updateSession(_ session: AVCaptureSession?) {
        // Only update if session actually changed to avoid unnecessary work
        guard videoPreviewLayer.session !== session else { return }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        videoPreviewLayer.session = session
        CATransaction.commit()
        
        // Update orientation asynchronously
        DispatchQueue.main.async { [weak self] in
            self?.updateOrientation()
        }
    }
    
    private func updateOrientation() {
        guard let connection = videoPreviewLayer.connection,
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
            // Use interface orientation as fallback
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                switch windowScene.interfaceOrientation {
                case .portrait:
                    orientation = .portrait
                case .portraitUpsideDown:
                    orientation = .portraitUpsideDown
                case .landscapeLeft:
                    orientation = .landscapeLeft
                case .landscapeRight:
                    orientation = .landscapeRight
                default:
                    orientation = .portrait
                }
            } else {
                orientation = .portrait
            }
        }
        
        // Update orientation without animation to prevent blocking
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        connection.videoOrientation = orientation
        CATransaction.commit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update frame without animation
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        videoPreviewLayer.frame = bounds
        CATransaction.commit()
        
        // Update orientation asynchronously to avoid blocking
        DispatchQueue.main.async { [weak self] in
            self?.updateOrientation()
        }
    }
}

