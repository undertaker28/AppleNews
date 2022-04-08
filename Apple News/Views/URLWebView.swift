//
//  URLWebView.swift
//  AppleNews
//
//  Created by Pavel on 05.04.2022.
//

import SwiftUI
import WebKit

struct URLWebView: UIViewRepresentable {
    var urlToDisplay: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.load(URLRequest(url: urlToDisplay))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
