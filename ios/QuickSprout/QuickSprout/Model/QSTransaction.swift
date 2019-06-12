//
//  QSTransaction.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 14/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSTransaction : Codable {
    var id: String?
    var date: String?
    var creationDateTime: String?
    var text: String?
    var originalText: String?
    var amount: QSAmount?
    var balance: QSAmount?
    var type: String?
    var state: String?
}
