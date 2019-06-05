//
//  QSAmount.swift
//  QuickSprout
//
//  Created by Jesper Nysteen on 05/06/2019.
//  Copyright © 2019 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

struct QSAmount : Codable {
    let value: Double // This should be a Decimal, but isn't for the sake of simplicity (https://medium.com/wultra-blog/decoding-money-from-json-in-swift-d61a3fcf6404)
    let currency: String
}

