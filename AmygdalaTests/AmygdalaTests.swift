//
//  AmygdalaTests.swift
//  AmygdalaTests
//
//  Created by Aji Saputra Raka Siwi on 26/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import XCTest
@testable import Amygdala

class AmygdalaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsingFearExperienceJson() {
        let path = Bundle.main.path(forResource: "FearExperience", ofType: "json")
        if let path = path {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try Utils.fearExperienceJsonParser(data: data)
                XCTAssertNotNil(response)
            } catch let error {
                XCTAssertNil(error)
            }
        } else {
            XCTAssertNotNil(path)
        }
    }
}
