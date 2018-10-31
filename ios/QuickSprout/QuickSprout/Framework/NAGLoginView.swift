//
//  NAGLoginView.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 11/10/2018.
//  Copyright © 2018 Spiir A/S. All rights reserved.
//

import UIKit
import WebKit

protocol NAGLoginViewDelegate: AnyObject {
  func didReceiveToken(code: String)
}

class NAGLoginView: UIView {
  
  var nagWebView: WKWebView!
  var appWebView: WKWebView!
  var notificationName: String?
  var urlScheme: String?
  
  let userContentController = WKUserContentController()
  
  weak var delegate: NAGLoginViewDelegate? = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() -> Void {
    self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.appWebView = setupAppWebView()
    self.nagWebView = setupNagWebView()
    
    self.addSubview(appWebView)
    self.addSubview(nagWebView)
    webViewContraints(webView: nagWebView, container: self)
    webViewContraints(webView: appWebView, container: self)
    nagWebView.isHidden = true
  }
  
  func setupNagWebView() -> WKWebView {
    let webConfiguration = WKWebViewConfiguration()
    webConfiguration.userContentController = userContentController
    userContentController.add(self, name: "NAGWebHostBridge")
    let webView = WKWebView(frame: self.frame, configuration: webConfiguration)
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.navigationDelegate = self
    webView.scrollView.isScrollEnabled = false
    webView.scrollView.bounces = false
    return webView
  }
  
  func setupAppWebView() -> WKWebView {
    let webConfiguration = WKWebViewConfiguration()
    webConfiguration.userContentController = userContentController
    userContentController.add(self, name: "loadWebViewContent")
    let webView = WKWebView(frame: self.frame, configuration: webConfiguration)
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.navigationDelegate = self
    webView.scrollView.isScrollEnabled = false
    webView.scrollView.bounces = false
    return webView
  }
  
  func webViewContraints(webView: UIView, container: UIView) -> Void {
    webView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
    webView.heightAnchor.constraint(equalTo: container.heightAnchor ).isActive = true
    webView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    webView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
  }
}

extension NAGLoginView: WKScriptMessageHandler {
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let response = message.body as? NSDictionary else {
      return
    }
    
    if (response["method"] != nil) {
      if(response["method"] as? String == "loadWebViewContent") {
        handleLoadWebViewContent(response: response)
      }
      if (response["method"] as? String == "sendReturnValue") {
        handleSendReturnValue(response: response)
      }
    }
  }
  
  private func handleLoadWebViewContent(response: NSDictionary) -> Void {
    nagWebView.loadHTMLString(response["html"] as! String, baseURL: URL(string: response["baseUrl"] as! String))
    appWebView.isHidden = true
    nagWebView.isHidden = false
  }
  
  private func handleSendReturnValue(response: NSDictionary) -> Void {
    let data = response["data"] as! String
    appWebView.evaluateJavaScript("window.NAGWebViewBridge.sendReturnValue(\"\(data)\")", completionHandler: nil)
    appWebView.isHidden = false
    nagWebView.isHidden = true
  }
  
}

extension NAGLoginView: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if let notificationName = self.notificationName, let urlScheme = self.urlScheme {
      if(navigationAction.request.url?.scheme == urlScheme) {
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: navigationAction.request.url)
        decisionHandler(.cancel)
      } else {
        decisionHandler(.allow)
      }
    }
  }
  
}
