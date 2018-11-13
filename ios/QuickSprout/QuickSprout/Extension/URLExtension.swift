//
//  URLExtension.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 29/10/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import Foundation

extension URL {
    func getQueryString(parameter: String) -> String? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == parameter }?
            .value
    }
}
