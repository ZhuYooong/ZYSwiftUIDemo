//
//  WebView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import SwiftUI
import UIKit
import WebKit

struct WebView : UIViewRepresentable {
    var urlString:String?
    var loadFinishEvaluated: String?
    static let processPool = WKProcessPool()
    
    func makeCoordinator() -> Coordinater {
        Coordinater(self)
    }
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let config = WKWebViewConfiguration()
        let userController = WKUserContentController()
        
        if let jsURL = Bundle.main.url(forResource: "cssRule", withExtension: ".js") {
            let code = try! String(contentsOf: jsURL, encoding: String.Encoding.utf8)
            let userScript = WKUserScript(source: code, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            userController.addUserScript(userScript)
        }
        config.userContentController = userController
        
        config.processPool = Self.processPool
        let webView = WKWebView.init(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if self.urlString == uiView.url?.absoluteString {
            print("duplicate")
            return
        }
        guard let urlString = self.urlString else {
            print("empty urlSring")
            return
        }
        guard let url = URL(string: urlString) else {
            print("error urlString = \(urlString)")
            return
        }
        context.coordinator.setupTimerFor(uiView)
        let req = URLRequest(url: url)
        uiView.load(req)
    }
    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinater){
        uiView.stopLoading()
        coordinator.timer?.invalidate()
    }
}
class Coordinater: NSObject, WKNavigationDelegate, WKUIDelegate {
    var webView: WebView
    var timer: Timer?
    var webViewUIObj: WKWebView?
    
    init(_ webView: WebView) {
        self.webView = webView
    }
    func setupTimerFor(_ uiView: WKWebView?) -> Void {
        if self.webViewUIObj != nil {
            return
        }
        if let webView = uiView, let parentView = uiView?.superview {
            let loading = UIProgressView(frame: CGRect(x: CGFloat(0), y: 0, width: UIScreen.main.bounds.width, height: 2))
            loading.tintColor = UIColor.green
            loading.trackTintColor = UIColor.white
            parentView.addSubview(loading)
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
                if webView.estimatedProgress >= 1 {
                    loading.progress = 0
                } else {
                    loading.progress = Float(webView.estimatedProgress)
                }
            }
            self.webViewUIObj = webView
            self.timer = timer
        }else {
            print("parent is emtpy")
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
        print("Load url \(String(describing: webView.url?.absoluteString))")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView didFinish")
        if self.webView.loadFinishEvaluated != nil {
            self.webViewUIObj?.evaluateJavaScript(self.webView.loadFinishEvaluated!, completionHandler: { (r, err) in
                if r != nil && err == nil {
                    
                }
            })
        }
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if (!(navigationAction.targetFrame?.isMainFrame ?? false)) {
            webView.load(navigationAction.request)
        }
        return nil;
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
