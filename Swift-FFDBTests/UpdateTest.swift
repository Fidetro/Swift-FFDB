//
//  UpdateTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class UpdateTest: XCTestCase {
    
    func testUpdate() {
        print("\(Update(TestStoreModel()).sqlStatement!)")
    }
    func testUpdateObject() {
        let object = TestStoreModel()
        
        print("\(Update(object).set().whereFormat("ss = 'a'").sqlStatement!)")
        print("\(Update(object).set(["date","name"]).whereFormat("ss = 'a'").sqlStatement!)")
        print("\(Update(object).set("date = ''").whereFormat("ss = 'a'").sqlStatement!)")
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
