//
//  WebWrappedView.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import SwiftUI
import UIKit
import WebKit

struct WebWrappedView: RAUIViewRepresentable {

    private enum Constant {

        static let phoneInvalidURLKey = "tel:"
        static let phoneValidURLKey = "tel://"
    }

    let initialURL: String?
    let isScrollEnabled: Bool
    var enableUiDelegate = false
    @Binding var dynamicHeight: CGFloat

    var shouldOpenURLHandler: ((_ url: URL?) -> Bool)?
    var didFinishNavigationHandler: (() -> Void)?

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.isScrollEnabled = isScrollEnabled
        webView.navigationDelegate = context.coordinator
        if enableUiDelegate {
            webView.uiDelegate = context.coordinator
        }
        webView.load(initialURL)

        return webView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator

extension WebWrappedView {

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {

        private var webWrappedView: WebWrappedView

        init(_ webWrappedView: WebWrappedView) {
            self.webWrappedView = webWrappedView
        }

        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationResponse: WKNavigationResponse,
                     decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            let shouldOpenURL = webWrappedView.shouldOpenURLHandler?(webView.url) ?? true
            decisionHandler(shouldOpenURL ? .allow : .cancel)
        }

        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let navigationURL = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }

            if navigationURL.absoluteString.contains(Constant.phoneInvalidURLKey) ||
                navigationAction.targetFrame == nil {
                guard let url = URL(string: navigationURL.absoluteString.replace(
                    target: Constant.phoneInvalidURLKey,
                    withString: Constant.phoneValidURLKey
                )) else {
                    return
                }
                UIApplication.shared.open(url)

                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.webWrappedView.dynamicHeight = webView.scrollView.contentSize.height
            }
            webWrappedView.didFinishNavigationHandler?()
        }

        func webView(_ webView: WKWebView,
                     runJavaScriptConfirmPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (Bool) -> Void) {
        }
    }
}

// MARK: - init

extension WebWrappedView {

    init(initialURL: String? = nil,
         isScrollEnabled: Bool = true,
         enableUiDelegate: Bool = false,
         shouldOpenURLHandler: ((_ url: URL?) -> Bool)? = nil,
         didFinishNavigationHandler: (() -> Void)? = nil ) {
        _dynamicHeight = .constant(.zero)
        self.initialURL = initialURL
        self.isScrollEnabled = isScrollEnabled
        self.enableUiDelegate = enableUiDelegate
        self.shouldOpenURLHandler = shouldOpenURLHandler
        self.didFinishNavigationHandler = didFinishNavigationHandler
    }
}
