//
//  QSAccountNumber.swift
//  QuickSprout
//
//  Created by Jesper Nysteen on 05/06/2019.
//  Copyright © 2019 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSAccountNumber : Codable {
    let bbanType: String?
    let bban: String?
    let iban: String?
}
