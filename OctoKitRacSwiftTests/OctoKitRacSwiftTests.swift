//
//  OctoKitRacSwiftTests.swift
//  OctoKitRacSwiftTests
//
//  Created by eony on 28/04/2017.
//  Copyright © 2017 Maxwell. All rights reserved.
//

import XCTest
@testable import OctoKitRacSwift

class OctoKitRacSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       let subject = TokenConfiguration("111")
        XCTAssertEqual(subject.accessToken, "111")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let subject = OAuthConfiguration("1", token: "adhajds", secrect: "111", scopes: ["dahsjd"])
        print("aa\(subject)")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
