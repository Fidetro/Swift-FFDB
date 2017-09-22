//
//  InsertTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/11.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class InsertTest: XCTestCase {
    
    func testInsertPerson() {
        let insert = Insert().into(Person.self).columns(["sd","zx"]).values(["asd","zxccc"])
        if let sql = insert.sqlStatement {
            print(sql)
        }
        let insertClass = Insert().into(Person.self).columns(Person.self)
        if let sql = insertClass.sqlStatement {
            print(sql)
        }
    }
    
    
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
