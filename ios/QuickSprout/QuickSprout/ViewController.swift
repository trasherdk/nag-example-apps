//
//  ViewController.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 04/10/2018.
//  Copyright © 2018 Spiir A/S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var webViewButton: UIButton!
  @IBOutlet weak var tokenTextView: UITextView!
  
  var code: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    styleButton(button: webViewButton)
  }
  
  func styleButton(button: UIButton) -> Void {
    button.layer.cornerRadius = 20
    button.clipsToBounds = true
  }
}

