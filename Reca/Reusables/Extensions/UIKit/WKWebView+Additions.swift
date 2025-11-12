//
//  WKWebView+Additions.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import WebKit

extension WKWebView {

    func load(_ urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return
        }

        let request = URLRequest(url: url)
        load(request)
    }
}
