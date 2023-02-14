//
//  NavigationTest.swift
//  NavigationTest
//
//  Created by Artur Skaliy on 14.02.2023.
//

import XCTest
@testable import Navigation

class NavigationTest: XCTestCase {
    
    let checkerService = CheckerService()
    let feedModel = FeedModel()

    func testSuccessCheckerService() {
        let login = "1@1.ru"
        let password = "123456"
        var result = false
        let expect = self.expectation(description: "waiting firebase")
        checkerService.checkCredentials(login: login, password: password) { doneWorking in
            if doneWorking {
               result = true
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(result, true)
    }
    
    func testFailedCheckerService() {
        let login = "112312312@1.ru"
        let password = "123456"
        var result = false
        let expect = self.expectation(description: "waiting firebase")
        checkerService.checkCredentials(login: login, password: password) { doneWorking in
            if doneWorking {
               result = true
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(result, false)
    }
    
    func testSuccesFeedModel() {
        XCTAssertTrue(feedModel.check(word: feedModel.secretWord))
    }
}
