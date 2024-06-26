//
//  WebView.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/11/24.
//

import Foundation

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
