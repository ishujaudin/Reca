//
//  ToastUtils.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

final class ToastUtils {
    private static var toastQueue: [String] = []
    private static var isToastVisible: Bool = false

    /// Show a toast message
    /// - Parameters:
    ///   - message: The message to be displayed in the toast.
    ///   - timeout: The duration for which the toast is visible. Default is 1.5 seconds.
    ///   - force: Whether to force display the toast immediately, bypassing the queue.
    static func showToast(message: String, timeout: CGFloat = 1.5, force: Bool = false) {
        DispatchQueue.main.async {
            if !force && isToastVisible {
                toastQueue.append(message)
                return
            }
            guard let topVC = getTopMostViewController(), topVC.presentedViewController == nil else {
                toastQueue.append(message)
                return
            }

            isToastVisible = true
            displayToast(message: message, on: topVC, timeout: timeout)
        }
    }

    /// Displays the toast alert
    /// - Parameters:
    ///   - message: The message to be displayed.
    ///   - viewController: The view controller to display the toast on.
    ///   - timeout: The duration for which the toast is visible.
    private static func displayToast(message: String, on viewController: UIViewController, timeout: CGFloat) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = viewController.view
        viewController.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            alert.dismiss(animated: true) {
                isToastVisible = false
                if toastQueue.isNotEmpty {
                    let nextMessage = toastQueue.removeFirst()
                    showToast(message: nextMessage, force: true)
                }
            }
        }
    }

    /// Retrieves the topmost visible view controller
    /// - Returns: The topmost visible `UIViewController`, or `nil` if none is found.
    private static func getTopMostViewController() -> UIViewController? {
        guard var topController = UIApplication.currentKeyWindow()?.rootViewController else { return nil }
        while let presentedViewController = topController.presentedViewController { topController = presentedViewController }
        return topController
    }
}
