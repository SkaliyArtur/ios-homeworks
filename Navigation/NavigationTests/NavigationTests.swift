//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Artur Skaliy on 09.02.2023.
//

import XCTest
@testable import Navigation

class NavigationTests: XCTestCase {
    
    lazy var checkerService: LoginInspector = {
       return LoginInspector()
    }()

//    override init(checkerService: LoginInspector) {
//        self.checkerService = checkerService
//    }
//
//      required init?(coder aDecoder: NSCoder) {
//          fatalError("init(coder:) has not been implemented")
//      }

    
    func testVladitaion() {
    
        let login = "1@1.ru"
        let password = "123456"
        
//        let expect = expectation(description: "test")
       
//        var result: Bool {
           
            let result = checkerService.delegateCheck(login: login, password: password)
//            waitForExpectations(timeout: 5)
//            expect.fulfill()
//            return result
            
//        }
        
        
        XCTAssertEqual(result, true)
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
