//
//  URLUtilsTests.swift
//  QuickSproutTests
//
//  Created by Brian Vestergaard Danielsen on 16/11/2018.
//  Copyright © 2018 Brian Vestergaard Danielsen. All rights reserved.
//

import XCTest
@testable import QuickSprout

class URLUtilsTest: XCTestCase {
    
    func testIsUrlValid () -> Void {
        let url = URLUtils.url(url: "https://www.nordicapigateway.com")
        let isUrlValid = UIApplication.shared.canOpenURL(url!)
        XCTAssertTrue(isUrlValid)
    }
    
    func testIsUrlInvalid () -> Void {
        let url = URLUtils.url(url: "nordicapigateway")
        let isUrlInvalid = UIApplication.shared.canOpenURL(url!)
        XCTAssertFalse(isUrlInvalid)
    }
}
