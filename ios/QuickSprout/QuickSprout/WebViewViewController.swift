//
//  WebViewViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 08/10/2018.
//  Copyright © 2018 Spiir A/S. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
  
  let notificationName = "urlSchemeTriggered"
  let urlScheme = "nagdemoapp"
  weak var delegate: ViewControllerDelegate? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    if let view = self.view as? NAGLoginView {
      view.delegate = self
      if let info = Bundle.main.path(forResource: "Info", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: info) as? [String: Any] {
          let url = URL(string: dict["Nordic API Gateway URL"] as! String);
          QSAPI.initAuth(endpoint: url!, language: "da", redirectUrl: "nagdemoapp://") {
            (url) in
            NotificationCenter.default.addObserver(self, selector: #selector(self.urlSchemeTriggered(_:)), name: Notification.Name(self.notificationName), object: nil)
            let url = URL(string:url)
            let request = URLRequest(url: url!)
            view.notificationName = self.notificationName
            view.urlScheme = self.urlScheme
            view.appWebView.load(request)
          }
        }
      }
    }
  }
  
  @objc func urlSchemeTriggered(_ notification : Notification) {
    guard let url = notification.object as? URL else {
      return
    }
    NotificationCenter.default.removeObserver(self, name: Notification.Name(self.notificationName), object: nil)
    if let view = self.view as? NAGLoginView {
      view.delegate?.didReceiveToken(code: url.getQueryString(parameter: "code")!)
    }
  }
}

extension WebViewViewController: NAGLoginViewDelegate {
  func didReceiveToken(code: String) {
      delegate?.didReceiveCode(code: code)
      self.dismiss(animated: true, completion: nil)
    }
}
