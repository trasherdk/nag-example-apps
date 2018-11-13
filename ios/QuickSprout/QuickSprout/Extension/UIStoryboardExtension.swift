//
//  UIStoryboardExtension .swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func instantiateAccountsViewController() -> AccountsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AccountsViewController") as! AccountsViewController
        return viewController
    }
}
