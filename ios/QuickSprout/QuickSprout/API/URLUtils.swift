//
//  URLUtils.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 16/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation
struct URLUtils {
    static func url(url: String) -> URL? {
        guard let _ = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: url)
    }
}
