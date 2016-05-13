//
//  SentimentTests.swift
//  SentimentTests
//
//  Created by Jack Herrington on 5/11/16.
//  Copyright © 2016 Jack Herrington. All rights reserved.
//

import XCTest
@testable import Sentiment

class SentimentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNegative() {
        XCTAssert(Sentiment.analyze("this, sucks").matches == 1);
        XCTAssert(Sentiment.analyze("this, sucks").total == -3);
    }

    func testPositive() {
        XCTAssert(Sentiment.analyze("i really love this").matches == 1);
        XCTAssert(Sentiment.analyze("i really love this").total == 3);
    }
}
