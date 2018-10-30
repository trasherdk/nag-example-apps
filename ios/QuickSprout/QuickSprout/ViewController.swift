//
//  ViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 04/10/2018.
//  Copyright © 2018 Spiir A/S. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
  func didReceiveCode(code: String)
}

class ViewController: UIViewController {
  
  @IBOutlet weak var webViewButton: UIButton!
  
  var code: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    styleButton(button: webViewButton)
  }
  
  func styleButton(button: UIButton) -> Void {
    button.layer.cornerRadius = 20
    button.clipsToBounds = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "webViewSegue" {
      (segue.destination as! WebViewViewController).delegate = self
    }
  }
}

extension ViewController: ViewControllerDelegate {
  func didReceiveCode(code: String) {
    QSAPI.tokens(code: code) {
          (accessToken) in
            QSAPI.accounts(accessToken: accessToken) {
              (accounts) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateAccountsViewController()
                viewController.accounts = accounts
                self.navigationController?.pushViewController(viewController, animated: true)
                print(accounts)
            }
        }
    }
}
