//
//  AlertUtils.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

final class AlertUtils {
    static let shared = AlertUtils()

    private init() {}

    /// Show a simple alert with a title, message, and dismiss button
    func showAlert(title: String, message: String, dismissButtonTitle: String = "OK") {
        guard let rootVC = getRootViewController() else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil)
        alert.addAction(dismissAction)
        rootVC.present(alert, animated: true, completion: nil)
    }

    /// Show a confirmation alert with primary and secondary actions
    func showConfirmationAlert(
        title: String,
        message: String,
        primaryButtonTitle: String = "OK",
        primaryAction: @escaping () -> Void,
        secondaryButtonTitle: String = "Cancel",
        secondaryAction: (() -> Void)? = nil
    ) {
        guard let rootVC = getRootViewController() else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let primaryAction = UIAlertAction(title: primaryButtonTitle, style: .default) { _ in primaryAction() }
        let secondaryAction = UIAlertAction(title: secondaryButtonTitle, style: .cancel) { _ in secondaryAction?() }

        alert.addAction(primaryAction)
        alert.addAction(secondaryAction)
        rootVC.present(alert, animated: true, completion: nil)
    }

    /// Get the root view controller of the application's main window
    private func getRootViewController() -> UIViewController? {
        return UIApplication.currentKeyWindow()?.rootViewController
    }
}
