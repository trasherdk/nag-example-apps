//
//  QSGetAccountsResponse.swift
//  QuickSprout
//
//  Created by Jesper Nysteen on 05/06/2019.
//  Copyright © 2019 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSGetAccountsResponse: Codable {
    let accounts: [QSAccount]
    let pagingToken: String?
}
