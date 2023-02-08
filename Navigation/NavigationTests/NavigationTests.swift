//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Artur Skaliy on 09.02.2023.
//

import XCTest
@testable import Navigation

class NavigationTests: XCTestCase {
    
    var checkerService: LoginInspector?
    var checkerService2: CheckerService?

    func testVladitaion() {
    
        let login = "1@1.ru"
        let password = "123456"
        
        guard let result = checkerService?.delegateCheck(login: login, password: password) else {return}
//        var result: Bool {
////            guard let result = checkerService?.delegateCheck(login: login, password: password) else {return true}
//            guard let result = checkerService2?.checkCredentials(login: login, password: password) else {return false}
//            guard let sign = checkerService2?.isSingIn else {return false}
//            expectationn.fulfill()
//            return sign
//        }
////        waitForExpectations(timeout: 30)
//        XCTAssertEqual(result, true)
    }
    
//    func testVladitaion2() {
//
//        let login = "1@1.ru"
//        let password = "123456"
//        let expectationn = expectation(description: "test1")
////        guard let result = checkerService?.delegateCheck(login: login, password: password) else {return}
//        var result: Bool {
//            guard let result = checkerService?.delegateCheck(login: login, password: password) else {return false}
//            expectationn.fulfill()
//            return result
//        }
//        waitForExpectations(timeout: 20)
//        XCTAssertEqual(result, false)
//    }

}
