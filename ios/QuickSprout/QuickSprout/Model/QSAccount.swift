//
//  QSAccount.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 30/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSAccount : Codable {
    let id: String?
    let providerId: String?
    let name: String?
    let number: QSAccountNumber?
    var bookedBalance: QSAmount?
    var availableBalance: QSAmount?
}
