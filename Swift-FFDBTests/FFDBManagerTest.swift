//
//  FFDBManagerTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class FFDBManagerTest: XCTestCase {
    
    func testInsert()  {
        var test = TestStoreModel.init()
        test.date = 1235
        FFDBManager.insert(test,["111","222"])
        FFDBManager.insert(test,nil)
        FFDBManager.insert(test,["aaa"])
        FFDBManager.insert(TestStoreModel.self, ["date"], values: ["11",323])
    }
    
    func testSelect() {
        FFDBManager.select(TestStoreModel.self, nil, where: nil)
        FFDBManager.select(TestStoreModel.self, ["name"], where: nil)
        FFDBManager.select(TestStoreModel.self, ["name","date"], where: nil)
        FFDBManager.select(TestStoreModel.self, ["name","date"], where: "name = 'fidetro'")
    }
 
    func testUpdate() {
        var test = TestStoreModel.init()
        test.primaryID = 11111111
        FFDBManager.update(test, set: ["date"])
        test.date = 1994
        FFDBManager.update(test, set: nil)
//        FFDBManager.update(test, set: ["nullKey"])
        FFDBManager.update(test, set: ["date"])
        FFDBManager.update(test, set: ["date","name"])
        FFDBManager.update(TestStoreModel.self, set: "date = 'a'", where: "name = 1")
    }
    
    func testDelete() {
        var test = TestStoreModel.init()
        test.primaryID = 66
        FFDBManager.delete(test)
        FFDBManager.delete(TestStoreModel.self, where: "name = '1'")
        FFDBManager.delete(TestStoreModel.self, where: nil)
        
    }
    
}
